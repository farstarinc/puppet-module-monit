Puppet Monit Module
===================

Module for configuring Monit and and setting up monitoring
of running processes.

Tested on Debian GNU/Linux 6.0 Squeeze. Patches for other
operating systems welcome.


Installation
------------

Clone this repo to a monit directory under your Puppet
modules directory:

    git clone git://github.com/uggedal/puppet-module-monit.git monit

If you don't have a Puppet Master you can create a manifest file
based on the notes below and run Puppet in stand-alone mode
providing the module directory you cloned this repo to:

    puppet apply --modulepath=modules test_monit.pp


Usage
-----

To install and configure Monit, import the module:

    import monit

You can override defaults in the Monit config by importing
the module with this special syntax:

    class { monit: admin => "eivind@uggedal.com" }

Setting up monitoring of processes is done with the `monit::site` resource:

    monit::monitor { "sshd":
      pidfile => "/var/run/sshd.pid",
    }

You can specify a IP port to check if you're running a network process:

    monit::monitor { "nginx":
      pidfile => "/var/run/nginx.pid",
      ip_port => 22,
    }

Alternatively you can specify a Unix socket to check:

    monit::monitor { "gunicorn-blog":
      pidfile => "/var/run/gunicorn/blog.pid",
      socket => "/var/run/gunicorn/blog.sock",
    }
