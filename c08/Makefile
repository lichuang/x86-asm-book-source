
all:c08_mbr.asm
	nasm -f bin c08_mbr.asm -o c08_mbr.bin
	nasm -f bin c08.asm -o c08.bin
	-rm myfile.vhd
	dd if=/dev/zero of=mbr.img count=10000
	dd if=c08_mbr.bin of=mbr.img conv=notrunc
	dd if=c08.bin of=mbr.img seek=100  conv=notrunc
	VBoxManage convertfromraw mbr.img myfile.vhd --format VHD
