
all:c13_mbr.asm
	nasm -f bin c13_mbr.asm -o mbr.bin
	nasm -f bin c15_core.asm -o core.bin
	nasm -f bin c15.asm -o c15.bin
	-rm myfile.vhd
	dd if=/dev/zero of=mbr.img count=10000
	dd if=mbr.bin of=mbr.img conv=notrunc
	dd if=core.bin of=mbr.img seek=1  conv=notrunc
	dd if=c15.bin of=mbr.img seek=50  conv=notrunc
	dd if=diskdata.txt of=mbr.img seek=100  conv=notrunc
	VBoxManage convertfromraw mbr.img c15.vhd --format VHD
