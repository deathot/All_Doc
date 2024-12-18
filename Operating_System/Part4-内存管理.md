# Part4-内存管理
---
### 4-1. 内存管理概述
---
#### 1. 用户程序处理过程及地址空间概念和内存管理模式
1. 存储器层次结构
    - CPU -> CACHE -> 主存储器(内存、主村、磁盘缓冲) -> 辅助存储器(固定磁盘)
2. 用户程序处理过程
    - 符号名空间 -> 目标地址空间 -> 统一的目标地址空间 -> 物理地址空间
3. 实例
     <center><img src="/操作系统/All_pic/Screenshot 2024-10-09 at 20.43.04.png" width=50%></img></center>
#### 2. 程序的链接
1. 链接过程
    - 根据外部访问符号名表, 将经过编译的一组模块以及所需库函数, 装配成完整的模块
2. 链接方式
    - 静态链接方式、装入/运行时动态链接方式
3. 链接方式比较
    - 静态: 可执行文件, 难以实现内存模块共享
    - 装入时动态: 便于软件版本的修改、更新, 便于目标模块为多个应用程序共享
    - 运行时动态: 将某些链接推迟到执行时根据是否需要再完成, 有利于内存的利用
#### 3. 程序的装入与重定位
1. 程序的装入
    - 基本目标及相关问题
        1. 由装入程序将装入模块载入到内存
        2. 装入位置、地址变换及时机
    - 关键概念
        1. 相对、绝对地址、重定位及其寄存器
    - 装入方式
        1. 绝对装入(单道程序环境)
        2. 静态可重定位(多道程序)
        3. 动态运行时装入(运行中移动位置)
2. 绝对装入和可重定位装入模块实例
     <center><img src="/操作系统/All_pic/Screenshot 2024-10-09 at 20.53.06.png" width=50%></img></center>
3. (静态/动态)可重定位
    - 重定位
        1. 指令及数据地址的修改过程
    - 静态重定位
        1. 装入内存时一次性完成重定位
        2. 地址不再改变, 程序不能移动
    - 动态重定位
        1. 需要特殊硬件支持, 来保持地址转换不影响指令执行速度
        2. 便于动态链接和代码共享
4. 动态重定位示意图
     <center><img src="/操作系统/All_pic/Screenshot 2024-10-09 at 20.55.56.png" width=50%></img></center>
#### 4. OS内存管理功能目标及内存分配方式分类
1. 内存管理功能目标
    - 内存分配
    - 地址映射
    - 内存保护
    - 内存扩充
2. 连续/离散分配内存管理
    - 连续分配
        1. 单一连续分配
        2. 固定/动态(可重定位)分区分配
    - 连续存储管理弊端
        1. 碎片问题
        2. 对换、覆盖、伙伴技术
    - 离散分配及虚拟现实存储技术
        1. 分页
        2. 分段
        3. 段页式
---
### 4-2. 连续分配内存管理
---
#### 1. 单一连续分配内存管理
1. 单一连续分配方式
    - 内存划分为系统区和用户区
    - 整个用户区为一道程序独占, 仅驻留一道程序
    - 绝对装入方式
    - 静态链接
    - 基本不设立存储器保护措施, 最多设立界限检查机制
    - 仅适用于单用户、单任务操作系统
#### 2. 固定分区分配内存管理
1. 固定分区分配方式
    - 用户区分为若干固定区域
    - 每个分区可装一道作业
    - 分区划分方法
    - 分区说明表与内存分配算法
    - 可用于多道程序存储管理
2. 地址转换及内存保护
    - 静态链接
    - 可重定位装入、动态运行时装入
    - 保护操作系统程序间互不干扰
    - 仅用于事先确定的场景
#### 3. 动态分区分配内存管理
1. 基本思想
    - 根据进程实际需求, 动态地对内存进行操作
2. 关键问题
    - 分区分配数据结构
    - 算法
    - 回收
    - 碎片处理
3. 数据结构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-09 at 21.09.38.png" width=50%></img></center>
4. 算法
    - 首次适应算法(First Fit, FF)
        1. 空闲分区链以地址递增次序链接
        2. 查找开销大, 但利于大作业分配
    - 循环首次适应
        1. 首次适应 + 起始查询指针 + 循环查找
        2. 减少查找开销, 不利于大作业分配
    - 最佳适应/最坏适应
        1. 能满足要求且又最小的空闲分区
        2. 空闲分区按大小递增链接
        3. 微观意义上的最佳
#### 4. 动态可重定位分区分配内存管理
1. 紧凑技术
    - 要求内存空间连续性
    - 碎片问题
    - 移动拼接大分区
    - 内存地址变化及地址修正问题
