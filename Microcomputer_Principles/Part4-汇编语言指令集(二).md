## 3.4 汇编语言语法
---
---
#### 1. 汇编语言语句类型和格式
1. 语句: 是汇编语言汇编和执行的单位. 
2. 汇编语言源程序包括的语句类型为: 指令性语句和指示性语句.
    - 指令性语句: 符号指令(经汇编后, 其机器指令通知cpu进行操作)
    - 指示性语句: 包括伪指令和宏指令
        - 伪指令: 非机器指令, 在汇编链接期间进行操作. 为汇编程序, 链接程序提供汇编链接信息
    - 符号指令和伪指令的区别
    <center><img src="/All_pic/Screenshot 2024-11-06 at 17.30.39.png" width=50%></img></center>
    
    - 指令性语句(符号指令) 和指示性语句(伪指令)的格式
    <center><img src="/All_pic/Screenshot 2024-11-06 at 17.32.18.png" width=50%></img></center>
---
#### 2. 常用伪指令
1. 常用伪指令和运算符
    - 伪指令: DB DW DD EQU =
    - 运算符: $ SEG OFFET PTR 算术运算、逻辑运算、关系运算
    - 数据定义伪指令
        - DB DW DD DF/DQ/DT
    - 符号定义伪指令
        - EQU =
2. 数据定义伪指令
    1. 字节定义伪指令 DB
        - 变量名DB一个或多个用逗号间隔的单字节数
        - 例: N1 DB 12H, 64, -1, 3*3 或 N2 DB ?, ?, ? ;与N2 DB 3 DUP(?) 等价
        - 说明: DB - Define Byte
    2. 字定义伪指令DW
        - 变量名DW一个或多个用逗号间隔的双字节数
        - 例: WNUM DW 1234H, 56, 'AB', 'C'
        - 说明: DW - Define Word 
        - 功能: 通知汇编程序把DW后跟的双字节数, 依次存入, 占两个字节, 小端法, 不足两个字节的00补在前面
    3. 双字定义伪指令DD 
        - 变量名DD一串用逗号间隔的4字节数
        - 例: DNUM DD 12345678H
        - 依次存入, 每个数占4个字节
    4. 多字节定义伪指令DF/DQ/DT
        - DF: 6字节数
        - DQ: 8字节数
        - DT: 10字节数
3. 符号定义伪指令
    1. 等值伪指令EQU
        - NUM EQU 33 ;const NUM = 33
    2. 等号伪指令=
        - NUM = 33 ; NUM = 33
---
#### 3. 常用运算符
1. $运算符
    - $运算符可返回汇编计数器的当前值
    - 应用: $运算符紧跟在DB, DW, DD伪指令后, 统计字符串长度
    - e.g: 数据段有: 
        ```
        BUF DB 'THE QUICK BROWN FOX' ;长度为19
        LLL EQU $-BUF
        汇编后符号常数LLL的值为19
        ```
2. SEG运算符
    - 格式: SEG段名/变量名/标号名
    - 功能: 计算某一逻辑段的段基址
    - e.g: 
        ```
        MOV AX, SEG DATA
        MOV DS, AX
        设"DATA"是数据段的段名, 先算出段基址, 赋给AX, 再转赋DS
        ```
3. OFFSET运算符
    - 格式: OFFSET变量名或标号名
    - 功能: 算出逻辑段中某个变量名或标号名所在单元相对于段首的偏移地址
    - e.g: 设以DATA为段名的数据段中, 存在
        ```
        BUF DB 12H, 34H, 56H
        MOV AX, SEG DATA
        MOV DS, AX
        MOV BX, OFFSET BUF
        MOV AL, [BX] ;Al = 12H
        ```
4. PTR运算符
    - 格式: 类型说明符PTR地址表达式
    <center><img src="/All_pic/Screenshot 2024-11-07 at 22.43.34.png" width=50%></img></center>

    - 使用规则:
        - 指令的操作数至少有一个类型属性要确定, 否则必须用PTR运算符说明其中的内存操作数的类型
        - 若两个操作数的类型属性都确定, 则要保持一致. 否则改变内存操作数类型, 保持前后一致.
    - 类型属性确定的操作数:
        - 寄存器  /  用变量名直接寻址的内存操作数
    - 类型属性不确定的操作数
        - 立即数  /  非变量直接寻址的内存操作数
    <center><img src="/All_pic/Screenshot 2024-11-07 at 22.49.01.png" width=50%></img></center>

---
## 3.5 汇编语言基本指令集一
---
---
#### 1. 通用传送类指令
1. 总说明: 汇编语言指令集分为6类
    - N 立即数
    - R 寄存器操作数
    - M 内存操作数
    - S 段寄存器
2. 通用传送类指令
    - 数据传送指令
    ```
        MOV 目, 源
            R/M, N
            R/M/S, R ; 目标不允许是CS
            R/M, S
            R/S, M ; 目标不允许是CS
    功能: 源 -> 目, 源不变, 不能向段寄存器写入立即数, CS不能做目标寄存器
    ```
    <center><img src="/All_pic/Screenshot 2024-11-08 at 10.53.00.png" width=50%></img></center>

    - 符号扩展/零扩展传送指令
        - MOVSX 目, 源 ; 源符号为向高位扩展, 再送给目标数
        - MOVZX 目, 源 ; 源操作数高位扩展, 再送给目标
        - MOVS/ZX R, R/M
        - 说明: 源不变, 源操作数字长要小于或等于目字长
        - 例: 
            ```
                MOV DL, -16 ; DL = F0H
                MOVSX BX, DL ; BX = FFF0H, DL, DH 不变
                MOVZX, BX, DL ; BX = 00F0H, DL, DH不变
            ```
    - 有效地址传送指令
        ```
            LEA 目, 源
                R16/32, 内存地址表达式

        1. 计算内存单元的有效地址(不是操作数) -> 目标
        2. 有效地址就是偏移地址, LEA指令等效于OFFSET运算符
        ```
    - 交换传送指令
        ```
            XCHG 第一个操作数, 第二个操作数
                 R, R
                 M, R
                 R, M
        1. 完成两个操作数互换
        2. 段寄存器、 立即数不参加互换
        3. 2个内存操作数不能互换, 源, 目类型一致
        ```
