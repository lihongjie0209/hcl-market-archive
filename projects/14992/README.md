# 工程名称

QOS icmp限速

## 需求：
为了防止从用户平面上送控制平面的报文速率超过控制平面的处理能力，从而影响协议的正常运行，用户可以把QoS策略应用在控制平面上，通过对上送控制平面的报文进行过滤、限速等QoS处理，达到保护控制平面正常报文的收发、维护控制平面正常处理状态的目的。在接口G0/2上对源地址属于IP地址段10.1.1.1～10.1.1.9内所有PC进行限速，网段内各IP地址的流量共享剩余带宽


## 实验步骤：
①配地址，Internet上静态，PC指定网关（如果是路由器，就也写一个静态）
②# 定义类ICMP，匹配控制平面的ICMP协议报文。
<Device> system-view
[Device] traffic classifier ICMP
[Device-classifier-ICMP] if-match control-plane protocol icmp
[Device-classifier-ICMP] quit
# 定义流行为ICMP，使用协议报文限速对匹配的报文进行限速。
[Device] traffic behavior ICMP
[Device-behavior-ICMP] car cir  320
[Device-behavior-ICMP] quit
# 定义QoS策略ICMP，为类ICMP指定流行为ICMP。
[Device] qos policy ICMP
[Device-qospolicy-ICMP] classifier ICMP behavior ICMP
[Device-qospolicy-ICMP] quit
# 将QoS策略ICMP应用在控制平面。
[Device] control-plane 
[Device-cp-slot1] qos apply policy ICMP inbound
[Device-cp-slot1] quit
[Device] qos carl 1 source-ip-address range 10.1.1.1 to 10.1.1.9 per-address shared-bandwidth
[Device-GigabitEthernet0/2] qos car inbound carl 1 cir 500 cbs 1875 ebs 0 green pass red discard

## 测试结果：
![image.png](./Media/image.png)

## 说明： 