2. 动态重定位
    - 动态运行时装入方式及重定位寄存器
3. 分配算法
    - 动态算法 + 紧凑功能
#### 5. 对换技术
1. 多道程序环境下的对换
    - 对换概念及意义
        1. 内存 <-> 外存
    - 实现机制
        1. UNIX: 对换进程
    - 实现方式
        1. 进程对换: 分时系统
        2. 页面/分段对换: 虚拟存储技术
2. 对换空间管理
    - 文件区和对换区
    - 对换区使用情况数据结构
    - 对换区分配与回收
3. 进程的换出和换入
    - 换出
        1. 进程的选择
        2. 过程
    - 换入
        1. 选择
        2. 过程
#### 6. 覆盖技术
1. 基本思想
    - 不同时执行的程序共享一块内存
    - 覆盖段: 互相覆盖的程序段
    - 覆盖区: 共用的内存空间
#### 7. 伙伴系统
1. Pass
---
### 4-3. 基本分页内存管理
---
#### 1. 基本分内存管理核心概念
1. 物理块、页面、页表
    - 物理块和页面
        1. 内存空间及进程逻辑地址空间的划分
        2. 物理/页面编号
        3. 内存分配与碎片
    - 内存页表(物理块表)
    - 进程页表
        1. 页面映射表及其表项(物理块号、存取控制字段)
    - 页面大小选择
        1. 由机器地址结构决定
        2. 页面大小评析(512B ~ 8kb)
2. 物理块表(内存页表)
    Pass
3. 进程页表
    - 用户程序
    - 进程页表
    - 内存
#### 2. 基于位示图的分配与回收
1. 位示图
    - 利用位示图(Map[m][n])的一位0/1来表示内存物理块的使用情况, 使所有块都与一个二进制位相对应
2. 物理块的分配
```
Var Map: array[m] of integer; array[m][n] of bit 
```
    - 确定物理块数zKs
    - 扫描位示图, 找出为0的二进制位
    - 将找到的二进制Map[i][j]的行列号转换为物理块号b: b= n * i + j
    - 按物理块号分配, 修改位示图和进程页表
3. 物理块的回收
    - 回收块号b转换为行列号
        1. i = b DIV n;
        2. j = b MOD n;
    - 按物理块回收
    - 根据回收的块对应二进制行列修改位示图和进程页表
#### 3. 分页内存地址结构及地址变换方法
1. 
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-10 at 15.44.51.png" width=50%></img></center>
2. 举例说明
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-10 at 15.46.31.png" width=50%></img></center>
#### 4. 分页内存地址变换机构及快表引入和效率分析
1. 基本地址变换机构
    - Pass
2. 具有快表的地址变换机构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 08.46.10.png" width=50%></img></center>
3. 快表引入的数据存取速度比较
    - 快表检索时间20ns, 内存访问时间100ns.
        1. 在快表中: 100 + 20 = 120ns
        2. 无法在快表中: 100 + 100 + 20 = 220ns
        3. 假设快表命中率80%, 则有效访问时间为120 * 80% + 220 * 20% = 140ns
#### 5. 页表空间问题及对策
1. 问题及对策
    - 页表空间问题
        1. 逻辑地址空间非常大(2^32 ~ 2^64), 因此页表庞大, 若对32(2^32 = 4G)为逻辑地址空间的分页系统, 页面大小为4KB(2<sup>12</sup>B), 则每个进程的页表项可达1M个;若每个页表项大小为4B, 则每个进程仅页表便专用4MB内存, 且是连续的.
    - 解决方案
        1. 多级页表(页表分页及对换)/反置页表
#### 6. 两级和多级页表及地址变换机构
1. 两级页表结构基本方法
    - 基本思想: 
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 09.28.22.png" width=50%></img></center>
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 09.29.18.png" width=50%></img></center>
2. 两级页表的地址变换结构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 09.30.22.png" width=50%></img></center>
3. 多级页表结构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 09.30.53.png" width=50%></img></center>
#### 7. 反置页表及地址变换机构
1. 反置页表
    - 为每一个物理块设置一个页表项将他们按号数排序, 页表项内容包括页号及标识符
    - 利用反置页表进行地址变换, 用进程标识符和页号去检索反置页表.找到则已该表项序号既该页所在物理块号与页内地址构成物理地址;否则中断请求
    - 进程外部页表的设立及hash检索对于反置页表
