node default {
}

class { '::ntp':
  servers  => [ '0.centos.pool.ntp.org', '1.centos.pool.ntp.org', '2.centos.pool.ntp.org' ],
  restrict => ['127.0.0.1'],
}

sysctl { 'vm.swappiness': value => '0' }
sysctl { 'net.ipv6.conf.all.disable_ipv6': value => '1' }
sysctl { 'net.ipv6.conf.default.disable_ipv6': value => '1' }

limits::limits { 'hdfs_nofile':
      ensure     => present,
      user       => 'hdfs',
      limit_type => 'nofile',
      both       => 32768,
    }

limits::limits { 'hbase_nofile':
      ensure     => present,
      user       => 'hbase',
      limit_type => 'nofile',
      both       => 32768,
    }

limits::limits { 'hdfs_noproc':
      ensure     => present,
      user       => 'hdfs',
      limit_type => 'nproc',
      both       => 32768,
    }

limits::limits { 'hbase_noproc':
      ensure     => present,
      user       => 'hbase',
      limit_type => 'nproc',
      both       => 32768,
    }

limits::limits { 'root_nofile':
      ensure     => present,
      user       => 'root',
      limit_type => 'nofile',
      both       => 32768,
    }

#$interval = 3+fqdn_rand(2)
#cron {"puppet-agent":
#	   command => "/usr/bin/puppet agent --onetime --no-daemonize --splay --logdest syslog > /dev/null 2>&1",
#	   ensure  => present,
#	   user    => root,
#	   minute  => "*/$interval"
#}
# 
#service {'puppet':
#	   ensure  => stopped,
#	   require => Cron["puppet-agent"]
#}
