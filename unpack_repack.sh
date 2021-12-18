rm -rf linux
umount -f /mnt/linux
sudo mkdir /mnt/linux
sudo mount -o loop flatcar_production_iso_image.iso /mnt/linux/
cd /mnt/
tar -cvf - linux | (cd "/media/cppxaxa/New Volume/Ubuntu_Downloads/custom_flatcar_repo" && tar -xf - )
cd "/media/cppxaxa/New Volume/Ubuntu_Downloads/custom_flatcar_repo/linux/"
mkisofs -o ../new-flatcar.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V FLATCARNEW .

# Dev
cd "/media/cppxaxa/New Volume/Ubuntu_Downloads/custom_flatcar_repo"
