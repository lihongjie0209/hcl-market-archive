# 工程名称
v7交换机开启web远程登陆，限制可登录的源地址


## 需求：
1、开启交换机web登陆，运维人员可通过https式远程登陆交换机

2、仅地址10.0.12.2可以登录交换机web


## 实验步骤：
1、配置接口ip

2、开启http/https服务
ip http enable
ip https enable

3、配置名为web的本地用户，服务类型为http/https，密码为1qaz2wsx3edc，权限为network-admin
local-user web class manage
password simple 1qaz2wsx3edc
service-type http https
authorization-attribute user-role network-admin

4、配置基本acl 2000，匹配源地址是10.0.12.2的流量(如果管理口绑定了VPN实例，那么acl的rule也要携带vpn实例参数)

#
acl basic 2000
 rule 0 permit source 10.0.12.2 0
#


5、https服务关联acl 2000
#
ip https acl 2000
#



## 测试结果：
1、PC1可通过https://10.0.12.1登陆SW1web
2、本例仅用SW1说明开启web登陆的配置


## 说明： 

默认情况下，交换机对可web登录的源地址不做限制


