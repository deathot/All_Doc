a  EQU  12                                ; 定义常量a ,并赋值12         
b  EQU  3                                 ; 定义常量b,并赋值3                
c  EQU  7	                              ; 定义常量c，并赋值7                 

		AREA SWIStack, DATA, READWRITE
temp 	DCD 0x0

        AREA Test1,CODE,READONLY
        CODE32
        ENTRY
 
START   MOV   r0,#a                       ; 将r0置为a                           
	    MOV   r0,r0,lsl #8	              ; r0=r0<<8,相当于将a乘以2的8次幂       
	    MOV   r1,#b		                  ; 将r1置为b			       
	    ADD   r2 , r0 ,r1 ,lsr #1         ; r2=r0+r1>>1,将r1的值除以2加上r0放入r2 
	    LDR   r3 , =temp 	              ; 取数据缓冲区地址	       
	    STR   r2 , [r3]	                  ; 将运算结果放入缓冲区	
	
	
	    MOV   r0 , #c	                  ; 将r0置为c    
	    AND   r0 ,r0 ,#0xFF		          ; r0=r0&0xFF	 
	    MOV   r1 , #b			          ; 将r1置为b     
	    ADD   r2 , r0 ,r1 ,lsr  #1        ; r2=r0+r1>>1,将r1的值除以2加上r0放入r2 
	
	
	    LDR   r0 , [r3]	                  ; 从缓冲区中取出第一次的运算结果           
	    MOV   r1 ,#0x01	                  ; 将r1置为1		  
	    ORR   r0 ,r0 ,r1	              ; r0=r0 | r1 		
	    MOV   r1 ,r2		              ; 将第二次运算结果放入r1	       
	    ADD   r2 ,r0 ,r1 ,lsr  #1	      ; r2=r0+r1>>1,将r1的值除以2加上r0放入r2

        B     START

        END	                       

