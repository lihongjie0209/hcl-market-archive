# 工程名称

防火墙IRF结合冗余口冗余组实现主备。

## 需求：
防火墙做堆叠，并且利用冗余实现主备。


## 实验步骤：

1.配置防火墙堆叠。

2.配置track。

3.配置冗余口。

4.配置冗余组。

## 测试结果：

测试冗余组正常。
Redundancy group 1 (ID 1):

  Node ID      Slot          Priority   Status        Track weight

  1            Slot1         100        Primary       255

  2            Slot2         50         Secondary     255


Preempt delay time remained     : 0    min

Preempt delay timer setting     : 1    min

Remaining hold-down time        : 0    sec

Hold-down timer setting         : 1    sec

Manual switchover request       : No


Member interfaces:

    Reth2                 Reth4


Node 1:

  Track info:

    Track    Status           Reduced weight     Interface

    12       Positive         255                GE1/0/2

    14       Positive         255                GE1/0/4

Node 2:

  Track info:

    Track    Status           Reduced weight     Interface

    22       Positive         255                GE2/0/2

    24       Positive         255                GE2/0/4




## 说明： 


1.模拟器reth口无法正常通信，因此没有配置IP，该案例只能做切换测试，看看切换过程中的现象。