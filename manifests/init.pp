class gems {
  Exec { cwd => "/usr/local/src", path => ["/usr/bin", "/bin"] } 

  exec { "wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz":
    creates => "/usr/local/src/rubygems-1.3.1.tgz",
    alias => gems-wget   
  }

  exec { "tar -xzf rubygems-1.3.1.tgz":
    creates => "/usr/local/src/rubygems-1.3.1/",
    alias => gems-untar,
    require => Exec['gems-wget']
  }
 
  exec { "ruby setup.rb":
    cwd => "/usr/local/src/rubygems-1.3.1",
    creates => "/usr/bin/gem1.8",
    alias => gems-setup,
    require => Exec['gems-untar']
  }

  file { "/usr/bin/gem":
    target => "/usr/bin/gem1.8",
    ensure => present,
    mode => 755,
    require => Exec['gems-setup'] 
  }
} 
