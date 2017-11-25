require 'spec_helper'
describe 'systemd_networkd' do
  context 'with default values for all parameters' do
    it { should contain_class('systemd_networkd') }
  end
end
