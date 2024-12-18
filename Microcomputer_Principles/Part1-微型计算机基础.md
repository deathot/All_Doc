### 1.1-计算机中的信息表示
1. **计算机中的数制**
> 1. 常用进数制
>> - H(hex)十六进制
>> - D(decimal)十进制
>> - B(binary)二进制
>> - O(octal)八进制
> 2. 数制转换
>> - **二进制->十进制 != 十进制的BCD码**
2. **计算机中的信息表示**
> 1. 字符的编码--ASCII码
>> - <center><img src="All_pic/Screenshot 2024-09-18 at 2.24.55 PM.png" width></img></center>
>> - 键入"1", 实际写入键盘存储区的是31H, 即00110001B
>> - 欲显示"0", 应把30H既00110000B -> 显示存储区
> 2. 十进制数的二进制编码--BCD码
>> - 紧凑型: (37)D = (0011, 0111)<sub>BCD</sub>
>> - 非紧凑型: (37)D = (0000, 0011)<sub>BCD</sub>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;(0000, 0111)<sub>BCD</sub>
> 3. 有符号数的编码--原、反、补码
>> - 机器数比真值数多一个符号位
>> - 正数的原、反、补与真值数相同
>> - **负数原码**的数值部分与**真值**相同;反码为按位取反;补码为反码+1;
>> - 真值与机器数的转换(设字长n=8)
>>> 1. x = (-120)<sub>10</sub> = (-1111000)<sub>2</sub>
则[x]<sub>补</sub> = (10000111+1)<sub>2</sub> = (10001000)<sub>2</sub> = (88)<sub>16</sub>
3. **整数补码运算**
> 1. 求补运算
>> - **[+X]补 按位取反 末位加1 得[-X]补**
>> - 机器字长=8, X=+75, 则[X]补 = 01001011
X =-75, 则[X]补=10110101
> 2. 整数补码的加减运算
>> - **[x+y]补 = [x]补 + [y]补
[x-y]补 = [x]补 + [-y]补**
>> - **定字长**的机器, 表示的数值**有范围**, 超出范围时的数据表示**出错**。
> 3. 溢出和进位的概念
>> - CF(C为进位标志-无符号数)
>> - OF(O为溢出标志-有符号数)
---
### 1.2-微型计算机系统的基本组成
1. **微型计算机系统的基本组成**
> 1. 计算机系统组成
>> - 硬件
>> - 软件
> 2. 微型机的硬件结构
>> - 微型计算机/微型计算机系统
>> - 存储器、I/O接口/设备、总线、CPU
>>> 1. *I/O设备不能直接与CPU交换信息* 
> 3. 计算机的工作过程
>> - **取指令** -> 指令译码 -> **取操作数** -> 执行指令 -> **回送结果**
> 4. 习题
>> - 20根地址线所能寻址的存储器容量是是1M, 14根地址线所能寻址的存储器容量是多少?
>>> 因为2^20=1048576=1M, 所以2^14=16384=16K
>> - 20根地址线所能寻址的存储器地址范围是00000H~FFFFFH，14根地址线所能寻址的存储器地址范围是多少？
>>> 因为2<sup>14</sup>=16384, 所以16384-1 = 16383; 所以就是0000H~3FFFH
2. **存储器基本概念**
> 1. 存储器的一些基本术语
>> - 存储元
>> - 存储单元
>> - 存储体
>> - 单元地址
>> - 存储器
>> <center><img src="All_pic/Screenshot 2024-09-18 at 8.27.07 PM.png" width=80%></img></center>
> 2. 强调
>> - **位**(bit)是计算机表示的最小基本的数据单位, 指的是只能为0/1的二进制位.做单位时记作b.
>> - **字节**(byte)由8个二进制位组成.做单位记作B
> 3. 存储器分类
>> - CACHE/动态RAM/静态RAM/ROM等