---
#### 2. 堆栈操作类指令
1. 堆栈的基本概念
    - 人为设置的一片连续内存区, 用来存放数据, 先进后出规律存取
    - 栈顶: 栈区的低地址
    - 栈低: 栈区的高地址
    - SS(Stack Segment register): 存放堆栈段段基址
    - ESP(SP): 存放堆栈单元的偏移地址
    - SS、ESP(SP)初值, 由程序员赋值或DOS系统自动赋值, SP的大小决定堆栈大小
2. 数据进栈PUSH过程(16位操作数)
     <center><img src="/All_pic/Screenshot 2024-11-08 at 14.48.33.png" width=50%></img></center>
3. 数据出栈POP过程(16位)
    <center><img src="/All_pic/Screenshot 2024-11-08 at 14.50.32.png" width=50%></img></center>
4. 堆栈指令
    - 进栈指令
    ```
        PUSH 源操作数
        N16/32 
        S 
        R16/32
        M16/32
    ```
    - 出栈指令
    ```
        POP 目标操作数
        R16/32
        M16/32
        S(CS非法)
    ```
    - 非直接寻址的内存操作数, 必须用PTR说明属性
    - 例: 
    ```
        1. PUSH WORD PTR [BX]
        2. PUSH AX
           POP BX ; BX = AX
    ```
5. 常见堆栈指令
    1. PUSHA 16位寄存器进栈指令: 依次把AX, CX, DX, BX, SP, BP, SI, DI压栈(2*8字节)
    2. POPA 16位寄存器出栈指令: 从栈顶弹出2*8字节依次存入DI ~ AX
    3. PUSHAD 32位寄存器进栈指令: 依次把EAX ~ EDI 压栈(4*8)
    4. POPAD 32位寄存器出栈指令: 从栈顶弹出4*8字节依次存入EDI ~ EAX 
    5. PUSHF 16位标志寄存器入栈: 将16位标志寄存器Flag的内容压入堆栈保存
    6. POPF 16位标志寄存器出栈: 与PUSHF相反
    7. PUSHFD 32位标志寄存器入栈: 与PUSHF相同但为32位标志寄存器
    8. POPFD 32位标志寄存器出栈: PASS
---
#### 3. 加减运算类指令
1. 二进制加法(add): ADD 目, 源
2. 二进制减法(subtract): SUB 目, 源
3. 二进制加进位(add with carry): ADC 目, 源
4. 二进制减进位(subtract with borrow): SBB 目, 源
<center><img src="/All_pic/Screenshot 2024-11-08 at 15.35.46.png" width=50%></img></center>
<center><img src="/All_pic/Screenshot 2024-11-08 at 15.37.48.png" width=50%></img></center>
<center><img src="/All_pic/Screenshot 2024-11-08 at 15.38.18.png" width=50%></img></center>

1. 二进制加1: INC 目(R/M) ; 不影响C标, AOPSZ都影响, 且非直接寻址的内存操作数, 要用PTR说明
2. 二进制减1: DEC 目(R/M) ; 不影响C标, AOPSZ都影响, 且非直接寻址的内存操作数, 要用PTR说明
    <center><img src="/All_pic/Screenshot 2024-11-08 at 15.42.12.png" width=50%></img></center>
3. 二进制求补(negate): NEG 目(R/M)
    - 功能: 0 - 目 - > 目 ;影响ACOPSZ
    - 应用: 求出目标操作数的负值
4. 比较指令: CMP 目(R/M), 源(与目标等长的R/M)
    - 不破坏源, 但改变6个状态标志
---
#### 4. 乘除运算类指令
1. 无符号二进制数乘法: MUL 乘数
2. 有符号二进制数乘法
    - 格式1: I MUL 乘数
    <center><img src="/All_pic/Screenshot 2024-11-08 at 20.02.22.png" width=50%></img></center>

    - 格式2 and 格式3: I MUL 目, 源 / I MUL 目, 源, 立即数
    <center><img src="/All_pic/Screenshot 2024-11-08 at 20.05.25.png" width=50%></img></center>
3. 无符号二进制数除法: DIV 除数
4. 有符号二进制数除法: IDIV 除数
    <center><img src="/All_pic/Screenshot 2024-11-08 at 20.08.26.png" width=50%></img></center>
---
#### 5. BCD码调整指令
1. 基本概念
    <center><img src="/All_pic/Screenshot 2024-11-09 at 17.12.09.png" width=50%></img></center>
2. BCD调整指令
    <center><img src="/All_pic/Screenshot 2024-11-09 at 17.13.05.png" width=50%></img></center>
3. 组合BCD码加法调整示例
    <center><img src="/All_pic/Screenshot 2024-11-09 at 17.15.12.png" width=50%></img></center>
4. 组合BCD码减法示例
    <center><img src="/All_pic/Screenshot 2024-11-09 at 17.16.00.png" width=50%></img></center>
---
**outline for add/sub/mult/div**
    <center><img src="/All_pic/Screenshot 2024-11-08 at 15.32.12.png" width=50%></img></center>