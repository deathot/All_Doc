SYS32_MODE  EQU   0x1F
SWI32_MODE  EQU   0x13
T_bit       EQU	  0x20
MaxSWI      EQU   0x4
	

	AREA SWIStack, DATA, READWRITE
swi_stack SPACE 0x100

	AREA Vect, CODE, READONLY
	CODE32
	ENTRY
; *****************
; Exception Vectors
; *****************

; Note: LDR PC instructions are used here, though branch (B) instructions
; could also be used, unless the ROM is at an address >32MB.

        
        EXPORT	Vector_Table
        
        
Vector_Table		
        LDR     PC, Reset_Addr
        LDR     PC, Undefined_Addr
        LDR     PC, SWI_Addr
        LDR     PC, Prefetch_Addr
        LDR     PC, Abort_Addr
        NOP                             ; Reserved vector
        LDR     PC, IRQ_Addr
        LDR     PC, FIQ_Addr


Reset_Addr      DCD     Reset_Handler
Undefined_Addr  DCD     Undefined_Handler
SWI_Addr        DCD     SWI_Handler
Prefetch_Addr   DCD     Prefetch_Handler
Abort_Addr      DCD     Abort_Handler
				DCD		0
IRQ_Addr        DCD     IRQ_Handler
FIQ_Addr        DCD     FIQ_Handler



; ************************
; Exception Handlers
; ************************

; The following dummy handlers do not do anything useful in this example.
; They are set up here for completeness.

Undefined_Handler
        B       Undefined_Handler
;SWI_Handler
;        B       SWI_Handler	     
Prefetch_Handler
        B       Prefetch_Handler
Abort_Handler
        B       Abort_Handler
		NOP
IRQ_Handler
        B       IRQ_Handler
FIQ_Handler
        B       FIQ_Handler   

     
        
Reset_Handler

	   
   ;设置SWI的中断栈
	LDR   	R0,=swi_stack
	ADD   	R0,R0,#0x100
	MOV   	sp,R0

	MRS 	R0,CPSR                   ;复制CPSR 到R0
    BIC 	R0,R0,#0x1F               ;清除R0的后5 位
    ORR 	R0,R0,#SYS32_MODE         ;设定R0的最后5位为11111
	MSR 	CPSR_c,R0                 ;把R0 装载到CPSR,切换到系统模式
  
	MOV     R0,#0xffffffff  
	SWI     0x4                       ;产生中断号为2的软中断
	MOV     R1,#0xffffffff

in_loop
	B          in_loop
     

   
SWI_Handler	

 ;保存被中断任务的寄存器现场
  
   STMFD	  SP!, {R0-R12, lr}  
   MOV        R1,SP            ;保存堆栈指针在R1中，R1被作为第二个参数传递给子程序   
 
   MRS        R0, SPSR
   TST        R0, #T_bit	
   LDRNEH     R0, [lr,#-2]     ;Thumb态:指令中的8立即数表示SWI功能号
   BICNE      R0, R0, #0xff00  
   LDREQ      R0, [lr,#-4]      
   BICEQ      R0, R0, #0xff000000   ;ARM状态：指令中的24位立即数表示SWI功能号
     
   CMP        R0,#MaxSWI
   LDRLS      PC,[PC,R0,LSL #2]  
   B          SWIOutOfRange    
   
;***************** 用DCD定义各功能函数入口地址 *********************

SWIJumpTable
   DCD        SWInum0
   DCD        SWInum1
   DCD        SWInum2
   DCD        SWInum3
   DCD        SWInum4
   
;*****************恢复现场，原先保存的寄存器出栈********************

EndofSWI
 
   LDMFD	  SP!, {R0-R12, pc}^
   
;************** 0号中断处理函数，将R0-2置为0x00000000 ***************
SWInum0
   
   MOV        R0,#0x0
   MOV        R1,#0x0
   MOV        R2,#0x0
   B          EndofSWI

;*************** 1号中断处理函数，将R0-2置为0x11111111 **************
SWInum1
   
   MOV        R0,#0x1
   MOV        R1,#0x1
   MOV        R2,#0x1
   B          EndofSWI

;*************** 2号中断处理函数，将R0-2置为0x22222222 **************
SWInum2
   
   MOV        R0,#0x2
   MOV        R1,#0x2
   MOV        R2,#0x2
   B          EndofSWI

;*************** 3号中断处理函数，将R0-2置为0x33333333 **************
SWInum3
   
   MOV        R0,#0x3
   MOV        R1,#0x3
   MOV        R2,#0x3
   B          EndofSWI
   
;*************** 4号中断处理函数，将R0-2置为0x44444444 **************
SWInum4
   
   MOV        R0,#0x4
   MOV        R1,#0x4
   MOV        R2,#0x4
   B          EndofSWI

   
;**************** 中断处理函数，将R0-2置为0xffffffff ****************
SWIOutOfRange
    
   MOV        R0,#0xffffffff
   MOV        R1,#0xffffffff
   MOV        R2,#0xffffffff
   B          EndofSWI   
   
   END
   


