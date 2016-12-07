require 'spec_helper'
describe 'myactivemq' do
  context 'with default values for all parameters' do
    it { should contain_class('myactivemq') }
  end
end
