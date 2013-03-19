require 'spec_helper'

describe 'monit', :type => :class do
  context "osfamily = RedHat" do
    let :facts do
      {
        :osfamily        => 'RedHat',
        :lsbdistid       => 'RedHat',
        :kernel          => 'Linux',
        :operatingsystem => 'CentOS',
      }
    end

    context "default usage (osfamily = RedHat)" do
      let(:title) { 'monit-basic' }

      it 'should compile' do
        should contain_file('/etc/monit.conf')
        should contain_file('/etc/monit.d')
        should contain_file('/etc/logrotate.d/monit')
        should contain_service('monit')
      end
    end
  end

  context "osfamily = Debian" do
    let :facts do
      {
        :osfamily        => 'Debian',
        :lsbdistid       => 'Debian',
        :kernel          => 'Linux',
        :operatingsystem => 'Debian',
      }
    end

    context "default usage (osfamily = Debian)" do
      let(:title) { 'monit-basic' }

      it 'should compile' do
        should contain_file('/etc/monit/monitrc')
        should contain_file('/etc/monit/conf.d')
        should contain_file('/etc/logrotate.d/monit')
        should contain_service('monit')
      end
    end
  end
end
