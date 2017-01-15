
ASMFILE=c11_mbr.asm

all:$(ASMFILE)
	nasm -f bin $(ASMFILE) -o mbr.bin
	-rm myfile.vhd
	VBoxManage convertfromraw mbr.bin myfile.vhd --format VHD