2. 反置页表地址变换机构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 09.40.51.png" width=50%></img></center>
---
### 4-4. 基本分段内存管理
---
#### 1. 基本分段内存管理
1. 分段
    - 作业地址被划分为若干段, 如MAIN、子程序X等
    - 每个段都从0开始编址, 采用连续的地址空间, 且段长取决于逻辑信息的长度, 所以各段长度不等
    - 整个作业的地址空间是二维的, 逻辑地址由段号(名)和段内地址所组成
2. 利用段表实现地址映射示意图
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 14.41.52.png" width=50%></img></center>
3. 分段系统地址变换机构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 14.43.16.png" width=50%></img></center>
#### 2. 分段内存管理的优势及其与分页内存管理的比较
1. 分段的优势
    - 方便编程作业基于逻辑关系自然分段
    - 信息共享、信息保护、动态链接、动态增长(数据段动态增长)
2. 分页与分段的比较
    - 相似之处
        1. 实现机制(离散、地址映射)
    - 目的及内涵
        1. 系统管理需要/用户需求、物理/逻辑单位
    - 分段/页的长度
        1. 固定与否, 取决于(系统硬件/信息性质)
    - 作业地址空间维数
        1. 一/二维
#### 3. 可重入代码及分页与分段信息共享的比较
1. 可重入代码(纯代码)
    - 一种允许多个进程同时访问的代码, 在执行期间不允许任何进程对其修改, 但多数情况下因变量、指针、信号量等, 可设置**局部数据区**, 对于要修改的部分拷贝到该数据去区, 即可实现共享代码
2. 信息共享比较说明
    - 多个用户对文本编辑程序的共享
        1. 某个系统接纳40个用户, 160kb代码区、40kb的数据区.则需要8000kb的内存空间.若该代码是**可重入**的那么只需要40 * 40 + 160 = 1760kb
3. 基于分页的文本编辑器共享
    - 50(表项/4b) * 40 = 2000kb的开销
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 15.13.29.png" width=50%></img></center>
5. 基于分段的文本编辑器共享
    - 2 * 40 * 8(表项/8b) = 640kb的开销
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 15.14.34.png" width=50%></img></center>
---
### 4-5. 段页式内存管理
---
#### 1. 段页式内存管理
1.  引入
    - 分页系统有效提高内存利用率
    - 分段系统更好满足用户需求
2. 段页式内存管理方法
    - 原理: 将程序信息分为若干段, 再把每段划分为若干页
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 15.37.50.png" width=50%></img></center>
3. 利用段表和页表实现地址映射
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 15.39.03.png" width=50%></img></center>
4. 段页式系统的地址变换结构
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 15.39.55.png" width=50%></img></center>
5. 64位机器内存逻辑地址结构设计
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 15.41.06.png" width=50%></img></center>
---
### 4-6. 虚拟内存管理
---
#### 1. 常规内存管理问题、对策及局部性原理
1. 常规存储管理问题与对策
    - 要求将一个作业全部装入内存方能运行
        1. 内存容量大的作业无法一次性装入
        2. 同时有大量作业要运行, 内存不够, 只能运行少数, 其他的外存等待
    - 解决方法
        1. 增加物理内存
        2. 虚拟存储技术-逻辑上扩充
2. 一次性全部装入及驻留性问题
    - 不必要一次性装入: 在运行时并非用到全部程序和数据
    - 作业常驻内存不合理: 因I/O未完成, 而占据资源
    - 后果: 降低利用率吞吐率
3. 局部性原理
    - 程序执行时呈现局部性规律, 就是在短时间内, 程序仅执行在某个部分; 相应的, 所访问内存空间仅限于某个区域
        1. 多数情况程序顺序执行
        2. 过程调用深度及执行轨迹
        3. 循环结构及数据操作结构
    - 局部性表现
        1. 时间局部性: 指令、数据不久被再次执行
        2. 空间局部性: 被访问单元被再次访问
4. 工作集
    - 程序都显现出高度局部性, 一段时间内, 如页面被反复引用, 随时间推移, 成员会发生剧烈/渐进的变化, 把这组页面的集合称为**工作集**
#### 2. 虚拟存储器概述
1. 技术要点
    - 作业部分装入内存即可运行
    - 程序执行过程的页段访问机制
        1. 已调入内存直接访问
        2. 未调入的则缺页/段中断及请求调入
        3. 页段置换功能
    - 技术效果
        1. 大的程序在小内存空间运行
        2. 多道程序的提高
2. 虚拟存储器定义
    - 具有请求调入和置换功能, 从逻辑上扩充内存容量.逻辑容量由内存和外存之和决定, 运行速度接近内存, 成本接近外存
