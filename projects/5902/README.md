# 工程名称
V7交换机三台及以上设备环堆(IRF)


## 需求：
SW1、SW2、SW3三台交换机环形连接，组建IRF


## 实验步骤：
1、SW2和SW3修改IRF成员编号，重启生效

SW2:
[SW2]irf member 1 renumber 2
Renumbering the member ID may result in configuration change or loss. Continue?[Y/N]:y
[SW2]qu
<SW2>
<SW2>reboot


SW3:
[SW3]irf member 1 renumber 3
Renumbering the member ID may result in configuration change or loss. Continue?[Y/N]:y
[SW3]qu
<SW3>
<SW3>reboot


2、SW1、SW2、SW3分别将IRF物理口shutdown，按照规划加入IRF-PORT。仅以SW1举例，参考拓扑标注将SW2\SW3相关接口加入对应IRF-PORT即可

[SW]interface range Ten-GigabitEthernet 1/0/49 TO Ten-GigabitEthernet 1/0/52
[SW-if-range]shutdown 
[SW-if-range]quit
[SW]
[SW]irf-port 1/1
[SW-irf-port1/1]port group interface Ten-GigabitEthernet 1/0/49
[SW-irf-port1/1]port group interface Ten-GigabitEthernet 1/0/50
[SW-irf-port1/1]quit
[SW]
[SW]irf-port 1/2
[SW-irf-port1/2]port group interface Ten-GigabitEthernet 1/0/51
[SW-irf-port1/2]port group interface Ten-GigabitEthernet 1/0/52
[SW-irf-port1/2]quit
[SW]

3、SW1、SW2、SW3分别将IRF物理口undo shutdown，并保存配置，仅以SW1举例

[SW]INTER range Ten-GigabitEthernet 1/0/49 TO Ten-GigabitEthernet 1/0/52
[SW-if-range]undo shutdown 
[SW-if-range]quit
[SW]
[SW]save force


4、SW1、SW2、SW3分别激活IRF配置,仅以SW1举例

[SW]irf-port-configuration active


## 测试结果：
1、查看IRF状态

<SW>display irf
MemberID    Role    Priority  CPU-Mac         Description
 *+1        Master  1         a61d-24ae-0104  ---
   2        Standby 1         a61d-29c0-0204  ---
   3        Standby 1         a61d-2f2e-0304  ---
--------------------------------------------------
 * indicates the device is the master.
 + indicates the device through which the user logs in.

 The bridge MAC of the IRF is: a61d-24ae-0100
 Auto upgrade                : yes
 Mac persistent              : 6 min
 Domain ID                   : 0
<SW>

2、查看IRF相关接口

<SW>display irf link 
Member 1
 IRF Port  Interface                             Status
 1         Ten-GigabitEthernet1/0/49             UP    
           Ten-GigabitEthernet1/0/50             UP    
 2         Ten-GigabitEthernet1/0/51             UP    
           Ten-GigabitEthernet1/0/52             UP    
Member 2
 IRF Port  Interface                             Status
 1         Ten-GigabitEthernet2/0/51             UP    
           Ten-GigabitEthernet2/0/52             UP    
 2         Ten-GigabitEthernet2/0/49             UP    
           Ten-GigabitEthernet2/0/50             UP    
Member 3
 IRF Port  Interface                             Status
 1         Ten-GigabitEthernet3/0/49             UP    
           Ten-GigabitEthernet3/0/50             UP    
 2         Ten-GigabitEthernet3/0/51             UP    
           Ten-GigabitEthernet3/0/52             UP    
<SW>


## 说明： 
1、IRF-PORT A/B ,其中A代表当前设备成员编号，B只能为1或者2，配置IRF时，相邻的IRF-PORT的B位必须1和2交叉对应，比如SW1的xg1/0/49和xg1/0/50加入了IRF-PORT1/1，那么对端SW2的xg1/0/49和xg1/0/50所在的IRF-PORT必须是IRF-PORT2/2

2、IRF物理口在undo shutdown后，必须先保存配置再激活IRF配置

3、激活IRF配置后，竞选失败的设备会自动重启加入IRF，MASTER设备不会重启

4、环堆仅适用于三台即以上设备组建IRF，相较于链堆，环堆可靠性更高


