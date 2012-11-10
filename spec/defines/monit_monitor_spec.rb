require 'spec_helper'

describe 'monit::monitor', :type => :define do
  context "osfamily = RedHat" do
    let :facts do
      {
        :osfamily        => 'RedHat',
        :kernel          => 'Linux',
        :operatingsystem => 'CentOS',
      }
    end

    context "default usage (osfamily = RedHat)" do
      let(:title) { 'monit-monitor-basic' }

      let(:params) {
        {
          'pidfile' => '/var/run/monit.pid',
        }
      }

      it 'should compile' do
        should contain_file('/etc/monit.d/monit-monitor-basic.conf')
      end
    end
  end

  context "osfamily = Debian" do
    let :facts do
      {
        :osfamily        => 'Debian',
        :kernel          => 'Linux',
        :operatingsystem => 'Debian',
      }
    end

    context "default usage (osfamily = Debian)" do
      let(:title) { 'monit-monitor-basic' }

      let(:params) {
        {
          'pidfile' => '/var/run/monit.pid',
        }
      }

      it 'should compile' do
        should contain_file('/etc/monit/conf.d/monit-monitor-basic.conf')
      end
    end
  end

end