3. 请求分页/分段虚拟存储系统
    - 技术构成
        1. 分页/分段 + 请求调页/段 + 页面/段置换
    - 硬件支持
        1. 分页页表机制/分段段表机制
        2. 缺页中断机构/缺段
        3. 地址变换机构
    - 软件支持
        1. 请求调页/段
        2. 页面/分段置换
4. 虚拟存储器特征
    - 离散性
    - 多次性: 作业被分成多次调入
    - 对换性: 程序运行时被换进/出
    - 虚拟性
---
### 4-7. 请求分页内存管理
---
#### 1. 请求分页页表、缺页中断处理及地址变换机制
1. 页表机制
    - 页表项的扩充
2. 请求分页虚拟内存管理举例
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 22.43.40.png" width=50%></img></center>
3. 缺页中断机构
    - 缺页中断之中断特征
        1. 保护cpu现场
        2. 分析原因
        3. 转入缺页中断程序
        4. 恢复
    - 特殊性
        1. 指令执行期间产生处理中断信号
        2. 一条指令期间, 可能多次缺页中断
4. 地址变换机构
    - 在分页系统的地址变换机构基础上, 增加缺页中断产生和处理页面置换功能
    - 地址变换过程要领
        1. 从页表找到对应分页的页表项获取该页尚未调入内存时, 产生缺页中断, 请求操作系统从外存把该页调入内存
        2. 快表和页表的检索及表项修改
5. 请求分页系统地址变换过程
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 22.53.38.png" width=50%></img></center>
6. 缺页中断处理
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-11 at 22.54.46.png" width=50%></img></center>
#### 2. 请求分页内存分配策略和算法
1. 最小物理块数的确定
    - 保证进程正常运行时所需的最少物理块数
        1. 系统为进程分配的块数少于此值时, 进程将无法正常运行
        2. 不同于使进程有效工作所需的物理块数
    - 与计算机硬件结构有关, 取决于指令的格式(操作数个数)、功能和寻址方式(直/间接)
2. 物理块分配与置换策略
    - 固定分配局部置换
        1. 为每个进程分配固定页数的内存空间, 在整个运行期间不再改变
    - 可变分配全局置换
        1. 系统设立一个空闲物理队列, 缺页即触发全局新增分配或全局置换
    - 可变分配局部置换
        1. 依据缺页率增加或减少物理块
3. 物理块分配算法
    - 平均分配算法
        1. 物理块平均分配
    - 按比例分配算法
        1. BlockOfP<sub>k</sub> = max{minBlocks, Blocks * PagesOfP<sub>k</sub>/&Sigma;PagesOfP<sub>i</sub>}
    - 考虑优先权的分配算法
        1. 重要/紧迫作业
#### 3. 分页虚拟存储器调页策略
1. 何时调入页面
    - 预调页策略
        1. 将不久之后会被访问的程序/数据所在页面, 预先调入内存
        2. 预测为基础, 主要用于进程首次调入
    - 请求调页策略
        1. 进程运行时需访问某部副程序和数据, 若页面不在内存, 立即提出请求, 系统将页面调入内存;易于实现, 但系统开销大
2. 何处调入页面
    - 对换区空间充分
        1. 进程运行前, 便将有关文件从文件去拷贝到对换区
    - 对换区空间不足
        1. 文件是否修改分别处理
    - UNIX方式
        1. 未运行的页面都调入, 而运行过的又被换出到对换区的页面则从对换区调入
3. 页面调入过程
    - 缺页中断发生
        1. 程序所访问页面不在内存产生缺页中断并转入处理程序
    - 根据页表项给定外存地址调入所缺页面
        1. 页表项外存地址(物理盘块号)
    - 内存不足置换
        1. 页面淘汰算法
        2. 是否重写磁盘
#### 4. 抖动与缺页率
1. 抖动的定义
    - 刚被换出的页面很快又被访问, 在选一页换出, 不久也被访问, 频繁更换页面, 以及页面置换, 称该进程发生了抖动/颠簸
2. 缺页率
    - 缺页率 = 缺页中断次数/页面访问次数
#### 5. 最佳淘汰算法
1. 基本思想
    - 永不使用或长时间不在访问的页面淘汰出内存
2. 评价
    - 理想化算法, 具有最好性能(对固定分配页面方式, 可获最低缺页率), 实际难以实现
3. 举例
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 10.56.42.png"width=50%></img></center>
#### 6. 先进先出淘汰算法
1. 基本思想
    - 选最先进入内存的页面换出到外存
    - 进程已调入内存的页面按进入先后次序排列, 设置替换指针指向最老页面
2. 评价
    - 简单直观, 不符合运行规律, 性能差
3. 举例
    Pass
#### 7. 最近最久未使用者淘汰算法LRU
1. 基本思想
    - 以最近的过去作为最近的将来的近似, 选择最近一段时间最长时间未被访问页面淘汰
