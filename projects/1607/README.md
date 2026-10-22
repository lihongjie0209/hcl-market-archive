# 工程名称

防火墙IPSEC主模式互通

## 需求：
通过防火墙做IPSEC VPN，实现流量私网流量在公网加密传输，并且实现互通。
防火墙两端内网地址分别为192.168.1.1/24和192.168.2.1/24网段。防火墙都是内网网关。
防火墙公网地址为1.1.1.1和2.2.2.1，公网用路由器三层转发模拟公网。


## 实验步骤：
1.配置ip

2.配置安全域和安全策略，防火墙公网口放入untrust，内网口在trust。注意VPN情况下防火墙安全策略必须放通协商报文和实际转发流量报文。也就是必须放通untrust到local的协商报文，并且放通实际内网转发的trust到untrust，由于本次是互通，因此需要双向放通。

3.配置ipsec

4.配置路由。


## 测试结果：
测试两边可以互通，并且防火墙存在IPSEC SA和IKE SA。
ping 192.168.2.2

Ping 192.168.2.2 (192.168.2.2): 56 data bytes, press CTRL+C to break

56 bytes from 192.168.2.2: icmp_seq=0 ttl=253 time=1.000 ms

56 bytes from 192.168.2.2: icmp_seq=1 ttl=253 time=2.000 ms

56 bytes from 192.168.2.2: icmp_seq=2 ttl=253 time=1.000 ms

56 bytes from 192.168.2.2: icmp_seq=3 ttl=253 time=1.000 ms

56 bytes from 192.168.2.2: icmp_seq=4 ttl=253 time=1.000 ms



[H3C]ping 192.168.1.1

Ping 192.168.1.1 (192.168.1.1): 56 data bytes, press CTRL+C to break

56 bytes from 192.168.1.1: icmp_seq=0 ttl=253 time=3.000 ms

56 bytes from 192.168.1.1: icmp_seq=1 ttl=253 time=2.000 ms

56 bytes from 192.168.1.1: icmp_seq=2 ttl=253 time=2.000 ms

56 bytes from 192.168.1.1: icmp_seq=3 ttl=253 time=2.000 ms

56 bytes from 192.168.1.1: icmp_seq=4 ttl=253 time=2.000 ms

[H3C]dis ike sa

    Connection-ID   Remote                Flag         DOI

------------------------------------------------------------------

    2               2.2.2.1/500           RD           IPsec

Flags:

RD--READY RL--REPLACED FD-FADING RK-REKEY

[H3C]dis ips

[H3C]dis ipsec sa

-------------------------------

Interface: GigabitEthernet1/0/3

-------------------------------



  -----------------------------

  IPsec policy: 1

  Sequence number: 1

  Mode: ISAKMP

  -----------------------------

    Tunnel id: 0

    Encapsulation mode: tunnel

    Perfect Forward Secrecy:

    Inside VPN:

    Extended Sequence Numbers enable: N

    Traffic Flow Confidentiality enable: N

    Transmitting entity: Initiator

    Path MTU: 1444

    Tunnel:

        local  address: 1.1.1.1

        remote address: 2.2.2.1

    Flow:

        sour addr: 192.168.1.1/255.255.255.255  port: 0  protocol: ip

        dest addr: 192.168.2.2/255.255.255.255  port: 0  protocol: ip


    [Inbound ESP SAs]

      SPI: 2783965941 (0xa5eff2f5)

      Connection ID: 12884901888

      Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-SHA1

      SA duration (kilobytes/sec): 1843200/3600

      SA remaining duration (kilobytes/sec): 1843198/3216

      Max received sequence-number: 15

      Anti-replay check enable: Y

      Anti-replay window size: 64

      UDP encapsulation used for NAT traversal: N

      Status: Active


    [Outbound ESP SAs]

      SPI: 2900635764 (0xace43074)

      Connection ID: 4294967297

      Transform set: ESP-ENCRYPT-3DES-CBC ESP-AUTH-SHA1

      SA duration (kilobytes/sec): 1843200/3600

      SA remaining duration (kilobytes/sec): 1843198/3216

      Max sent sequence-number: 20

      UDP encapsulation used for NAT traversal: N

      Status: Active



## 说明： 

普通防火墙即可。
