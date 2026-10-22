# PPPoE Server通过ND协议、IPv6CP协商生成信息用于用户生成IPv6地址配置举例

## 需求：

Host和Router之间通过以太网接口相连，Host通过PPPoE接入Router，Router作为PPPoE
Server通过ND协议为Host分配IPv6地址。

在该场景下，Host通过ND协议中的RA报文获得IPv6地址前缀，通过IPv6CP协商获取IPv6接口标识，二者组合生成IPv6全球单播地址。

## 实验步骤：

1、配置虚拟模板接口的参数，采用PAP认证对端，配置本端IPv6地址，关闭对RA消息发布的抑制。

2、在GigabitEthernet0/0接口上启用PPPoE
Server协议，将该以太网接口与虚拟模板接口绑定。

3、配置PPPoE用户。

4、在ISP域下配置为用户授权IPv6前缀属性。

## 测试结果：

配置完成后，当Host使用用户名user1、密码123456TESTplat&!，通过PPPoE接入Router后，通过授权的IPv6前缀和IPv6CP协商获取的IPv6接口标识就自动生成一个IPv6全球单播地址。

![](./Media//image1.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认。