2. 评价
    - 适用于各类程序, 性能较好, 但需要硬件支持
3. 举例
    - 从当前往前看, 选一个最近最久未使用的淘汰
    <center><img src="/All_pic/Screenshot 2024-10-13 at 11.07.30.png" width=50%></img></center>
4. 移位寄存器
    - 为每一个物理块设置一个移位寄存器, 未被访问就置0, 访问了置0, 再淘汰时选0最多的那一个块淘汰
5. 栈
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 11.12.21.png"width=50%></img></center>
#### 8. 时钟式淘汰算法
1. 简单时钟淘汰算法(Clock/NRU)
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 15.31.58.png"width=50%></img></center>
2. 改进型算法
    - 基本思想
        1. 从查询指针当前位置起扫描内存分页循环队列, 选择A=0, M=0, 的第一个页面淘汰; 未找到, 进入2
        2. 开始第二轮扫描, 选择A=0, M=1的第一个页面淘汰, 并将经过的所有页面位置0;若不能找到, 进入1
    - 评价
        1. 可减少I/O操作, 但要多次扫描, 开销大
#### 9. 最少使用者淘汰算法LFU
1. 基本思想
    - 为内存各页设置移位寄存器来记录对应访问频率, 选择最近时期访问次数最少的页面淘汰
2. 评价
    - 仅用移位寄存器有限各位来记录页面使用情况会导致访问一次与多次的等效性, 算法不能真实反映页面使用情况
#### 10. 页面缓冲策略PBA
1. 基本思想
    - 设立**空闲页面链表**和**已修改页面链表**
    - 采用可变分配和基于先进先出的局部置换策略, 规定淘汰页不做物理移动, 而是依据是否修改分别挂到空闲或已修改页面链表的末尾
    - 空闲页面链表同时用于物理块分配
    - 当已修改页面链表达到一定长度如64个页面时, 一起将所有已修改链表写回磁盘, 可显著减少I/O次数
---
### 4-8. 请求分段内存管理
---
#### 1. 请求分段段表、缺段中断处理及地址变换机制
1. 段表机制
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 15.44.03.png"width=50%></img></center>
2. 地址变换机构
    - 分段系统的地址变换机构上, 增加缺段中断产生和处理以及分段置换功能
    - 地址变换过程
        1. 段表找对应分段的段表项, 未调入内存时, 产生缺段中断, 请求操作系统从外存把该段调入内存
        2. 快表、段表的检索及表项修改
3. 地址变换举例
    - Pass
4. 缺段中断机构及处理过程
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 15.53.49.png"width=50%></img></center>
#### 2. 请求分段内存管理的分段共享机制
1. 共享段表
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 16.02.01.png"width=50%></img></center>
2. 共享段的分配与回收
    - 分配: 第一个请求使用共享段的进程, 系统把该共享段进行内存区的分配与装入, 同时把共享段的信息填入对应进程段表, 以及表项等内容; 对于其它进程提出的要求, 只用修改进程段表项以及共享段表项
    - 回收: 与分配相反
#### 3. 请求分段内存管理的分段保护机制
1. 越界检查与存取控制检查
    - 越界检查: 段号、段内地址的检查
    - 存取控制检查: 段表中表项存取控制字段为依据, 通常访问方式包括只读、 只执行、 读/写等, 共享段的存取控制对不同进程赋予不同权限
2. 环保护机构
    - 程序间的控制传输以及数据间的访问
---
### 4-9. x86系统中请求段页式支撑机制及Linux地址映射
---
#### 1. x86系统中请求段页式支撑机制及Linux地址映射
1. x86体系结构段页式存储管理
    - 全局描述表和局部描述符表
        1. 代码段、数据段、堆栈段、系统段
        2. 程序地址空间 -> 线性地址空间
        3. lgdt/lldt(加载全局描述附表/局部描述附表)
    - 页目录表与页表
        1. 线性地址空间 -> 物理地址空间
        2. CR0 ~ CR3(MOV指令操作)
    - 系统内核空间与用户进程空间(Linux)
        1. 线性地址空间(0 ~ [3GB] ~ 4GB)
        2. 物理地址空间(0 ~ 16MB ~ 896MB ~ 4GB)
2. Linux虚拟/物理地址空间映射
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 16.34.33.png"width=50%></img></center>
3. x86体系结构存储相关寄存器
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 16.35.15.png"width=50%></img></center>
4. x86体系结构地址变换
    <center><img src="/操作系统/All_pic/Screenshot 2024-10-13 at 16.37.22.png"width=50%></img></center>