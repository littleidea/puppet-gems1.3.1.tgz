class gems {
  Exec { cwd => "/usr/local/src", path => ["/usr/bin", "/bin"] } 

  exec { gems-wget:
    command => "wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz",
    creates => "/usr/local/src/rubygems-1.3.1.tgz",
  }

  exec { gems-untar:
    command => "tar -xzf rubygems-1.3.1.tgz",
    creates => "/usr/local/src/rubygems-1.3.1/",
    require => Exec['gems-wget']
  }
 
  exec { gems-setup:
    command => "ruby /usr/local/src/rubygems-1.3.1/setup.rb",
    creates => "/usr/bin/gem1.8",
    require => Exec['gems-untar']
  }

  file { "/usr/bin/gem":
    target => "/usr/bin/gem1.8",
    ensure => link,
    require => Exec['gems-setup'] 
  }
} 
