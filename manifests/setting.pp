define bios::setting ($setting = $title, $value, $expect=$value){
  case $bios::make {
    'Intel' : { 
      # Handle running syscfg for Intel platforms
      # Sometimes syscfg returns a different value then what you set
      # so we provide the $expect variable to let it know what to expect if it worked
      exec { "$bios::syscfg_command /bcs '$section' '$setting' $set_value":
        unless => "$bios::syscfg_command /d biossettings '$setting' | grep 'Current Value' | grep $expect_value",
        provider => [ shell => 'sh' ]
      }
    }

    'Dell'  : {
      # Handle running setupbios on dell platforms. 
      # setupbios setting get will always return the same value for set
      exec { "$bios::setupbios_command setting set $setting $value":
        unless => "$bios::setupbios_command setting get $setting | grep $value",
        provider => [ shell => 'sh' ]
      }
    }

    default : fail('Bios Setting is not supported on this make: $bios::make")
  }
}
