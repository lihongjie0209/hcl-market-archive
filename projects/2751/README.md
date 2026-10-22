# 工程名称

防火墙做LLB实现出链路负载。

## 需求：
防火墙做LLB，实现出链路负载，在两个出接口进行负载。
地址如组网图。
PC模拟终端访问，用ping测试loopback接口。

## 实验步骤：

1.配置地址和路由。注意防火墙做LLB，因此不配置任何路由。

2.配置安全策略和安全域，内网口做trust，外网口放trust。由于有健康性检测，因此策略放trust-untrust，和local-untrust。

3.配置健康性检测，由于要限制出接口，因此要做2个。

4.配置链路，链路组和虚服务。

5.接口做NAT outbound。




## 测试结果：

在pc上多次ping10.1.1.1，测试可以通，并且看统计两个接口分别有计数，说明负载正常。
[H3C]dis loadbalance  link statistics

Slot 1:

Loadbalance link: 2

  Total connections: 1

  Active connections: 1

  Max connections: 1,

    recorded at: 18:43:48 on Tue Aug 16 2022

  Connections per second: 0

  Max connections per second: 1,

    recorded at: 18:43:48 on Tue Aug 16 2022

  Downstream traffic: 420 bytes

  Upstream traffic: 420 bytes

  Throughput: 0 bps

  Inbound throughput: 0 bps

  Outbound throughput: 0 bps

  Max throughput: 6720 bps,

    recorded at: 18:43:49 on Tue Aug 16 2022

  Max inbound throughput: 3360 bps,

    recorded at: 18:43:49 on Tue Aug 16 2022

  Max outbound throughput: 3360 bps,

    recorded at: 18:43:49 on Tue Aug 16 2022

  Received packets: 5

  Sent packets: 5

  Dropped packets: 0

  Received packets per second: 0

  Sent packets per second: 0

  Packet loss rate: 0


Loadbalance link: 3

  Total connections: 1

  Active connections: 1

  Max connections: 1,

    recorded at: 18:43:48 on Tue Aug 16 2022

  Connections per second: 0

  Max connections per second: 1,

    recorded at: 18:43:48 on Tue Aug 16 2022

  Downstream traffic: 420 bytes

  Upstream traffic: 420 bytes

  Throughput: 0 bps

  Inbound throughput: 0 bps

  Outbound throughput: 0 bps

  Max throughput: 6720 bps,

    recorded at: 18:43:49 on Tue Aug 16 2022

  Max inbound throughput: 3360 bps,

    recorded at: 18:43:49 on Tue Aug 16 2022

  Max outbound throughput: 3360 bps,

    recorded at: 18:43:49 on Tue Aug 16 2022

  Received packets: 5

  Sent packets: 5

  Dropped packets: 0

  Received packets per second: 0

  Sent packets per second: 0

  Packet loss rate: 0


## 说明： 


