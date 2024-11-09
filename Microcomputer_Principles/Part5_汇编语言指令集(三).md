## 3.5 汇编语言基本指令二
---
---
#### 6. 转移类指令
1. 转移类指令分类
    - 无条件和有条件转移
    - 段内和段间转移
    - 直接和间接转移
2. 无条件转移
    <center><img src="/All_pic/Screenshot 2024-11-09 at 20.36.52.png" width=50%></img></center>

    - SHORT是短转移, +129 ~ -126之间
    - 段内JMP标号, 实模式下, 可转移到64k代码段任何位置
3. 有条件转移
    - 一般格式: 操作码助记符  转移地址标号
    - 应用: CMP 目, 源(条件转移指令)
    - 转移范围: 代码段任何位置
    - 说明: 操作码助记符隐含转移条件
4. 按标志位的当前状态转移
    <center><img src="/All_pic/Screenshot 2024-11-09 at 20.41.59.png" width=50%></img></center>
5. 有/无符号条件转移
   1. 无符号数条件转移
       - 应用: CMP N1, N2 ; N1, 2 无符号
       <center><img src="/All_pic/Screenshot 2024-11-09 at 20.43.46.png" width=50%></img></center>
   2. 有符号数条件转移
       <center><img src="/All_pic/Screenshot 2024-11-09 at 20.44.16.png" width=50%></img></center>
6. 循环控制转移
    <center><img src="/All_pic/Screenshot 2024-11-09 at 20.46.06.png" width=50%></img></center>
7. 例题
    <center><img src="/All_pic/Screenshot 2024-11-09 at 20.48.52.png" width=50%></img></center>

    ```
        MOV AX, SEG SCORE
        MOV DS, AX
        MOV BX, OFFECT SCORE
        MOV CX, 40
        MOV DL, 0
    LAST: CMP BYTE PTR [BX], 60
        JC NO
        INC DL
    NO: INC BX
        LOOP LAST
        MOV OK, DL   
    RETURN DOS 
    ```
8. 总结
    - 无条件转移 JMP
    - 常用条件转移 JZ JNZ JG JL JGE JLE JA JNA JC JNC
    - 常用循环控制指令 LOOP
---
#### 7. 调用类指令
1. 过程定义语句
    - 格式
    ```
        过程名 PROC 属性
              子程序实体
              RET
        过程名 ENDP
    NEAR: 子程序和调用在同一个代码段
    FAR: 同上反
    ```
2. 段内调用CALL指令
    - 直接调用 CALL 过程名
    - 间接调用 
      - CALL 寄存器操作数
      - CALL 内存操作数
    - 功能
        - 断点偏移地址 -> 堆栈
        - 子程序入口的偏移地址 -> IP从而转子程序 
3. 段间调用CALL指令
    <center><img src="/All_pic/Screenshot 2024-11-09 at 21.49.02.png" width=50%></img></center>
4. 段内/段间返回RET指令
    <center><img src="/All_pic/Screenshot 2024-11-09 at 21.50.18.png" width=50%></img></center>
5. 总结
    <center><img src="/All_pic/Screenshot 2024-11-09 at 21.52.38.png" width=50%></img></center>
---
#### 8. 逻辑类指令
1. 指令总结
    <center><img src="/All_pic/Screenshot 2024-11-09 at 22.02.35.png" width=50%></img></center>
