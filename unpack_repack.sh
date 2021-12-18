# Clean up
# rm -rf linux
rm -rf mnt
rm -f new-flatcar.iso
umount -f /mnt/linux

# Ops
sudo mkdir /mnt/linux
sudo mount -o loop flatcar_production_iso_image.iso /mnt/linux/
tar -cvf - /mnt/linux | (tar -xf - )

cd mnt/linux
mkisofs -o ../../new-flatcar.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V FLATCARNEW .
cd ../..

# Dev
ls
