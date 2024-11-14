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
---
#### 9. 移位类指令
1. 示例图
    <center><img src="/All_pic/Screenshot 2024-11-10 at 14.35.39.png" width=50%></img></center>
2. 总结
    <center><img src="/All_pic/Screenshot 2024-11-10 at 14.37.43.png" width=50%></img></center>
---
#### 10. 串操作指令一
1. 串的定义: 若干相同类型元素构成的序列
    - 80X86有6条串操作指令: 串传送、 串比较、 串搜索、 串装入、 串存储、 I/O串操作
2. 串传送指令
    1. 格式: MOVSB/W/D, 分别是字节串/字串/双字串传送
    2. 功能: 把DS: [SI]的一个元素 -> ES: [DI]的若干单元(把源串SI间址的元素, 送到目标串也就是附加段DI间址的单元)
        - 元素: 字节串传送, 一个元素就是1个字节...
    3. 修改串指针的操作: D = 0 时为增址型, D = 1 时为减址型
    4. 有重复前缀的格式 
       - REP MOVSB/W/D
3. 串装入指令
    <center><img src="/All_pic/Screenshot 2024-11-10 at 15.33.35.png" width=50%></img></center>
4. 串存储指令
    <center><img src="/All_pic/Screenshot 2024-11-10 at 15.34.27.png" width=50%></img></center>
    <center><img src="/All_pic/Screenshot 2024-11-10 at 15.34.55.png" width=50%></img></center>
---
#### 10. 串操作指令二
1. 串比较指令
    - 基本型: CMPSB/W/D
    - 准备工作: 源串首/末地址 -> DS:SI, 目串首/末地址: ES:DI, 0/1 -> D标
    - 有重复前缀型: 
        - REPE CMP~ ; 当前元素相等继续比较, 不相等退出循环
        - REPNE CMP~ ; 与上反
     <center><img src="/All_pic/Screenshot 2024-11-13 at 22.14.51.png" width=50%></img></center>
2. 串搜索指令
    - 基本型: SCASB/W/D
    - 准备工作: 目标区首/末地址 -> ES:DI, 0/1 -> D标, 关键字 -> AL/AX/EAX
    - 功能: 比较AL/AX/EAX = ES:[DI]?, 若ES:[DI] = 关键字, Z置1, 否则0, 修改DI
    - 有重复前缀型:
        - REPE SCAS~ ; 相等继续循环, 不相等退出循环
        - REPNE SCAS~ ; 与上相反
