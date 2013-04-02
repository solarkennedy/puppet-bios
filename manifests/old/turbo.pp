$setting_failure_msg="I don't know how to configure the bios setting $name for $manufacturer"
class bios::setting::turbo($enable=true) { 
  if $bios::syscfg_command {
    case $enable {
      true, '1', 'enable','on', 'true':      { $set_value=1 $expect_value='Enabled' }
      false, '0', 'disable', 'off', 'false': { $set_value=0 $expect_value='Disabled' }
    }
    exec { "$bios::syscfg_command /bcs 'Processor Configuration' 'Intel(R) Turbo Boost Technology' $set_value":
      unless => "$bios::syscfg_command /d biossettings 'Intel(R) Turbo Boost Technology' | grep 'Current Value' | grep $expect_value",
      provider => [ shell => 'sh' ]
    }
  } 
  elsif $bios::setupbios_command {
    case $enable {
      true, '1', 'enable','on', 'true':      { $set_value='enabled'  }
      false, '0', 'disable', 'off', 'false': { $set_value='disabled' }
    }
    exec { "$bios::setupbios_command setting set turbo_mode $set_value":
      unless => "$bios::setupbios_command setting get turbo_mode | grep $set_value",
      provider => [ shell => 'sh' ]
    }
  }
  else { notify($setting_failure_msg) }
}

