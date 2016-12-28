# TODO: Move source/package/etc to params.pp
class xtradb {

  apt::source { 'percona':
    location    => 'http://repo.percona.com/apt/',
    release     => "${::lsbdistcodename}",
    repos       => 'main',
    key         => '430BDF5C56E7C94E848EE60C1C4CBDCDCD2EFD2A',
    pin         => '1001',
    include_src => 'true',
  }

  package { [ 'percona-xtradb-cluster-server-5.6',
    'percona-xtradb-cluster-client-5.6',
    'percona-xtradb-cluster-galera-3.x',
    'percona-xtrabackup',]:
    ensure      => installed,
    require     => Apt::Source['percona'],
  }

  service { "mysql":
    ensure	=> running,
    hasstatus	=> true,   
    hasrestart	=> true,
    require	=> Package['percona-xtradb-cluster-server-5.6'],
  }
}
