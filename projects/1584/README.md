# 工程名称
防火墙NAT66实现内网访问外网


## 需求：
内网访问外网，并且进行前缀转换。
防火墙2001::1/96模拟内网网关，内网设备2001::2/96，外网2000::2/96对接防火墙2000::1/96。


## 实验步骤：
1.配置IPV6地址。

2.配置安全策略和安全域，g1/0/2外网放入untrust，g1/0/3内网放入trust。策略直接放通trust-untrust即可。

3.配置NAT66前缀转换。

4.配置路由。


## 测试结果：
通过ping可以看到可以通外网，并且防火墙会话也转换了。

ping ipv6  2000::2

Ping6(56 data bytes) 2001::2 --> 2000::2, press CTRL+C to break

56 bytes from 2000::2, icmp_seq=0 hlim=63 time=4.000 ms

56 bytes from 2000::2, icmp_seq=1 hlim=63 time=1.000 ms

56 bytes from 2000::2, icmp_seq=2 hlim=63 time=1.000 ms

56 bytes from 2000::2, icmp_seq=3 hlim=63 time=4.000 ms

56 bytes from 2000::2, icmp_seq=4 hlim=63 time=2.000 ms

[H3C]dis session table ipv6 p i v

Slot 1:

Initiator:

  Source      IP/port: 2001::2/10965

  Destination IP/port: 2000::2/32768

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: IPV6-ICMP(58)

  Inbound interface: GigabitEthernet1/0/3

  Source security zone: Trust

Responder:

  Source      IP/port: 2000::2/10965

  Destination IP/port: **2002::FFFE:2/33024**

  VPN instance/VLAN ID/Inline ID: -/-/-

  Protocol: IPV6-ICMP(58)

  Inbound interface: GigabitEthernet1/0/2

  Source security zone: Untrust

State: ICMPV6_REPLY

Application: ICMP

Rule ID: 1

Rule name: trust_untrust

Start time: 2022-07-13 19:01:53  TTL: 25s

Initiator->Responder:            0 packets          0 bytes

Responder->Initiator:            0 packets          0 bytes



## 说明： 


防火墙NAT66前缀转换，由于满足RFC要求必须IP校验和不变，因此会自动填充。