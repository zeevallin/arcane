require 'spec_helper'

describe Arcane do

  let(:user)       { double(name: :user) }
  let(:parameters) { nil_model_params }
  let(:controller) { double(request: request, current_user: user).tap { |c| c.extend(Arcane) } }
  let(:request)    { double(parameters: parameters) }

  describe '#params' do
    it 'sets the user for parameters' do
      controller.params.user.should eq user
    end

    context 'when #arcane_user defined in controller' do
      let(:arcane_user)  { double(name: 'arcane_user') }

      before { controller.stub(arcane_user: arcane_user) }

      it 'sets this user instead of #current_user for parameters' do
        controller.params.user.should eq arcane_user
      end
    end
  end

  describe '#params=' do
    context 'sets the user for' do
      it 'hash parameters' do
        controller.params = { foo: :bar }
        controller.instance_variable_get(:@_params).user.should eq user
      end

      it 'ActionController::Parameters parameters' do
        controller.params = ActionController::Parameters.new({ foo: :bar })
        controller.instance_variable_get(:@_params).user.should eq user
      end
    end

    it 'handles nil' do
      controller.params = nil
      controller.instance_variable_get(:@_params).should be_nil
    end
  end

end
