         ;代码清单6-1
         ;文件名：c06_mbr.asm
         ;文件说明：硬盘主引导扇区代码
         ;创建日期：2011-4-12 22:12 
      
         jmp near start
         
  mytext db 'L',0x07,'a',0x07,'b',0x07,'e',0x07,'l',0x07,' ',0x07,'o',0x07,\
            'f',0x07,'f',0x07,'s',0x07,'e',0x07,'t',0x07,':',0x07
  number db 0,0,0,0,0
  
  start:
         mov ax,0x7c0                  ;设置数据段基地址 
         mov ds,ax
         
         mov ax,0xb800                 ;设置附加段基地址 
         mov es,ax
         
         cld
         ;movsw指令的源地址由ds:si指定，目的地址由es:di指定
         ;次数由cx指定
         mov si,mytext                 
         mov di,0
         ;除以2是因为mytext定义的是db格式，而下面使用movsw指令
         mov cx,(number-mytext)/2      ;实际上等于 13
         rep movsw                      ;执行cx次movsw操作
     
         ;得到标号所代表的偏移地址
         mov ax,number
         
         ;计算各个数位
         mov bx,ax                      ;bx做为内存地址索引
         mov cx,5                      ;循环次数 
         mov si,10                     ;除数 
  digit: 
         xor dx,dx                      ;每次计算前将余数清零
         div si
         mov [bx],dl                   ;保存数位
         inc bx                         ;bx做为内存地址索引
         loop digit                     ;当cx大于0时循环一直执行下去
         
         ;显示各个数位
         mov bx,number                  ;偏移地址保存在bx中
         mov si,4                       ;个数保存在si中
   show:
         mov al,[bx+si]                 ;取其中一位保存在al中
         add al,0x30                    ;加0x30得到对应的ASCII码
         mov ah,0x04                    ;显示属性是黑底红字
         mov [es:di],ax                 ;存储到显示缓冲区
         add di,2                       ;移动到下一个显示缓冲区，加2是因为ASCII需要两个字节
         dec si                         ;移动到下一个需要显示的数位
         jns show                       ;jns当SF不为1时则跳转，上一条指令dec si计算之后，如果si小于0，则SF为1
         
         mov word [es:di],0x0744

         jmp near $

  times 510-($-$$) db 0                 ;$为当前汇编代码行标记，$$为nasm提供的当前汇编段的起始汇编地址，510是512-2字节(0x55,0xaa共两字节)
                   db 0x55,0xaa
