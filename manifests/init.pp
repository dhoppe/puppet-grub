class grub (
  $grub_password = $grub::params::password,
  $grub_timeout  = $grub::params::timeout
) inherits grub::params {

  validate_string(hiera('password'))
  validate_string(hiera('timeout'))

  exec { 'update-grub':
    command     => 'update-grub',
    refreshonly => true,
  }

  file { '/etc/default/grub':
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("grub/${::lsbdistcodename}/etc/default/grub.erb"),
    notify  => Exec['update-grub'],
    require => Package['grub-pc'],
  }

  file { '/etc/grub.d/00_header':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("grub/${::lsbdistcodename}/etc/grub.d/00_header.erb"),
    notify  => Exec['update-grub'],
    require => Package['grub-pc'],
  }

  file { '/etc/grub.d/10_linux':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("grub/${::lsbdistcodename}/etc/grub.d/10_linux.erb"),
    notify  => Exec['update-grub'],
    require => Package['grub-pc'],
  }

  file { '/etc/grub.d/40_custom':
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => 'puppet:///modules/grub/common/etc/grub.d/40_custom',
    notify  => Exec['update-grub'],
    require => Package['grub-pc'],
  }

  package { 'grub-pc':
    ensure => present,
  }
}