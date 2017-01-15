
all:c13_mbr.asm
	nasm -f bin c13_mbr.asm -o mbr.bin
	nasm -f bin c13_core.asm -o core.bin
	nasm -f bin c13.asm -o c13.bin
	-rm myfile.vhd
	dd if=/dev/zero of=mbr.img count=10000
	dd if=mbr.bin of=mbr.img conv=notrunc
	dd if=core.bin of=mbr.img seek=1  conv=notrunc
	dd if=c13.bin of=mbr.img seek=50  conv=notrunc
	dd if=diskdata.txt of=mbr.img seek=100  conv=notrunc
	VBoxManage convertfromraw mbr.img c13.vhd --format VHD
