# Ubuntu RDP

The following is based on a Linode with the following specs:

* Ubuntu 20.10
* 8 GB RAM
* 160 GB Storage
* 4 CPUs

## Install a desktop

### GNOME desktop vanilla

https://linuxconfig.org/how-to-install-gnome-on-ubuntu-20-04-lts-focal-fossa

Probably the quickest way to get a desktop installed, but will have minimal applications.

```sh
apt install gnome-session gdm3 -y
reboot
```

### Full GNOME desktop

https://linuxconfig.org/how-to-install-gnome-on-ubuntu-20-04-lts-focal-fossa

```sh
apt install tasksel
tasksel install ubuntu-desktop
reboot
```

### Cinnamon Desktop

https://itsfoss.com/install-cinnamon-on-ubuntu/

```sh
apt install cinnamon -y
```



## Install XRDP

https://linuxize.com/post/how-to-install-xrdp-on-ubuntu-20-04/

```sh
apt install xrdp -y
systemctl status xrdp
adduser xrdp ssl-cert
systemctl restart xrdp
```

```sh
ufw allow 3389
```

## Add a User

Add a user, if you need to:

```sh
useradd david
passwd david
```

Make the user's home directory, if needed:

```sh
mkdir /home/david
chown david /home/david
```

# My Cinnamon Install

```sh
apt install cinnamon -y
# There will be no default browser with the desktop environment. Select another if you prefer.
apt install firefox -y
apt install xrdp -y
adduser xrdp ssl-cert
systemctl restart xrdp
# The following will make RDP available from any IP address. Unwise, but easy for short term use.
ufw allow 3389
# Change the name, I don't mind.
useradd david
mkdir /home/david
chown david /home/david
# This will be an interactive prompt.
passwd david
```
