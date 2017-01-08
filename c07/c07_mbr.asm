         ;代码清单7-1
         ;文件名：c07_mbr.asm
         ;文件说明：硬盘主引导扇区代码
         ;创建日期：2011-4-13 18:02
         
         jmp near start
	
 message db '1+2+3+...+100='
        
 start:
         mov ax,0x7c0           ;设置数据段的段基地址 
         mov ds,ax

         mov ax,0xb800          ;设置附加段基址到显示缓冲区
         mov es,ax

         ;以下显示字符串 
         mov si,message         ;si存放字符串内存地址
         mov di,0               ;di存放显示缓冲区索引
         mov cx,start-message   ;cx保存字符串数量
     @g:
         mov al,[si]            ;把字符串赋值给al寄存器
         mov [es:di],al         ;通过al寄存器存放到显示缓冲区
         inc di                 ;递增显示缓冲区索引，下一个字节要保存显示属性
         mov byte [es:di],0x07  ;显示属性
         inc di                 ;递增显示缓冲区索引
         inc si                 ;指向下一个字符串的字符
         loop @g                ;cx不为0时一直循环下去

         ;以下计算1到100的和 
         xor ax,ax              ;清零ax寄存器，用于保存最后计算的和
         mov cx,1               ;cx寄存器保存循环计数
     @f:
         add ax,cx              ;累加结果保存到ax中
         inc cx                 ;递增cx
         cmp cx,100             ;与100进行比较
         jle @f                 ;小于100时继续执行循环

         ;以下计算累加和的每个数位 
         xor cx,cx              ;设置堆栈段的段基地址
         mov ss,cx              ;堆栈段的段地址为0
         mov sp,cx              ;sp指针也为0

         mov bx,10              ;bx保存除数
         xor cx,cx              ;cx用来保存下面的求余数操作中共有多少余数
     @d:
         inc cx                 ;递增cx寄存器，也就是保存余数的位数
         xor dx,dx              ;清零bx寄存器，用于保存余数
         div bx                 ;除以bx
         or dl,0x30             ;余数与0x30或，得到ASCII码
         push dx                ;将结果保存到堆栈中
         cmp ax,0               ;
         jne @d

         ;以下显示各个数位，此时cx寄存器中的值为上面计算得到的余数的位数，将作为循环终止的条件
     @a:
         pop dx                 ;依次将前面保存在堆栈中的结果取出来
         mov [es:di],dl         ;送入到显示缓冲区中
         inc di                 ;递增显示缓冲区指针，用于保存显示属性
         mov byte [es:di],0x07  ;保存显示属性
         inc di                 ;递增显示缓冲区指针
         loop @a                ;cx不为0时继续循环
       
         jmp near $ 
       

times 510-($-$$) db 0
                 db 0x55,0xaa
