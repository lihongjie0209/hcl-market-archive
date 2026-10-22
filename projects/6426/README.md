# 工程名称

无线控制器 Password Control基础配置举例

## 需求：

（1）全局密码管理策略：用户3次登录失败后就永久禁止该用户通过现有的IP地址登录；最小密码长度为10个字符，密码老化时间为30天；允许用户进行密码更新的最小时间间隔为36小时；密码过期后60天内允许登录5次；用户帐号的闲置时间为30天；不允许密码中包含连续三个或以上相同字符；密码元素的最少组合类型为3种，至少要包含每种元素的个数为1个。

（2）切换到用户角色network-operator时使用的super密码管理策略：最小密码长度为12个字符，密码元素的最少组合类型为3种，至少要包含每种元素的个数为3个。

（3）本地Telnet用户test的密码管理策略：最小密码长度为12个字符，密码元素的最少组合类型为3种，至少要包含每种元素的个数为3个，密码老化时间为20天。


## 实验步骤：

**1.针对全部的登录用户做限制，需要在全局配置密码策略：**

[H3C]password-control enable //开启密码策

[H3C]password-control aging enable //开启密码有效期的策略

[H3C]password-control aging 90 //配置密码有效的时间为90天

[H3C]password-control length enable //开启密码长度的限制

[H3C]password-control length 10 // 配置密码长度最小为10位

[H3C]password-control login-attempt 10 exceed lock-time 10//配置密码可尝试的失败次数为10次，10次失败以后被锁定10分钟后方可继续尝试

**2、针对某个用户做限制，需要在具体用户试图下做配置：**

[H3C]password-control enable //开启密码策略

[H3C]local-user admin //创建admin用户

[H3C-luser-manage-admin]password-control aging 90

//配置admin用户密码有效期为90天

[H3C-luser-manage-admin]password-control length 8//配置admin用户密码长度最小为8位

[H3C-luser-manage-admin]password-control login-attempt 10 exceed lock-time 5//配置admin用户的密码可尝试的失败次数为10次，10次失败以后被锁5分钟后方可继续尝试

注意：
1）假设用户内和全局都配置了密码策略，则该用户内的密码策略生效）
2）假设用户内没有配置密码策略且全局开启了密码策略，则生效的是全局的密码策略

**3. 针对实现需求的配置**
#
password-control enable

password-control aging 30

password-control length 10

password-control composition type-number 3 type-length 1

password-control login-attempt 3 exceed lock

password-control update-interval 36

password-control login idle-time 30

password-control expired-user-login delay 60 times 5

password-control super length 12

password-control super composition type-number 3 type-length 3

#
local-user test class manage

service-type telnet

authorization-attribute user-role network-operator

password-control aging 20


password-control length 12

password-control composition type-number 3 type-length 3

password simple 123ABCDceshi

#

super password role network-operator simple 1234ABCceshi

#


## 测试结果：

（1）可通过如下命令查看全局密码管理的配置信息。
[H3C]display password-control 

 Global password control configurations:

 Password control:                    Enabled

 Password aging:                      Enabled (30 days)

 Password length:                     Enabled (10 characters)

 Password composition:                Enabled (3 types, 1 characters per type)

 Password history:                    Enabled (max history records:4)

 Early notice on password expiration: 7 days

 Maximum login attempts:              3

 Action for exceeding login attempts: Lock

 Minimum interval between two updates:36 hours

 User account idle time:              30 days

 Logins with aged password:           5 times in 60 days

 Password complexity:                 Enabled (username checking)

                                      Disabled (repeated characters checking)

 Password change:                     Enabled (first login)

                                      Disabled (mandatory weak password change)

（2）可通过如下命令查看super密码管理的配置信息。
[H3C]display password-control super 

 Super password control configurations:

 Password aging:                      Enabled (90 days)

 Password length:                     Enabled (12 characters)

 Password composition:                Enabled (3 types, 3 characters per type)

（3）可通过如下命令查看到本地用户密码管理的配置信息。

[H3C]display local-user user-name test class manage 

Total 1 local users matched.

Device management user test:

  State:                     Active

  Service type:              Telnet

  User group:                system

  Bind attributes:

  Authorization attributes:

    Work directory:          flash:

    User role list:          network-operator

  Password control configurations:

    Password aging:          20 days

    Password length:         12 characters

    Password composition:    3 types, 3 characters per type

    Password complexity:     username checking


## 说明： 

1、本实验用的模拟器为WX5560H-HCL，设置内存为默认。

2、本实验用的AC版本为默认版本。

