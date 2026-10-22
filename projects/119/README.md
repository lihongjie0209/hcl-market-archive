# Password Control基础配置举例

## 需求：

有以下密码管理需求：

-   全局密码管理策略：用户2次登录失败后就永久禁止该用户通过现有的IP地址登录；最小密码长度为16个字符，密码老化时间为30天；允许用户进行密码更新的最小时间间隔为36小时；密码过期后60天内允许登录5次；用户帐号的闲置时间为30天；不允许密码中包含用户名或者字符顺序颠倒的用户名；不允许密码中包含连续三个或以上相同字符；密码元素的最少组合类型为4种，至少要包含每种元素的个数为4个。

-   切换到用户角色network-operator时使用的super密码管理策略：最小密码长度为24个字符，密码元素的最少组合类型为4种，至少要包含每种元素的个数为5个。

-   本地Telnet用户test的密码管理策略：最小密码长度为24个字符，密码元素的最少组合类型为4种，至少要包含每种元素的个数为5个，密码老化时间为20天。

## 实验步骤：

密码策略常用命令如下：

1、针对全部的登录用户做限制，需要在全局配置密码策略：

\[H3C\]password-control enable //开启密码策略

\[H3C\]password-control aging enable //开启密码有效期的策略

\[H3C\]password-control aging 90 //配置密码有效的时间为90天

\[H3C\]password-control length enable //开启密码长度的限制

\[H3C\]password-control length 16 // 配置密码长度最小为16位

\[H3C\]password-control login-attempt 10 exceed lock-time 10

//配置密码可尝试的失败次数为10次，10次失败以后被锁定10分钟后方可继续尝试

2、针对某个用户做限制，需要在具体用户试图下做配置：

\[H3C\]password-control enable //开启密码策略

\[H3C\]local-user admin //创建admin用户

\[H3C-luser-manage-admin\]password-control aging 90
//配置admin用户密码有效期为90天

\[H3C-luser-manage-admin\]password-control length 8
//配置admin用户密码长度最小为8位

\[H3C-luser-manage-admin\]password-control login-attempt 10 exceed
lock-time 5

//配置admin用户的密码可尝试的失败次数为10次，10次失败以后被锁5分钟后方可继续尝试

注意：

1、假设用户内和全局都配置了密码策略，则该用户内的密码策略生效

2、假设用户内没有配置密码策略且全局开启了密码策略，则生效的是全局的密码策略

不作为业务使用的场景下，恢复简单密码配置（仅仅做为演示）：

undo password-control enable

undo password-control length enable

undo password-control composition enable

undo password-control complexity

针对实现需求的配置：

\#

password-control enable

password-control aging 30

password-control length 16

password-control composition type-number 4 type-length 4

password-control login-attempt 2 exceed lock

password-control update-interval 36

password-control login idle-time 30

password-control expired-user-login delay 60 times 5

password-control complexity same-character check

password-control super length 24

password-control super composition type-number 4 type-length 5

\#

local-user test class manage

service-type telnet

authorization-attribute user-role network-operator

password-control aging 20

password-control length 24

password-control composition type-number 4 type-length 5

password simple 987654321ABGFTweuix@h3c.com\*#!

\#

super password role network-operator simple
123456789ABGFTweuix@h3c.com\*#!

\#

## 测试结果：

可通过如下命令查看全局密码管理的配置信息。

![](./Media//image1.png)


可通过如下命令查看super密码管理的配置信息。

![](./Media//image2.png)


可通过如下命令查看到本地用户密码管理的配置信息。

![](./Media//image3.png)


## 说明： 

1、本实验用的模拟器为MSR36-20，设置内存为默认。

2、本实验用的路由器版本为默认版本。
