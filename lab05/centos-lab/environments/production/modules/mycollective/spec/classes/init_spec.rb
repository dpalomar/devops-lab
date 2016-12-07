require 'spec_helper'
describe 'mymcollective' do
  context 'with default values for all parameters' do
    it { should contain_class('mymcollective') }
  end
end
