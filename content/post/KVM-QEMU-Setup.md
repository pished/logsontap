---
title: "KVM QEMU Setup"
date: 2019-11-18T15:43:01-05:00
lastmod: 2019-11-18T15:43:01-05:00
draft: true
keywords: []
description: ""
tags: []
categories: []
series: []
author: ""

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: false
toc: false
autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false
# You can also define another contentCopyright. e.g. contentCopyright: "This is another copyright."
contentCopyright: false
reward: false
mathjax: false
mathjaxEnableSingleDollar: false
mathjaxEnableAutoNumber: false

# You unlisted posts you might want not want the header or footer to show
hideHeaderAndFooter: false

# You can enable or disable out-of-date content warning for individual post.
# Comment this out to use the global config.
#enableOutdatedInfoWarning: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""

---
VirtualBox and VMware products aren't required on Linux as they are on other operating systems. 
<!--more-->

## Hardware Support

For KVM to work, the hardware needs to support virtualization which is based on the processor. You can check if your machine supports virtualization with the following command

`LC_ALL=C lscpu | grep Virtualization`

If you have an Intel chip it should say VT-x, and for AMD processors it should be AMD-V. Even if nothing is displayed, there is a small chance that virtualization was disabled by default by the manufacturer and you can enable it in the BIOS settings.

## Kernel Support

This is to check if the required kernel modules are present on the system. Enter the following command:

`zgrep CONFIG_KVM /proc/config.gz`

which produces something like

```
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
```

Of the above output, either `CONFIG_KVM_INTEL` or `CONFIG_KVM_INTEL` needs a `y` or `m` to signify that it is available.

Next to ensure that the modules are being loaded, enter the command:

`lsmod | grep kvm`

If you don't get any output - then the modules aren't autoloading. You can manually load a module with the `modprobe` command.

## Put it all together

`sudo pacman -S qemu libvirt ebtables dnsmasq bridge-utils openbsd-netcat virt-manager`

ebtables, and dnsmasq for the default NAT/DHCP networking.
bridge-utils for bridged networking.
openbsd-netcat for remote management over SSH.

`sudo systemctl enable --now libvirtd.service`

Then add yourself to the libvirt group for the polkit agent

`sudo usermod --append --groups libvirt $(whoami)`

To be honest, I am not sure if this last bit is needed, but I did it because I was trying to get the polkit in the wheel group so I wouldn't have to add myself to another group.

```
polkit.addAdminRule(function(action, subject) {
    return ["unix-group:wheel"];
});
```

to `/etc/polkit-1/rules.d/50-default.rules`.