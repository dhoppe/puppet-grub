class grub::params {
  case $::lsbdistcodename {
    'squeeze', 'natty': {
      $password = hiera('password')
      $timeout  = hiera('timeout')
    }
    default: {
      fail("Module ${module_name} does not support ${::lsbdistcodename}")
    }
  }
}
