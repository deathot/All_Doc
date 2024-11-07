
     AREA Test2,CODE,READONLY
     CODE32
     ENTRY

START
       B Reset_Handler

Undefined_Handler
       B Undefined_Handler

SWI_Handler
       B SWI_Handler

Prefetch_Handler
       B Prefetch_Handler

Abort_Handler
       B Abort_Handler
       
IRQ_Handler
       B IRQ_Handler
       
FIQ_Handler
       B FIQ_Handler

Reset_Handler

;进入System模式

       MRS R0,CPSR                   ;复制CPSR 到R0
       BIC R0,R0,#0x1F               ;清除R0 的后5 位
       ORR R0,R0,#0x1F               ;设定R0 的最后5 位为11111
       MSR CPSR_c,R0                 ;把R0 装载到CPSR,切换到系统模式
       
       MOV R0,#1                     ;对系统模式下的R0赋值,下面的R1~R14一样
       MOV R1,#2
       MOV R2,#3
       MOV R3,#4
       MOV R4,#5
       MOV R5,#6
       MOV R6,#7
       MOV R7,#8
       MOV R8,#9
       MOV R9,#10
       MOV R10,#11
       MOV R11,#12
       MOV R12,#13
       MOV R13,#14
       MOV R14,#15

;进入FIQ模式

       MRS R0,CPSR
       BIC R0,R0,#0x1F
       ORR R0,R0,#0x11               ;设定R0 的最后5位为10001
       MSR CPSR_c,R0                 ;把R0 装载到CPSR,切换到Fiq 模式
       
       MOV R8,#16                    ;给Fiq 模式的特有缓存器R8 赋值,下面的R9~R14一样
       MOV R9,#17
       MOV R10,#18      
       MOV R11,#19
       MOV R12,#20
       MOV R13,#21
       MOV R14,#22

;进入IRQ模式

       MRS R0,CPSR
       BIC R0,R0,#0x1F
       ORR R0,R0,#0x12               ;设定R0 的最后5 位为10010
       MSR CPSR_c,R0                 ;把R0 装载到CPSR,切换到IRQ 模式
      
       MOV R13,#23                   ;给IRQ 模式的特有缓存器R13 赋值,下面的R14一样
       MOV R14,#24

;进入SVC模式

       MRS R0,CPSR
       BIC R0,R0,#0x1F
       ORR R0,R0,#0x13               ;设定R0 的最后5 位为10011
       MSR CPSR_c,R0                 ;把R0 装载到CPSR,切换到Svc 模式
      
       MOV R13,#25                   ;给SVC 模式的特有缓存器R13 赋值, 下面的R14 一样
       MOV R14,#26

;进入Abort模式

       MRS R0,CPSR
       BIC R0,R0,#0x1F
       ORR R0,R0,#0x17               ;设定R0 的最后5 位为10111
       MSR CPSR_c,R0                 ;把R0 装载到CPSR,切换到Abort 模式
       
       MOV R13,#27                   ;给Abort 模式的特有缓存器R13 赋值, 下面的R14 一样
       MOV R14,#28

;进入UNDEF模式

       MRS R0,CPSR
       BIC R0,R0,#0x1F
       ORR R0,R0,#0x1b               ;设定R0 的最后5 位为11011
       MSR CPSR_c,R0                 ;把R0 装载到CPSR,切换到UNDEF 模式

       MOV R13, #29                  ;给UNDEF 模式的特有缓存器R13 赋值, 下面的R14 一样
       MOV R14, #30

       B Reset_Handler               ;跳移到Reset_Handler循环

       END

