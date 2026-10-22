# HCL 市场工程快照

`projects/<项目 ID>/` 是普通文件目录，不含内层 `.git`、submodule 或裸仓库。克隆本仓库即可拿到**已提交**的全部工程快照。外层 Git 保留归档的快照历史，但不保留各上游仓库的原始 Git 历史。ZIP、VDI、PNG、DOCX、HCL 和 MDB 二进制文件由 Git LFS 管理；克隆机需要安装 Git LFS 才能取得实际文件，而非指针。

`update.sh` 从 HCLHub 公开市场 API 分页发现项目，浅克隆默认分支到临时目录，并将工作树同步到 `projects/`。市场下架的项目不会自动删除；重复运行可增量更新现有快照。`catalog.json` 为最近一次列表；`state.tsv` 与 `logs/` 是本地运行报告。脚本不读取 HCL 登录凭据，不修改 HCL 客户端工程。

工程来自 [HCLHub 公开市场](https://hclhub.h3c.com/)，按原样保存供实验检索；本归档没有给上游项目增加许可。各项目文件、图片和配置的权利归原作者或相关权利人。项目 3263 内含上游原有的演示证书及私钥，仅用于该实验，**不要在真实环境复用**。下载和克隆本归档可能消耗仓库所有者的 Git LFS 流量配额。

完整克隆：

```bash
git lfs install
git clone https://github.com/lihongjie0209/hcl-market-archive.git
```

更新依赖 Bash、curl、jq、Git、Git LFS、rsync、flock。Linux、WSL 和常见 CI runner 可运行：

```bash
./update.sh --max-projects 1  # 小样本验证
./update.sh                   # 全量同步
git add catalog.json projects
git commit -m 'Update HCL market snapshots'
```

脚本不自动提交或推送。只有提交后的文件才会出现在下一次 `git clone` 中；历史快照可用 `git log -- projects/<ID>` 查询。磁盘剩余低于 10 GiB 时停止；下载失败、目录冲突均保留原有文件并在日志中报告。未归档上游分支、标签和完整提交历史。

## 项目目录

下表由 `generate-index.sh` 根据市场列表和本地文件自动生成。只有“已归档”条目才提供本仓库目录链接；上游简介保留原文，未对内容作兼容性或安全性背书。

<!-- PROJECT_INDEX_START -->

市场项目：536；已归档：536。

| ID | 项目 | 简介 | 状态 | 本地目录 |
| --- | --- | --- | --- | --- |

| 30 | 分布式EVPN网关配置举例 | Router A、Router B为分布式EVPN网关设备；Router C为与广域网连接的边界网关设备；Router D为RR，负责在路由器之间反射BGP路由。虚拟机VM 1和VM 3属于VXLAN 10；VM 2和VM 4属于VXLAN 20。相同VXLAN之间可以二层互通；不同VXLAN之间通过分布式EVPN网关实现三层互通；VXLAN与广域网之间通过边界网关实现三层互通。 | 已归档 | [projects/30](projects/30/) |
| 49 | DHCP Relay+DRNI组网配置举例 | DRNI组网中，DR设备使能DHCP Relay，Device D设备作为dhcp client，Device C设备作为dhcp server，client从server获取地址。 | 已归档 | [projects/49](projects/49/) |
| 50 | 动态分配IPv6地址配置举例 | Switch作为DHCPv6服务器，DHCPv6客户端从DHCPv6服务器获取IPv6地址前缀，以及网络配置参数：DNS服务器地址、域名、SIP服务器地址和SIP服务器域名。 | 已归档 | [projects/50](projects/50/) |
| 55 | PAP单向认证配置举例 | Router A和Router B之间用接口Serial2/0互连，要求设备Router A用CHAP方式认证设备Router B。 | 已归档 | [projects/55](projects/55/) |
| 56 | 从ISP域下关联的PPP地址池中分配IP地址配置举例 | Router A通过PPP协商，为Router B的接口Serial2/0分配IP地址。要求Router A从接口下指定的PPP地址池中分配IP地址。 | 已归档 | [projects/56](projects/56/) |
| 67 | BGP负载分担配置 | 所有路由器都配置BGP，Router A在AS 65008中，Router B和Router C在AS 65009中。Router A与Router B、Router C之间运行EBGP，Router B和Router C之间运行IBGP。在Router A上配置负载分担的路由条数为2，以提高链路利用率。 | 已归档 | [projects/67](projects/67/) |
| 68 | BGP基本配置 | 所有路由器均运行BGP协议。要求Router A和Router B之间建立EBGP连接，Router B和Router C之间建立IBGP连接，使得Router C能够访问Router A直连的8.1.1.0/24网段。 | 已归档 | [projects/68](projects/68/) |
| 71 | IPv6 BGP基本配置 | 所有路由器均运行IPv6 BGP协议。Router A位于AS 65008；Router B和Router C位于AS 65009。要求Router A和Router B之间建立EBGP连接，Router B和Router C之间建立IBGP连接，使得Router C能够访问Router A直连的50::/64网段。 | 已归档 | [projects/71](projects/71/) |
| 72 | IPv6 IS-IS基本组网配置举例 | Router A、Router B、Router C和Router D属于同一自治系统，所有路由器已使能了IPv6能力，要求它们之间通过IPv6 IS-IS协议达到IPv6网络互连的目的。其中Router A和Router B是Level-1路由器，Router D是Level-2路由器，Router C是Level-1-2路由器。Router A、Router B和Router C属于区域10，而Router D属于区域20。 | 已归档 | [projects/72](projects/72/) |
| 74 | IS-IS验证配置举例 | Router A、Router B、Router C和Router D属于同一路由域，要求它们之间通过IS-IS协议达到IP网络互连的目的。其中，Router A、Router B和Router C属于同一个区域，区域号为10，Router D属于另外一个区域，区域号为20。在区域10内配置区域验证，防止不可信任的路由信息加入到区域10的LSDB中；在Router C和Router D上配置路由域验证，防止将不可信的路由信息注入当前路由域；分别在Router A、Router B、Router C和Router D上配置邻居关系验证。 | 已归档 | [projects/74](projects/74/) |
| 75 | IS-IS引入外部路由配置举例 | Router A、Router B、Router C和Router D属于同一自治系统，要求它们之间通过IS-IS协议达到IP网络互连的目的。Router A和Router B为Level-1路由器，Router D为Level-2路由器，Router C作为Level-1-2路由器将两个区域相连。Router A、Router B和Router C的区域号为10，Router D的区域号为20。在Router D的IS-IS进程中引入RIP路由。 | 已归档 | [projects/75](projects/75/) |
| 76 | IS-IS与BFD联动配置举例 | 当Router A、Router B和Router C上运行IS-IS，网络层相互可达。当Router A和Router B通过L2 Switch通信的链路出现故障时BFD能够快速感知通告IS-IS协议，并且切换到Router C进行通信。 | 已归档 | [projects/76](projects/76/) |
| 77 | OSPF NSSA区域配置举例 | 所有的路由器都运行OSPF，整个自治系统划分为3个区域。其中Router A和Router B作为ABR来转发区域之间的路由。要求将Area1配置为NSSA区域，同时将Router C配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。 | 已归档 | [projects/77](projects/77/) |
| 78 | OSPF发布聚合路由配置举例 | Router A和Router B位于AS200内，AS200内使用OSPF作为IGP协议。Router C、Router D和Router E位于AS100内，AS100内使用OSPF作为IGP协议。Router B和Router C之间建立EBGP连接，配置BGP引入OSPF和直连路由，配置OSPF进程引入BGP路由。为了减小Router A的路由表规模，在Router B上配置路由聚合，只发布聚合后的路由10.0.0.0/8。 | 已归档 | [projects/78](projects/78/) |
| 79 | OSPF快速重路由配置举例 | Router A、Router B和Router C属于同一OSPF区域，通过OSPF协议实现网络互连。要求当Router A和Router B之间的链路出现故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/79](projects/79/) |
| 80 | OSPF虚连接配置举例 | Area2没有与Area0直接相连。Area1被用作传输区域（Transit Area）来连接Area2和Area0。Router B和Router C之间配置一条虚连接。配置完成后，Router B能够学到Area2中的路由。 | 已归档 | [projects/80](projects/80/) |
| 81 | OSPF与BFD联动配置举例 | Router A、Router B和Router C上运行OSPF，网络层相互可达。当Router A和Router B通过L2 Switch通信的链路出现故障时BFD能够快速感知通告OSPF协议，并且切换到Router C进行通信。 | 已归档 | [projects/81](projects/81/) |
| 84 | OSPFv3发布ASBR聚合路由配置举例 | Router A、Router B和Router C位于Area 2内；Router B上运行两个OSPFv3进程：1和2。Router B通过进程1和Router A交换路由信息，通过进程2和Router C交换路由信息；在Router A的接口GigabitEthernet1/0/1上配置地址2:1:1::1/64、2:1:2::1/64、2:1:3::1/64，并在Router B上配置OSPFv3进程2引入直连路由和OSPFv3进程1的路由，使得Router C能够学习到达2::/64、2:1:1::/64、2:1:2::/64、2:1:3::/64的路由；为了减小Router C的路由表规模，在Router B上配置ASBR聚合路由，只发布聚合后的路由2::/16。 | 已归档 | [projects/84](projects/84/) |
| 85 | 基于报文协议类型的本地策略路由配置 | Router A分别与Router B和Router C直连（保证Router B和Router C之间路由完全不可达）。通过策略路由控制Router A产生的报文：指定所有TCP报文的下一跳为1.1.2.2；其它报文仍然按照查找路由表的方式进行转发。 | 已归档 | [projects/85](projects/85/) |
| 96 | EVPN和DRNI二层转发配置举例 | Switch A、Switch B、Switch D为与服务器连接的VTEP设备，Switch A和Switch B分布式聚合为一台虚拟VTEP设备，通过IPL（Intra-Portal Link，内部控制链路）同步MAC地址和ARP信息。Switch C作为路由反射器在Switch A、Switch B、Switch D之间反射路由。虚拟机sever1、sever 4和sever 3同属于VXLAN 10，通过EVPN实现不同站点间的二层互通。 | 已归档 | [projects/96](projects/96/) |
| 97 | EVPN和DRNI三层转发配置举例 | Switch A、Switch B、Switch D为与服务器连接的VTEP设备，Switch A和Switch B分布式聚合为一台虚拟VTEP设备，通过IPL（Intra-Portal Link，内部控制链路）同步MAC地址和ARP信息。Switch C作为路由反射器在Switch A、Switch B、Switch D之间反射路由。虚拟机VM 1和VM 5属于VXLAN 10，VM4属于VXLAN 20，通过分布式EVPN网关实现不同VXLAN之间互通。 | 已归档 | [projects/97](projects/97/) |
| 99 | LDP方式VPLS配置举例 | PE 1、PE 2通过服务实例将报文与VSI实例关联，以便更为灵活地匹配从AC接收到的报文：服务实例10用来匹配接口收到的VLAN Tag为100的报文，并通过VSI实例aaa转发文。 | 已归档 | [projects/99](projects/99/) |
| 100 | BGP PW配置举例 | 用户网络多个站点之间通过静态PW实现互通，在PE 1和PE 2分别创建以太网服务实例10，匹配接口Twenty-FiveGigE1/0/1接收到的VLAN Tag为10的报文。 | 已归档 | [projects/100](projects/100/) |
| 101 | 静态PW配置举例 | 用户网络多个站点之间通过静态PW实现互通，在PE 1和PE 2分别创建以太网服务实例10，匹配接口Twenty-FiveGigE1/0/1接收到的VLAN Tag为10的报文。 | 已归档 | [projects/101](projects/101/) |
| 102 | QinQ基本组网配置举例 | 两个分支机构Site 1和Site 2通过运营商网络进行通信，PE 1和PE 2为运营商网络的边缘设备，且二者通过TPID值为0x8200的运营商网络设备进行连接，Site 1和Site 2需要利用运营商提供的VLAN 100使公司A的两个分支机构之间实现互通。 | 已归档 | [projects/102](projects/102/) |
| 103 | MPLS L3VPN配置举例 | CE 1、CE 3属于VPN 1，CE 2、CE 4属于VPN 2；VPN 1使用的Route Target属性为111:1，VPN 2使用的Route Target属性为222:2。不同VPN用户之间不能互相访问。 | 已归档 | [projects/103](projects/103/) |
| 113 | 明确的Dot1q终结配置举例 | 如下图所示，Host A、Host B和Switch A相连，Host C、Host D和Switch B相连。Host A和Host C属于VLAN 10，Host B和Host D属于VLAN 20。Device子接口GigabitEthernet0/1.10、GigabitEthernet0/1.20、GigabitEthernet0/2.10、GigabitEthernet0/2.20的IP地址分别为1.0.0.1/8、2.0.0.1/8、3.0.0.1/8和4.0.0.1/8。要求实现：Host A和Host B之间、Host C和Host D之间能够互相通信，即同一交换机、不同VLAN之间能够互相通信；Host A和Host C之间、Host B和Host D之间能够互相通信，即不同交换机、同一VLAN之间能够互相通信；Host A和Host D之间、Host B和Host C之间能够互相通信，即不同交换机、不同VLAN之间能够互相通信。 | 已归档 | [projects/113](projects/113/) |
| 115 | 即插即用网关基本组网配置举例 | PC-1的IP地址是172.16.0.1/16，所在局域网的网络号为172.16.0.0/16。PC-2的IP地址是172.16.1.1/16，所在局域网的网络号为172.16.0.0/16。PC-1和PC-2互相认为处于同一子网，但实际却被设备Router分在两个不同的子网。PC-1和PC-2没有配置缺省网关，要求在设备Router上开启普通代理ARP功能，使处在两个子网的PC-1和PC-2能互通。 | 已归档 | [projects/115](projects/115/) |
| 116 | 配置在OSPF中引入IS-IS路由时应用路由策略配置举例 | Router B与Router A之间通过OSPF协议交换路由信息，与Router C之间通过IS-IS协议交换路由信息。要求在Router B上配置路由引入，将IS-IS路由引入到OSPF中去，并同时使用路由策略设置路由的属性。其中，设置172.17.1.0/24的路由的开销为100，设置172.17.2.0/24的路由的Tag属性为20。 | 已归档 | [projects/116](projects/116/) |
| 119 | Password Control基础配置举例 | 全局密码管理策略：用户2次登录失败后就永久禁止该用户通过现有的IP地址登录；最小密码长度为16个字符，密码老化时间为30天；允许用户进行密码更新的最小时间间隔为36小时；密码过期后60天内允许登录5次；用户帐号的闲置时间为30天；不允许密码中包含用户名或者字符顺序颠倒的用户名；不允许密码中包含连续三个或以上相同字符；密码元素的最少组合类型为4种，至少要包含每种元素的个数为4个。切换到用户角色network-operator时使用的super密码管理策略：最小密码长度为24个字符，密码元素的最少组合类型为4种，至少要包含每种元素的个数为5个。本地Telnet用户test的密码管理策略：最小密码长度为24个字符，密码元素的最少组合类型为4种，至少要包含每种元素的个数为5个，密码老化时间为20天。 | 已归档 | [projects/119](projects/119/) |
| 122 | IRF典型配置举例（BFD MAD检测方式） | 由于公司人员激增，接入层设备提供的端口数目已经不能满足PC的接入需求。现需要在保护现有投资的基础上扩展端口接入数量，并要求网络易管理、易维护。这里采用IRF方式，并且采用BFD进行MAD检测。 | 已归档 | [projects/122](projects/122/) |
| 132 | NGFW GRE over IPsec野蛮模式配置实验 | 搭建gre over ipsec的隧道，其中ipsec为野蛮模式，MSR36-20_3为NAT设备，做SNAT转换源地址，F1060_1为分支设备，F1060_2为总部设备并使用模板方式。 | 已归档 | [projects/132](projects/132/) |
| 133 | F1060 IPsec主模式NAT穿越FQDN对接实验 | NAT穿越模式下（分支侧穿越），IPSEC主模式，分支使用对等体，总部使用对等体FQDN认证建立IPSEC VPN。 | 已归档 | [projects/133](projects/133/) |
| 136 | NGFW IPsec反向路由注入实验 | FW1作为总部，和分支FW3/FW4建立ipsec隧道，采用模板方式，总部不写感兴趣流，分支侧触发，建立隧道后，总部侧自动生成到分支的静态路由，隧道删除后相应路由删除。组网如下： | 已归档 | [projects/136](projects/136/) |
| 140 | F1090 IPsec野蛮模式NAT穿越FQDN对接实验 |  通过ikev2的方式建立ipsec隧道，其中ipsec为野蛮模式，MSR36-20_3为NAT设备，做SNAT转换源地址，F1060_1为分支设备，F1060_2为总部设备并使用模板方式。 | 已归档 | [projects/140](projects/140/) |
| 141 | NGFW IPsec中心分支组网配置实验 | MSR36_20_2作为分支与F1090_3的总部建立IPsec隧道，使得内部主机PC_1与PC_4能够正常通信。 | 已归档 | [projects/141](projects/141/) |
| 142 | NGFW IPsec主模式IKEv2配置实验 |  通过ikev2的方式建立ipsec隧道，其中ipsec为主模式。 | 已归档 | [projects/142](projects/142/) |
| 143 | NGFW L2TP over IPsec inode拨号配置实验 | l2tp over ipsec+NAT穿越+inode拨号实验，要求能拨号成功。拓扑： | 已归档 | [projects/143](projects/143/) |
| 145 | NGFW SSLVPN inode拨号配置实验 |  | 已归档 | [projects/145](projects/145/) |
| 146 | NGFW VPN实例下NAT server配置实验 | 防火墙FW1位于外网区域，FW2为NAT设备，入接口配置了VPN实例v1,内网口设置为三种情况：VPN实例v2,无VPN实例以及VPN实例v1FW3、4、5作为内网服务器提供服务。根据该实验学习VPN实例场景下进行NAT转发的配置 | 已归档 | [projects/146](projects/146/) |
| 147 | NGFW单机基础NAT配置实验 | 内网主机192.168.10.1和内网服务器10.1.1.1网关均在核心交换机上，核心交换机相连的接口地址分别为192.168.10.2、10.1.1.2。核心交换机上行是出口防火墙F1090，内网口G1/0/3地址为172.31.1.1，公网口G1/0/2地址为61.1.1.1。出口防火墙公网口与公网服务器61.1.1.2直连。要求：（1）内网主机需要通过出口防火墙做动态NAT转换去访问公网服务器，要求使用公网地址61.1.1.10作为动态地址池地址。（2）出口防火墙上做一条nat server的映射（61.1.1.6:5456映射内网服务器10.1.1.1:23），使得公网可以访问内网服务器的23端口。 | 已归档 | [projects/147](projects/147/) |
| 148 | 双机IRFNAT配置实验 | 内网主机192.168.10.1和内网服务器10.1.1.1网关均在核心交换机上，核心交换机相连的接口地址分别为192.168.10.2、10.1.1.2。核心交换机上行是出口防火墙F1090，F1090做IRF，与交换机之前通过三层聚合口6相连，三层聚合口6地址为172.31.1.1，公网口G1/0/2加入三层聚合口5，地址为61.1.1.1。出口防火墙公网口与外部交换机通过三层聚合口5相连，三层聚合口5地址未61.1.1.1，外部交换机与公网服务器11.1.1.2相连。要求：（1）内网主机需要通过出口防火墙做动态NAT转换去访问公网服务器，要求使用公网地址61.1.1.3作为动态地址池地址。（2）出口防火墙上做一条nat server的映射（61.1.1.4:5456映射内网服务器10.1.1.1:23），使得公网可以访问内网服务器的23端口。 | 已归档 | [projects/148](projects/148/) |
| 149 | NGFW攻击防范配置实验 | 内网网关地址为10.10.10.2/24，在出口部署一台防火墙用于保护内网服务器，防火墙内网口G1/0/2地址为10.10.10.1，外网口G1/0/1地址为116.1.1.1/24，用一台Host模拟公网主机（116.1.1.2），在防火墙上配置攻击防范策略保护内网服务器避免受到公网主机的攻击。 | 已归档 | [projects/149](projects/149/) |
| 150 | IRF冗余主备配置 | 2台防火墙堆叠，通过Reth1口（冗余口）和上行交换机SW1互联，下行两个三层口和MSR对接，正常情况下业务由MSR的G0/1口上到FW1处理，当FW1故障时业务切换至FW2处理。其中，防火墙G1/0/2口地址为10.10.1.1/24，G2/0/2口地址为10.20.1.1/24；MSR G0/1口地址为10.10.1.2/24，G0/2口地址为10.20.1.2/24。 | 已归档 | [projects/150](projects/150/) |
| 151 | NGFW双机RBM VRRP组网配置实验 | 防火墙FW1和FW2作为网络出口进行HA组网，RBM结合VRRP，同时需要两台防火墙同时处理业务，提高业务处理能力。但是当FW1或其链路发生故障时，FW2可以接替FW2继续工作，保证业务不会中断。 | 已归档 | [projects/151](projects/151/) |
| 152 | NGFW双向NAT（等同NAT hairpin）配置实验 | 虚拟机PC_3和PC_4同网段，但是需要用nat server global地址去访问，由于同网段，如果不做源地址转换，回程PC_4会直接通过交换机发给PC_3，因此需要来回流量都过防火墙，普通的nat hairpin能实现但是有诸多限制，因此使用nat server加NAT outbound的方式实现二次NAT。 | 已归档 | [projects/152](projects/152/) |
| 173 | IRF典型配置举例（LACP MAD检测方式） | 由于公司人员激增，接入层设备提供的端口数目已经不能满足PC的接入需求。现需要在保护现有投资的基础上扩展端口接入数量，并要求网络易管理、易维护。这里采用IRF方式，并且采用LACP进行MAD检测。 | 已归档 | [projects/173](projects/173/) |
| 174 | 三层静态聚合配置举例 | Device A与Device B通过各自的三层以太网接口GigabitEthernet0/0～GigabitEthernet0/1相互连接。在Device A和Device B上分别配置三层静态链路聚合组，并为对应的三层聚合接口配置IP地址和子网掩码。 | 已归档 | [projects/174](projects/174/) |
| 175 | Dot1q终结支持PPPoE Server配置举例 | Client和Switch相连，分别属于VLAN 10、VLAN 20，客户端需要使用拨号方式访问Internet。 | 已归档 | [projects/175](projects/175/) |
| 176 | 模糊的Dot1q终结配置举例 | Host A、Host B、Host C和Switch A相连，Server group和Switch B相连。Host A、Host B、Host C分别属于VLAN 11、VLAN 12、VLAN 13；这些Host需要与Server group互相通信。 | 已归档 | [projects/176](projects/176/) |
| 177 | PAP双向认证配置举例 | Router A和Router B之间用接口Serial2/0互连，要求Router A和Router B用PAP方式相互认证对方。 | 已归档 | [projects/177](projects/177/) |
| 178 | 从接口下指定的PPP地址池中分配IP地址配置举例 | Router A通过PPP协商，为Router B的接口Serial2/0分配IP地址。要求Router A从接口下指定的PPP地址池中分配IP地址。 | 已归档 | [projects/178](projects/178/) |
| 179 | 在接口下指定为Client端分配的IP地址配置举例 | Router A通过PPP协商，为Router B的接口Serial2/0分配IP地址。要求Router A用接口下指定的IP地址为Router B分配IP地址。 | 已归档 | [projects/179](projects/179/) |
| 180 | 通过将物理接口直接绑定到VT接口方式进行MP捆绑配置举例 | 设备Router A和Router B的Serial1/0和Serial2/0分别对应连接。要求通过将物理接口直接绑定到VT接口方式进行MP捆绑。 | 已归档 | [projects/180](projects/180/) |
| 181 | 通过将链路绑定到MP-group接口方式进行MP捆绑配置举例 | 设备Router A和Router B的Serial1/0和Serial2/0分别对应连接。要求通过将链路绑定到MP-group接口方式进行MP捆绑。 | 已归档 | [projects/181](projects/181/) |
| 182 | PPPoE Server通过本地DHCP服务器为用户分配IP地址配置举例 | 要求以太网内的主机可以通过PPPoE接入Router，并连接到外部网络。主机作为PPPoE Client，运行PPPoE客户端拨号软件。Router作为PPPoE Server，配置本地PAP认证，并通过DHCPv4协议为终端分配IP地址。 | 已归档 | [projects/182](projects/182/) |
| 183 | Client-Initiated模式L2TP隧道配置举例 | PPP用户直接与LNS建立L2TP隧道，通过L2TP隧道访问公司总部。 | 已归档 | [projects/183](projects/183/) |
| 184 | HDLC基本组网配置举例 | 路由器Router A和Router B通过POS接口相连，要求运行HDLC协议。 | 已归档 | [projects/184](projects/184/) |
| 185 | IPv4 over IPv6手动隧道典型配置举例 | 两个IPv4网络分别通过Router A和Router B与IPv6网络连接。通过在Router A和Router B之间建立IPv4 over IPv6手动隧道，实现两个IPv4网络穿越IPv6网络互联。 | 已归档 | [projects/185](projects/185/) |
| 186 | DS-Lite隧道典型配置举例 | 运行IPv4协议的私网Private IPv4 network和公网IPv4 network通过IPv6网络相连。通过在B4设备（Router A）和AFTR（Router B）之间建立DS-Lite隧道，并在AFTR连接IPv4 network接口上配置NAT，实现IPv4私网主机穿越IPv6网络访问IPv4公网。 | 已归档 | [projects/186](projects/186/) |
| 187 | IPv4 Hub-Spoke类型ADVPN典型配置举例 | 在IPv4 Hub-Spoke的组网方式下，数据通过Hub-Spoke隧道进行转发。主、备VAM Server负责管理、维护各个节点的信息；AAA服务器（模拟器采用本地认证）负责对VAM Client进行认证和计费管理；两个Hub互为备份，负责数据的转发和路由信息的交换。Spoke与Hub之间建立永久的ADVPN隧道。根据数据转发方式的不同，ADVPN组网结构分为如下两种：Full-Mesh（全互联）网络：Spoke和Spoke之间可以建立隧道直接通信。Hub-Spoke网络：Spoke之间不能建立隧道直接通信，只能通过Hub转发数据。在Full-Mesh网络中，Spoke向VAM Server注册后获得Spoke所属ADVPN域所在Hub组中Hub的信息，并与Hub建立永久的ADVPN隧道。当两个Spoke之间有数据报文交互时，Spoke从VAM Server获取对端Spoke的公网地址，并在Spoke之间直接建立隧道。Spoke之间的隧道是动态的，当在一段时间（Spoke-Spoke隧道空闲超时时间）内没有数据报文交互时，则删除该隧道。在Hub-Spoke网络中，Spoke向VAM Server注册后获得Spoke所属ADVPN域所在Hub组中Hub的信息，并与Hub建立永久的ADVPN隧道。两个Spoke之间有数据报文交互时，该报文通过Hub转发，不会在Spoke之间建立隧道。Hub既作为路由信息交换的中心，又作为数据转发的中心。在OSPF中，有网络类型的存在，而Tunnel接口默认是点对点的。因为Hub跟Spoke是点对N的关系，那么则有Broadcast与P2MP选择，Broadcast是需要选举DR，BDR的，所以在这种情况下 Spoke不能充当DR，否则的话很有可能许多DR，Hub端会把Spoke都当成DR（可能Spoke端的Router ID大），这样的话路由传递就会有问题。所以需要把Spoke的DR选举优先级改为0。 | 已归档 | [projects/187](projects/187/) |
| 188 | Full-Mesh类型ADVPN典型配置举例 | 在IPv4 Full-Mesh的组网方式下，主、备VAM Server负责管理、维护各个节点的信息；AAA服务器（模拟器采用本地认证）负责对VAM Client进行认证和计费管理；两个Hub互为备份，负责数据的转发和路由信息的交换。Spoke与Hub之间建立永久的ADVPN隧道。同一ADVPN域中，任意的两个Spoke之间在有数据时动态建立ADVPN隧道。根据数据转发方式的不同，ADVPN组网结构分为如下两种：Full-Mesh（全互联）网络：Spoke和Spoke之间可以建立隧道直接通信。Hub-Spoke网络：Spoke之间不能建立隧道直接通信，只能通过Hub转发数据。在Full-Mesh网络中，Spoke向VAM Server注册后获得Spoke所属ADVPN域所在Hub组中Hub的信息，并与Hub建立永久的ADVPN隧道。当两个Spoke之间有数据报文交互时，Spoke从VAM Server获取对端Spoke的公网地址，并在Spoke之间直接建立隧道。Spoke之间的隧道是动态的，当在一段时间（Spoke-Spoke隧道空闲超时时间）内没有数据报文交互时，则删除该隧道。在Hub-Spoke网络中，Spoke向VAM Server注册后获得Spoke所属ADVPN域所在Hub组中Hub的信息，并与Hub建立永久的ADVPN隧道。两个Spoke之间有数据报文交互时，该报文通过Hub转发，不会在Spoke之间建立隧道。Hub既作为路由信息交换的中心，又作为数据转发的中心。在OSPF中，有网络类型的存在，而Tunnel接口默认是点对点的。因为Hub跟Spoke是点对N的关系，那么则有Broadcast与P2MP选择，Broadcast是需要选举DR，BDR的，所以在这种情况下 Spoke不能充当DR，否则的话很有可能许多DR，Hub端会把Spoke都当成DR（可能Spoke端的Router ID大），这样的话路由传递就会有问题。所以需要把Spoke的DR选举优先级改为0。 | 已归档 | [projects/188](projects/188/) |
| 189 | 静态路由与BFD联动（直连）配置举例 | 在Router A上配置静态路由可以到达120.1.1.0/24网段，在Router B上配置静态路由可以到达121.1.1.0/24网段，并使能BFD检测功能。在Router C上配置静态路由可以到达120.1.1.0/24网段和121.1.1.0/24网段。当Router A和Router B通过L2 Switch通信的链路出现故障时，BFD能够快速感知，并且切换到Router C进行通信。 | 已归档 | [projects/189](projects/189/) |
| 190 | 静态路由与BFD联动（非直连）配置举例 | 在Router A上配置静态路由可以到达120.1.1.0/24网段，在Router B上配置静态路由可以到达121.1.1.0/24网段，并使能BFD检测功能。在Router C和Router D上配置静态路由可以到达120.1.1.0/24网段和121.1.1.0/24网段。Router A存在到Router B的接口Loopback1（2.2.2.9/32）的路由，出接口为GigabitEthernet0/0；Router B存在到Router A的接口Loopback1（1.1.1.9/32）的路由，出接口为GigabitEthernet0/0；Router D存在到1.1.1.9/32的路由，出接口为GigabitEthernet0/0，存在到2.2.2.9/32的路由，出接口为GigabitEthernet0/1。当Router A和Router B通过Router D通信的链路出现故障时，BFD能够快速感知，并且切换到Router C进行通信。 | 已归档 | [projects/190](projects/190/) |
| 191 | 静态路由快速重路由配置举例 | Router A、Router B和Router C通过静态路由实现网络互连。要求当Router A和Router B之间的链路A出现单通故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/191](projects/191/) |
| 192 | OSPF引入自治系统外部路由配置举例 | 所有的路由器都运行OSPF，并将整个自治系统划分为3个区域。其中Router A和Router B作为ABR来转发区域之间的路由。在Router C上配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。 | 已归档 | [projects/192](projects/192/) |
| 193 | OSPF基本功能配置举例 | 所有的路由器都运行OSPF，并将整个自治系统划分为3个区域。其中Router A和Router B作为ABR来转发区域之间的路由。配置完成后，每台路由器都应学到AS内的到所有网段的路由。 | 已归档 | [projects/193](projects/193/) |
| 194 | OSPF Stub区域配置举例 | 所有的路由器都运行OSPF，整个自治系统划分为3个区域。其中Router A和Router B作为ABR来转发区域之间的路由，Router D作为ASBR引入了外部路由（静态路由）。要求将Area1配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。 | 已归档 | [projects/194](projects/194/) |
| 195 | IS-IS基本功能配置举例 | Router A、Router B、Router C和Router D属于同一自治系统，要求它们之间通过IS-IS协议达到IP网络互连的目的。Router A和Router B为Level-1路由器，Router D为Level-2路由器，Router C作为Level-1-2路由器将两个区域相连。Router A、Router B和Router C的区域号为10，Router D的区域号为20。 | 已归档 | [projects/195](projects/195/) |
| 196 | BGP与IGP交互配置 | 公司A的所有设备在AS 65008内，公司B的所有设备在AS 65009内，AS 65008和AS 65009通过设备Router A和Router B相连。现要求实现Router A能够访问AS 65009内的网段9.1.2.0/24，Router C能够访问AS 65008内的网段8.1.1.0/24。 | 已归档 | [projects/196](projects/196/) |
| 197 | BGP路由聚合配置 | 通过在边界设备Router C和外部网络设备Router D之间建立EBGP连接，实现公司内部网络与外部网络的互通。在公司内部，核心层设备Router B与汇聚层设备Router A之间配置静态路由，Router B与Router C之间配置OSPF，并在OSPF路由中引入静态路由，以实现公司内部网络的互通。公司内部网络包括三个网段：192.168.64.0/24、192.168.74.0/24和192.168.99.0/24。在Router C上配置路由聚合，将这三个网段的路由聚合为一条路由，以减少通过BGP发布的路由数量。 | 已归档 | [projects/197](projects/197/) |
| 204 | TFTP服务器典型配置举例 | 将PC与Device通过以太口直连，配置相应IP地址，保证设备之间互通。Device作为TFTP Server。PC登录到TFTP服务器上实现文件的上传下载。 | 已归档 | [projects/204](projects/204/) |
| 205 | 通过SSH登录设备 | 用户可以通过Host上运行的Stelnet客户端软件（SSH2版本）安全地登录到Server上，并被授予用户角色network-admin进行配置管理；Router采用scheme认证方式对Stelnet客户端进行认证，客户端的用户名和密码保存在本地。 | 已归档 | [projects/205](projects/205/) |
| 209 | Telnet用户的本地用户角色授权配置 | Telnet用户主机与Router相连，需要实现Router对Telnet用户进行本地认证并授权用户角色。Telnet用户的登录用户名为user1@bbb，密码为Qwerty1234，认证通过后被授权的用户角色为role1。role1具有如下用户权限：允许用户执行所有特性中读类型的命令；允许用户执行进入接口视图以及接口视图下的相关命令，并具有操作接口GigabitEthernet0/1～GigabitEthernet0/2的权限。 | 已归档 | [projects/209](projects/209/) |
| 210 | FTP服务器典型配置举例 | FTP客户端登录FTP服务器的用户名为admin，密码为Qwerty1234。将存储在PC上的文件temp.bin上传到FTP服务器，并使用FTP功能备份FTP-Server的启动配置文件。 | 已归档 | [projects/210](projects/210/) |
| 211 | 三层聚合负载分担配置举例 | Device-A与Device-B通过各自的三层以太网接口GigabitEthernet0/0～GigabitEthernet0/1、GigabitEthernet5/0～GigabitEthernet5/1相互连接。在Device-A和Device-B上分别配置两个三层静态链路聚合组，并为对应的三层聚合接口都配置IP地址和子网掩码。通过在聚合组1上按照源IP地址进行聚合负载分担、在聚合组2上按照目的IP地址进行聚合负载分担的方式，来实现数据流量在各成员端口间的负载分担。 | 已归档 | [projects/211](projects/211/) |
| 212 | 三层动态聚合配置举例 | Device A与Device B通过各自的三层以太网接口GigabitEthernet0/0～GigabitEthernet0/1相互连接。在Device A和Device B上分别配置三层动态链路聚合组，并为对应的三层聚合接口配置IP地址和子网掩码。 | 已归档 | [projects/212](projects/212/) |
| 213 | CHAP单向认证配置举例 | Router A和Router B之间用接口Serial2/0互连，要求设备Router A用CHAP方式认证设备Router B。 | 已归档 | [projects/213](projects/213/) |
| 214 | 通过按用户名找VT方式进行MP捆绑配置举例 | 设备Router A和Router B的Serial1/0和Serial2/0分别对应连接。要求通过按用户名找VT方式进行MP捆绑。 | 已归档 | [projects/214](projects/214/) |
| 215 | PPPoE Server通过远端DHCP服务器为用户分配IP地址配置举例 | 要求以太网内的主机可以通过PPPoE接入Router，并连接到外部网络。主机作为PPPoE Client，运行PPPoE客户端拨号软件。Router作为PPPoE Server，配置本地PAP认证，DHCP中继向远端DHCP服务器申请IP地址。 | 已归档 | [projects/215](projects/215/) |
| 216 | PPPoE Server通过PPP地址池为用户分配IPv4地址配置举例 | 要求以太网内的主机可以通过PPPoE接入Router，并连接到外部网络。主机作为PPPoE Client，运行PPPoE客户端拨号软件。Router作为PPPoE Server，配置本地CHAP认证，并通过PPP地址池为主机分配IP地址。 | 已归档 | [projects/216](projects/216/) |
| 217 | PPPoE Server通过ND协议、IPv6CP协商生成信息用于用户生成IPv6地址配置举例 | Host和Router之间通过以太网接口相连，Host通过PPPoE接入Router，Router作为PPPoE Server通过ND协议为Host分配IPv6地址。在该场景下，Host通过ND协议中的RA报文获得IPv6地址前缀，通过IPv6CP协商获取IPv6接口标识，二者组合生成IPv6全球单播地址。 | 已归档 | [projects/217](projects/217/) |
| 218 | PPPoE Server通过DHCPv6协议为用户分配IPv6地址配置举例 | Host和Router之间通过以太网接口相连，Host通过PPPoE接入Router，Router作为PPPoE Server通过DHCPv6协议为Host分配IPv6地址。 | 已归档 | [projects/218](projects/218/) |
| 219 | PPPoE Server通过DHCPv6协议分配代理前缀用于用户生成IPv6地址配置举例 | Router A和Router B之间通过以太网接口相连，Router A通过PPPoE接入Router B，Router B作为PPPoE Server通过DHCPv6协议给Router A分配代理前缀，Router A再通过代理前缀给下面的主机分配IPv6地址。 | 已归档 | [projects/219](projects/219/) |
| 221 | PPPoE Client永久在线模式配置举例 | Router A和Router B之间通过各自的GigabitEthernet0/0接口相连，其中Router A作为PPPoE Server，Router B作为PPPoE Client工作在永久在线模式。 | 已归档 | [projects/221](projects/221/) |
| 222 | PPPoE Client按需拨号模式配置举例 | Router A和Router B之间通过各自的GigabitEthernet0/0接口相连，其中Router A作为PPPoE Server，Router B作为PPPoE Client工作在按需模式，空闲时间间隔为150秒。 | 已归档 | [projects/222](projects/222/) |
| 223 | PPPoE Client诊断模式配置举例 | Router A和Router B之间通过各自的GigabitEthernet0/0接口相连，其中Router A作为PPPoE Server，Router B作为PPPoE Client工作在诊断模式，诊断时间间隔为200秒。 | 已归档 | [projects/223](projects/223/) |
| 225 | LAC-Auto-Initiated模式L2TP隧道配置举例 | PPP用户接入之前，在LAC和LNS之间采用LAC-Auto-Initiated模式建立L2TP隧道。PPP用户接入后，通过已经建立的L2TP隧道访问公司总部。 | 已归档 | [projects/225](projects/225/) |
| 226 | NAS-Initiated模式L2TP隧道配置举例 | PPP用户通过LAC接入LNS，在LAC和LNS之间建立L2TP隧道，以便用户通过该L2TP隧道访问公司总部。 | 已归档 | [projects/226](projects/226/) |
| 227 | HDLC链路捆绑基本组网配置举例 | 为了增加Router A和Router B之间的链路带宽，并提高连接可靠性，在设备之间建立HDLC捆绑逻辑链路。 | 已归档 | [projects/227](projects/227/) |
| 228 | 普通代理ARP基本组网配置举例 | PC-1的IP地址是172.16.0.1/16，所在局域网的网络号为172.16.0.0/16。PC-2的IP地址是172.16.1.1/16，所在局域网的网络号为172.16.0.0/16。PC-1和PC-2互相认为处于同一子网，但实际却被设备Router分在两个不同的子网。PC-1和PC-2没有配置缺省网关，要求在设备Router上开启普通代理ARP功能，使处在两个子网的PC-1和PC-2能互通。 | 已归档 | [projects/228](projects/228/) |
| 230 | GRE over IPv6隧道配置举例 | 运行IPv4协议的两个子网Group 1和Group 2通过IPv6网络相连。通过在Router A和Router B之间建立GRE over IPv6隧道，实现两个子网穿越IPv6网络互联。 | 已归档 | [projects/230](projects/230/) |
| 231 | 6to4隧道典型配置举例 | 两个6to4网络通过网络边缘6to4 router（Router A和Router B）与IPv4网络相连。在Router A和Router B之间建立6to4隧道，实现6to4网络中的主机Host A和Host B之间的互通。 | 已归档 | [projects/231](projects/231/) |
| 232 | 6to4中继典型配置举例 | Router A为6to4路由器，其IPv6侧的网络使用6to4地址。Router B作为6to4中继路由器，它和IPv6网络（2001::/16）相连。要求在Router A和Router B之间配置6to4隧道，使得6to4网络中的主机与IPv6网络中的主机互通。 | 已归档 | [projects/232](projects/232/) |
| 233 | IPv6 over IPv4手动隧道典型配置举例 | 两个IPv6网络分别通过Router A和Router B与IPv4网络连接，要求在Router A和Router B之间建立IPv6 over IPv4隧道，使两个IPv6网络可以互通。由于隧道终点的IPv4地址不能从IPv6报文的目的地址中自动获取，因此，需要配置IPv6 over IPv4手动隧道。 | 已归档 | [projects/233](projects/233/) |
| 234 | ISATAP隧道典型配置举例 | IPv6网络和IPv4网络通过ISATAP路由器相连，在IPv4网络侧分布着一些IPv6主机。要求将IPv4网络中的IPv6主机通过ISATAP隧道接入到IPv6网络。 | 已归档 | [projects/234](projects/234/) |
| 235 | IPv4兼容IPv6自动隧道典型配置举例 | 两台具有双协议栈的路由器Router A和Router B通过IPv4网络连接。网络管理员希望建立IPv4兼容IPv6自动隧道，使得这两台设备能够通过IPv6协议互通。 | 已归档 | [projects/235](projects/235/) |
| 236 | IPv4 over IPv4隧道 | 运行IP协议的两个子网Group 1和Group 2位于不同的区域，这两个子网都使用私网地址。通过在路由器Router A和路由器Router B之间建立IPv4 over IPv4隧道，实现两个子网的互联。 | 已归档 | [projects/236](projects/236/) |
| 237 | IPv6 over IPv6隧道基本组网配置举例 | 运行IPv6协议的两个子网Group 1和Group 2的网络地址不希望泄露到IPv6网络中。网络管理员通过在路由器Router A和路由器Router B之间建立IPv6 over IPv6隧道，实现在Group 1和Group 2的网络地址不被泄露的情况下，确保Group 1和Group 2互通。 | 已归档 | [projects/237](projects/237/) |
| 238 | IS-IS快速重路由配置举例 | Router A、Router B和Router C属于同一IS-IS区域，通过IS-IS协议实现网络互连。要求当Router A和Router B之间的链路出现故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/238](projects/238/) |
| 239 | 基于报文协议类型的转发策略路由配置举例 | Router A分别与Router B和Router C直连（保证Router B和Router C之间路由完全不可达）。通过策略路由控制从Router A的以太网接口GigabitEthernet1/0/1接收的报文：指定所有TCP报文的下一跳为1.1.2.2；其它报文仍然按照查找路由表的方式进行转发。 | 已归档 | [projects/239](projects/239/) |
| 240 | BGP快速重路由配置 | Router A、Router B、Router C和Router D通过BGP协议实现网络互连。要求链路B正常时，Router A和Router D之间的流量通过链路B转发；链路B出现故障时，流量可以快速切换到链路A上。 | 已归档 | [projects/240](projects/240/) |
| 241 | BGP路由反射器配置 | 所有路由器运行BGP协议，Router A与Router B建立EBGP连接，Router C与Router B和Router D之间建立IBGP连接。Router C作为路由反射器，Router B和Router D为Router C的客户机。Router D能够通过Router C学到路由20.0.0.0/8。 | 已归档 | [projects/241](projects/241/) |
| 242 | BGP联盟配置 | AS 200中有多台BGP路由器，为了减少IBGP的连接数，现将他们划分为3个子自治系统：AS 65001、AS 65002和AS 65003。其中AS 65001内的三台路由器建立IBGP全连接。 | 已归档 | [projects/242](projects/242/) |
| 243 | BGP路径选择配置 | 所有路由器都运行BGP协议。Router A与Router B和Router C之间运行EBGP；Router D与Router B和Router C之间运行IBGP。AS 200中运行OSPF协议。配置路由策略，使得Router D优选从Router C学到的1.0.0.0/8路由。 | 已归档 | [projects/243](projects/243/) |
| 246 | BGP与BFD联动配置 | 在AS 200内使用OSPF作为IGP协议，实现AS内的互通。Router A与Router C之间建立两条IBGP连接。当Router A与Router C之间的两条路径均连通时，Router C与1.1.1.0/24之间的报文使用Router A<－>Router B<－>Router C这条路径转发；当Router A<－>Router B<－>Router C这条路径发生故障时，BFD能够快速检测并通告BGP协议，使得Router A<－>Router D<－>Router C这条路径能够迅速生效。 | 已归档 | [projects/246](projects/246/) |
| 247 | OSPFv3 IPsec安全框架配置 | 所有的路由器都运行OSPFv3，整个自治系统划分为2个区域。要求配置IPsec安全框架对Router A、Router B和Router C之间的OSPFv3报文进行有效性检查和验证。 | 已归档 | [projects/247](projects/247/) |
| 248 | OSPFv3 NSSA区域配置 | 所有的路由器都运行OSPFv3，整个自治系统划分为3个区域。其中Router B和Router C作为ABR来转发区域之间的路由。要求将Area 1配置为NSSA区域，同时将Router A配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。 | 已归档 | [projects/248](projects/248/) |
| 249 | OSPFv3 Stub区域配置举例 | 所有的路由器都运行OSPFv3，整个自治系统划分为3个区域。其中Router B和Router C作为ABR来转发区域之间的路由。要求将Area 2配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。 | 已归档 | [projects/249](projects/249/) |
| 250 | BGP自动发现LDP信令方式VPLS配置举例 | CE 1、CE 2和CE 3分属于3个站点，同属于VPN 1；站点1、站点2和站点3通过以太网接口的方式接入PE 1、PE 2和PE 3；在各个PE上配置VPLS，使得PE之间采用BGP协议自动发现邻居、采用LDP信令协议建立PW，通过PW连接各个CE。 | 已归档 | [projects/250](projects/250/) |
| 251 | VPLS 静态PW配置举例 | CE 1、CE 2和CE 3分属于3个站点，同属于VPN 1；站点1、站点2和站点3通过以太网接口的方式接入PE 1、PE 2和PE 3；在各个PE上配置VPLS，使得PE之间采用静态配置建立PW，通过PW连接各个CE。 | 已归档 | [projects/251](projects/251/) |
| 252 | VPLS的Hub-spoke组网配置举例 | 为了便于对各个站点的流量进行集中管理，VPLS采用Hub-spoke组网方式，采用的信令协议为LDP。 | 已归档 | [projects/252](projects/252/) |
| 253 | MPLS L2VPN BGP PW配置举例 | 用户网络有若干个站点，希望通过在骨干网上建立BGP PW，实现站点1与站点2互联，站点1和站点2通过以太网接口的方式接入PE 1和PE 2。 | 已归档 | [projects/253](projects/253/) |
| 254 | MPLS L2VPN LDP PW配置举例 | 用户网络有若干个站点，希望通过在骨干网上建立LDP PW，实现站点1与站点2互联，站点1和站点2通过以太网接口的方式接入PE 1和PE 2。 | 已归档 | [projects/254](projects/254/) |
| 255 | MPLS L2VPN静态PW配置举例 | 用户网络有若干个站点，希望通过在骨干网上建立静态PW，实现站点1与站点2互联，站点1和站点2通过以太网接口的方式接入PE。 | 已归档 | [projects/255](projects/255/) |
| 256 | 配置MPLS L3VPN示例 | CE 1、CE 3属于VPN 1，CE 2、CE 4属于VPN 2；VPN 1使用的Route Target属性为111:1，VPN 2使用的Route Target属性为222:2。不同VPN用户之间不能互相访问；CE与PE之间配置EBGP交换VPN路由信息；PE与PE之间配置OSPF实现PE内部的互通、配置MP-IBGP交换VPN路由信息。 | 已归档 | [projects/256](projects/256/) |
| 257 | 配置MPLS跨域VPN-OptionA方式示例 | CE 1和CE 2属于同一个VPN。CE 1通过AS 100的PE 1接入，CE 2通过AS 200的PE 2接入。采用OptionA方式实现跨域的MPLS L3VPN，即，采用VRF-to-VRF方式管理VPN路由。同一个AS内部的MPLS骨干网使用OSPF作为IGP。 | 已归档 | [projects/257](projects/257/) |
| 258 | 配置MPLS跨域VPN-OptionB方式示例 | Site 1和Site 2属于同一个VPN，Site 1的CE 1通过AS 100的PE 1接入，Site 2的CE 2通过AS 600的PE 2接入；同一自治系统内的PE设备之间运行IS-IS作为IGP；PE 1与ASBR-PE 1间通过MP-IBGP交换VPNv4路由；PE 2与ASBR-PE 2间通过MP-IBGP交换VPNv4路由；ASBR-PE 1与ASBR-PE 2间通过MP-EBGP交换VPNv4路由；ASBR上不对接收的VPNv4路由进行Route Target过滤。 | 已归档 | [projects/258](projects/258/) |
| 259 | 配置MPLS跨域VPN-OptionC方式示例 | Site 1和Site 2属于同一个VPN，Site 1通过AS 100的PE 1接入，Site 2通过AS 600的PE 2接入；同一自治系统内的PE设备之间运行IS-IS作为IGP；PE 1与ASBR-PE 1间通过IBGP交换标签IPv4路由；PE 2与ASBR-PE 2间通过IBGP交换标签IPv4路由；PE 1与PE 2建立MP-EBGP对等体交换VPNv4路由；ASBR-PE 1和ASBR-PE 2上分别配置路由策略，对从对方接收的路由压入标签；ASBR-PE 1与ASBR-PE 2间通过EBGP交换标签IPv4路由。 | 已归档 | [projects/259](projects/259/) |
| 260 | BGP方式VPLS配置举例 | CE 1、CE 2和CE 3分属于3个站点，同属于VPN 1；站点1、站点2和站点3通过以太网接口的方式接入PE 1、PE 2和PE 3；在各个PE上配置VPLS，使得PE之间采用BGP信令协议建立PW，通过PW连接各个CE。 | 已归档 | [projects/260](projects/260/) |
| 261 | ICMP-echo测试配置举例 | 使用NQA的ICMP-echo测试功能，测试本端（Device A）发送的报文是否可以经过指定的下一跳设备（Device C）到达指定的目的端（Device B），以及报文的往返时间。 | 已归档 | [projects/261](projects/261/) |
| 263 | ICMP-jitter测试配置举例 | 使用NQA的ICMP-jitter测试功能，测试本端（RTA）和指定目的端（RTB）之间传送报文的时延抖动。 | 已归档 | [projects/263](projects/263/) |
| 264 | VPLS LDP方式配置举例 | CE 1、CE 2和CE 3分属于3个站点，同属于VPN 1；站点1、站点2和站点3通过以太网接口的方式接入PE 1、PE 2和PE 3；在各个PE上配置VPLS，使得PE之间采用LDP信令协议建立PW，通过PW连接各个CE。 | 已归档 | [projects/264](projects/264/) |
| 265 | VXLAN头端复制配置举例 | Router A、Router B、Router C为与服务器连接的VTEP设备。虚拟机VM 1、VM 2和VM 3同属于VXLAN 10。通过VXLAN实现不同站点间的二层互联，确保虚拟机在站点之间进行迁移时用户的访问流量不会中断。具体需求为：不同VTEP之间手工建立VXLAN隧道。手工关联VXLAN和VXLAN隧道。通过源MAC地址动态学习远端MAC地址表项。站点之间的泛洪流量采用头端复制的方式转发。 | 已归档 | [projects/265](projects/265/) |
| 266 | 分布式VXLAN IP网关配置举例（IPv4网络） | Router A、Router C为分布式VXLAN IP网关设备，Router B为与广域网连接的边界网关设备，Internet为广域网内的三层设备。虚拟机VM 1属于VXLAN 10，VM 2属于VXLAN 20，VM 3属于VXLAN 30。通过分布式VXLAN IP网关实现不同VXLAN网络的三层互联，并通过边界网关实现与广域网的三层互联。具体需求为：不同VTEP之间手工建立VXLAN隧道。手工关联VXLAN和VXLAN隧道。站点之间的泛洪流量采用头端复制的方式转发。VM 1、VM 2、VM 3之间可以互访，且VM 1、VM 2和VM 3都可以访问外部网络。 | 已归档 | [projects/266](projects/266/) |
| 267 | 分布式VXLAN IP网关配置举例（IPv6网络） | VTEP-A、VTEP-C为分布式VXLAN IP网关设备，VTEP-B为与广域网连接的边界网关设备，Internet为广域网内的三层设备。虚拟机VM 1属于VXLAN 10，VM 2属于VXLAN 20。通过分布式VXLAN IP网关实现不同VXLAN网络的三层互联，并通过边界网关实现与广域网的三层互联。具体需求为：不同VTEP之间手工建立VXLAN隧道。手工关联VXLAN和VXLAN隧道。站点之间的泛洪流量采用头端复制的方式转发。 | 已归档 | [projects/267](projects/267/) |
| 268 | 集中式VXLAN IP网关配置举例 | Router A、Router C为与服务器连接的VTEP设备，Router B为与广域网连接的集中式VXLAN IP网关设备，Internet为广域网内的三层设备。虚拟机VM 1、VM 2同属于VXLAN 10，通过VXLAN实现不同站点间的二层互联，并通过VXLAN IP网关与广域网三层互联。具体需求为：不同VTEP之间手工建立VXLAN隧道。手工关联VXLAN和VXLAN隧道。通过源MAC地址动态学习远端MAC地址表项。站点之间的泛洪流量采用头端复制的方式转发。 | 已归档 | [projects/268](projects/268/) |
| 269 | 集中式EVPN网关配置举例 | 使用Router A、Router B为与服务器连接的VTEP设备；Router C为与广域网连接的集中式EVPN网关设备；Router D为RR，负责在路由器之间反射BGP路由。虚拟机VM 1和VM 3属于VXLAN 10；VM 2和VM 4属于VXLAN 20。相同VXLAN之间可以二层互通，不同VXLAN之间、VXLAN与广域网之间可以通过集中式EVPN网关互通。 | 已归档 | [projects/269](projects/269/) |
| 270 | L2TP隧道交换配置举例 | 在LAC和LTS、LTS和LNS之间分别建立L2TP隧道，PPP用户通过多跳L2TP隧道访问公司总部。 | 已归档 | [projects/270](projects/270/) |
| 271 | GRE over IPv4隧道配置举例 | Router A和Router B分别连接IPv4私有网络Group 1和Group 2。这两个私有网络都使用私网地址，且属于同一个VPN。通过在Router A和Router B之间建立GRE隧道，实现两个私有网络的互联。 | 已归档 | [projects/271](projects/271/) |
| 274 | IPv4 Internet访问IPv6网络内部服务器配置举例 | 某公司将网络升级到了IPv6，此时Internet仍然是IPv4网络。该公司希望内部的FTP服务器能够继续为IPv4 Internet的用户提供服务。该公司拥有的IPv4地址为10.1.1.1。为满足上述要求，本例实现方式如下：·使用IPv6侧服务器配置将IPv6内部服务器的地址及端口映射为IPv4地址及端口，Router收到来自IPv4 Internet的报文后，根据该配置策略将报文IPv4目的地址转换为IPv6地址；·使用NAT64前缀将报文源IPv4地址转换为IPv6地址。 | 已归档 | [projects/274](projects/274/) |
| 276 | DHCP中继支持Option 82配置举例 | 在DHCP中继Router A上开启Option 82功能；对包含Option 82的请求报文的处理策略为replace；Circuit ID填充内容为company001，Remote ID填充内容为device001；Router A将添加Option 82的DHCP请求报文转发给DHCP服务器Router B，使得DHCP客户端可以获取到IP地址。 | 已归档 | [projects/276](projects/276/) |
| 278 | NAT444端口块动态映射配置 | 内部网络中的10.110.10.0/24网段的用户可以访问Internet，其它网段的用户不能访问Internet。基于NAT444端口块动态映射方式复用两个外网地址202.38.1.10和202.38.1.11，外网地址的端口范围为1024～65535，端口块大小为300。当为某用户分配的端口块资源耗尽时，再为其增量分配1个端口块。                                                                                                     | 已归档 | [projects/278](projects/278/) |
| 279 | NAT444端口块静态映射配置 | 内部网络用户10.110.10.1～10.110.10.10使用外网地址202.38.1.100访问Internet。内网用户地址基于NAT444端口块静态映射方式复用外网地址202.38.1.100，外网地址的端口范围为10001～15000，端口块大小为500。                                                                                           | 已归档 | [projects/279](projects/279/) |
| 292 | IRF典型配置举例 | 配置Device A、Device B组成IRF设备。配置BFD MAD进行分裂检测。 | 已归档 | [projects/292](projects/292/) |
| 295 | DS-Lite B4端口块动态映射配置 | B4设备为用户网络的网关或者运行DS-Lite客户端软件的用户主机，AFTR设备作为隧道端点设备和NAT网关负责执行隧道报文的封装、解封装以及对解封装后的IPv4地址进行转换。通过在B4和AFTR之间建立DS-Lite隧道，并在AFTR连接IPv4 network接口上配置NAT，为DS-Lite host动态分配端口块，实现IPv4私网穿越IPv6网络访问IPv4公网。 | 已归档 | [projects/295](projects/295/) |
| 296 | VRRP、Track与Echo报文方式的BFD会话联动配置举例（Backup监视Master） | 当Switch A正常工作时，Host A发送给Host B的报文通过Switch A转发；Master出现故障时，Backup若只依赖于VRRP通告报文的超时时间来判断是否应该抢占，切换时间一般在3秒～4秒之间，无法达到秒级以下的切换速度；如果Backup通过Echo报文方式的BFD会话检测Master的运行状态，则能够在毫秒级的时间内发现Master的故障，立即抢占成为Master，加快切换速度。 | 已归档 | [projects/296](projects/296/) |
| 297 | VRRP、Track与NQA联动配置举例（Master监视上行链路） | 当Switch A正常工作时，Host A发送给Host B的报文通过Switch A转发；当通过NQA监测到Switch A上行链路不通时，Host A发送给Host B的报文通过Switch B转发。Switch A和Switch B属于虚拟IP地址为10.1.1.10的备份组。 | 已归档 | [projects/297](projects/297/) |
| 298 | VRRP、Track与控制报文方式的BFD会话联动配置举例（Backup监视Master） | 当Switch A正常工作时，Host A发送给Host B的报文通过Switch A转发；Master出现故障时，Backup若只依赖于VRRP通告报文的超时时间来判断是否应该抢占，切换时间一般在3秒～4秒之间，无法达到秒级以下的切换速度；如果Backup通过控制报文方式的BFD会话检测Master的运行状态，则能够在毫秒级的时间内发现Master的故障，立即抢占成为Master，加快切换速度。 | 已归档 | [projects/298](projects/298/) |
| 299 | IPsec_手动配置SPI |    RTA和RTB跨越INTERNET建立ipsec隧道，隧道采用手工方式建立。 | 已归档 | [projects/299](projects/299/) |
| 300 | IKE主模式及预共享秘钥认证配置举例 | 在Device A和Device B之间建立一个IPsec隧道，对Host A所在的子网（10.1.1.0/24）与Host B所在的子网（10.1.2.0/24）之间的数据流进行安全保护。 | 已归档 | [projects/300](projects/300/) |
| 301 | IPV4 VRRP单备份组配置举例 |  | 已归档 | [projects/301](projects/301/) |
| 304 | VRRP、Track与BFD联动配置举例（Backup监视Master） |  | 已归档 | [projects/304](projects/304/) |
| 305 | VRRP、Track与BFD联动配置举例（监测上行链路） |  | 已归档 | [projects/305](projects/305/) |
| 312 | IPv6 VRRP单备份组配置举例 |    Router A和Router B属于虚拟IPv6地址为1::10/64和FE80::10的备份组1；   Host A需要访问Internet上的Host B；Host A通过路由器发送的RA消息学习到缺省网关地址为1::10/64； 当Router A正常工作时，Host A发送给Host B的报文通过Router A转发；当Router A出现故障时，Host A发送给Host B的报文通过Router B转发。 | 已归档 | [projects/312](projects/312/) |
| 313 | 静态路由track与BFD联动配置举例 | Router A、Router B、Router C和Router D连接了20.1.1.0/24和30.1.1.0/24两个网段，在路由器上配置静态路由以实现两个网段的互通，并配置路由备份以提高网络的可靠性。·下一跳为Router B的静态路由优先级高，作为主路由。该路由可达时，Router A通过Router B将报文转发到30.1.1.0/24网段。·下一跳为Router C的静态路作为备份路由。·在Router A上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Router A通过Router C将报文转发到30.1.1.0/24网段。同样地，Router D作为30.1.1.0/24网段内主机的缺省网关，在Router D上存在两条到达20.1.1.0/24网段的静态路由，下一跳分别为Router B和Router C。这两条静态路由形成备份，其中：·  下一跳为Router B的静态路由优先级高，作为主路由。该路由可达时，Router D通过Router B将报文转发到20.1.1.0/24网段。·  下一跳为Router C的静态路作为备份路由。·在Router D上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Router D通过Router C将报文转发到20.1.1.0/24网段。其中，在Router A和Router B上配置环回口分别代表20.1.1.1/24和30.1.1.1/24的业务。RouterA上存在环回口1.1.1.1，Roouter B上存在环回口2.2.2.2，这两个环回口地址是用来建立BFD Control会话，为跨设备的多跳BFD会话。 | 已归档 | [projects/313](projects/313/) |
| 314 | 静态路由track与nqa联动配置举例 | Router A、Router B、Router C和Router D连接了20.1.1.0/24和30.1.1.0/24两个网段，在路由器上配置静态路由以实现两个网段的互通，并配置路由备份以提高网络的可靠性。·下一跳为Router B的静态路由优先级高，作为主路由。该路由可达时，Router A通过Router B将报文转发到30.1.1.0/24网段。·下一跳为Router C的静态路作为备份路由。·在Router A上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Router A通过Router C将报文转发到30.1.1.0/24网段。同样地，Router D作为30.1.1.0/24网段内主机的缺省网关，在Router D上存在两条到达20.1.1.0/24网段的静态路由，下一跳分别为Router B和Router C。这两条静态路由形成备份，其中：·  下一跳为Router B的静态路由优先级高，作为主路由。该路由可达时，Router D通过Router B将报文转发到20.1.1.0/24网段。·  下一跳为Router C的静态路作为备份路由。·在Router D上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Router D通过Router C将报文转发到20.1.1.0/24网段。其中，在Router A和Router B上配置环回口分别代表20.1.1.1/24和30.1.1.1/24的业务。 | 已归档 | [projects/314](projects/314/) |
| 323 | 访问防火墙本地安全策略配置实验 | 本实验用于指导基础用户学习FW安全策略应该如何去配置本实验没有NAT，网络连通性全靠路由打通组网如下：MSR2（G0/0:10.0.0.1）-------(G1/0/1:10.0.0.2)FW1(G0/2:1.1.1.1)-----（G0/0:1.1.1.2）MSR3其中FW1的G1/0/1属于trust安全域FW2的G1/0/2属于UNtrust安全域防火墙的报文转发是基于会话的，并且是有方向的 | 已归档 | [projects/323](projects/323/) |
| 324 | 安全策略不通问题debug排查实验 | 本实验用于指导基础用户如何排查过FW不通本实验没有NAT，网络连通性全靠路由打通组网如下：MSR2（G0/0:10.0.0.1）-------(G1/0/1:10.0.0.2)FW1(G0/2:1.1.1.1)-----（G0/0:1.1.1.2）MSR3其中FW1的G1/0/1属于trust安全域FW2的G1/0/2属于UNtrust安全域 | 已归档 | [projects/324](projects/324/) |
| 326 | NGFW IPsec野蛮模式IKEv2+NAT穿越实验 |  通过ikev2的方式建立ipsec隧道，其中ipsec为野蛮模式，MSR36-20_3为NAT设备，做SNAT转换源地址，F1060_1为分支设备，F1060_2为总部设备并使用模板方式。 | 已归档 | [projects/326](projects/326/) |
| 328 | NGFW OSPFv3安全策略配置实验 | 使用防火墙和路由器搭建OSPF V3的环境，确定防火墙上需要安全策略细化的配置。 | 已归档 | [projects/328](projects/328/) |
| 334 | MSTP典型配置举例 | 网络中所有设备都属于同一个MST域。Device A和Device B为汇聚层设备，Device C和Device D为接入层设备。通过配置MSTP，使不同VLAN的报文按照不同的MSTI转发。 | 已归档 | [projects/334](projects/334/) |
| 339 | 短静态ARP表项配置举例 | 网络管理员需要通过某种方法来防止恶意用户对Device B进行ARP攻击，增加Device B和Device A通信的安全性。如果Device A的IP地址和MAC地址是固定的，则可以通过在Device B上配置静态ARP表项的方法，防止恶意用户进行ARP攻击。 | 已归档 | [projects/339](projects/339/) |
| 340 | 静态路由、Track与NQA联动配置举例 | Switch A、Switch B、Switch C和Switch D连接了20.1.1.0/24和30.1.1.0/24两个网段，在交换机上配置静态路由以实现两个网段的互通，并配置路由备份。Switch A上存在两条到达30.1.1.0/24网段的静态路由，下一跳分别为Switch B和Switch C。这两条静态路由形成备份，其中：•下一跳为Switch B的静态路由优先级高，作为主路由。该路由可达时，Switch A通过Switch B将报文转发到30.1.1.0/24网段。•下一跳为Switch C的静态路作为备份路由。•在Switch A上通过静态路由、Track与NQA联动，实时判断主路由是否可达。当主路由不可达时，备份路由生效，Switch A通过Switch C将报文转发到30.1.1.0/24网段。 | 已归档 | [projects/340](projects/340/) |
| 341 | N比1 VLAN映射配置举例 | 网络中从DEVICEA过来的不同vlan的业务流需要在DEVICEB上进行转化为特定某一vlan送给DEVICEC。 | 已归档 | [projects/341](projects/341/) |
| 342 | LDP PW配置举例 | 用户网络多个站点之间通过静态PW实现互通，在PE 1和PE 2分别创建以太网服务实例10，匹配接口Twenty-FiveGigE1/0/1接收到的VLAN Tag为10的报文。 | 已归档 | [projects/342](projects/342/) |
| 344 | 分布式EVPN网关配置举例（IPv4网络） |  | 已归档 | [projects/344](projects/344/) |
| 603 | DRNI基本功能配置举例 | 用户对于业务的可靠性要求很高，如果Device C和接入设备（Device A和Device B）之间配置链路聚合只能保证链路级的可靠性，接入设备发生故障时则会导致业务中断。这时可以采用DRNI技术，正常工作时链路进行负载分担且任何一台设备故障对业务均没有影响，保证业务的高可靠性。 | 已归档 | [projects/603](projects/603/) |
| 1507 | 静态绑定地址配置举例 | 路由器Gateway做为DHCP Server，PC-1、PC-2获取的地址需要固定。这里采用静态绑定的方式对其分配地址。 | 已归档 | [projects/1507](projects/1507/) |
| 1510 | 单机aft静态模式实现互访 |  | 已归档 | [projects/1510](projects/1510/) |
| 1513 | ngfw单机aft动态和前缀转换实现外网访问内部服务器 |  | 已归档 | [projects/1513](projects/1513/) |
| 1514 | 防火墙单机aft映射ipv6服务器 |  | 已归档 | [projects/1514](projects/1514/) |
| 1521 | 动态分配地址配置举例 | DHCP服务器通过地址池保存IP地址和网络参数，从地址池中选择IP地址和网络参数分配给客户端。路由器RTA做为DHCP Server，终端动态获取IP。 | 已归档 | [projects/1521](projects/1521/) |
| 1522 | DHCP服务器的用户下线探测 | 在移动终端接入比较频繁的场景中，部分用户离开时可能没有正常发送DHCP下线报文，导致DHCP服务器占用了较多DHCP地址，只有等到租约老化才能释放。为了缓解该类问题，可以配置DHCP用户下线探测功能。DHCP服务器的用户下线探测功能以ARP表项老化功能为基础，当ARP表项老化时认为该表项对应的用户已下线。如果在接口上开启了DHCP服务器的用户下线探测功能，则当ARP表项老化时，系统会删除该表项对应用户的地址绑定信息。手工删除ARP表项，不会触发DHCP服务器删除对应用户的地址绑定信息。 | 已归档 | [projects/1522](projects/1522/) |
| 1523 | 开启DHCP Snooping配置举例 | SW通过以太网端口GigabitEthernet1/0/1连接到合法DHCP服务器，通过GigabitEthernet1/0/2、GigabitEthernet1/0/3连接到DHCP客户端。要求：与合法DHCP服务器相连的端口可以转发DHCP服务器的响应报文，而其他端口不转发DHCP服务器的响应报文；记录DHCP-REQUEST报文和信任端口收到的DHCP-ACK报文中DHCP客户端IP地址及MAC地址的绑定信息。 | 已归档 | [projects/1523](projects/1523/) |
| 1524 | DHCP Relay多Server配置示例 | 为了提高可靠性，可以在一个网络中设置多个DHCP服务器。DHCP中继上配置多个DHCP服务器后，DHCP中继会将客户端发来的DHCP报文转发给所有的服务器。 | 已归档 | [projects/1524](projects/1524/) |
| 1525 | VRRP场景下DHCP配置举例 | VRRP场景下，链路或网络问题可能导致网关主备切换。在该情况下，备设备如果没有配置DHCP可能会导致后续接入的终端不能获取地址上网，因此主备设备都需要配置DHCP池，开启DHCP服务。 | 已归档 | [projects/1525](projects/1525/) |
| 1526 | 用户类白名单功能配置 | Gateway作为DHCP服务器只为局域网中匹配硬件地址34c7-9acb-0305，硬件地址掩码为ffff-ffff-ffff的DHCP客户端动态分配网段为10.1.1.0/24的IP地址。 | 已归档 | [projects/1526](projects/1526/) |
| 1529 | DHCP中继基本组网配置举例 | DHCP客户端所在网段为192.168.1.0/24，DHCP服务器的IP地址为192.168.2.2/24；由于DHCP客户端和DHCP服务器不在同一网段，因此，需要在客户端所在网段设置DHCP中继设备，以便客户端可以从DHCP服务器申请到192.168.1.0/24网段的IP地址及相关配置信息；DHCP中继通过GigabitEthernet0/1接口连接到DHCP客户端所在的网络，GigabitEthernet0/1接口的IP地址为192.168.1.1/24，GigabitEthernet0/0接口的IP地址为192.168.2.1/24。 | 已归档 | [projects/1529](projects/1529/) |
| 1530 | DHCPv6中继基本组网典型配置 | DHCPv6客户端所在网络地址为1::/64，DHCPv6服务器的地址为2::2/64。客户端和服务器不在同一个链路范围，需要通过DHCPv6中继转发报文。DHCPv6 Relay同时作为1::/64网络的网关设备，通过RA消息中的M标志位和O标志位指定该网络中的主机通过DHCPv6获取IPv6地址和其他网络配置参数。 | 已归档 | [projects/1530](projects/1530/) |
| 1531 | DHCPv6无状态配置 | DHCPv6服务器可以为已经具有IPv6地址/前缀的客户端分配其他网络配置参数，该过程称为DHCPv6无状态配置。DHCPv6客户端通过地址无状态自动配置功能成功获取IPv6地址后，即DHCPv6客户端根据路由器发现/前缀发现所获取的信息自动配置IPv6地址后，如果接收到的RA（Router Advertisement，路由器通告）报文中M标志位（Managed address configuration flag，被管理地址配置标志位）取值为0、O标志位（Other stateful configuration flag，其他配置标志位）取值为1，则DHCPv6客户端会自动启动DHCPv6无状态配置功能，以获取除地址/前缀外的其他网络配置参数。 | 已归档 | [projects/1531](projects/1531/) |
| 1532 | DHCPv6有状态配置 | 为了便于集中管理IPv6地址，简化网络配置，DHCPv6服务器可以用来为DHCPv6客户端提供诸如IPv6地址、域名后缀、DNS服务器地址等网络配置参数。DHCPv6客户端根据服务器分配的参数来实现主机的配置。DHCPv6服务器为客户端分配的IPv6地址分为以下两类：临时IPv6地址：在短期内经常变化且不用续约的地址；非临时IPv6地址：正常使用，可以进行续约的地址。 | 已归档 | [projects/1532](projects/1532/) |
| 1533 | Gre over Gre配置 | 总部与分支之间可以互访；分支之间不访问。PE-1、PE-2之间访问通过GRE隧道；PE-1、PE-3之间访问通过GRE over GRE隧道（不仅在公网实现数据封装，在私网也实现数据封装），即PE-1访问PE-3时，PE-1到PE-2之间的流量是双层GRE。 | 已归档 | [projects/1533](projects/1533/) |
| 1536 | RIP基本功能配置举例 | 在Router A和Router B的所有接口上使能RIP，以RIP进行路由学习。 | 已归档 | [projects/1536](projects/1536/) |
| 1537 | RIPng IPsec安全框架配置 | Router A、Router B和Router C相连并通过RIPng来学习网络中的IPv6路由信息。要求配置IPsec安全框架对Router A、Router B和Router C之间的RIPng报文进行有效性检查和验证。 | 已归档 | [projects/1537](projects/1537/) |
| 1538 | RIPng基本功能配置 | Router A、Router B和Router C相连并通过RIPng来学习网络中的IPv6路由信息。在Router B上对接收的路由信息进行过滤，仅接收除2::/64之外的路由信息。在Router B上对发布的路由信息进行过滤，仅发布4::/64路由信息。 | 已归档 | [projects/1538](projects/1538/) |
| 1539 | RIPng快速重路由配置 | Router A、Router B和Router C通过RIPng协议实现网络互连。要求当Router A和Router B之间的链路出现单通故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/1539](projects/1539/) |
| 1540 | UDP-jitter测试配置 | 使用NQA的UDP-jitter测试功能，测试本端（Device A）和指定目的端（Device B）的端口9000之间传送报文的抖动时间。 | 已归档 | [projects/1540](projects/1540/) |
| 1541 | EIGRP基本功能配置 | Router A和Router B之间通过EIGRP交互路由信息，实现网络互连。 | 已归档 | [projects/1541](projects/1541/) |
| 1542 | EIGRP接口开销值配置 | Router A、Router B、Router C、Router D和Router E使用EIGRP进行网络互连。Router A有两条链路可以到达Router D，其中，通过Router B到达Router D的链路与通过Router C到达Router D的链路有相同的带宽值1000000kbps和延时值100微秒。在Router A的GigabitEthernet0/0上配置接口的EIGRP度量值，使得Router A优选从Router C学到的1.1.5.0/24网段的路由。 | 已归档 | [projects/1542](projects/1542/) |
| 1543 | EIGRP聚合路由配置 | Router A、Router B运行OSPF，Router D运行EIGRP，Router C同时运行OSPF和EIGRP。在Router C上配置EIGRP进程引入OSPF路由，使Router D有到达10.1.1.0/24、10.2.1.0/24、10.5.1.0/24和10.6.1.0/24网段的路由。为了减小Router D的路由表规模，在Router C上配置路由聚合，只发布聚合后的路由10.0.0.0/8。 | 已归档 | [projects/1543](projects/1543/) |
| 1544 | EIGRP引入外部路由配置 | Router B上运行两个EIGRP进程：EIGRP 10和EIGRP 20。Router B通过EIGRP 10和Router A交换路由信息，通过EIGRP 20和Router C交换路由信息。在Router B上配置EIGRP进程20引入直连路由和EIGRP进程10的路由，使得Router C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Router A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。 | 已归档 | [projects/1544](projects/1544/) |
| 1545 | BGP Fake AS | 进行系统移植时，例如，Router A原来位于AS 2，现在将它移植到AS 3里，网络管理员需要在Router A的所有EBGP对等体上修改Router A的AS号。通过在Router A上为EBGP对等体/对等体组配置一个虚拟的本地自治系统号2，可以将本地真实的AS号3隐藏起来。在EBGP对等体看来Router A始终位于AS 2，不需要改变EBGP对等体上的配置。注意：peer fake-as命令只适用于EBGP对等体和对等体组。 | 已归档 | [projects/1545](projects/1545/) |
| 1546 | BGP Public AS Only | 私有AS号是内部使用的AS号，范围为64512～65535（旧规范）。私有AS号主要用于测试网络，一般情况下不需要在公共网络中传播。对公网EBGP邻居传递时，可以通过public-as-only命令去掉私有AS号。peer public-as-only命令用来配置向指定EBGP对等体/对等体组发送BGP更新消息时只携带公有AS号，不携带私有AS号。 | 已归档 | [projects/1546](projects/1546/) |
| 1547 | SNMP | SNMP（Simple Network Management Protocol，简单网络管理协议）广泛用于网络设备的远程管理和操作。SNMP允许管理员通过NMS对网络上不同厂商、不同物理特性、采用不同互联技术的设备进行管理，包括状态监控、数据采集和故障处理。NMS与Agent相连，NMS通过SNMPv2c对Agent进行监控管理。 | 已归档 | [projects/1547](projects/1547/) |
| 1548 | IPv6 NetStream普通流的统计信息输出配置举例 | 在RTB上启动IPv6 NetStream功能。要求在GigabitEthernet0/1上配置IPv6 NetStream，对接收的报文进行入方向和出方向统计，并将IPv6 NetStream普通流的统计信息输出到IPv6 NetStream服务器。IPv6 NetStream服务器的IP地址为1::1/64，UDP端口号为5000。 | 已归档 | [projects/1548](projects/1548/) |
| 1549 | NetStream普通流的统计信息输出配置 | 在RTA上启动NetStream功能。要求在GigabitEthernet0/0上配置NetStream的入方向与出方向的统计功能，并将NetStream普通流的统计信息输出到NetStream服务器。NetStream服务器的IP地址为192.168.56.1/24，UDP端口号为5000。 | 已归档 | [projects/1549](projects/1549/) |
| 1550 | 配置MPLS L3VPN采用GRE隧道 | CE 1和CE 2属于VPN 1。在运营商骨干网上，PE设备具备MPLS能力，P设备只提供纯IP功能，不具备MPLS能力。在骨干网上使用GRE隧道封装并转发VPN报文，实现MPLS L3VPN。在PE上配置隧道策略，指定VPN流量使用的隧道类型为GRE。 | 已归档 | [projects/1550](projects/1550/) |
| 1551 | 配置OSPF伪连接 | CE 1和CE 2都属于VPN 1，它们分别接入PE 1和PE 2；CE 1和CE 2在同一个OSPF区域中；CE 1与CE 2之间的VPN流量通过MPLS骨干网转发，不使用OSPF的区域内路由。 | 已归档 | [projects/1551](projects/1551/) |
| 1571 | 利用LDP动态建立LSP配置 | Router A、Router B和Router C均支持MPLS。在Router A和Router C之间使用LDP动态建立LSP，使11.1.1.0/24和21.1.1.0/24这两个网段中互访的报文能够通过MPLS进行传输。Router A、Router B和Router C上只允许目的地址为1.1.1.9/32、2.2.2.9/32、3.3.3.9/32、11.1.1.0/24和21.1.1.0/24的路由表项触发LDP建立LSP，其他路由表项不能触发LDP建立LSP，以避免建立的LSP数量过多，影响设备性能。 | 已归档 | [projects/1571](projects/1571/) |
| 1572 | 静态LSP通用配置 | Router A、Router B和Router C均支持MPLS。在Router A和Router C之间建立静态LSP，使11.1.1.0/24和21.1.1.0/24这两个网段中互访的报文能够通过MPLS进行传输。 | 已归档 | [projects/1572](projects/1572/) |
| 1577 | VRRP负载均衡模式配置举例 | Router A、Router B和Router C属于虚拟IP地址为10.1.1.1/24的备份组1；10.1.1.0/24网段内主机的缺省网关为10.1.1.1/24，利用VRRP备份组保证某台网关设备（Router A、Router B或Router C）出现故障时，局域网内的主机仍然可以通过网关访问外部网络；备份组1工作在负载均衡模式，通过一个备份组实现负载分担，充分利用网关资源；在Router A、Router B和Router C上分别配置虚拟转发器通过Track项监视上行接口GigabitEthernet0/0的状态。当上行接口出现故障时，降低Router A、Router B或Router C上虚拟转发器的权重，以便其它设备接管它的转发任务。 | 已归档 | [projects/1577](projects/1577/) |
| 1582 | IP流量统计 | 对1.1.1.1到3.3.3.3的ICMP流量进行统计。判断流量收发情况，在丢包的情况下辅助判断丢包位置。 | 已归档 | [projects/1582](projects/1582/) |
| 1583 | nat66untrust-trust |  | 已归档 | [projects/1583](projects/1583/) |
| 1584 | nat66trust-untrust |  | 已归档 | [projects/1584](projects/1584/) |
| 1585 | VXLAN over GRE | 中间网络只放通GRE，对于原始VLXAN可以采用VXLAN over GRE的配置。 | 已归档 | [projects/1585](projects/1585/) |
| 1586 | QoS流量过滤 | 流量过滤可以使用包过滤或者QoS过滤，这里演示使用QoS过滤的情况。在RTB上配置QoS过滤，抑制RTA 1.1.1.1访问RTC 2.2.2.2的ICMP流量。 | 已归档 | [projects/1586](projects/1586/) |
| 1590 | 配置IPv6 NTP对等体模式 | 网络中存在时间服务器Device A。为了通过IPv6 NTP实现Device B与Device A进行时间同步，要求：在Device A上设置本地时钟作为参考时钟，层数为2；配置Device A工作在对等体模式，指定Device B为被动对等体，即Device A为主动对等体，Device B为被动对等体。 | 已归档 | [projects/1590](projects/1590/) |
| 1591 | 配置NTP对等体模式 | 网络中存在时间服务器Device A。为了通过NTP实现Device B与Device A进行时间同步，要求：在Device A上设置本地时钟作为参考时钟，层数为2；配置Device A工作在对等体模式，指定Device B为被动对等体，即Device A为主动对等体，Device B为被动对等体。 | 已归档 | [projects/1591](projects/1591/) |
| 1592 | 配置NTP广播模式 | 为了实现Router C作为同一网段中多个设备的时间服务器，同时同步多个设备的时间，要求：在Router C上设置本地时钟作为参考时钟，层数为2；Router C工作在广播服务器模式，从接口GigabitEthernet1/0/1向外广播发送NTP报文；Router A和Router B工作在广播客户端模式，分别从各自的接口GigabitEthernet1/0/1监听NTP广播报文。 | 已归档 | [projects/1592](projects/1592/) |
| 1593 | 配置NTP组播模式 | 为了实现Router C作为不同网段中多个设备的时间服务器，同时同步多个设备的时间，要求：在Router C上设置本地时钟作为参考时钟，层数为2；Router C工作在组播服务器模式，从接口GigabitEthernet0/0向外组播发送NTP报文；Router A和Router D工作在组播客户端模式，分别从各自的接口GigabitEthernet0/0监听NTP组播报文。 | 已归档 | [projects/1593](projects/1593/) |
| 1598 | SNTP基本组网配置举例 | Device B对时间精度要求不高。为了实现Device B与Device A的时间同步，要求：在Device A上设置本地时钟作为参考时钟，层数为2；Device B工作在SNTP客户端模式，指定Device A为NTP服务器。Device B要求对NTP服务器进行验证，以保证时间同步的安全性。 | 已归档 | [projects/1598](projects/1598/) |
| 1599 | IPv4网络访问IPv6 Internet中的服务器配置 | Internet已经升级到了IPv6，但是某公司内部网络仍然是IPv4网络。而该公司内部网络的10.1.1.0/24网段的用户仍需要访问IPv6 Internet中的服务器，其他用户不能访问。为满足上述要求，本例中使用如下方式实现：使用IPv4到IPv6源地址动态地址转换策略，将IPv4报文的源地址转换为IPv6地址。通过IPv6到IPv4的源地址静态转换策略为IPv6 Internet上服务器的IPv6地址指定一个对应的IPv4地址，Router收到发往该IPv4地址的报文时将其转换为对应的IPv6地址。 | 已归档 | [projects/1599](projects/1599/) |
| 1601 | IPv6 Internet访问IPv4网络配置 | Internet已经升级到了IPv6，但是某公司内部网络仍然是IPv4网络。而该公司仍希望为IPv6 Internet内的用户提供FTP服务。该公司访问IPv6 Internet使用的IPv6地址为2012::1。为满足上述要求，实现方式如下：通过IPv4到IPv6源地址静态转换策略，为IPv4网络中的FTP服务器地址指定一个对应的IPv6地址，IPv6 Internet中的主机通过访问该IPv6地址可以访问IPv4网络中的FTP服务器。Router收到发往该IPv6地址的报文时将其目的地址转换为对应的IPv4地址。通过IPv6到IPv4源地址动态转换策略，将IPv6 Internet发送过来的IPv6报文源地址转换为IPv4地址30.1.1.1和30.1.1.2。 | 已归档 | [projects/1601](projects/1601/) |
| 1606 | 防火墙普通带宽限速 |  | 已归档 | [projects/1606](projects/1606/) |
| 1607 | ngfw普通主模式ipsec互通 |  | 已归档 | [projects/1607](projects/1607/) |
| 1610 | IKEv2预共享密钥认证配置举例 | 在Device A和Device B之间建立IPsec隧道，对Host A所在的子网（10.1.1.0/24）与Host B所在的子网（10.1.2.0/24）之间的数据流进行安全保护。Device A和Device B之间采用IKEv2协商方式建立IPsec SA。使用缺省的IKEv2提议。使用缺省的IKEv2安全策略。 | 已归档 | [projects/1610](projects/1610/) |
| 1611 | IKE野蛮模式及NAT穿越配置 | Device A在NAT安全网关内网侧，所连接的内网侧用户进过NAT设备后访问外网。要求在Device A和Device B之间建立一个IPsec隧道，对Host A所在的子网（10.1.1.0/24）与Host B所在的子网（10.1.2.0/24）之间的数据流进行安全保护。具体需要求如下：协商双方使用缺省的IKE提议。协商模式为野蛮模式协商。第一阶段协商的认证方法为预共享密钥认证。 | 已归档 | [projects/1611](projects/1611/) |
| 1612 | OSPF database-filter配置 | 当两台路由器之间存在多条链路时，根据过滤策略，通过命令ospf filter-lsa-out配置本地路由器在某些链路上对LSA的过滤，减少不必要的重传，节省带宽资源。 | 已归档 | [projects/1612](projects/1612/) |
| 1613 | OSPF stub-router | Stub路由器用来控制流量，它告知其他OSPF路由器不要使用这个Stub路由器来转发数据，但可以拥有一个到Stub路由器的路由。通过将当前路由器配置为Stub路由器，在该路由器发布的Router-LSA中，当链路类型取值为3表示连接到Stub网络时，链路度量值不变；当链路类型为1、2、4分别表示通过P2P链路与另一路由器相连、连接到传送网络、虚连接时，链路度量值将设置为最大值65535。这样其邻居计算出这条路由的开销就会很大，如果邻居上有到这个目的地址开销更小的路由，则数据不会通过这个Stub路由器转发。 | 已归档 | [projects/1613](projects/1613/) |
| 1628 | 防火墙配置父子通道限速 |  | 已归档 | [projects/1628](projects/1628/) |
| 1629 | 防火墙每ip限速 |  | 已归档 | [projects/1629](projects/1629/) |
| 1630 | VPDN 业务配置 | VPDN（Virtual Private Dial Network，虚拟专有拨号网络）业务是在宽带互联网基础上开放的基于拨号方式的虚拟专有网络业务，利用L2TP或GRE技术为物联网客户构建与公众互联网隔离的虚拟专用网络，满足客户的物联网无线终端访问客户内部网络的需求。目前大部分VPDN业务都采用L2TP技术实现。在运营商网络中，VPDN用户通过拨号的方式接入，由AAA服务器根据账号给BRAS下发LNS IP等参数，BRAS作为LAC和LNS端建立L2TP隧道，实现终端用户访问本企业/封闭站点的虚拟专用网络。PPP用户通过LAC接入LNS，在LAC和LNS之间建立L2TP隧道，以便用户通过该L2TP隧道访问公司总部。 | 已归档 | [projects/1630](projects/1630/) |
| 1631 | BGP LS配置举例 | 所有路由器运行BGP协议，Router A与Router B建立IBGP连接，Router B分别与Router C和Router D建立IBGP连接。Router B作为路由反射器，Router A为Router B的客户机。Router A能够通过Router B学到Router C和Router D发布的LS信息。 | 已归档 | [projects/1631](projects/1631/) |
| 1632 | BGP MD5认证 | 通过为BGP对等体配置BGP的MD5认证，可以在以下两方面提高BGP的安全性：·为BGP建立TCP连接时进行MD5认证，只有两台路由器配置的密钥相同时，才能建立TCP连接，从而避免与非法的BGP路由器建立TCP连接。·传递BGP报文时，对封装BGP报文的TCP报文段进行MD5运算，从而保证BGP报文不会被篡改。 | 已归档 | [projects/1632](projects/1632/) |
| 1635 | IPv6 BGP 通过IPsec保护报文配置 | Router A、Router B和Router C三台路由器之间运行IPv6 BGP交互路由信息。Router A和Router B之间建立IBGP连接，Router B和Router C之间建立EBGP连接。为了提高安全性，配置通过IPsec对IPv6 BGP报文进行保护。 | 已归档 | [projects/1635](projects/1635/) |
| 1636 | IPv6 BGP与BFD联动配置 | 在AS 200内使用OSPFv3作为IGP协议，实现AS内的互通。Router A与Router C之间建立两条IBGP连接。当Router A与Router C之间的两条路径均连通时，Router C与1200::0/64之间的报文使用Router A<－>Router B<－>Router C这条路径转发；当Router A<－>Router B<－>Router C这条路径发生故障时，BFD能够快速检测并通告IPv6 BGP协议，使得Router A<－>Router D<－>Router C这条路径能够迅速生效。 | 已归档 | [projects/1636](projects/1636/) |
| 1642 | RIP引入外部路由配置举例 | Router B上运行两个RIP进程：RIP 100和RIP 200。Router B通过RIP 100和Router A交换路由信息，通过RIP 200和Router C交换路由信息。在Router B上配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由，使得Router C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Router A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。 | 已归档 | [projects/1642](projects/1642/) |
| 1643 | RIP快速重路由配置举例 | Router B上运行两个RIP进程：RIP 100和RIP 200。Router B通过RIP 100和Router A交换路由信息，通过RIP 200和Router C交换路由信息。在Router B上配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由，使得Router C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Router A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。 | 已归档 | [projects/1643](projects/1643/) |
| 1644 | RIP silent-interface | RIP中，部分接口只作为末梢发布路由即可，这时可以配置静默接口。silent-interface命令用来配置接口工作在抑制状态，即接口只接收RIP报文而不发送RIP报文。 | 已归档 | [projects/1644](projects/1644/) |
| 1646 | IPv6 IS-IS与BFD联动配置 | Router A、Router B通过二层交换机互连，并且在双方接口上使能BFD应用，之间运行IPv6 IS-IS，网络层相互可达。当Router B和二层交换机之间的链路发生故障后，BFD能够快速检测并通告IPv6 IS-IS协议。 | 已归档 | [projects/1646](projects/1646/) |
| 1647 | OSPFv3快速重路由配置 | Router A、Router B和Router C属于同一OSPFv3区域，通过OSPFv3协议实现网络互连。要求当Router A和Router B之间的链路出现故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/1647](projects/1647/) |
| 1648 | OSPFv3与BFD联动配置 | Router A、Router B和Router C上运行OSPFv3，网络层相互可达。当Router A和Router B通过L2 Switch通信的链路出现故障时BFD能够快速感知通告OSPFv3协议，并且切换到Router C进行通信。 | 已归档 | [projects/1648](projects/1648/) |
| 1649 | 基于报文协议类型的IPv6本地策略路由配置 | Router A分别与Router B和Router C直连（保证Router B和Router C之间路由完全不可达）。通过策略路由控制Router A产生的报文：指定所有TCP报文的下一跳为1::2；其它IPv6报文仍然按照查找路由表的方式进行转发。 | 已归档 | [projects/1649](projects/1649/) |
| 1650 | 基于报文协议类型的IPv6转发策略路由配置 | Router A分别与Router B和Router C直连（保证Router B和Router C之间路由完全不可达）。通过策略路由控制从Router A的以太网接口GigabitEthernet0/2接收的报文：指定所有TCP报文的下一跳为1::2；其它IPv6报文仍然按照查找路由表的方式进行转发。 | 已归档 | [projects/1650](projects/1650/) |
| 1651 | GRE Over IPSec配置 | RTA与RTC之间建立GRE隧道，同时需要对GRE数据流进行加密，这里采用GRE Over IPSec的配置。 | 已归档 | [projects/1651](projects/1651/) |
| 1652 | GRE运行动态路由 | RTA与RTC之间建立GRE隧道，后续需要在RTA，RTC上部署业务，路由希望通过OSPF或ISIS宣告出去。 | 已归档 | [projects/1652](projects/1652/) |
| 1654 | 负载分担内部服务器配置 | 某公司内部拥有3台FTP服务器对外提供FTP服务。需要实现如下功能：使用IP地址为202.38.1.1作为公司对外提供服务的IP地址。两台FTP服务器可以同时对外提供服务，并进行负载分担。 | 已归档 | [projects/1654](projects/1654/) |
| 1655 | 地址重叠的两个VPN之间互访配置 | 某公司两个部门由于需要业务隔而分属不同的VPN实例，且两个部门内部使用了相同的子网地址空间。现在要求这两个部门的主机Host A 和Host B之间能够通过NAT地址互相访问。 | 已归档 | [projects/1655](projects/1655/) |
| 1656 | 内网用户通过NAT地址访问外网配置举例（地址不重叠） | 某公司内网使用的IP地址为192.168.0.0/16。该公司拥有202.38.1.2和202.38.1.3两个外网IP地址。需要实现，内部网络中192.168.1.0/24网段的用户可以访问Internet，其它网段的用户不能访问Internet。使用的外网地址为202.38.1.2和202.38.1.3。 | 已归档 | [projects/1656](projects/1656/) |
| 1657 | 内网用户通过NAT地址访问外网配置举例（静态地址转换） | 内部网络用户10.110.10.8/24使用外网地址202.38.1.100访问Internet。 | 已归档 | [projects/1657](projects/1657/) |
| 1658 | PPPoE使用Radius认证（IP POOL分配地址） | Host PPPoE拨号接入，BRAS分配IP地址，认证由AAA实现。 | 已归档 | [projects/1658](projects/1658/) |
| 1678 | 串联模式防火墙做slb-dnat |  | 已归档 | [projects/1678](projects/1678/) |
| 1679 | 防火墙旁路模式slb-dnat |  | 已归档 | [projects/1679](projects/1679/) |
| 1685 | 内网口外网口不同VPN NAT配置 | 设备内网口与外网口处于不同的VPN实例，通过配置PBR实现跨不同VPN做NAT上网。 | 已归档 | [projects/1685](projects/1685/) |
| 1735 | VLAN间路由-单臂路由 | 在路由器以太网接口上进行子接口的划分，与交换机的Trunk链路对接，从而实现VLAN间路由。 | 已归档 | [projects/1735](projects/1735/) |
| 1737 | 通过路由器实现VLAN间路由 | VLAN内部节点的通信是二层通信，而不同的VLAN之间的节点通信则是三层通信，可以借助路由器实现VLAN间路由。 | 已归档 | [projects/1737](projects/1737/) |
| 1738 | Vlan-interface实现VLAN间路由 | 设备上配置vlan-interface接口，实现VLAN间通信。注：真机需要添加二层接口卡或者使用原生二层接口。 | 已归档 | [projects/1738](projects/1738/) |
| 1739 | 接口上开启uRPF配置举例 | 客户路由器Router A与ISP路由器Router B直连，在Router B的接口GigabitEthernet0/0上配置严格型uRPF检查，源地址能够匹配ACL 2000的报文在任何情况下都能通过检查。在Router A的接口GigabitEthernet0/0上配置严格型uRPF检查，同时允许匹配缺省路由。 | 已归档 | [projects/1739](projects/1739/) |
| 1740 | 防火墙做lb串联模式snat-dnat |  | 已归档 | [projects/1740](projects/1740/) |
| 1741 | 旁路防火墙做负载均衡snat-dnat |  | 已归档 | [projects/1741](projects/1741/) |
| 1769 | IPV6静态路由配置 |  | 已归档 | [projects/1769](projects/1769/) |
| 1771 | SNMP剔除某一OID节点配置举例 |  | 已归档 | [projects/1771](projects/1771/) |
| 1775 | Telnet用户的本地用户角色授权配置举例 | Telnet用户主机与Switch相连，需要实现Switch对Telnet用户进行本地认证并授权用户角色。Telnet用户的登录用户名为user1@bbb，认证通过后被授权的用户角色为role1；role1具有如下用户权限：允许用户执行所有特性中读类型的命令；允许用户执行创建VLAN以及进入VLAN视图后的相关命令，并只具有操作VLAN 10～VLAN 20的权限。 | 已归档 | [projects/1775](projects/1775/) |
| 1776 | S-MLAG配置举例 | Device A通过二层以太网接口GigE1/0/1～GigE1/0/3分别与Device B、Device C、Device D的二层以太网接口GigE1/0/1相互连接；Device B、Device C、Device D为独立运行的设备，由于用户对于业务的可靠性要求很高，要求Device A和Device B、Device C、Device D之间配置链路聚合。为了实现Device B、Device C、Device D之间跨设备聚合，这时用户可以配置S-MLAG功能，保证正常工作时链路进行负载分担且任何一台设备故障对业务均没有影响，提高可靠性。 | 已归档 | [projects/1776](projects/1776/) |
| 1778 | DHCP 动态分配地址配置举例 | 作为DHCP服务器的Switch A为网段10.1.1.0/24中的客户端动态分配IP地址，该地址池网段分为两个子网网段：10.1.1.0/25和10.1.1.128/25;Switch A的两个VLAN接口，VLAN接口10和VLAN接口20的地址分别为10.1.1.1/25和10.1.1.129/25；10.1.1.0/25网段内的地址租用期限为10天12小时，域名后缀为aabbcc.com，DNS服务器地址为10.1.1.2/25，WINS服务器地址为10.1.1.4/25，网关的地址为10.1.1.126/25；10.1.1.128/25网段内的地址租用期限为5天，域名后缀为aabbcc.com，DNS服务器地址为10.1.1.2/25，无WINS服务器地址，网关的地址为10.1.1.254/25。 | 已归档 | [projects/1778](projects/1778/) |
| 1781 | 全局开启DHCP Snooping配置举例 | Switch 1通过以太网端口GigE1/0/1连接到合法DHCP服务器，通过以太网端口GigE1/0/2连接到非法DHCP服务器，通过GigE1/0/3连接到DHCP客户端。要求：法DHCP服务器相连的端口可以转发DHCP服务器的响应报文，而其他端口不转发DHCP服务器的响应报文。记录DHCP-REQUEST报文和信任端口收到的DHCP-ACK报文中DHCP客户端IP地址及MAC地址的绑定信息。 | 已归档 | [projects/1781](projects/1781/) |
| 1782 | IPv6基本组网配置举例 | Host、Switch 1和Switch 2之间通过以太网端口相连，将以太网端口分别加入相应的VLAN里，在VLAN接口上配置IPv6地址，验证它们之间的互通性。·     Switch 2有可以到Host的路由。·     在Host上配置接口地址为自动获取，根据IPv6邻居发现协议自动配置IPv6地址，有可以到Switch B的路由。 | 已归档 | [projects/1782](projects/1782/) |
| 1783 | DHCPv6中继基本组网典型配置举例 | DHCPv6客户端所在网络地址为1::/64，DHCPv6服务器的地址为2::2/64。客户端和服务器不在同一个链路范围，需要通过DHCPv6中继转发报文。Switch A作为DHCPv6中继，为客户端和服务器转发报文。Switch A同时作为1::/64网络的网关设备，通过RA消息中的M标志位和O标志位指定该网络中的主机通过DHCPv6获取IPv6地址和其他网络配置参数。。 | 已归档 | [projects/1783](projects/1783/) |
| 1784 | DHCPv6 Snooping典型配置举例 | Switch2通过以太网端口GE1/0/1连接到合法DHCPv6服务器，通过以太网端口GE1/0/3连接到非法服务器，通过GE1/0/2连接到DHCPv6客户端。要求：与合法DHCPv6服务器相连的端口可以转发DHCPv6服务器的响应报文，而其他端口不转发DHCPv6服务器的响应报文。记录DHCPv6客户端IPv6地址及MAC地址的绑定关系。 | 已归档 | [projects/1784](projects/1784/) |
| 1789 | ARP测试配置举例 | 使用NQA的ARP测试功能，测试本端（Device A）发出的ARP请求报文到接收目的端Device B的ARP响应报文以及报文的往返时间。 | 已归档 | [projects/1789](projects/1789/) |
| 1791 | GRE结合VRRP部署 | GRE出口含两台设备，为了可靠性，可以使用VRRP结合GRE来部署。 | 已归档 | [projects/1791](projects/1791/) |
| 1792 | 串联模式做双向代理 |  | 已归档 | [projects/1792](projects/1792/) |
| 1793 | 防火墙做负载均衡三角传输 |  | 已归档 | [projects/1793](projects/1793/) |
| 1797 | DHCP中继基本组网配置举例-交换机 | ·     DHCP客户端所在网段为10.10.1.0/24，DHCP服务器的IP地址为10.1.1.1/24；·     由于DHCP客户端和DHCP服务器不在同一网段，因此，需要在客户端所在网段设置DHCP中继设备，以便客户端可以从DHCP服务器申请到10.10.1.0/24网段的IP地址及相关配置信息；·     Device A作为DHCP中继通过端口（属于VLAN10）连接到DHCP客户端所在的网络，交换机VLAN接口10的IP地址为10.10.1.1/24，VLAN接口20的IP地址为10.1.1.2/24。。 | 已归档 | [projects/1797](projects/1797/) |
| 1798 | 三层动态聚合配置举例-交换机 | Device A与Device B通过各自的三层以太网接口GigE1/0/1～GigE1/0/3相互连接；在Device A和Device B上分别配置三层动态链路聚合组，并为对应的三层聚合接口配置IP地址和子网掩码。 | 已归档 | [projects/1798](projects/1798/) |
| 1800 | 三层聚合负载分担配置举例-交换机 | Device A与Device B通过各自的三层以太网接口GigE1/0/1～GigE1/0/4相互连接；在Device A和Device B上分别配置两个三层静态链路聚合组，并为对应的三层聚合接口都配置IP地址和子网掩码；通过在聚合组1上按照源IP地址进行聚合负载分担、在聚合组2上按照目的IP地址进行聚合负载分担的方式，来实现数据流量在各成员端口间的负载分担。 | 已归档 | [projects/1800](projects/1800/) |
| 1801 | 动态路由中引入缺省路由配置举例 | 网络中SW1和SW2分别建立bgp和ospf，同时，设备SW1配置缺省路由并在两台设备的ospf和bgp中引入。 | 已归档 | [projects/1801](projects/1801/) |
| 1802 | VRRP+STP配置举例 | 网络中SW1和SW2分别作为下游设备网关，配置VRRP。为实现链路级冗余，SW3和SW4分别与SW1 SW2双上行互联。 | 已归档 | [projects/1802](projects/1802/) |
| 1803 | 1比1VLAN映射配置举例 |  | 已归档 | [projects/1803](projects/1803/) |
| 1804 | L2TP多域接入典型配置举例 | 不同地区的主机Host A和Host B上通过L2TP隧道传输数据。具体应用需求如下：LNS 上设置两个域，分别为属于不同区域的用户提供接入服务；不同域的用户获得不同网段的 IP 地址，实现与 LNS 互通。 | 已归档 | [projects/1804](projects/1804/) |
| 1805 | L2TP多实例配置举例 | 多个企业共用Router C作为LNS，不同的企业用户分别连接Router A和Router B与各自的总部site1 和site2 进行通讯。现要求：在Router C上配置L2TP多实例功能，使其能够为Router A和Router B同时提供L2TP接入服务，实现不同企业的用户能够远程访问企业内部网络。 | 已归档 | [projects/1805](projects/1805/) |
| 1806 | L2TP over IPsec 典型配置举例 | Host通过L2TP隧道访问LNS一侧的网络。具体应用需求如下：• LAC 与 LNS 自动建立 L2TP 隧道• LAC 与 LNS 之间采用 IKE 方式建立 IPsec 安全隧道来对 L2TP 流量进行加密。 | 已归档 | [projects/1806](projects/1806/) |
| 1812 | VRRP虚地址建立IPsec配置 | Router1、Router2、Router3都连接在一台交换机上，Router2和Router3组VRRP，虚地址为10.1.1.254，Router3作为VRRP master,Router2作为backup;Router1和VRRP虚地址之间建立基于IKE的IPSEC，实际应用中，Router2和Router3的内网口也建议使用VRRP，对内提供统一网关 | 已归档 | [projects/1812](projects/1812/) |
| 1817 | DHCP 静态分配地址配置举例 | Switch B作为DHCP客户端，从DHCP服务器Switch A获取静态绑定的IP地址、域名服务器、网关地址等信息。 Switch B上VLAN接口2的MAC地址为：6896-5b7f-0202。 | 已归档 | [projects/1817](projects/1817/) |
| 1819 | 防火墙旁路做ssl双向代理 |  | 已归档 | [projects/1819](projects/1819/) |
| 1820 | 防火墙串联http重定向 |  | 已归档 | [projects/1820](projects/1820/) |
| 1876 | IPSec Over Gre配置 | 两台VPN设备之间建立GRE隧道，两台设备下挂网段间流量走GRE，在GRE中对流量进行加密。 | 已归档 | [projects/1876](projects/1876/) |
| 1877 | 6PE配置 | 通过配置6PE实现利用MPLS技术跨越运营商的IPv4网络连接隔离的两个IPv6用户网络。其中：运营商网络内部采用OSPF作为IGP路由协议。PE 1和PE 2为运营商网络的边缘设备，PE 1和PE 2之间建立IPv4 IBGP连接。CE 1和CE 2为IPv6用户网络的边缘设备，用户网络通过该设备接入运营商网络。CE与PE之间配置IPv6静态路由，以指导IPv6报文的转发。 | 已归档 | [projects/1877](projects/1877/) |
| 1879 | 宽带业务配置 | Router A作为运营商的BRAS设备，为宽带用户提供接入服务。宽带用户Host A采用PPPoE方式接入，需要支持双栈，BRAS设备作为PPPoE Server通过DHCPv4协议为Host A分配IPv4地址，通过DHCPv6协议为Host A分配IPv6地址。 | 已归档 | [projects/1879](projects/1879/) |
| 1880 | BGP VPNV4路由反射器配置 | 所有路由器运行BGP协议，Router A、Router C都与Router B建立IBGP连接。Router B作为路由反射器，Router A和Router C为Router B的客户机。 | 已归档 | [projects/1880](projects/1880/) |
| 1913 | 防火墙旁路实现http重定向 |  | 已归档 | [projects/1913](projects/1913/) |
| 1942 | V7_NGFW_策略NAT之源地址转换 | 防火墙通过配置策略NAT，实现常见场景下的NAT源地址转换 | 已归档 | [projects/1942](projects/1942/) |
| 1952 | 防火墙做负载均衡实现v6访问v4 |  | 已归档 | [projects/1952](projects/1952/) |
| 1953 | 防火墙做负载均衡并且实现v6访问v4 |  | 已归档 | [projects/1953](projects/1953/) |
| 2021 | V7_NGFW_策略NAT之目的地址转换_NAT映射 | 防火墙通过配置策略NAT，实现常见场景下的NAT目的地址转换，或者端口映射 | 已归档 | [projects/2021](projects/2021/) |
| 2024 | V7_NGFW_策略NAT之内网使用公网地址访问内部服务器 | 防火墙通过配置策略NAT，实现内网使用公网地址访问内部服务器 | 已归档 | [projects/2024](projects/2024/) |
| 2124 | rbm-vrrp主备互通 |  | 已归档 | [projects/2124](projects/2124/) |
| 2125 | 防火墙做llb |  | 已归档 | [projects/2125](projects/2125/) |
| 2139 | V7_NGFW_基于IPv4地址的安全策略_黑名单 | 防火墙通过配置ipv4类型的安全策略规则，实现仅禁止特定ip/端口的流量，其他全部放行，类似黑名单的效果 | 已归档 | [projects/2139](projects/2139/) |
| 2140 | V7_NGFW_基于IPv4地址的安全策略_白名单 | 防火墙通过配置ipv4类型的安全策略规则，实现仅允许特定ip的流量，其他全部禁止，类似白名单的效果 | 已归档 | [projects/2140](projects/2140/) |
| 2149 | V7_NGFW_IPSEC_主模式_总部多分支 | 某企业总部和各分公司均有一台出口防火墙，要求各个分支和总部以及各个分支之间的通信都要经过ipsec隧道加密，且各个分支之间的通信要经过总部设备 | 已归档 | [projects/2149](projects/2149/) |
| 2150 | V7_NGFW_黑名单 | 通过在防火墙配置黑名单功能，实现封禁指定ip地址 | 已归档 | [projects/2150](projects/2150/) |
| 2154 | V7_NGFW_DHCPv4_DHCP服务器 | 防火墙作为网关，同时配置DHCPv4服务器，给内网的终端分配ip地址 | 已归档 | [projects/2154](projects/2154/) |
| 2187 | V7_NGFW_DHCPv4_DHCP中继 | 防火墙作为网关，同时配置DHCPv4中继，由指定DHCP服务器给内网的终端分配ip地址 | 已归档 | [projects/2187](projects/2187/) |
| 2194 | 防火墙做负载并实现v4访问v6 |  | 已归档 | [projects/2194](projects/2194/) |
| 2195 | 防火墙旁路lb四层情况下实现v4访问v6 |  | 已归档 | [projects/2195](projects/2195/) |
| 2221 | RIP发布聚合路由配置举例 |      Switch A、Switch B运行OSPF，Switch D运行RIP，Switch C同时运行OSPF和RIP。     在Switch C上配置RIP进程引入OSPF路由，使Switch D有到达10.1.1.0/24、10.2.1.0/24、10.5.1.0/24和10.6.1.0/24网段的路由。     为了减小Switch D的路由表规模，在Switch C上配置路由聚合，只发布聚合后的路由10.0.0.0/8。组网RIP发布聚合路由配置组网图 | 已归档 | [projects/2221](projects/2221/) |
| 2228 | RIP与BFD联动配置举例（指定目的地址的echo报文单跳检测） |      Switch A和Switch B互连，Switch A的接口Vlan-interface100和Switch B的接口Vlan-interface100都运行RIP进程1。Switch A的接口Vlan-interface100上使能了BFD检测功能，指定目的地址为Switch B的接口Vlan-interface100的地址。     Switch B与Switch C互连，它们的接口Vlan-interface200都运行RIP进程1。     Switch A和Switch C上配置静态路由，并都将静态路由引入RIP进程中，其中Switch A引入路由的cost值比Switch C引入的cost值小，这样，当Switch B上学习到Switch A和Switch C发送的路由后，会优选Switch A的路由，出接口为与Switch A连接的接口。     在Switch A和Switch B之间的链路发生单通故障（从Switch A到Switch B方向报文是通的，但是从Switch B到Switch A方向的链路不通）后，Switch A上BFD能够快速检测链路故障并通告RIP协议。Switch A上的RIP协议响应BFD会话down，删除从接口Vlan-interface100学习到的邻居和路由，并不再从该接口接收和发送RIP报文。Switch B上在学自Switch A的路由老化后，会优选Switch C发送的静态路由，出接口为与Switch C连接的接口。组网 RIP与BFD联动配置组网图（指定目的地址的echo报文单跳检测） | 已归档 | [projects/2228](projects/2228/) |
| 2229 | RIP与BFD联动配置举例（echo报文单跳检测） |      Switch A、Switch C通过二层交换机互连，它们的接口Vlan-interface100都运行RIP进程1。并且Switch A的接口Vlan-interface100上还使能了BFD检测功能。     Switch A通过Switch B与Switch C互连，Switch A的接口Vlan-interface200运行RIP进程2。Switch C的接口Vlan-interface300、Switch B的接口Vlan-interface200和Vlan-interface300上都运行RIP进程1。     Switch C上配置静态路由，并且将静态路由引入在RIP进程中，使Switch C有路由发送至Switch A。Switch A上学习到Switch C发送的静态路由，出接口为与二层交换机相连的接口。     在Switch C和二层交换机之间的链路发生故障后，BFD能够快速检测链路中断并通告RIP协议。RIP协议响应BFD会话down，删除与Switch C的邻居，并删除从Switch C学习的路由。Switch A上学习到Switch C上发送的静态路由，出接口为与Switch B相连的接口。组网 RIP与BFD联动配置组网图（echo报文单跳检测） | 已归档 | [projects/2229](projects/2229/) |
| 2230 | RIP与BFD联动配置举例（control报文双向检测） |      Switch A通过Switch B与Switch C互连。Switch A的接口Vlan-interface100和Switch C的接口Vlan-interface200上都运行RIP进程1。分别在Switch A和Switch C上配置到达对端的静态路由，并在Switch A的接口Vlan-interface100和Switch C的接口Vlan-interface200上并使能BFD检测功能。     Switch A通过Switch D与Switch C互连。Switch A的接口Vlan-interface300运行RIP进程2。Switch C的接口Vlan-interface400、Switch D的接口Vlan-interface300和Vlan-interface400上运行RIP进程1。     为使Switch A与Switch C互有路由发送，在Switch A与Switch C上将到达对端的静态路由引入RIP协议中。Switch A与Switch C之间建立BFD会话。Switch A上学习到Switch C发送的静态路由，出接口为与Switch B连接的接口。     在Switch B与Switch C之间的链路发生故障后，BFD能够快速检测链路中断并通告RIP协议。RIP协议响应BFD会话down，删除与Switch C的邻居，并删除从Switch C学习的路由。Switch A上学习到Switch C发送的静态路由，出接口为与Switch D连接的接口。组网 RIP与BFD联动配置组网图（control报文双向检测） | 已归档 | [projects/2230](projects/2230/) |
| 2252 | RIP快速重路由配置举例交换机 | Switch A、Switch B和Switch C通过RIPv2协议实现网络互连。要求当Switch A和Switch B之间的链路出现单通故障时，业务可以快速切换到链路B上。组网 RIP快速重路由配置组网图 | 已归档 | [projects/2252](projects/2252/) |
| 2253 | RIP引入外部路由配置举例交换机 |      Switch B上运行两个RIP进程：RIP 100和RIP 200。Switch B通过RIP 100和Switch A交换路由信息，通过RIP 200和Switch C交换路由信息。     在Switch B上配置RIP进程200引入外部路由，引入直连路由和RIP进程100的路由，使得Switch C能够学习到达10.2.1.0/24和11.1.1.0/24的路由，但Switch A不能学习到达12.3.1.0/24和16.4.1.0/24的路由。组网RIP引入外部路由配置组网图 | 已归档 | [projects/2253](projects/2253/) |
| 2261 | 防火墙做负载实现七层v4访问v6 |  | 已归档 | [projects/2261](projects/2261/) |
| 2262 | 防火墙做负载均衡实现7成v4访问v6旁路 |  | 已归档 | [projects/2262](projects/2262/) |
| 2268 | Private_VLAN_Promiscuous模式配置 |  | 已归档 | [projects/2268](projects/2268/) |
| 2274 | V7_NGFW_DHCPv6_DHCP服务器 | 防火墙作为网关，同时配置DHCPv6服务器，给内网的终端分配ipv6地址 | 已归档 | [projects/2274](projects/2274/) |
| 2312 | 静态路由与BFD联动直连配置举例交换机 |  | 已归档 | [projects/2312](projects/2312/) |
| 2314 | 静态路由与BFD联动（非直连）配置举例交换机 |      在Switch A上配置静态路由可以到达120.1.1.0/24网段，在Switch B上配置静态路由可以到达121.1.1.0/24网段，并都使能BFD检测功能。     在Switch C和Switch D上配置静态路由可以到达120.1.1.0/24网段和121.1.1.0/24网段。     Switch A存在到Switch B的接口Loopback1（2.2.2.9/32）的路由，出接口为Vlan-interface10；Switch B存在到Switch A的接口Loopback1（1.1.1.9/32）的路由，出接口为Vlan-interface12；Switch D存在到1.1.1.9/32的路由，出接口为Vlan-interface10，存在到2.2.2.9/32的路由，出接口为Vlan-interface12。     当Switch A和Switch B通过Switch D通信的链路出现故障时，BFD能够快速感知，并且切换到Switch C进行通信。  | 已归档 | [projects/2314](projects/2314/) |
| 2315 | GRE over IPv6隧道配置举例交换机 | 运行IPv4协议的两个子网Group 1和Group 2通过IPv6网络相连。通过在Switch A和Switch B之间建立GRE over IPv6隧道，实现两个子网穿越IPv6网络互联。 | 已归档 | [projects/2315](projects/2315/) |
| 2316 | GRE over IPv4隧道配置举例交换机 | Switch A和Switch B分别连接IPv4私有网络Group 1和Group 2。这两个私有网络都使用私网地址，且属于同一个VPN。通过在Switch A和Switch B之间建立GRE隧道，实现两个私有网络的互联。 | 已归档 | [projects/2316](projects/2316/) |
| 2319 | V7_NGFW_DHCPv6_DHCP中继 | 防火墙作为网关，同时配置DHCPv6中继，由指定DHCPv6服务器给内网的终端分配ipv6地址 | 已归档 | [projects/2319](projects/2319/) |
| 2322 | V7_NGFW_设备管理_SSH登陆 | 配置防火墙作为SSH server，运维人员可通过SSH方式远程登陆防火墙 | 已归档 | [projects/2322](projects/2322/) |
| 2323 | V7_NGFW_设备管理_Telnet登陆 | 配置防火墙作为telnet server，使运维人员可以使用telnet远程登陆防火墙。 | 已归档 | [projects/2323](projects/2323/) |
| 2329 | V7_SW_设备管理_SSH登录 | 配置交换机作为SSH server，运维人员可通过SSH方式远程登陆交换机 | 已归档 | [projects/2329](projects/2329/) |
| 2330 | V7_NGFW_路由协议_OSPF基础配置 | 防火墙和路由器之间建立OSPF邻居，通过动态路由学习使各子网之间互通。 | 已归档 | [projects/2330](projects/2330/) |
| 2331 | V7_SW_路由协议_OSPF基础配置 | 交换机和路由器之间建立OSPF邻居，通过动态路由学习使各子网之间互通。 | 已归档 | [projects/2331](projects/2331/) |
| 2361 | 二层静态聚合配置举例 | Device A与Device B通过各自的二层以太网接口GigabitEthernet1/0/1 - GigabitEthernet1/0/2互相连接。 Device A和Device B分别配置二层静态聚合链路组，并实现设备间VLAN互通。 | 已归档 | [projects/2361](projects/2361/) |
| 2362 | 二层动态聚合配置举例 | Device A与Device B通过各自的二层以太网接口GigabitEthernet1/0/1 - GigabitEthernet1/0/2互相连接。 Device A和Device B分别配置二层动态聚合链路组，并实现设备间VLAN互通。 | 已归档 | [projects/2362](projects/2362/) |
| 2365 | 二层聚合负载分担配置举例 | Device A与Device B通过各自的二层以太网接口GigabitEthernet1/0/1～GigabitEthernet1/0/4相互连接。 在Device A和Device B上分别配置两个二层静态链路聚合组，并使两端的VLAN 10通过二层聚合接口1互通、VLAN 20通过二层聚合接口2互通。 | 已归档 | [projects/2365](projects/2365/) |
| 2371 | route-replicate跨vpn实例路由互引配置案例 |  | 已归档 | [projects/2371](projects/2371/) |
| 2454 | hcl_ipsec |  | 已归档 | [projects/2454](projects/2454/) |
| 2455 | hcl_ietledwa |  | 已归档 | [projects/2455](projects/2455/) |
| 2457 | zhumoshi_ipsec_moban |  | 已归档 | [projects/2457](projects/2457/) |
| 2458 | 防火墙旁路部署结合track_NQA典型配置案例 |  | 已归档 | [projects/2458](projects/2458/) |
| 2468 | V7_交换机浮动静态路由 | 交换机通过配置浮动静态路由，实现路由主备备份 | 已归档 | [projects/2468](projects/2468/) |
| 2472 | 交换机RBAC配置案例 |  | 已归档 | [projects/2472](projects/2472/) |
| 2653 | V7_交换机_等价静态路由_ECMP | 交换机上行有双出口，交换机配置等价路由实现双出口的负载 | 已归档 | [projects/2653](projects/2653/) |
| 2732 | V7_交换机_OSPF路由聚合_ASBR | 为了减少LSDB的规模，配置OSPF路由聚合功能，由ABR/ASBR将具有相同前缀的路由信息聚合，只发布一条路由到其它区域 | 已归档 | [projects/2732](projects/2732/) |
| 2735 | V7_交换机_OSPF路由聚合 | 为了减少LSDB的规模，配置OSPF路由聚合功能，由ABR/ASBR将具有相同前缀的路由信息聚合，只发布一条路由到其它区域 | 已归档 | [projects/2735](projects/2735/) |
| 2750 | llb选路 |  | 已归档 | [projects/2750](projects/2750/) |
| 2751 | 防火墙做普通llb |  | 已归档 | [projects/2751](projects/2751/) |
| 2759 | V7_交换机_OSPF_stub区域 | 配置Stub区域，并且观察Stub区域配置前后，区域中路由器的路由表变化。 | 已归档 | [projects/2759](projects/2759/) |
| 2760 | V7_交换机_OSPF_NSSA区域 | 配置NSSA区域，并且观察NSSA区域配置前后，区域中路由器的路由表变化。 | 已归档 | [projects/2760](projects/2760/) |
| 2761 | V7_交换机_OSPF_虚连接 | 非骨干区域与骨干区域之间没有直接相连的物理链路，但可以在ABR上配置虚连接，使非骨干区域通过一条逻辑链路与骨干区域保持连通。 | 已归档 | [projects/2761](projects/2761/) |
| 2762 | V7_交换机_OSPF_验证 | 从安全性角度来考虑，为了避免路由信息外泄或者OSPF路由器受到恶意攻击，配置OSPF报文验证功能 | 已归档 | [projects/2762](projects/2762/) |
| 2764 | V7_交换机_ISIS_基础配置 | ISIS基本功能验证 | 已归档 | [projects/2764](projects/2764/) |
| 2792 | V7_交换机_策略路由 | 通过配置策略路由，实现指定流量走指定下一跳转发 | 已归档 | [projects/2792](projects/2792/) |
| 2805 | V7_交换机_BGP_基本配置 | BGP基本功能验证 | 已归档 | [projects/2805](projects/2805/) |
| 2830 | rbm结合ospf主备模式 |  | 已归档 | [projects/2830](projects/2830/) |
| 3166 | V7_交换机_BGP_Local-preference属性 | 掌握BGP的local-preference属性的基本配置方法 | 已归档 | [projects/3166](projects/3166/) |
| 3170 | V7_交换机_BGP_MED属性 | 掌握BGP的MED属性的基本配置方法 | 已归档 | [projects/3170](projects/3170/) |
| 3193 | V7_交换机_BGP_路由过滤_AS_PATH | 使用AS-PATH-ACL完成BGP路由过滤 | 已归档 | [projects/3193](projects/3193/) |
| 3236 | V7_交换机_BGP_路由过滤_ip前缀列表 | 使用IP prefix-list完成BGP路由过滤 | 已归档 | [projects/3236](projects/3236/) |
| 3239 | V7_交换机_BGP_反射器 | 通过配置BGP反射器实现将从IBGP邻居学习到的路由传递给IBGP邻居 | 已归档 | [projects/3239](projects/3239/) |
| 3242 | V7_交换机_BGP_路由聚合 | 在大规模的网络中，BGP路由表十分庞大，使用路由聚合（Routes Aggregation）可以大大减小BGP路由表的规模。 路由聚合实际上是将多条路由合并的过程。这样BGP在向对等体通告路由时，可以只通告聚合后的路由，而不是将所有的具体路由都通告出去。 目前系统支持自动聚合和手动聚合方式。使用后者还可以控制聚合路由的属性，以及决定是否发布具体路由。 | 已归档 | [projects/3242](projects/3242/) |
| 3249 | hcl_pm3r_d1a |  | 已归档 | [projects/3249](projects/3249/) |
| 3252 | isis_bfdIS-IS与BFD联动配置举例 |  | 已归档 | [projects/3252](projects/3252/) |
| 3253 | ipv6_isis_basic |  | 已归档 | [projects/3253](projects/3253/) |
| 3258 | OSPF发布聚合路由配置举例（交换） | SWA和SWB位于AS 200内，AS 200内使用OSPF作为IGP协议。SWC、SWD和SWE位于AS 100内，AS 100内使用OSPF作为IGP协议。SWB和SWC之间建立EBGP连接，配置BGP引入OSPF和直连路由，配置OSPF进程引入BGP路由。为了减小SWA的路由表规模，在SWB上配置路由聚合，只发布聚合后的路由10.0.0.0/8。。 | 已归档 | [projects/3258](projects/3258/) |
| 3259 | OSPF NSSA区域配置举例（交换） | 所有的交换机都运行OSPF，整个自治系统划分为3个区域。其中SWA和SWB作为ABR来转发区域之间的路由。要求将Area1配置为NSSA区域，同时将Switch C配置为ASBR引入外部路由（静态路由），且路由信息可正确的在AS内传播。。 | 已归档 | [projects/3259](projects/3259/) |
| 3260 | OSPF Stub区域配置举例（交换） | 所有的交换机都运行OSPF，整个自治系统划分为3个区域。其中SWA和SWB作为ABR来转发区域之间的路由，SW D作为ASBR引入了外部路由（静态路由）。要求将Area1配置为Stub区域，减少通告到此区域内的LSA数量，但不影响路由的可达性。。 | 已归档 | [projects/3260](projects/3260/) |
| 3261 | OSPF虚连接配置举例（交换） | Area 2与Area 0没有直接相连。Area 1被用作传输区域（Transit Area）来连接Area 2和Area 0。SWB和SW C之间配置一条虚连接。配置完成后，SWB能够学到Area 2中的路由。。 | 已归档 | [projects/3261](projects/3261/) |
| 3263 | OSPF NSR配置举例（交换） | Switch S、Switch A、Switch B属于同一OSPF区域，通过OSPF协议实现网络互连。要求对Switch S进行主备倒换时，Switch A和Switch B到Switch S的邻居没有中断，Switch A到Switch B的流量没有中断。 | 已归档 | [projects/3263](projects/3263/) |
| 3268 | OSPF快速重路由配置举例（交换） | Switch A、Switch B和Switch C属于同一OSPF区域，通过OSPF协议实现网络互连。要求当Switch A和Switch B之间的链路出现故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/3268](projects/3268/) |
| 3269 | OSPF引入自治系统外部路由配置举例交换 | 所有的交换机都运行ospf，整个自治系统划分为3个区域，其中SWA和SWB作为ABR来转发区域之间的路由，在SWC上配置为ASBR引入外部路由（静态路由），且路由信息可正确在AS内传播。 | 已归档 | [projects/3269](projects/3269/) |
| 3428 | 防火墙做rbm实现ospf双主 |  | 已归档 | [projects/3428](projects/3428/) |
| 3429 | 防火墙做rbm结合vrrp主备 |  | 已归档 | [projects/3429](projects/3429/) |
| 3465 | rbm_vrrp_ipsec |  | 已归档 | [projects/3465](projects/3465/) |
| 3505 | OSPF与BFD联动配置举例（交换） | SWA、SWB和SWC上运行OSPF，网络层相互可达。当SWA和SWB通过L2 Switch通信的链路出现故障时BFD能够快速感知通告OSPF协议，并且切换到SWC进行通信。。 | 已归档 | [projects/3505](projects/3505/) |
| 3506 | IS-IS快速重路由配置举例（交换机） | Switch A、Switch B和Switch C属于同一IS-IS路由域，通过IS-IS协议实现网络互连。要求当Switch A和Switch B之间的链路出现故障时，业务可以快速切换到链路B上。 | 已归档 | [projects/3506](projects/3506/) |
| 3518 | rbm结合ospf和vrrp实现主备 |  | 已归档 | [projects/3518](projects/3518/) |
| 3519 | rbm结合vrrp双主 |  | 已归档 | [projects/3519](projects/3519/) |
| 3671 | 交换机分布式vxlan_ip网关配置举例 |  | 已归档 | [projects/3671](projects/3671/) |
| 3713 | hcl_gh0usz1l |  | 已归档 | [projects/3713](projects/3713/) |
| 3715 | Ospfv3的nssa配置 |  | 已归档 | [projects/3715](projects/3715/) |
| 3717 | hcl_ospfstub |  | 已归档 | [projects/3717](projects/3717/) |
| 3731 | BGP重路由配置 |  | 已归档 | [projects/3731](projects/3731/) |
| 3812 | 防火墙做rbm联动静态路由实现主备 |  | 已归档 | [projects/3812](projects/3812/) |
| 3813 | 防火墙rbm静态路由双主 |  | 已归档 | [projects/3813](projects/3813/) |
| 3818 | 防火墙rbm二层主备 |  | 已归档 | [projects/3818](projects/3818/) |
| 3819 | 防火墙rbm二层双主 |  | 已归档 | [projects/3819](projects/3819/) |
| 3863 | 防火墙发送流日志 |  | 已归档 | [projects/3863](projects/3863/) |
| 3864 | 防火墙快速模式发送nat日志 |  | 已归档 | [projects/3864](projects/3864/) |
| 3898 | NGFW双机RBM_VRRP组网NAT_Server配置实验 |  | 已归档 | [projects/3898](projects/3898/) |
| 3901 | 防火墙冗余主备 |  | 已归档 | [projects/3901](projects/3901/) |
| 3902 | 防火墙堆叠双主 |  | 已归档 | [projects/3902](projects/3902/) |
| 3973 | 防火墙堆叠二层聚合口主备 |  | 已归档 | [projects/3973](projects/3973/) |
| 3974 | 防火墙二层聚合双主 |  | 已归档 | [projects/3974](projects/3974/) |
| 4039 | 防火墙vrf情况下实现互通 |  | 已归档 | [projects/4039](projects/4039/) |
| 4040 | 防火墙vrf下做natserver |  | 已归档 | [projects/4040](projects/4040/) |
| 4092 | 防火墙做vpn隔离配置natstatic |  | 已归档 | [projects/4092](projects/4092/) |
| 4093 | 防火墙vpn实例下做natoutbound |  | 已归档 | [projects/4093](projects/4093/) |
| 4119 | bgpbfd联动 |  | 已归档 | [projects/4119](projects/4119/) |
| 4157 | vxlan-jizhong |  | 已归档 | [projects/4157](projects/4157/) |
| 4158 | 集中式VXLAN IP网关保护组配置举例 | Switch A、Switch B 为与服务器连接的 VTEP 设备，Switch C 和 Switch D 为与广域网连接的集中式 VXLAN IP 网关设备。虚拟机 VM 1 属于 VXLAN 10，虚拟机 VM 4 属于 VXLAN 20。通过 VXLAN IP 网关保护组实现 Switch C 和 Switch D 能够同时对虚拟机的跨网络报文进行三层转发，同时实现网关设备的备份。 | 已归档 | [projects/4158](projects/4158/) |
| 4159 | smartlinktrack |  | 已归档 | [projects/4159](projects/4159/) |
| 4160 | VRRP单备份组配置举例 | Host A需要访问Internet上的Host B；当Switch A正常工作时，Host A发送给Host B的报文通过Switch A转发；当Switch A出现故障时，Host A发送给Host B的报文通过Switch B转发。 | 已归档 | [projects/4160](projects/4160/) |
| 4161 | 多Smartlink组负载分担组网配置举例 | Vlan1-100的流量经过Device C上Smart Link组1的主端口向Device A转发，VLAN 101～200的流量经Device C上Smart Link组2的主端向Device A转发；在DeviceC上实现双上行链路的灵活备份和负载分担。  | 已归档 | [projects/4161](projects/4161/) |
| 4162 | VRRP负载均衡模式配置举例（交换机） | Switch A、Switch B和Switch C属于备份组1；备份组1工作在负载均衡模式，通过一个备份组实现负载分担，充分利用网关资源；在Switch A、Switch B和Switch C上分别配置虚拟转发器通过Track项监视上行接口（VLAN接口3）的状态。当上行接口出现故障时，降低Switch A、Switch B或Switch C上虚拟转发器的权重，以便其它设备接管它的转发任务。 | 已归档 | [projects/4162](projects/4162/) |
| 4163 | smartlinktrackqqq |  | 已归档 | [projects/4163](projects/4163/) |
| 4164 | tracklll |  | 已归档 | [projects/4164](projects/4164/) |
| 4204 | V7_交换机_vlan划分 | V7交换机vlan划分基础介绍 | 已归档 | [projects/4204](projects/4204/) |
| 4205 | V7_交换机_WEB登陆 | 接入交换机开启web登陆 | 已归档 | [projects/4205](projects/4205/) |
| 4208 | V7_交换机_日志外发 | 交换机配置日志外发，将日志发送到指定日志服务器 | 已归档 | [projects/4208](projects/4208/) |
| 4212 | V7_交换机_本地端口镜像 | 交换机配置本地端口镜像，将指定源端口指定方向的流量镜像至监控口 | 已归档 | [projects/4212](projects/4212/) |
| 4217 | V7_交换机_SNMPv1_v2c配置 | 交换机开启SNMP功能，使网管侧可以通过OID读取设备信息，实现监控设备状态 | 已归档 | [projects/4217](projects/4217/) |
| 4219 | V7_交换机_Trap告警外发 | 交换机在开启SNMP后，配置将trap告警日志外发到指定网管设备 | 已归档 | [projects/4219](projects/4219/) |
| 4221 | V7_交换机_NTP时钟同步 | 交换机配置NTP功能，可以让设备本身作为NTP服务器，也可以让设备作为NTP客户端去找NTP服务器同步时间 | 已归档 | [projects/4221](projects/4221/) |
| 4222 | V7_交换机_带验证的NTP同步 | 为了提高时间同步的安全性，NTP提供了NTP验证功能。 | 已归档 | [projects/4222](projects/4222/) |
| 4261 | 防火墙vpn实例下实现v6访问v4服务器 |  | 已归档 | [projects/4261](projects/4261/) |
| 4262 | 防火墙vpn实例下用v4server做映射 |  | 已归档 | [projects/4262](projects/4262/) |
| 4273 | 防火墙vrf下实现v6v4互访 |  | 已归档 | [projects/4273](projects/4273/) |
| 4274 | 防火墙vrf下做aftv4访问v6 |  | 已归档 | [projects/4274](projects/4274/) |
| 4499 | 防火墙映射内网服务器下带宽限速 |  | 已归档 | [projects/4499](projects/4499/) |
| 4546 | 防火墙vrf下配置带宽策略 |  | 已归档 | [projects/4546](projects/4546/) |
| 4547 | vrf场景下防火墙做ipsec |  | 已归档 | [projects/4547](projects/4547/) |
| 4559 | 通过路由复制方式实现私网与公网互通 |  | 已归档 | [projects/4559](projects/4559/) |
| 4560 | hcl_oouh_dva |  | 已归档 | [projects/4560](projects/4560/) |
| 4561 | hcl_ciqoku58 |  | 已归档 | [projects/4561](projects/4561/) |
| 4581 | 防火墙测试llbpbr路由三者优先级 |  | 已归档 | [projects/4581](projects/4581/) |
| 4999 | 防火墙全局nat实现内网访问内网 |  | 已归档 | [projects/4999](projects/4999/) |
| 5103 | 防火墙vrf情况下的全局nat |  | 已归档 | [projects/5103](projects/5103/) |
| 5104 | 防火墙不同nat在vrf场景下和策略的关系 |  | 已归档 | [projects/5104](projects/5104/) |
| 5164 | 运营商宽带业务配置 | 运营商BRAS设备，为宽带用户提供接入服务。宽带用户采用PPPoE方式接入，需要支持双栈，BRAS设备作为PPPoE Server通过DHCPv4协议为CPE分配IPv4地址，通过DHCPv6协议为Host A分配IPv6地址。 | 已归档 | [projects/5164](projects/5164/) |
| 5165 | DHCPv6实验 | 服务器给Client分发IPv6地址，同时下发IPv6前缀2001:410::/48。Client接口引用前缀生成IPv6地址，Host使用无状态获取IPv6地址。 | 已归档 | [projects/5165](projects/5165/) |
| 5169 | Telnet配置方式 | Telnet三种配置方式总结。 | 已归档 | [projects/5169](projects/5169/) |
| 5175 | GRE Over IPSec配置示例 | RTA与RTC之间建立GRE隧道，同时需要对GRE数据流进行加密，这里采用GRE Over IPSec的配置。 | 已归档 | [projects/5175](projects/5175/) |
| 5176 | OSPF RIP缺省路由的发布 | RTA与RTB 建立OSPF邻居，RTB与RTC建立RIP邻居。RTA，RTC分别产生缺省路由向RTB发布。 | 已归档 | [projects/5176](projects/5176/) |
| 5240 | 防火墙单臂旁路 |  | 已归档 | [projects/5240](projects/5240/) |
| 5241 | 防火墙镜像黑洞 |  | 已归档 | [projects/5241](projects/5241/) |
| 5242 | 防火墙bridge透传 |  | 已归档 | [projects/5242](projects/5242/) |
| 5243 | 防火墙vrf下发日志 |  | 已归档 | [projects/5243](projects/5243/) |
| 5358 | V7_SW_MLAG_SINGLE_LY2 | 单级MLAG二层基础配置(原DRNI) | 已归档 | [projects/5358](projects/5358/) |
| 5369 | Option43发现方式建立CAPWAP隧道配置举例 | AP通过交换机与AC相连，交换机做DHCP server为AP分配IP地址。需要实现AP能正常在AC上注册在线，具体要求如下： AC属于VLAN 1，AP属于VLAN 2，AC和AP之间跨三层网络建立连接。 | 已归档 | [projects/5369](projects/5369/) |
| 5457 | ac的telnet用户本地用户角色授权配置举例 | Telnet用户主机与AC相连，需要实现AC对Telnet用户进行本地认证并授权用户角色。Telnet用户的登录用户名为user1@bbb，密码为abc123456789,认证通过后被授权的用户角色为role1。 | 已归档 | [projects/5457](projects/5457/) |
| 5514 | 开启自动ap功能建立capwap隧道典型配置举例 | AC作为DHCP服务器为AP分配IP地址，现要求使用自动AP功能，实现AP与AC自动关联，并且在关联后将AP转化为固化AP。 | 已归档 | [projects/5514](projects/5514/) |
| 5517 | 端口隔离典型配置举例 | AP 3、AP 4、AP 5分别与AC的端口GigabitEthernet1/0/1、GigabitEthernet1/0/2、GigabitEthernet1/0/3相连，AC设备通过GigabitEthernet1/0/0端口与交换机相连。现需要实现AP 3、AP 4和AP 5彼此之间二层报文不能互通，但可以和交换机通信。 | 已归档 | [projects/5517](projects/5517/) |
| 5525 | 开启手动AP功能建立CAPWAP隧道典型配置举例 | AC作为DHCP服务器为AP分配IP地址，现要求使用手动AP功能，实现AP与AC手动关联。   | 已归档 | [projects/5525](projects/5525/) |
| 5546 | 静态ARP绑定配置举例 | 静态ARP表项通过手工配置和维护，不会被老化，不会被动态ARP表项覆盖。 配置静态ARP表项可以增加通信的安全性。静态ARP表项可以限制和指定IP地址的设备通信时只使用指定的MAC地址，此时攻击报文无法修改此表项的IP地址和MAC地址的映射关系，从而保护了本设备和指定设备间的正常通信。 | 已归档 | [projects/5546](projects/5546/) |
| 5547 | 动态arp表项老化时间配置举例 | 为适应网络的变化，ARP表需要不断更新。ARP表中的动态ARP表项并非永远有效，每一条记录都有一个生存周期，到达生存周期仍得不到刷新的记录将从ARP表中删除，这个生存周期被称作老化时间。如果在到达老化时间前记录被刷新，则重新计算老化时间。 | 已归档 | [projects/5547](projects/5547/) |
| 5550 | 终端接入静态黑名单典型配置举例 | 需要对接入无线网络的终端进行接入限制，仅静态黑名单中的终端被拒绝接入。 如图1所示，AC和AP通过Switch相连，AP已上线，要求配置静态黑名单，仅拒绝MAC地址为00e0-0402-1235的终端接入，允许其它终端接入。 | 已归档 | [projects/5550](projects/5550/) |
| 5554 | 终端接入白名单典型配置举例 | 需要对接入无线网络的终端进行接入限制，仅白名单中的终端允许接入。  如图所示，AC和AP通过Switch相连，AP已上线，要求配置白名单，仅允许MAC地址为00e0-0402-1235的终端接入，拒绝其它终端接入。 | 已归档 | [projects/5554](projects/5554/) |
| 5563 | DHCP中继配置举例 | 交换机作为DHCP Server在vlan 20网段，AC作为DHCP Relay，为vlan 10网段的终端提供IP地址。 | 已归档 | [projects/5563](projects/5563/) |
| 5574 | IPv6基本组网配置举例 | 构建IPv6网络，SWA交换机作为DHCPv6服务器，AP向其申请IPv6地址后注册到AC上，终端上线获取IPv6地址。 | 已归档 | [projects/5574](projects/5574/) |
| 5578 | 通过if_match将ap根据获取的ip地址网段加入ap组典型配置举例 | AC连接L3交换机，L3交换机连接三个AP，三个AP分别获取vlan 200，300和400网段的地址，根据AP获取的IP地址段，利用if-match匹配规格让AP自动加入不同的AP组。 | 已归档 | [projects/5578](projects/5578/) |
| 5637 | 无线内二层隔离 | 在集中转发场景下，Client 1、Client 2分别通过AP 1、AP 2接入无线网络，在AC上开启基于SSID的用户隔离功能，通过该SSID接入无线服务且处于同一VLAN内的无线用户之间将不能够互相访问。 | 已归档 | [projects/5637](projects/5637/) |
| 5727 | WLAN本地转发典型配置举例 | 在AC上配置本地转发功能，使Client的数据流量不经过AC，直接由AP转发 | 已归档 | [projects/5727](projects/5727/) |
| 5851 | hcl_qm1vw7 |  | 已归档 | [projects/5851](projects/5851/) |
| 5852 | hcl_4tnjvd |  | 已归档 | [projects/5852](projects/5852/) |
| 5853 | hcl_zotl2n |  | 已归档 | [projects/5853](projects/5853/) |
| 5854 | hcl_xsrnxr95 |  | 已归档 | [projects/5854](projects/5854/) |
| 5855 | hcl_ogvbfz |  | 已归档 | [projects/5855](projects/5855/) |
| 5856 | hcl_6baqp_ |  | 已归档 | [projects/5856](projects/5856/) |
| 5857 | hcl_624vpy |  | 已归档 | [projects/5857](projects/5857/) |
| 5865 | DHCPv6发现方式建立CAPWAP隧道典型配置举例 | AC作为DHCPv6服务器为AP分配IPv6,并使用手动AP功能，实现AP与AC的手动关联   | 已归档 | [projects/5865](projects/5865/) |
| 5877 | H3C无线控制器静态VLAN-group典型配置举例 | 在AC上配置VLAN-group。现要求：Client分别接入不同VLAN组，VLAN组可以为Client随机分配组内的VLAN，使Client被均衡地分配在所有VLAN中 | 已归档 | [projects/5877](projects/5877/) |
| 5892 | V7_SW_设备管理_SSH登录_限制源 | 通过配置ACL，实现仅ACL permit的源地址可以登陆设备 | 已归档 | [projects/5892](projects/5892/) |
| 5893 | V7_SW_设备管理_Telnet登录_限制源 | 通过配置ACL，实现仅ACL permit的地址可以telnet登陆交换机 | 已归档 | [projects/5893](projects/5893/) |
| 5894 | V7_SW_设备管理_Telnet登陆_仅密码验证 | 配置交换机作为Telnet server，运维人员可通过Telnet方式远程登陆交换机，验证时仅输入密码即可，无需用户名 | 已归档 | [projects/5894](projects/5894/) |
| 5896 | V7_SW_设备管理_WEB登陆 | 开启交换机web登陆功能，运维人员可通过https方式远程登陆交换机 | 已归档 | [projects/5896](projects/5896/) |
| 5898 | V7_SW_设备管理_WEB登录_限制源 | 开启交换机web登陆功能，并配置ACL控制可web登录的地址 | 已归档 | [projects/5898](projects/5898/) |
| 5902 | V7_SW_IRF堆叠_多台设备环堆 | 三台及以上设备环形堆叠 | 已归档 | [projects/5902](projects/5902/) |
| 5903 | V7_SW_IRF堆叠_多台设备链堆 | 三台及以上设备链形堆叠 | 已归档 | [projects/5903](projects/5903/) |
| 5904 | dhcpv6中继配置举例 | dhcpv6中继配置举例 （交换机作为DHCPv6服务器，AC作为DHCPv6中继，为接入AP分配IPv6地址） | 已归档 | [projects/5904](projects/5904/) |
| 5905 | dhcpv6服务器典型配置举例 | 1. AC作为DHCPv6服务器的AC为AP分配1::1:0:0:0/96网段、客户端分配1::2:0:0:0/96网段的IPv6地址；  2. AC的两个VLAN接口Vlan-interface10和Vlan-interface20的地址分别为1::1:0:0:1/96和1::2:0:0:1/96。 | 已归档 | [projects/5905](projects/5905/) |
| 6183 | vlan划分典型配置 | 给AC配置vlan2和vlan3，并且接口G1/0/0需要trunk permitvlan2和vlan3 | 已归档 | [projects/6183](projects/6183/) |
| 6194 | 双链路备份典型配置举例 | AP通过Switch与AC 1和AC 2连接： · 使用双链路备份对AC进行备份，AC 1工作在主用状态，AC 2工作在备用状态，当AC 1发生故障或主备AC切换时，AP可以通过AC 2进行通信。 | 已归档 | [projects/6194](projects/6194/) |
| 6200 | 通过https登录AC设备 | Host和设备通过IP网络相连且路由可达。管理员可以通过Host使用HTTPS方式登录设备，以便通过Web页面来配置和管理设备。 | 已归档 | [projects/6200](projects/6200/) |
| 6232 | IPv4域名静态解析典型配置举例 | 静态域名解析就是手工建立域名和IP地址之间的对应关系。当用户使用域名进行某些应用（如telnet应用）时，系统查找静态域名解析表，从中获取指定域名对应的IP地址。 | 已归档 | [projects/6232](projects/6232/) |
| 6233 | IPv4域名代理解析典型配置举例 | DNS代理（DNS proxy）用来在DNS client和DNS server之间转发DNS请求和应答报文。局域网内的DNS client把DNS proxy当作DNS server，将DNS请求报文发送给DNS proxy。DNS proxy将该请求报文转发到真正的DNS server，并将DNS server的应答报文返回给DNS client，从而实现域名解析。 | 已归档 | [projects/6233](projects/6233/) |
| 6268 | 接口通过dhcpv6协议无状态获取ip地址配置举例 | AP1和AP2分别通过无状态获取方式获取vlan 100和200网段的IP地址，然后使用此地址与AC建立CAPWAP隧道。 | 已归档 | [projects/6268](projects/6268/) |
| 6269 | 接口通过dhcpv6协议有状态获取ip地址配置举例 | AC分别为vlan 100和200网段提供DHCPv6服务，AP1和AP2分别获取这两个网段的IPv6地址，然后与AC建立CAPWAP隧道 | 已归档 | [projects/6269](projects/6269/) |
| 6291 | V7_交换机_策略路由_IPV6 | ipv6环境的策略路由配置 | 已归档 | [projects/6291](projects/6291/) |
| 6293 | V7_SW_OSPFV3_基本功能 | OSPFv3基础功能配置 | 已归档 | [projects/6293](projects/6293/) |
| 6297 | V7_SW_OSPFv3_Stub区域配置 | OSPFv3 stub区域配置 | 已归档 | [projects/6297](projects/6297/) |
| 6304 | V7_SW_OSPFv3_Totally_stub区域配置 | OSPFv3 Totally stub区域配置 | 已归档 | [projects/6304](projects/6304/) |
| 6306 | V7_SW_OSPFv3_NSSA区域配置 | OSPFv3 NSSA区域配置 | 已归档 | [projects/6306](projects/6306/) |
| 6307 | V7_SW_OSPFv3_Totallly_NSSA区域配置 | OSPFv3 Totally NSSA区域配置 | 已归档 | [projects/6307](projects/6307/) |
| 6314 | V7_SW_BGP_IPV6_基本配置 | IPV6 BGP基本配置 | 已归档 | [projects/6314](projects/6314/) |
| 6321 | 动态链路聚合典型配置举例 | 两个AC进行动态链路聚合 | 已归档 | [projects/6321](projects/6321/) |
| 6373 | 通过服务模板acl接入控制配置举例 | 在AC服务模板下配置ACL，实现对无线客户端的接入控制。 | 已归档 | [projects/6373](projects/6373/) |
| 6377 | 通过radio进行acl接入控制配置举例 | 在AP的Radio下配置ACL，实现对无线客户端的接入控制。 | 已归档 | [projects/6377](projects/6377/) |
| 6404 | 通过ssh登录ac设备典型配置举例 | 配置AC作为ssh server，使运维人员可以通过内网口地址ssh远程登陆设备 | 已归档 | [projects/6404](projects/6404/) |
| 6405 | 通过telnet登录ac设备 | AC2设备与AC1设备通过IP网络相连且路由可达。管理员可以使用telnet方式登录AC1设备。 | 已归档 | [projects/6405](projects/6405/) |
| 6426 | 无线控制器PasswordControl基础配置举例 | （1）全局密码管理策略  （2）切换到用户角色network-operator时使用的super密码管理策略  （3）本地Telnet用户test的密码管理策略 | 已归档 | [projects/6426](projects/6426/) |
| 6465 | IPv6域名静态解析典型配置举例 | 为了避免记忆复杂的IPv6地址，设备希望通过便于记忆的主机名访问某一主机。在设备上手工配置IPv6地址对应的主机名，利用静态域名解析功能，就可以实现通过主机名访问该主机。 在本例中，AC访问的主机IPv6地址为1::2，主机名为test.com。 | 已归档 | [projects/6465](projects/6465/) |
| 6475 | IPv6域名代理解析典型配置举例 | DNS代理（DNS proxy）用来在DNS client和DNS server之间转发DNS请求和应答报文。局域网内的DNS client把DNS proxy当作DNS server，将DNS请求报文发送给DNS proxy。DNS proxy将该请求报文转发到真正的DNS server，并将DNS server的应答报文返回给DNS client，从而实现域名解析。 | 已归档 | [projects/6475](projects/6475/) |
| 6517 | vpls |  | 已归档 | [projects/6517](projects/6517/) |
| 6526 | vplsxpp1 |  | 已归档 | [projects/6526](projects/6526/) |
| 6527 | vplsxpp |  | 已归档 | [projects/6527](projects/6527/) |
| 6530 | vplsxpp2 |  | 已归档 | [projects/6530](projects/6530/) |
| 6531 | vplsxpp3 |  | 已归档 | [projects/6531](projects/6531/) |
| 6552 | hcl_otwqdx |  | 已归档 | [projects/6552](projects/6552/) |
| 6553 | hcl_mskzk8 |  | 已归档 | [projects/6553](projects/6553/) |
| 6554 | vpngswluyouhuyin |  | 已归档 | [projects/6554](projects/6554/) |
| 6555 | hcl_tyhjdj |  | 已归档 | [projects/6555](projects/6555/) |
| 6556 | hcl_bgppath |  | 已归档 | [projects/6556](projects/6556/) |
| 6557 | aaaa |  | 已归档 | [projects/6557](projects/6557/) |
| 6558 | hcl_bgptuanti |  | 已归档 | [projects/6558](projects/6558/) |
| 6559 | hcl_d9i2u3 |  | 已归档 | [projects/6559](projects/6559/) |
| 6560 | mpls-optiona |  | 已归档 | [projects/6560](projects/6560/) |
| 6561 | hcl_8kwmxr |  | 已归档 | [projects/6561](projects/6561/) |
| 6562 | rbaclmy |  | 已归档 | [projects/6562](projects/6562/) |
| 6568 | h3c无线控制器动态vlan-group典型配置举例 | 在AC上配置VLAN-group。现要求：Client分别接入不同VLAN组，VLAN组可以为Client随机分配组内的VLAN，使用动态vlan-group方式 | 已归档 | [projects/6568](projects/6568/) |
| 6574 | Ap组管理典型配置 | AC通过交换机与AP1，AP2相连，将AP1加入group1,AP2加入group2。   | 已归档 | [projects/6574](projects/6574/) |
| 6575 | dhcp动态分配地址典型配置举例 | dhcp动态分配地址典型配置举例 | 已归档 | [projects/6575](projects/6575/) |
| 6579 | DHCPip地址绑定 | DHCP ip地址绑定 | 已归档 | [projects/6579](projects/6579/) |
| 6606 | vlan-interface实现vlan间路由 | 设备上配置vlan-interface接口，实现VLAN间通信。 注：真机需要添加二层接口卡或者使用原生二层接口。 | 已归档 | [projects/6606](projects/6606/) |
| 6608 | ipv6静态路由配置举例 | 网络中SW1和SW2分别作为下游设备网关，实现下挂终端互访需求。 | 已归档 | [projects/6608](projects/6608/) |
| 6718 | ntp典型配置举例 | AC NTP典型配置举例 | 已归档 | [projects/6718](projects/6718/) |
| 6721 | AC_ntp_ipv6典型配置举例 | 为了通过IPv6 NTP实现Switch与AC的时间同步，要求：  ·              在AC上设置本地时钟作为参考时钟，层数为2；  ·              配置Switch工作在客户端模式，指定AC为IPv6 NTP服务器。  | 已归档 | [projects/6721](projects/6721/) |
| 6881 | ap固定信道配置举例 | AP通过Switch与AC连接，具体要求如下： · 通过配置修改AP radio1的信道，默认为自动信道，将radio1修改为固定信道149； | 已归档 | [projects/6881](projects/6881/) |
| 6890 | 定时执行任务典型配置 | Client访问无线网络，AC直接连接AP，AC充当DHCP服务器，为AP和Client分配IP地址。现要求：配置定时执行任务功能，每天8：00开启AC上关联AP的Radio1接口，每天20：00关闭AC上关联AP的Radio1接口。  | 已归档 | [projects/6890](projects/6890/) |
| 6921 | V7_防火墙_RBM_OSPF路由主备 | 防火墙RBM结合OSPF路由主备部署 | 已归档 | [projects/6921](projects/6921/) |
| 6923 | AC_NTP对等体典型配置 | 网络中存在时间服务器AC。为了通过NTP实现Switch与AC进行时间同步，要求： ·              在AC上设置本地时钟作为参考时钟，层数为2； ·              配置AC工作在对等体模式，指定Switch为被动对等体，即AC为主动对等体，Switch为被动对等体。 | 已归档 | [projects/6923](projects/6923/) |
| 7017 | AC_NTP_IPV6对等体典型配置举例 | 网络中存在时间服务器AC。为了通过IPv6 NTP实现Switch与AC进行时间同步，要求： ·              在AC上设置本地时钟作为参考时钟，层数为2； ·              配置AC工作在对等体模式，指定Switch为被动对等体，即AC为主动对等体，Switch为被动对等体 | 已归档 | [projects/7017](projects/7017/) |
| 7209 | hcl_55bitcpk |  | 已归档 | [projects/7209](projects/7209/) |
| 7211 | hcl_lumm |  | 已归档 | [projects/7211](projects/7211/) |
| 7212 | mpls-optionalmy |  | 已归档 | [projects/7212](projects/7212/) |
| 7759 | 关闭wlan_2.4G低速率 | AP通过Switch与AC 连接，具体要求如下： · 通过配置修改AP radio2的2.4G默认支持的速率集，禁用速率：1、2、5.5、6、9Mbps； | 已归档 | [projects/7759](projects/7759/) |
| 7761 | AP固定功率配置案例 | AP通过Switch与AC连接，具体要求如下： · 通过配置修改AP radio1的功率值，默认为20，将5G修改为10dBm； | 已归档 | [projects/7761](projects/7761/) |
| 7763 | AP频宽配置案例 | AP通过Switch与AC连接，具体要求如下： · 通过配置修改AP radio1的频宽，默认为80MHz，将5G修改为40MHz； | 已归档 | [projects/7763](projects/7763/) |
| 8068 | AC带验证功能的NTP典型配置举例 | 为了通过NTP实现Switch与AC的时间同步，并保证时间同步的安全性，要求： ·              在AC上设置本地时钟作为参考时钟，层数为2； ·              Switch工作在客户端模式，指定AC为NTP服务器； ·           AC和Switch上同时配置NTP验证 | 已归档 | [projects/8068](projects/8068/) |
| 8096 | 通过ACweb界面手工注册ap上线典型配置举例 | 管理员可以通过Host使用HTTPS方式登录设备，以便通过Web页面来手工注册AP上线。 | 已归档 | [projects/8096](projects/8096/) |
| 12144 | Server2功能演示 |  | 已归档 | [projects/12144](projects/12144/) |
| 12148 | Server2功能演示_test |  | 已归档 | [projects/12148](projects/12148/) |
| 14746 | BGP的MD5认证配置举例 |  | 已归档 | [projects/14746](projects/14746/) |
| 14760 | RouterID的选取配置举例 |  | 已归档 | [projects/14760](projects/14760/) |
| 14763 | 静态路由实现网络连通 |  | 已归档 | [projects/14763](projects/14763/) |
| 14803 | 对端设备AS号与本端peer不一致导致BGP建立失败 |  | 已归档 | [projects/14803](projects/14803/) |
| 14992 | H3C路由器配置上送CPU的ICMP报文限速 | 介绍qos icmp限速的配置指导 | 已归档 | [projects/14992](projects/14992/) |
| 14993 | H3C路由器配置QoS重标记修改报文优先级 | qos重标记配置指导 | 已归档 | [projects/14993](projects/14993/) |
| 14994 | H3C交换机配置QoS基于VLAN实现带宽分配 | 基于vlan带宽qos配置指导 | 已归档 | [projects/14994](projects/14994/) |
| 14995 | H3C交换机配置QoS保障业务高可靠性 | QoS带宽保障配置指导 | 已归档 | [projects/14995](projects/14995/) |
| 14996 | H3C交换机基于子网划分VLAN | vlan基于子网划分介绍 | 已归档 | [projects/14996](projects/14996/) |
| 15006 | v7_ngfw_安全策略过滤域名 | 通过安全策略规则过滤域名，禁止用户访问www.baidu.com | 已归档 | [projects/15006](projects/15006/) |
| 15007 | v7_ngfw_快速日志_安全策略日志 | V7_NGFW_快速日志_安全策略日志 | 已归档 | [projects/15007](projects/15007/) |
| 15008 | v7_ngfw_snmp_trap告警外发 | 配置snmp trap告警外发功能 | 已归档 | [projects/15008](projects/15008/) |
| 15010 | v7_ngfw_bgp基础 | 基本的BGP配置 | 已归档 | [projects/15010](projects/15010/) |
| 15011 | v7_ngfw_isis基础 | ISIS基础配置 | 已归档 | [projects/15011](projects/15011/) |
| 15488 | Option52方式建立双链路备份IPv6CAPWAP典型配置举例 | AP与通过交换机与主备AC相连。需要实现AP能正常在AC上注册在线，具体要求如下： 主备AC属于VLAN 100，AP属于VLAN 300，AP跨三层网络分别与主备AC建立R/M和R/B的IPv6 CAPWAP隧道，交换机使用DHCPv6给AP分配IPv6地址，并通过Option 52给AP下发主备AC的IPv6地址信息 | 已归档 | [projects/15488](projects/15488/) |
| 15490 | Option138发现方式建立CAPWAP隧道配置举例 | AP通过DHCP Server分配IP地址时携带的OPTION138属性发现AC | 已归档 | [projects/15490](projects/15490/) |
| 15492 | 双链路备份建立IPv6CAPWAP典型配置举例 | 通过在AP上指定AC的ipv6地址，让AP在主备AC上线 | 已归档 | [projects/15492](projects/15492/) |
| 15496 | 通过在AP上手工指定ACIPv6地址建立IPv6三层CAPWAP隧道配置举例 | 通过在AP上手工指定AC IPv6地址建立IPv6三层CAPWAP隧道 | 已归档 | [projects/15496](projects/15496/) |
| 15497 | 通过在AP上手工指定ACIP地址建立三层CAPWAP隧道应用举例 | 通过在AP上手工指定AC IP地址建立三层CAPWAP隧道配置 | 已归档 | [projects/15497](projects/15497/) |
| 15499 | 通过禁止弱信号接入防止弱信号终端接入AP射频 | 通过禁止弱信号接入防止弱信号终端接入AP射频 | 已归档 | [projects/15499](projects/15499/) |
| 15501 | TCP源地址插入 |  | 已归档 | [projects/15501](projects/15501/) |
| 15502 | ComwareV7FW跨VPN实例的IPSEC典型配置 |  | 已归档 | [projects/15502](projects/15502/) |
| 15503 | comwareV7防火墙跨VPN实例的静态NAT典型配置 |  | 已归档 | [projects/15503](projects/15503/) |
| 15504 | 多分支IPSEC典型配置 |  | 已归档 | [projects/15504](projects/15504/) |
| 15505 | 某局点F1000IPSEC内网不通 |  | 已归档 | [projects/15505](projects/15505/) |
| 15506 | 动态路由下的不通VPN实例之间的路由互引 |  | 已归档 | [projects/15506](projects/15506/) |
| 15507 | ComwareV7FWIPSEC反向路由注入典型配置 |  | 已归档 | [projects/15507](projects/15507/) |
| 15508 | GREOVERIPSEC典配 |  | 已归档 | [projects/15508](projects/15508/) |
| 15778 | NQA_TRACK | 策略路由通过与Track联动，增强了应用的灵活性和对网络环境变化的动态感知能力。 | 已归档 | [projects/15778](projects/15778/) |

<!-- PROJECT_INDEX_END -->
