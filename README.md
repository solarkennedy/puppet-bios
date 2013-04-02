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
As long as you have the tool installed in the default path, there shouldn't 
need to be any configuration. It sets up a defined type that you can use 
over and over for each bios setting you need.

Examples
=== 
```
# Easy to set on a dell
bios::setting {'turbo_mode': value => 'disabled' }

# Intel requires some more hand holding with turbo. You set 1/0 and expect Enabled/Disabled..
bios::setting {'Intel(R) Turbo Boost Technology': value => '0', expect => 'Disabled', section => 'Processor Configuration' }

# Set fan speed on intel:
bios::setting {'Fan PWM Offset': value => '100', section => 'System Acoustic and Performance Configuration' }

# Disabled Cstates on dell:
bios::setting {'c_states': value => 'disabled' }

```

What?
===
Where did I get these magic words? How do I know what section to use?
How do I know what valid inputs are for "value" and when to "expect" something
different?

I don't have a good answer. You can look in the docs folder for some example
outputs of these commands. At first I attempted to have puppet validate inputs
to abstract over some of this, but there are just so many possible combinations
of platform/bios revision/hardware/etc. It is much more sane to let the tool
itself validate your inputs. (the tool is the single point of truth)
