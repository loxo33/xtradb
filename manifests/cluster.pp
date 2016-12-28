# Build a Database Cluster
define xtradb::cluster (
  $cluster_name  = hiera('xtradb::cluster_name'),
  $sst_method    = hiera('xtradb::sst_method'),
  $sst_user      = hiera('xtradb::sst_user'),
  $sst_pass      = hiera('xtradb::sst_pass'),
  $cluster_array = hiera_array('xtradb::cluster_ips'),
  $wsrep_options = hiera_array('xtradb::wsrep'),
  $sst_donor     = undef,
  $rootpw	 = hiera('xtradb::rootpw'),
  $debianpw      = hiera('xtradb:debianpw'),
  ){

  file { '/etc/mysql/conf.d/galera.cnf':
    ensure  => 'file',
    owner   => '0',
    group   => '0',
    content => template('xtradb/galera.cnf.erb'),
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/my.cnf':
      ensure  => 'file',
      owner   => '0',
      group   => '0',
      mode    => '0644',
      notify  => Service['mysql'],
      content => template('xtradb/my.cnf.erb'),
  }

   file{ '/etc/mysql/debian.cnf':
      ensure  => 'file',
      owner   => '0',
      group   => '0',
      mode    => '0600',
      content => template('xtradb/debian.cnf.erb'),
  }

  file { '/root/.my.cnf':
      ensure  => 'file',
      owner   => '0',
      group   => '0',
      mode    => '0600',
      content => template('xtradb/root.my.cnf.erb'),
  }
}
