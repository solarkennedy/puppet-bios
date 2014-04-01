define bios::setting (
  $value, 
  $setting = $title, 
  $expect  = $value, 
  $section = ''
){
  include bios
  case $bios::make {
    'Intel': {
      # Handle running syscfg for Intel platforms
      # Sometimes syscfg returns a different value then what you set
      # so we provide the $expect variable to let it know what to expect if it worked
      exec { "syscfg /bcs '${section}' '${setting}' '${value}'":
        unless   => "syscfg /d biossettings '${setting}' | grep 'Current Value' | sed 's/Current Value : //g' | grep ${expect}",
        provider => [ shell => 'sh' ]
      }
    }

    'Dell': {
      # Handle running setupbios on dell platforms.
      # setupbios setting get will always return the same value for set
      exec { "setupbios setting set ${setting} ${value}":
        unless   => "setupbios setting get ${setting} | grep ${value}",
        provider => [ shell => 'sh' ]
      }
    }

    default: { fail("Bios Setting is not supported on this make: ${bios::make}") }
  }
}
