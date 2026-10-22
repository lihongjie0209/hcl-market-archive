# PPPoE Server通过DHCPv6协议分配代理前缀用于用户生成IPv6地址配置举例

## 需求：

Router A和Router B之间通过以太网接口相连，Router A通过PPPoE接入Router
B，Router B作为PPPoE Server通过DHCPv6协议给Router A分配代理前缀，Router
A再通过代理前缀给下面的主机分配IPv6地址。

## 实验步骤：

1、配置虚拟模板接口的参数，采用PAP认证对端，配置本端IPv6地址，关闭对RA消息发布的抑制。

2、在GigabitEthernet0/0接口上启用PPPoE
Server协议，将该以太网接口与虚拟模板接口绑定。

3、配置DHCPv6前缀池，DHCPv6地址池，在地址池下引用前缀池。

4、配置PPPoE用户。

5、在ISP域下配置为用户授权地址池属性。

## 测试结果：

配置完成后，当Router
A使用用户名user1、密码123456TESTplat&!，通过PPPoE接入Router B后，Router
B通过DHCPv6协议为Router A分配一个代理前缀。

显示Router A上创建的IPv6前缀信息。

![](./Media//image1.png)


以上信息表示，Router A从Router B获取到代理前缀后，已根据ipv6 dhcp client
pd 1配置创建了编号为1的IPv6前缀。

Router
A把分配到的代理前缀4001::/42再分配给Host，Host用来生成IPv6全球单播地址。

![](./Media//image2.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
