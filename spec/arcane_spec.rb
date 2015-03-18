require 'spec_helper'

class MockController
  attr_accessor :request, :user
  def initialize(request, user)
    @request, @user = request, user
  end
end

class MockNoUserController
  attr_accessor :request
  def initialize(request)
    @request = request
  end
end

describe Arcane do

  let(:user)       { double(name: :user) }
  let(:parameters) { nil_model_params }
  let(:controller) { double(request: request, current_user: user).tap { |c| c.extend(Arcane) } }
  let(:request)    { double(parameters: parameters) }

  describe '#params' do
    it 'sets the user for parameters' do
      controller.params.user.should eq user
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

  describe "#current_params_user" do
    context "when there is no current user" do
      let(:controller) { MockNoUserController.new(request).tap { |c| c.extend(Arcane) } }
      it "should raise a no method error" do
        expect { controller.current_params_user }.to raise_exception NameError
      end
    end
  end

end
