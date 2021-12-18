# Clean up
echo [INFO] Clean up
rm -rf mnt
rm -f new-flatcar.iso
umount -f /mnt/linux

# Ops
# Extract ISO
echo [INFO] Extract ISO
sudo mkdir /mnt/linux
sudo mount -o loop flatcar_production_iso_image.iso /mnt/linux/
tar -cvf - /mnt/linux | (tar -xf - )

# Extract GZIP CPIO archive
echo [INFO] Extract GZIP CPIO archive
cd mnt/linux/flatcar
gzip -d cpio.gz
    # cpio.gz gets deleted automatically

# Extract CPIO
echo [INFO] Extract CPIO
mkdir cpio_out
cd cpio_out
cpio -id < ../cpio
cd ..
rm cpio

# Extract SquashFs
echo [INFO] Extract SquashFs
cd cpio_out
mkdir unsquash
cd unsquash
unsquashfs -f -d . ../usr.squashfs
cd ..
rm usr.squashfs
cd ..

# Pack SquashFs
echo [INFO] Pack SquashFs
cd cpio_out/unsquash
mksquashfs . ../usr.squashfs
cd ../..

# Pack CPIO
echo [INFO] Pack CPIO
cd cpio_out
ls | cpio --create --format='newc' > ../cpio
cd ..
rm -rf cpio_out

# Pack GZIP CPIO archive
echo [INFO] Pack GZIP CPIO archive
gzip -c cpio > cpio.gz
rm cpio
cd ../../..

# Build new ISO
echo [INFO] Build new ISO
cd mnt/linux
mkisofs -o ../../new-flatcar.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -J -R -V FLATCARNEW .
cd ../..

# Dev
echo [INFO] Dev
ls
