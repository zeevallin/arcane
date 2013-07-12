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
  end

  describe '#params=' do
    it 'sets the user for parameters' do
      controller.params = { foo: :bar }
      controller.instance_variable_get(:@_params).user.should eq user
    end
  end

end