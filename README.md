# Linux Dotfiles
All of the dotfiles used for setting up Ubuntu Linux 20.04 programs.  

## Dependencies

* [zsh & ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
* [NeoVim](https://github.com/neovim/neovim)
* [tmux & tmuxinator](https://github.com/tmux/tmux)
* [i3](https://i3wm.org/)

## Instructions

First clone the repository as follows:

```bash
git clone https://github.com/lmark1/linux_dotfiles
cd linux_dotfiles
git submodule update --init --recursive
```

Go to a desired folder and start executing scripts!  
**NOTE** Some programs may be dependant on others.

## Troubleshooting 

### How to make Lenovo Legion work properly for Ubuntu Linux 20.04 - 5.8.0-50-generic kernel - Realtek RTL8822BE WiFi Adapter?

Credits to [linuxmint.com - lenovo legion y530 wifi problem](https://forums.linuxmint.com/viewtopic.php?t=345409&start=20).
```bash
# 1) displays wifi info with inxi
sudo apt install inxi
inxi -Fxz

# 2) displays diasbled/enabled list of devices.
rfkill list

# If devices are disabled, enable them, e.g. rfkill unblock bluetooth

# 3) Download, build and install new drivers
sudo apt install dkms git build-essential
git clone -b extended git@github.com:lmark1/lwfinger-rtlwifi_new.git
sudo dkms add ./lwfinger-rtlwifi_new
sudo dkms install rtlwifi-new/0.6
sudo cp -r lwfinger-rtlwifi_new/firmware/rtlwifi/ /lib/firmware/rtlwifi
echo "blacklist r8822be" | sudo tee /etc/modprobe.d/r8822be.conf

# 4) Reboot and Disable Secure Boot. Note - Secure boot automatically disabled in Legacy Mode.
echo "options rtl8822be aspm=0 ips=N" | sudo tee /etc/modprobe.d/rtl8822be.conf

# 5) Reboot
options rtl8822be aspm=0 ips=N

# 6) Reboot! Hopefully wifi works properly now.
```

## Credits

Thanks to [klaxalk/linux_setup](https://github.com/klaxalk/linux-setup/).