#/usr/bin/env sh

# Based on https://docs.cumulusnetworks.com/display/VX/Vagrant+and+Libvirt+with+KVM+or+QEMU

# Assums Vagrant has already been installed

sudo apt-get install libvirt-bin libvirt-dev qemu-utils qemu
sudo /etc/init.d/libvirt-bin restart

vagrant plugin install vagrant-mutate
vagrant plugin install vagrant-libvirt



