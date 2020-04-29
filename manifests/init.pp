# -----------------------------------------------------------------------------------
# Description: New Relic Infrastructure Agent
#
# Reviewer: elserhumano@gmail.com
#
# Date: 04/2020
#
# -----------------------------------------------------------------------------------
#   include newrelic_agent

class newrelic_agent {

  # Create the configuration yaml file.
  file { '/etc/newrelic-infra.yml':
    ensure  => 'present',
  }

  # Add a line to the configuration file.
  file_line { 'add config to file':
    ensure  => 'present',
    path    => '/etc/newrelic-infra.yml',
    line    => 'license_key: eu01xxcdff23f21c191b047c68330ea7a899NRAL',
    require => File['/etc/newrelic-infra.yml'],
  }

  # Configure the repo in yum.
  yumrepo { 'newrelic-infra':
    enabled  => 1,
    descr    => 'New Relic Infrastructure repo',
    baseurl  => 'https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64',
    gpgcheck => 0,
    require  => File_line['add config to file'],
  }

  # Install the agent using yum.
  package { 'newrelic-infra':
    ensure  => 'installed',
    require => Yumrepo['newrelic-infra'],
  }
}
