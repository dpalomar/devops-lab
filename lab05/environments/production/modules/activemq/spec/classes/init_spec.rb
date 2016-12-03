require 'spec_helper'
describe 'activemq' do
  context 'with default values for all parameters' do
    it { should contain_class('activemq') }
  end
end
