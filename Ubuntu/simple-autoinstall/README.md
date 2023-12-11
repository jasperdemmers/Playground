## Autoinstall
Machines created with this ISO will be automatically setup according to the autoinstall file.

### Features:
- Create user admin with password adminadmin
- post install script
    - Set static IP
    - Set Hostname
    - Set new password for user admin
- Allow SSH from authorized keys
- Set Keyboard layout

## Instructions:

### Step 1) Grab ISO
```bash
mkdir u22.04-autoinstall-ISO
cd u22.04-autoinstall-ISO
mkdir source-files
wget https://cdimage.ubuntu.com/ubuntu-server/jammy/daily-live/current/jammy-live-server-amd64.iso
```

### Step 2) Unpack ISO
7zip is very nice for unpacking ISO since it will create image files for the mbr and efi partitions for you.
```bash
7z -y x jammy-live-server-amd64.iso -osource-files
```
Move the boot directory out of the way and rename it.
```bash
cd source-files
mv  '[BOOT]' ../BOOT
```


**Note:** The rest of the steps are run from within the source-files directory.

### Step 3) Create directories
Create the directory for the user-data and meta-data files.
The meta-data file is just an empty file that cloud-init expects to be present (it would be populated with data needed when using cloud services)
```bash
mkdir server
touch server/meta-data
```

### Step 4) Create user-data file
Create the user-data file.
```bash
nano server/user-data
```

Example file (password is adminadmin):
```bash
#cloud-config
autoinstall:
  storage:
    layout:
      name: lvm
  identity:
    hostname: ubuntu
    username: admin
    password: $6$komvlOeHEY3Vb6To$Nv8K8tvOrSjSXb.7.RehS1oXE/2VU/T0hZXhYRoAo/5UV6J4YkoSWoJHU.MXhKrsBWEc8gwc.LqS6BQD/I.ff0
  kernel:
    package: linux-generic
  keyboard:
    layout: us
    toggle: null
    variant: ''
  locale: en_US.UTF-8
  ssh:
    allow-pw: true
    install-server: true
    authorized-keys: []
  updates: security
  version: 1
  shutdown: reboot
```

### Step 5) Add Menu Entry to GRUB
We will create a new menu entry in the grub menu. To do this edit the grub.cfg file.
```bash
nano boot/grub/grub.cfg
```
Add the following above existing menu entries:
```bash
menuentry "Autoinstall Ubuntu Server" {
        set gfxpayload=keep
        linux   /casper/vmlinuz quiet autoinstall ds=nocloud\;s=/cdrom/server/  ---
        initrd  /casper/initrd
}
```

### Step 6) Generate new ISO
To generate the new ISO, use xorriso.
```bash
xorriso -as mkisofs -r \
  -V 'Ubuntu 22.04 LTS AUTO (EFIBIOS)' \
  -o ../ubuntu-22.04-autoinstall.iso \
  --grub2-mbr ../BOOT/1-Boot-NoEmul.img \
  -partition_offset 16 \
  --mbr-force-bootable \
  -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b ../BOOT/2-Boot-NoEmul.img \
  -appended_part_as_gpt \
  -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
    -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info \
  -eltorito-alt-boot \
  -e '--interval:appended_partition_2:::' \
  -no-emul-boot \
  .
```
