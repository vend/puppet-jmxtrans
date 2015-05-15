# == Class jmxtrans
# Installs a jmxtrans package and ensures that the jmxtrans service is running.
# The jmxtrans::metrics define includes this class, so you probably don't
# need to use it directly.
#
# == Parameters
# $run_interval - seconds between runs of jmx queries.  Default: 15
# $log_level    - level at which to log jmxtrans messages.  Default: 'info'
# $heap_size    - number of MB to use as max and starting heap size. Default: 512
# $jar_file     - string path to jmxtrans jar. Default: undef - means will not be included in defaults file
#
class jmxtrans(
  $run_interval = 15,
  $log_level    = 'info',
  $heap_size    = 512,
  $jar_file     = undef
) {
  package {
    'jmxtrans':
      ensure  => 'installed';
  }

  file {
    '/etc/default/jmxtrans':
      content => template('jmxtrans/jmxtrans.default.erb');
  }

  service {
    'jmxtrans':
      ensure    => 'running',
      enable    => true,
      require   => Package['jmxtrans'],
      subscribe => File['/etc/default/jmxtrans'];
  }
}
