

all:c05_mbr.asm
	nasm -f bin c05_mbr.asm -o mbr.bin
	rm myfile.vhd
	VBoxManage convertfromraw mbr.bin myfile.vhd --format VHD
