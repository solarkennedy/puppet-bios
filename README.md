Bios 
===
A puppet module for configuring bios settings

Installation
=== 

Requirements / Supported Platforms
=== 
Not all hardware platforms can have their bios changed in a programmatic way.
The sad truth is that **most** platforms require a warm body to change bios 
settings. You are in luck though if you have something like:

* Intel based platforms (using the syscfg tool)
* Dell C-series Servers (using the setupbios tool)

*Important*: This module assumes you have the proper tool installed and in the
path. This is left as an exercise to the reader. I suggest finding the tool 
appropriate for your platform, pick a place to put it, write a wrapper script 
for /usr/bin and use [fpm](https://github.com/jordansissel/fpm) to package 
it all together.

Configuration
=== 

Examples
=== 
```
class { "bios::setting::turbo": enable => true }

class { "bios::setting::fan_pwm_offset": offset => '60' }
```


