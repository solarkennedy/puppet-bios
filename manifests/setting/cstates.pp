$setting_failure_msg="I don't know how to configure the bios setting $name for $manufacturer"

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

