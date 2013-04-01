$setting_failure_msg="I don't know how to configure the bios setting $name for $manufacturer"

class bios::setting::fan_pwm_offset($offset='100') {
  if $bios::syscfg_command {
    exec { "$bios::syscfg_command /bcs 'System Acoustic and Performance Configuration' 'Fan PWM Offset' $offset":
      unless => "$bios::syscfg_command /d biossettings 'Fan PWM Offset' | grep 'Current Value' | grep $offset",
      provider => [ shell => 'sh' ]
    }
  }
  else { notify($setting_failure_msg) }
}

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

class bios::setting::c_states($enable=true) {
  if $bios::setupbios_command {
    case $enable {
      true, '1', 'enable','on', 'true':      { $set_value='enabled'  }
      false, '0', 'disable', 'off', 'false': { $set_value='disabled' }
    }
    exec { "$bios::setupbios_command setting set c_states $set_value":
      unless => "$bios::setupbios_command setting get c_states | grep $set_value",
      provider => [ shell => 'sh' ]
    }
  }
  else { notify($setting_failure_msg) }
}

