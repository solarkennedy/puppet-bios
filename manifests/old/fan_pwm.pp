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


