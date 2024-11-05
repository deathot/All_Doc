# Part2-进程管理
---
### 2-1. 进程基本概念
1. **进程执行分析及前趋图**
> 1. 前趋图概念及举例说明
>> - P1是P2的直接前趋, P2是P1的直接后继
> 2. 前趋图中必须不存在循环
2. **程序顺序执行**
> 1. 顺序执行
> 2. 顺序执行时的特征
>> - 顺序性
>> - 封闭性
>> - 可再现性
3. **程序并发执行**
> 1. 并发执行
> 2. 并发执行特征
>> - 间断性
>> - 失去封闭性
>> - 不可再现性
4. **进程的定义及特征**
> 1. 进程的引入
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 5.29.21 PM.png" width=50%></img></center>
> 2. 进程的定义
>> - 进程是可并发执行的程序在一个数据集合上的运行过程, 亦即进程实体的运行过程
>>> 1. 进程实体由程序段、 数据段及进程控制块三部分构成
>> - 进程是系统进行资源分配和调度的一个独立单位
> 3. 进程的特征-与程序的区别与联系
>> - 结构特征 
>> - 动态性
>> - 并发性
>> - 独立性
>> - 异步性
5. **进程状态及状态转换图**
> 1. 进程的基本状态及状态转换
>> - <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 6.55.30 PM.png" width=50%></img></center>
> 2. 引入挂起状态的可能原因
>> - 终端用户、父进程、OS、负载调节的请求
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 7.01.34 PM.png" width=50%></img></center>
6. **UNIX进程状态转换图**
> 1. 状态图
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 7.09.40 PM.png" width=50%></img></center>
7. **Linux进程状态转换图**
> 1. 状态图
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 7.17.50 PM.png" width=50%></img></center>
---
### 2-2. 进程控制
1. **进程控制块**
> 1. 进程控制块
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 7.51.22 PM.png" width=50%></img></center>
> 2. 块中的信息
>> - 进程标识符
>> - 处理器状态信息
>> - 进程调度信息
>> - 进程控制信息
> 3. 进程图(进程🌲)
> 4. 进程控制块的组织方式1-链接方式
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 7.58.31 PM.png" width=50%></img></center>
> 5. 进程控制块的组织方式1-索引方式
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-21 at 7.59.50 PM.png" width=50%></img></center>
2. **Linux task_struct结构体**
> 1. Pass
3. **进程的创建与终止**
> 1. 引起事件
>> - 用户登入/作业调度/提供服务/应用请求
>> - 正常结束/异常结束/外界干预
> 2. 进程创建/终止过程
>> - Create()原语
>>> 1. 分配标识符,并申请空白进程控制块
>>> 2. 为新进程的程序和数据及用户栈分配必要的内存空间
>>> 3. 初始化进程控制块
>>> 4. 将新进程插入到就绪进程队列
>> - Terminate()原语
>>> 1. 检索被终止进程PCB, 读取进程状态
>>> 2. 若正处于执行状态, 应立即终止执行并设置调度标志为真, 以指示调度新进程
>>> 3. 终止子孙进程
>>> 4. 资源归还
>>> 5. 移出被终止进程PCB, 等待其他程序查询利用
4. **进程的阻塞与唤醒**
> 1. 引起事件
>> - 请求系统服务/启动某种操作/新数据尚未到达/无新工作可做
>> - 系统服务满足/操作完成/数据到达/新任务出现
> 2. 进程阻塞/唤醒过程
>> - Block()原语
>>> 1. 立即停止执行, 把进程控制块中的现行状态由"执行"改为阻塞, 并将它插入到对应的阻塞队列中
>>> 2. 转调度程序进行重新调度, 将处理机分配给另一就绪进程, 并进行切换
>> - Wakeup()原语
>>> 1. 将阻塞进程移出, 改PCB为就绪状态, 再将进程插入就绪队列
5. **进程的挂起与激活**
> 1. 进程挂起/激活过程
>> - Suspend()原语
>>> 1. 检查被挂进程现行状态并修改和插队
>>> 2. 复制PCB到指定域
>>> 3. 若被挂进程正在执行则转向调度程序重新调度
>> - Activate()原语
>>> 1. 检查进程现行状态并修改和插队
>>> 2. 若有新进程进入就绪队列且采用了抢占式调度策略, 检查和决定是否重新调度
6. **UNIX进程描述与控制概要**
> 1. 进程控制数据结构
> 2. 进程映像
>> - 进程是进程映像的执行过程, 进程映像则是正在运行进程的实体
>>> 1. 用户级上下文/寄存器上下文/系统级上下文
> 3. 进程控制
>> - fork系统调用/exit系统调用/exec系统调用/wait系统调用
> 4. 进程调度与切换
>> - 调用算法/进程优先级分类/优先数计算/进程切换
---
### 2-3. 进程同步机制
1. **进程并发制约关系及临界区**
> 1. 并发进程间制约关系
>> - 资源共享关系-间接制约
>> - 相互合作关系-直接制约
> 2. 临界资源
>> - 一段时间内只允许一个进程访问的资源
> 3. 临界区
>> - 保证互斥的访问资源
> 4. 临界资源的循环进程描述
2. **进程同步机制准则**
> 1. 准则
>> - 空闲让进/忙则等待/有限等待/让权等待
3. **进程互斥访问临界资源的软件解决方案-算法1**
> 1. 进程互斥问题
> 2. 互斥算法1-设置访问编号
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-23 at 3.20.25 PM.png" width=50%></img></center>
4. **算法2**
> 1. 设置访问标志
5. **算法3**
> 1. 设置欲访问标志
6. **算法4-Peterson算法**
> 1. 编号+标志(Peterson算法)
7. **硬件方法**
> 1. Test-and-Set指令
> 2. Swap指令
8. **整形信号量机制**
> 1. 整型信号量
>> - wait(s): while s ≤0 do no_op;
>> - s := s-1;
>> signal(s): s := s+1;
9. **记录型信号量机制**
> 1. 信号量类型说明
>> ```
>> type semaphore = record
>>     value: integer;
>>     L: list of process;
>> end
>> ```
> 2. wait(s)操作描述
>> ```
>> procedure wait(s)
>> Var s: semaphore;
>> begin
>>     s.value := s.value - 1;
>>     if s.value < 0 then block(s.L);
>> end
>> ```
> 3. signal(s)操作描述
>> ```
>> procedure signal(s)
>> Var s: semaphore
>> begin
>>     s.value := s.value + 1;
>>     if s.value ≤ 0 then wakeup(s.L);
>> end
>> ```
10. **AND型信号量集机制**
> 1. 引入
>> - 多个进程要引入两个以上的资源时, 记录型信号量机制可能导致死锁
>> - 对策: 若干个临界资源的分配采取原子操作方式
> 2. Swait(s1, s2, sn)操作
>> <center><img src="/操作系统/All_pic/Screenshot  2024-09-25 at 8.01 AM.png" width = 50%></img></center>
> 3. Ssignal(s1, s2, sn)操作
>> <center><img src="/操作系统/All_pic/Screenshot  2024-09-25 at 8.03 AM.png" width = 50%></img></center>
11.   **一般信号量集机制**
> 1. 引入
>> - 记录型信号量/AND型信号量机制, waits/signal一次只能操作1, 效率低下
>> - 且当资源数量低于某一下限.所以需要测试
>> - 所以需要一般化的"信号量集"机制
> 2. Swaits操作 
>> <center><img src="/操作系统/All_pic/Screenshot  2024-09-25 at 8.05 AM.png" width = 50%></img></center>
> 3. Signal操作
>> <center><img src="/操作系统/All_pic/Screenshot  2024-09-25 at 8.07 AM.png" width = 50%></img></center>
> 4. 特殊情况
>> - Swait(s, d, d)
>>> 1. 信号量集中只有一个信号量, 但每次允许分配d个资源; 当现有资源少于d个时, 便不予分配
>> - Swait(s, 1, 1)
>>> 1. 此时的信号量集已退化为一般的记录型信号量
>> - Swait(s, 1, 0)
>>> 1. 特殊且有用的信号量, 相当于可控开关
>>> 2. 当s >= 1时, 允许多个进程进入特定区; 当s变为0, 将阻止任何进程进入特定区
12.  **基于信号量机制解决进程并发问题的应用基础**
> 1. 利用信号量实现互斥-主程序
>> ```
>> Var mutex: semaphore := 1;
>> begin
>>  parbegin
>>      process1;
>>      process2;
>>  parend
>> end
>> ```
> 2. 利用信号量实现互斥-子程序
>> ```
>> process1:
>> begin
>>  repeat
>>  ''''''
>>  wait(mutex);
>>  临界区
>>  signal(mutex);
>>  ''''''
>>  until false;
>> end
>> ```
>> ```
>> process2:
>> begin
>>  repeat
>>  ''''''
>>  wait(mutex);
>>  临界区
>>  signal(mutex);
>>  ''''''
>>  until false;
>> end
>> ```
> 3. 信号量要描述的前趋关系示例
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 2.57.42 PM.png" width = 50%></img></center>
> 4. 利用信号量来描述前趋关系
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 3.01.25 PM.png" width = 50%></img></center>
---
### 2-4. 经典进程同步问题
1. **生产者及消费者问题初步解决方案**
> 1. 问题背景
>> - 生产-消费问题是相互合作进程关系的抽象
> 2. 问题描述
>> - 生产者生产数据, 提供给消费者处理
>> - 二者并发执行, 他们之间有n个缓冲区的循环缓冲, 生产者进程可将生产数据放入一个缓冲区, 消费进程可从一个缓冲区取得一个数据消费
>> - 异步运行方式及彼此必须保持同步
> 3. 问题剖析
>> - 空缓冲区与满缓冲区
>> - 进程同步
>>> 1. 生产者送数据时要有空缓冲区, 有, 则可投放数据, 再通知消费者进程, 否则等待./消费者则相反
>> - 进程互斥: 缓冲区及其指针是临界资源: 多个生产者/消费者进程
> 4. 生产者-消费者程序变量设计
>> - 循环缓冲表示机制: 一维数组buffer: array [0...n-1] of item;
>> - 输入指针in
>>> 1. 指示下一个可以投放数据的缓冲区
>>> 2. 初始值为0;变化方式: in := (in + 1) mod n
>> - 输出指针out
>>> 1. 指示下一个可以获取数据的缓冲区
>>> 2. 初始值为0; 变化方式: out := (out + 1) mod n
>> - nextp/nextc暂存每次要生产或消费的数据
> 5. 生产者-消费者程序变信号量设计
>> - 循环缓冲(缓冲区及其指针)的互斥使用: 互斥信号量mutex, 初始值为1
>> - 资源信号量
>>> 1. empty表示循环缓冲区中的空缓冲区数量, 初始值为n
>>> 2. full表示'''满缓冲区数量, 初始值为0
> 6. 生产者-消费者主程序设计
>> ```
>> Var buffer: array [0...n-1] of item;
>>  in, out: integer := 0, 0;
>>  mutex, empty, full: semaphore := 1, n, 0;
>> begin
>>  parbegin
>>      producer1; ...; producerY;
>>      consumer1; ...; consumerX;
>>  parend
>> end
>> ```
> 7. 生产者子程序设计
>> ```
>> producerY:
>> Var nextp: item;
>>  begin
>>      repeat
>>          produce an item in nextp;
>>          wait(empty);
>>          wait(mutex);
>>          buffer[in] := nextp; in := (in + 1) mod n;
>>          signal(mutex);
>>          signal(full);
>>      until false;
>>  end
>> ```
> 8. 消费者子程序设计
>> ```
>> consumerX:
>> Var nextc: item;
>>  begin
>>      repeat
>>          wait(full);
>>          wait(mutex);
>>          nextc := buffer[out]; out := (out + 1) mod n;
>>          signal(mutex);
>>          signal(empty);
>>          consume the item in nextc;
>>      until false;
>>  end
>> ```
2. **生产者-消费者问题初步解决方案的反思**
> 1. 相邻wait(signal)操作颠倒分析
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 3.35.50 PM.png" width = 50%></img></center>
> 2. 关于signal操作缺失的分析
>> >> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 3.37.27 PM.png" width = 50%></img></center>
> 3. 基于AND信号量的生产/消费者子程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 3.39.08 PM.png" width = 50%></img></center>
> 4. 同步问题程序设计要领
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 3.43.19 PM.png" width = 50%></img></center>
3. **生产者-消费者问题方案的改进**
> 1. 生产者-消费者主程序设计
>> >> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 3.56.37 PM.png" width = 50%></img></center>
> 2. 生产者子程序设计
>> >> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.17.01 PM.png" width = 50%></img></center>
> 3. 消费者子程序设计
>> >> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.19.16 PM.png" width = 50%></img></center>
4. **基于单缓冲的单生产者-单消费者问题及解决方案**
> 1. 两者的同步问题
>> >> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.41.53 PM.png" width = 50%></img></center>
> 2. 主程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.43.18 PM.png" width = 50%></img></center>
> 3. 数据采集任务子程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.44.01 PM.png" width = 50%></img></center>
> 4. 计算任务子程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.44.44 PM.png" width = 50%></img></center>
5. **哲学家进餐问题及解决方案**
> 1. 问题描述
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.53.57 PM.png" width = 50%></img></center>
> 2. 问题解析
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.55.10 PM.png" width = 50%></img></center>
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 4.56.17 PM.png" width = 50%></img></center>
> 3. 进餐主程序设计-1-双筷齐举[AND型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.01.33 PM.png" width = 50%></img></center>
> 4. 进餐子程序设计-1-双筷齐举[AND型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.02.02 PM.png" width = 50%></img></center>
> 5. 进餐主程序设计-1-双筷齐举[记录型型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.03.23 PM.png" width = 50%></img></center>
> 6. 进餐子程序设计-1-双筷齐举[记录型型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.04.14 PM.png" width = 50%></img></center>
> 7. 进餐主程序设计-2-奇偶有别[记录型型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.01.33 PM.png" width = 50%></img></center>
> 8. 进餐子程序设计-2-奇偶有别[记录型型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.06.51 PM.png" width = 50%></img></center>
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.07.37 PM.png" width = 50%></img></center>
> 9. 进餐主程序设计-3-进餐限数[记录型型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.08.01 PM.png" width = 50%></img></center>
> 10. 进餐主程序设计-3-进餐限数[记录型型信号量]
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.08.52 PM.png" width = 50%></img></center>
6. **读者-写者问题及解决方案**
> 1. 读者-写着问题描述
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.13.41 PM.png" width = 50%></img></center>
> 2. 程序信号量及变量设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.16.17 PM.png" width = 50%></img></center>
> 3. 主程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.16.54 PM.png" width = 50%></img></center>
> 4. 写者子程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.17.32 PM.png" width = 50%></img></center>
> 5. 读者子程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.19.35 PM.png" width = 50%></img></center>
7. **读写程序解决方案反思**
> pass
8. **公平型读者-写者问题解决方案**
> pass
9. **写者优先的-读写方案**
> pass
10.  **读者数限定-读写方案**
> pass
---
### 2-5. 管程
1. **管程概念及实现要旨**
> 1. 引入
>> - 基于信号量的进程同步机制的弊端
>> - 对策: 引入管程来负责同步方案
> 2. 语法
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.28.40 PM.png" width = 50%></img></center>
> 3. 管程的资源请求与释放
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.30.32 PM.png" width = 50%></img></center>
> 4. 管程的定义
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.30.53 PM.png" width = 50%></img></center>
> 5. 管程的进程同步互斥保证
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.31.50 PM.png" width = 50%></img></center>
2. **Hoare管程实现方案**
> 1. 实现方案
>> - TYPE interface = RECORD
>> - 管理定义及成员组成
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 5.36.46 PM.png" width = 50%></img></center>
>> - wait操作函数
>>> Pass
>> - signal操作函数
>>> Pass
3. **基于Hoare管程的哲学家进餐问题**
> 1. 程序设计
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 8.47.17 PM.png" width = 50%></img></center>
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 8.48.30 PM.png" width = 50%></img></center>
>> - 再分别写Test, PickUp, PutDown函数
4. **Hanson管程实现方案**
> 1. 实现方案
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 8.52.48 PM.png" width = 50%></img></center>
5. **基于Hanson管程的生-消问题解决方案**
> 1. Hanson管程应用
>> - 基于Hanson管程的进程同步问题解决方案
>>> 1. entry类型过程隐含以check()开始, 以release()结束
>> - 基于Hanson管程的进程同步问题解决示例
>>> 1. 生产者-消费者问题
> 2. 生产者-消费者管程设计要领
>> - 循环缓冲及操作机制
>>> 1. 循环缓冲buffer
>>> 2. 生产/消费指针in, out
>>> 3. 已有有效数据量count
>> - 条件变量设计
>>> 1. noEmpty/noFull
>> - 针对每个条件变量
>>> 1. 设置进程等待队列
>>> 2. 设置同步操作原语wait与signal
---
### 2-6. 进程通信
1. **进程通信概念及分类**
> 1. 进程通信概念及实现机制
>> - 通信概念: 进程之间的信息交换
>> - 实现机制
>>> 1. 低级进程通信: 效率低, 针对控制消息传送.如信号量机制
>>> 2. 高级进程通信: 传送大量数据, 效率高, 由操作系统提供, 编制简单
> 2. 进程通信的类型
>> - 共享存储器系统
>> - 消息传递系统
>> - 管道通信系统
2. **消息传递通信实现方式**
> 1. 直接通信方式
>> - 通信原语: Send, Receive
>> - 一个接收进程可与多个发送进程通信
>> - 基于进程直接通信原语的应用
> 2. 直接通信方式程序设计
>> Pass
> 3. 间接通信方式
>> - 信箱
>> - 通信原语
>> - 发送/接收进程间存在四种关系
> 4. 消息传递系统的问题
>> - 通信链路
>> - 消息格式
>> - 进程同步方式   
3. **消息缓冲队列通信机制**
> 1. 通信机制-数据结构
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 9.10.11 PM.png" width = 50%></img></center>
> 2. 发送原语
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 9.11.00 PM.png" width = 50%></img></center>
> 3. 接收原语
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 9.11.34 PM.png" width = 50%></img></center>
---
### 2-7. 线程
1. **线程的概念与特征**
> 1. 引入
>> - 进程并发机制缺陷
>> - 系统并发程度进一步提高的客观需求
>> - 对策
> 2. 线程的特征
>> - 轻型实体及共享进程资源/独立调度和分派/创建、撤销、切换等系统开销/地址空间共享及通信效率/系统并发执行程度提高
2. **线程的控制、同步与通信**
> 1. 线程的控制
>> - 基本属性: 线程标识符、寄存器状态、堆栈及专有存储器/线程状态、优先级与信号屏蔽
>> - 线程的创建和终止
> 2. 线程间的同步和通信
>> - 信号量机制
>> - 互斥锁
>> - 条件变量与互斥锁
> 3. 基于互斥锁和条件变量的线程同步
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 9.17.58 PM.png" width = 50%></img></center>
3. **线程实现方式**
> 1. 方式
>> - 内核支持线程
>> - 用户级线程
>> - 实现方式比较
> 2. 用户级线程模型
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 9.19.42 PM.png" width = 50%></img></center>
>> <center><img src="/操作系统/All_pic/Screenshot 2024-09-26 at 9.20.22 PM.png" width = 50%></img></center>
