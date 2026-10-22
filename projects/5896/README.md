# 工程名称
v7交换机开启web远程登陆


## 需求：
1、开启交换机web登陆，运维人员可通过https式远程登陆交换机

2、修改https服务端口号为8443


## 实验步骤：
1、配置接口ip
2、开启http/https服务，修改https端口号为8443
#
 ip http enable
 ip https enable
 ip https port 8443
#
3、配置名为web的本地用户，服务类型为http/https，密码为1qaz2wsx3edc，权限为network-admin
#
local-user web class manage
 password simple 1qaz2wsx3edc
 service-type http https
 authorization-attribute user-role network-admin
#


## 测试结果：

1、PC1可通过https://10.0.12.1:8443登陆SW1web
2、本例仅用SW1说明开启web登陆的配置

## 说明： 

交换机web开启后默认使用https(443)端口
