@echo off

rem 取得管理员权限
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)

rem 系统诊断修复工具

rem 检查系统环境变量

wmic /? >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	rem call:systempath %%SystemRoot%%\system32\Wbem
	echo 诊断工具功能可能受限，请手动修复C:\Windows\system32\Wbem环境变量
)

netsh winsock show >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	call:systempath %%SystemRoot%%\system32
)

rem 检查用户temp缓存目录环境变量
echo %temp% |%systemroot%\system32\findstr "Local\Temp" >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	%systemroot%\system32\reg add "HKEY_CURRENT_USER\Environment" /v Temp /t REG_EXPAND_SZ /d "%USERPROFILE%\AppData\Local\Temp" /f >nul 2>nul
	set temp=%USERPROFILE%\AppData\Local\Temp
	echo 已修复用户环境变量, 请重新打开检查工具
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq 360tray.exe" |findstr /i 360tray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo 请退出360安全卫士, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出360安全卫士, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq QQPCSoftMgr.exe" |findstr /i QQPCSoftMgr.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo 请退出腾讯电脑管家, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出腾讯电脑管家, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq HipsTray.exe" |findstr /i HipsTray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo 请退出火绒安全软件, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出火绒安全软件, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

title 网络诊断修复工具
rem color 2f
mode con cols=128 lines=40
setlocal enabledelayedexpansion
powershell -executionpolicy bypass -command "&{$H=get-host;$W=$H.ui.rawui;$B=$W.buffersize;$B.width=128;$B.height=300;$W.buffersize=$B;$W.windowtitle='系统诊断修复工具'}"
chcp 936 2>nul >nul

rem 获取系统版本信息
ver /? >nul 2>nul
if !ERRORLEVEL! equ 0 (
	for /f "tokens=4 " %%i in ('ver') do (
		for /f "tokens=1 delims=." %%a in ('echo %%i 2^>nul') do set systemver=%%a
	)
) else (
	set systemver=9
)

rem 获取powershell版本信息
for /f %%i in ('powershell -executionpolicy bypass $PSVersionTable.PSVersion 2^>nul ^|findstr [0-9]') do set powershellver=%%i

set ipv4ipv6=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^> [0-9][a-f][0-9]*: [a-f][a-f][a-f]*: [a-f][a-f][a-f][0-9]: [0-9][0-9][0-9]*::
set ipv4only=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^>
set ipv6only=[0-9][a-f][0-9]*: [a-f][a-f][a-f]*: [a-f][a-f][a-f][0-9]: [0-9][0-9][0-9]*::
rem 获取批处理文件名
set mybatname=%~n0
)

rem 声明安全/拨号/代理/模拟器/限速软件变量
set securitysoftwareprocess=Avast adguard 2345 V2RayN V3Medic V3LSvc Ldshelper LenovoNerveCenter wsctrl LenovoPcManagerService McUICnt kxetray rstray HipsDaemon HipsTray HipsMain ADSafe kavsvc Norton Mcafee avguard SecurityHealthSystray KWatch ZhuDongFangYu 360tray 360safe QQPCMgr QQPCTray QQPCRTP BullGuardCore GlassWire avira k7gw panda avg QHActiveDefense QHWatchDog symantec mbam HitmanPro emsi BdAgent iobit zoner sophos WO17 gdata zonealarm trend fsagent antimalwareservice webroot spyshelter Lavservice killer 8021x NetPeeker NetLimiter SSTap SSTap-mod GameFirst_V Shadowsocks SSTap SuService drclient C+WClient NetScaning Clmsn BarClientView ProcessSafe iNode GOGO上机 RzxClient CoobarClt nvvsvc NXPRUN LdBoxHeadless LdVBoxHeadless MEmuHeadless NoxVMHandle AndroidEmulator ddemuhandle LDSGameMaster
rem 游戏进程黑白名单/内存大小KB
for /f "tokens=1*" %%i in ('tzutil.exe /g') do set timezone=%%i %%j

for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage 2^>nul') do set Languages=%%i
if defined Languages (
	if !Languages!==0804 set SystemLanguages=简体中文
	if !Languages!==0404 set SystemLanguages=TraditionalChinese
	if !Languages!==0409 set SystemLanguages=English
	if !Languages!==0011 set SystemLanguages=Japanese
	if !Languages!==0012 set SystemLanguages=Korean
	if !Languages!==0007 set SystemLanguages=German
	if !Languages!==040C set SystemLanguages=French
) else (
	echo. >nul 2>nul
)

if defined date (
	set year=%date:~0,4%
	set month=%date:~5,2%
	set day=%date:~8,2%
	set week=%date:~11,6%
	set hour=%time:~0,2%
) else (
	echo. >nul 2>nul
)

rem 获取我的文档路径
for /f "tokens=3,4*" %%i in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal 2^>nul ^|findstr "Personal"') do set mydocdir=%%i %%j %%k
if defined mydocdir (
	set mydocdir=!mydocdir:~0,-2!
) else (
	echo. >nul 2>nul
)

rem 获取正在使用网络的名称
set NNN=0
for /f "tokens=1 delims=," %%i in ('Getmac /v /nh /fo csv ^|findstr /r "Device 暂缺" ^|findstr /r /v "Switch Bluetooth Direct Xbox VMware VirtualBox ZeroTier WSL Loopback 没有硬件"') do (
	set /a NNN+=1
	set networkname!NNN!=%%i
)
rem 判断网络接口优先级
if %NNN% equ 2 (
for /f %%i in ('netsh int ipv4 show interfaces ^|findstr /c:%networkname1%') do set networkname1id=%%i
for /f %%i in ('netsh int ipv4 show interfaces ^|findstr /c:%networkname2%') do set networkname2id=%%i
	if !networkname1id! LSS !networkname2id! (
	echo. >nul 2>nul
	) else (
	set networkname1=%networkname2%
	)
) else (
echo. >nul 2>nul
)

:menu
for /f "tokens=4" %%i in ('powercfg /LIST ^|findstr /v "Active" ^|findstr "*"') do set powerstate=%%i
set powerstate=!powerstate:(=! 2>nul
set powerstate=!powerstate:)=! 2>nul

rem Win10游戏模式
if "%systemver%"=="10" (
for /f "tokens=3" %%i in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gamebar=%%i
if defined gamebar (
if !gamebar!==0x0 set gamebar=游戏模式: 关
if !gamebar!==0x1 set gamebar=游戏模式: 开
) else (
set "gamebar=游戏模式: 开"
)
) else (
echo. >nul
)
cls
echo 系统时间: %time:~0,8%
echo 系统时区: %timezone%
echo 安装语言: %Languages% %SystemLanguages%
echo 电源模式: %powerstate%
if "%systemver%"=="10" (
echo %gamebar%
)
echo.
echo -------------------------------------------------------------------------------
echo                             系统诊断修复工具
echo -------------------------------------------------------------------------------
echo  1、系统环境诊断
echo  2、代理程序诊断
echo  3、系统修复
echo  4、hosts修复工具
echo  5、DNS设置工具
echo  6、网络协议栈重置
echo  7、LSP修复
echo  8、关闭Windows防火墙
echo  9、开启Windows防火墙
echo 10、显示程序列表
echo 11、重置IE
echo 12、卓越性能模式
echo 13、DNS缓存域名记录
echo 14、恢复UAC
echo 15、禁用UAC
echo 16、Xbox平台修复
echo 17、图标变白修复
echo 18、自定义开机选择系统启动项等待时间
echo 19、Windows聚焦壁纸修复
echo 20、Windows电源选项恢复
echo 21、Windows Update更新安装问题（0x80070002/0x80070005）其他故障请使用系统修复
echo 22、taskmgr.exe没有与之关联的程序运行
echo 23、多种exe没有与之关联的程序运行
echo 24、打开可移动磁盘自动运行
echo 25、关闭可移动磁盘自动运行
echo 26、开启系统休眠
echo 27、关闭系统休眠
echo 28、取消Windows激活状态并重置评估期（慎用！会使Windows变为未激活状态！）
echo 29、组策略添加、修复（适用于家庭版添加组策略或者升级专业版后组策略丢失异常等问题）
echo 30、系统盘缓存垃圾清理（使用有风险，会清理日志文件等，请做好备份）
echo -------------------------------------------------------------------------------

set /p a=请选择项目: 
if %a% equ 1 goto envdiag
if %a% equ 2 goto proxydiag
if %a% equ 3 goto systemrepair
if %a% equ 4 goto hsfile
if %a% equ 5 goto dnsfix
if %a% equ 6 goto networkreset
if %a% equ 7 goto lspfix
if %a% equ 8 goto systemfirewalloff
if %a% equ 9 goto systemfirewallon
if %a% equ 10 goto programlist
if %a% equ 11 goto iereset
if %a% equ 12 goto powercfgperf
if %a% equ 13 goto dnscachelist
if %a% equ 14 goto enableuac
if %a% equ 15 goto disableuac
if %a% equ 16 goto xboxfix
if %a% equ 17 goto IconRepair
if %a% equ 18 goto BootTime
if %a% equ 19 goto WinFocus
if %a% equ 20 goto borecover
if %a% equ 21 goto wu0205
if %a% equ 22 goto taskmgrexeErr
if %a% equ 23 goto exeError
if %a% equ 24 goto uautorunon
if %a% equ 25 goto uautorunoff
if %a% equ 26 goto hibernateon
if %a% equ 27 goto hibernateoff
if %a% equ 28 goto deactivate
if %a% equ 29 goto gpeditfix
if %a% equ 30 goto junkclean
echo.
echo 输入错误,请按任意键返回选择菜单. . .
echo.
pause >nul
goto menu

:envdiag
call:systemver
call:tracerttable
call:securitysoft
call:dnsserver 本地DNS服务器: 
call:dnseventlog
call:minidump
call:nicinterface
call:hardware
call:ieproxy
rem call:systemfirewalloff 9
call:hostsdiag
call:ipv6state
echo 本地DNS解析测试 (预计耗时5-10秒): 
ipconfig /flushdns >nul 2>nul
rem 项目6
call:nslookvalue www.people.com.cn www.xinhuanet.com www.cctv.com www.cac.gov.cn www.china.com.cn www.gmw.cn
set /a sum1=sum
rem 项目6
call:nslookvalue www.qstheory.cn www.ce.cn www.cri.cn www.cnr.cn www.youth.cn cn.chinadaily.com.cn
set /a sum2=sum
rem 项目6
call:nslookvalue www.163.com www.sina.com.cn www.qq.com www.taobao.com www.jd.com www.iqiyi.com
set /a sum3=sum
rem 项目6
call:nslookvalue www.baidu.com www.bing.com www.sohu.com
set /a sum4=sum

set /a sumall=sum1+sum2+sum3+sum4
set /a sumavg=sumall*100/24
echo     成功率: %sumavg%%%
echo.
call:systemtime
call:ipaddress 运营商: http://myip.ipip.net/
call:infocollect
echo.
pause
goto menu

:proxydiag
call:securitysoft
call:minidump
call:ieproxy
call:ipv6state
rem call:systemfirewalloff
call:dnsserver 本地DNS服务器: 
call:dnseventlog
call:systemtime
pause
goto menu

:networkreset
taskkill /F /IM VeryKuai.exe >nul 2>nul
echo.
echo 前置修复：重置LSP
netsh winsock reset >nul 2>nul
echo.

goto modeselect

:modeselect
set /p a=请选择重置模式（模式1普通重置，模式2暴力重置）: 
if %a% equ 1 goto regularreset
if %a% equ 2 goto brutereset

:brutereset
echo.
echo 重置TCP/IP协议
rem 获取网络名称和网络IP信息
netsh interface IP Show Address %networkname1% > %temp%\ip.txt 2>nul
for /f "tokens=3" %%i in ('type %temp%\ip.txt 2^>nul ^|findstr "IP"') do set ipsetaddress=%%i
for /f "tokens=2" %%i in ('type %temp%\ip.txt 2^>nul ^|findstr /r "默认网关 Gateway"') do set ipgateway=%%i
for /f "tokens=4" %%i in ('type %temp%\ip.txt 2^>nul ^|findstr /r "子网 Mask"') do set ipmask=%%i

rem 判断正在连接网络dhcp还是手动
netsh interface IP Show Address %networkname1% |findstr /r "否 No" 2>nul >nul && set ipsetmode=yes || set ipsetmode=no
netsh int ipv4 reset >nul 2>nul
netsh int ipv6 reset >nul 2>nul

echo %ipsetaddress% |findstr /b "^[1-9]" |findstr /v [a-z] >nul 2>nul
if %ERRORLEVEL% equ 0 (
if %ipsetmode% equ yes (
netsh interface ip set address %networkname1% static %ipsetaddress% %ipmask:~0,-1% %ipgateway% >nul 2>nul
netsh interface ip set dns %networkname1% static 223.5.5.5 primary >nul 2>nul
netsh interface ip add dns %networkname1% 119.29.29.29 >nul 2>nul
) else (
netsh interface ip set address name=%networkname1% source=dhcp >nul 2>nul
netsh interface ip set dns name=%networkname1% source=dhcp >nul 2>nul
)
) else (
netsh interface ip set address name=%networkname1% source=dhcp >nul 2>nul
netsh interface ip set dns name=%networkname1% source=dhcp >nul 2>nul
)
del /f /q %temp%\ip.txt >nul 2>nul
echo.

echo 禁用Killer服务
sc config "Killer Network Service x64" start= disabled >nul 2>nul
sc config "Killer Network Service" start= disabled >nul 2>nul
sc config "Killer Bandwidth Service" start= disabled >nul 2>nul
sc config "Rivet Bandwidth Service" start= disabled >nul 2>nul

:regularreset
echo.
echo 再次重置LSP
netsh winsock reset >nul 2>nul
netsh winsock reset >nul 2>nul
echo.

echo 重置hosts文件权限并清空
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts

rem 停止并删除驱动服务
set drivername=vkdpi xunyoufilter xunyounpf QeeYouPacket npf uuwfp uupacket networktunnel10_x64 ylwfp TP2CNNetFilter lgdcatcher lgdcatchertdi xfilter savitar netrtp
for %%i in (%drivername%) do (
sc stop %%i >nul 2>nul
sc config %%i start= DISABLED >nul 2>nul
sc delete %%i >nul 2>nul
)
echo.

rem echo Windows系统防火墙: 已还原默认设置并关闭
rem netsh advfirewall reset >nul 2>nul
rem netsh advfirewall set allprofiles state off >nul 2>nul
rem echo.

call:ieproxy

echo 刷新DNS/ARP缓存
ipconfig /flushdns >nul 2>nul
arp -d >nul 2>nul
echo.

echo 正在同步网络时间...
call:systemtimereset
echo.

rem 清理注册表信息
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vkdpi" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ylwfp" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\networktunnel10_x64" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XunYouFilter" /f >nul 2>nul

echo IE组件修复
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo.
set var=0
for /l %%i in (15,-1,1) do echo 正在停止驱动服务: %var%%%i && ping -n 2 127.1>nul

rem 删除驱动文件失败后重命名
del %userprofile%\appData\local\QiYou\processFilter.sys %userprofile%\appData\local\QiYou\npf.sys >nul 2>nul

set driverFile=vkdpi.sys uuwfp.sys uupacket.sys XunYouFilter.sys networktunnel10_x64.sys ylwfp.sys xunyounpf.sys TP2CNNetFilter.sys LgdCatcher.sys LgdCatcherTdi.sys xfilter.sys savitar.sys netrtp.sys
for %%i in (%driverFile%) do (
cd /d %WINDIR%\system32\drivers >nul 2>nul
del /f /q %%i >nul 2>nul
if EXIST %%i (
rename %%i %%i_bak_%random%
) else (
echo. >nul 2>nul
)
)
cd /d %WINDIR%\system32\ >nul 2>nul
echo.
echo 加速器驱动服务停止成功
echo.
echo 操作成功, 请重新启动计算机
mshta vbscript:msgbox("操作成功, 请重新启动计算机",64,"消息"^)(window.close^)

echo.
pause
goto menu

:lspfix
echo.
echo LSP修复
netsh winsock reset
netsh winsock reset
netsh winsock reset
echo.
echo 已修复
echo.
pause
goto menu

:systemrepair
echo.
echo 0、前置服务修复
echo 1、SFC修复（基础修复）
echo 2、DISM检查修复（高级修复）
echo 3、返回主菜单

set /p user_input=请选择一个项目：
if %user_input% equ 0 goto PreSFix
if %user_input% equ 1 goto SFCFIX
if %user_input% equ 2 goto DISMFIX
if %user_input% equ 3 goto menu
echo.
echo 无效的代码，请重新输入。
ping 127.1 -n 2 >nul
goto systemrepair

:PreSFix
echo.
echo 前置修复：诊断策略服务修复
sc config DPS start = AUTO > NUL
sc config diagsvc start = Demand > NUL
sc config WdiServiceHost start = Demand > NUL
sc config WdiSystemHost start = Demand > NUL
sc start DPS >nul
echo 前置服务修复完成
goto systemrepair

:SFCFIX
echo 即将使用SFC工具进行修复，如遇服务异常请先运行前置服务修复
echo 如遇进度条卡死超过10分钟，请退出程序重新运行并选择DISM工具修复
ping 127.1 -n 2 >nul
echo 运行SCANNOW命令修复系统
sfc /scannow
echo SFC基础修复完成
goto menu

:DISMFIX
echo.
echo 即将使用DISM工具进行修复，如遇服务异常请先运行前置服务修复
echo 如遇进度条卡死超过10分钟，请退出程序重新运行DISM工具修复
echo 若出现DISM工具异常或者仍然卡死，请考虑使用原版系统镜像覆盖安装系统修复文件（系统文件遭到DISM工具不可修复的破坏）
ping 127.1 -n 2 >nul
echo 使用DISM工具校验系统文件
Dism /Online /Cleanup-Image /ScanHealth
echo DISM扫描完成

:dismbreak
echo DISM工具扫描完成，请检查结果并选择：
echo 1、可以修复组件存储
echo 2、未检测到组件存储损坏
echo 3、其他问题
set /p host=请根据情况选择项目：
if %host% equ 1 goto DISMRestore
if %host% equ 2 goto DISMFin
if %host% equ 3 goto DISMother
echo.
echo 无效的代码，请重新输入。
ping 127.1 -n 2 >nul
goto dismbreak

:DISMRestore
echo 使用DISM工具修复系统文件
Dism /Online /Cleanup-Image /RestoreHealth
echo DISM修复组件存储完成
goto DISMFin

:DISMother
echo 以下列出几种常见问题：
echo 1. 存储组件已损坏，建议下载原版镜像覆盖安装系统修复
echo 2. 找不到映像源，找不到源文件，先检查网络是否通畅，重新运行
echo 若仍存在问题，请找原版镜像里的install.wim文件挂载，再利用StartComponent参数修复
echo 最推荐的方法是下载原版镜像覆盖安装系统修复
echo 3. 诊断策略服务未运行，请先运行前置修复，如果仍存在问题，建议下载原版镜像文件覆盖安装系统修复
echo 普通用户推荐使用微软官方的MediaCreationTool无损覆盖、安装、升级系统
echo 专业用户可自行寻找iso文件通过多种方式修复系统，不多赘述
ping 127.1 -n 3 >nul
echo 按任意键返回菜单
echo pause
goto menu

:DISMFin
echo DISM修复完成，推荐重启系统
ping 127.1 -n 3 >nul
goto menu

:hsfile
echo.
echo 0、返回主菜单
echo 1、修改hosts
echo 2、修复权限并清空hosts
echo 3、使hosts只读
echo 4、使hosts可写
echo 5、设置指定路径文件拒绝访问
echo 6、设置指定路径文件完全访问

echo.
set /p host=请选择: 
if %host% equ 0 goto host0
if %host% equ 1 goto host1
if %host% equ 2 goto host2
if %host% equ 3 goto host3
if %host% equ 4 goto host4
if %host% equ 5 goto host5
if %host% equ 6 goto host6
echo.
pause
goto menu

:host0
echo.
goto menu
:host1
echo.
rem 清除空行
type %WINDIR%\system32\drivers\etc\hosts 2>nul |findstr "." >> %WINDIR%\system32\drivers\etc\hosts_bak
copy /y %WINDIR%\system32\drivers\etc\hosts_bak %WINDIR%\system32\drivers\etc\hosts >nul
rem 使hosts可写
cacls.exe %WINDIR%\system32\drivers\etc\hosts /e /t /g Administrators:F
rem 删除备份文件
del /s /q %WINDIR%\system32\drivers\etc\hosts_bak >nul 2>nul
start notepad.exe %WINDIR%\system32\drivers\etc\hosts
echo 已启动记事本，hosts修改完成后请按任意键继续
echo.
pause
ipconfig /flushdns >nul 2>nul
goto menu
:host2
echo 修复权限并清空hosts
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
echo.
pause
goto menu
:host3
echo.
rem 使hosts只读
echo 按Y使hosts只读: 
cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:R
echo.
pause
goto menu
:host4
echo.
rem 使hosts可写
echo 按Y使hosts可写: 
cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F
cd. > %WINDIR%\system32\drivers\etc\hosts 2>nul
echo.
pause
goto menu
:host5
echo.
set /p files=请输入文件完整路径: 
cacls.exe "%files%" /e /t /p Administrators:N
echo 设置指定路径文件拒绝访问
echo.
pause
goto menu
:host6
echo.
set /p files=请输入文件完整路径: 
cacls.exe "%files%" /e /t /g Administrators:F
echo 设置指定路径文件完全访问
echo.
pause
goto menu

:iereset
echo.
del /f /q "%temp%\mb" >nul 2>nul
echo Miniblink缓存清理成功
Rundll32 InetCpl.cpl,ClearMyTracksByProcess 255
echo IE缓存清理成功
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
echo IE已重置
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo IE组件已修复
echo.
pause
goto menu

:dnsfix
echo.
echo 0、返回主菜单
echo 1、首选: 119.29.29.29    备用: 8.8.8.8
echo 2、首选: 223.5.5.5       备用: 8.8.8.8
echo 3、首选: 114.114.114.114 备用: 8.8.8.8
echo 4、首选: 180.76.76.76    备用: 8.8.8.8
echo 5、首选: 8.8.8.8         备用: 223.5.5.5
echo 6、首选: 9.9.9.9         备用: 223.5.5.5(防运营商劫持^)
echo 7、首选: 4.2.2.2         备用: 223.5.5.5
echo 8、移动: 101.226.4.6     备用: 223.5.5.5
echo 9、首选: 80.80.80.80     备用: 223.5.5.5(防运营商劫持^)
echo.
set /p dns=请选择: 
if %dns% equ 0 goto dnsip0
if %dns% equ 1 goto dnsip1
if %dns% equ 2 goto dnsip2
if %dns% equ 3 goto dnsip3
if %dns% equ 4 goto dnsip4
if %dns% equ 5 goto dnsip5
if %dns% equ 6 goto dnsip6
if %dns% equ 7 goto dnsip7
if %dns% equ 8 goto dnsip8
if %dns% equ 9 goto dnsip9
:dnsip0
goto menu
:dnsip1
call:dnssetting 119.29.29.29 8.8.8.8
pause
goto menu
:dnsip2
call:dnssetting 223.5.5.5 8.8.8.8
pause
goto menu
:dnsip3
call:dnssetting 114.114.114.114 8.8.8.8
nslookup whether.114dns.com 114.114.114.114 2>nul |findstr 127.0.0 >nul
If %ERRORLEVEL% equ 0 (
echo    警告: ISP劫持了114DNS
echo.
) else (
echo. >nul 2>nul
)
pause
goto menu
:dnsip4
call:dnssetting 180.76.76.76 8.8.8.8
pause
goto menu
:dnsip5
call:dnssetting 8.8.8.8 223.5.5.5
pause
goto menu
:dnsip6
call:dnssetting 9.9.9.9 223.5.5.5
pause
goto menu
:dnsip7
call:dnssetting 4.2.2.2 223.5.5.5
pause
goto menu
:dnsip8
call:dnssetting 101.226.4.6 223.5.5.5
pause
goto menu
:dnsip9
call:dnssetting 80.80.80.80 223.5.5.5
pause
goto menu

:dnssetting
netsh interface ip set dnsservers %networkname1% static %1 >nul 2>nul
netsh interface ip add dnsservers %networkname1% %2 >nul 2>nul
echo.
call:dnsserver DNS已设置成功: 
ipconfig /flushdns >nul 2>nul
echo DNS缓存已刷新
echo.
goto:eof

:programlist
for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k
for /f "tokens=3,4*" %%i in ('reg query HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k
for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k
pause
goto menu

:powercfgperf
if "%systemver%"=="10" (
goto powercfgwin10
) else (
goto powercfgwin7
)
:powercfgwin10
powercfg /LIST |findstr "卓越性能"
if "%errorlevel%"=="1" (
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
) else (
echo. >nul 2>nul
)
for /f "tokens=3" %%i in ('powercfg /LIST ^|findstr "卓越性能"') do set powerguid=%%i
powercfg -s %powerguid%
echo.
goto powerlabelexit
:powercfgwin7
for /f "tokens=3" %%i in ('powercfg /LIST ^|findstr "高性能"') do set powerguid=%%i
powercfg -s %powerguid%
echo.
echo 电源管理: 高性能(设置成功)
echo.
:powerlabelexit
pause
goto menu

:dnscachelist
echo.
echo DNS缓存查询(近30s^): 
set dnsexclude=adguard sougou 360safe .cm.steampowered .cm.wmsjsteam. twitch media : images .arpa facebook pcs-sdk qq-web mousegesturesapi fanyi adtidy url.cn xunyou tyjsq .360. acfun aixifan gitee wps qhmsg azureedge sina weibo kdocs office wyjsq qy.net .ngaa. ithome img qq.com ppstream msedge smtcdns qiyi proxy-cnc xboxlive 321fenx nvidia .yy. gting map. youku ipip ip138 bilibili hdslb. microsoft toutiao news18a 126.net 163.com 127.net netease ixigua pstatp snssdk .msn. h5. googletagmanager msedge.api bdimg onedrive .live. zyx.qq digicert qzone teamviewer qun.qq lamyu qpic sobot qlogo idqqimg twitter youtube iqiyi cibntv bilivideo tdnsv6 shifen report bing bdstatic baidu xunyou taobao windows twitter vkjsq verykuai
if "%systemver%"=="10" (
powershell -executionpolicy bypass Get-DnsClientCache ^|select Entry,Data ^|Sort-Object -Property Entry -unique |findstr /v /i "%dnsexclude%"
) else (
for /f "tokens=1" %%i in ('ipconfig /displaydns ^|findstr /v /I "%dnsexclude%" ^|findstr /v ":" ^|findstr ".com .cn .org .net .info .com.cn .top .vip .shop .jp .xyz .wang .win .pub .ru .tw .eu"') do echo   %%i
)
pause
goto menu

:securitysoft
echo 安全/拨号/代理/模拟器/限速软件: && for /f "tokens=1,10 delims=," %%i in ('tasklist /v /fo csv ^|findstr /I "%securitysoftwareprocess%"') do echo    %%i 名称:%%j

rem 数据诊断
tasklist /v /fo csv |findstr /I "2345" >nul 2>nul
if %ERRORLEVEL% equ 0 (
	set softwareresult2345=存在2345全家桶系列
) else (
	echo. >nul 2>nul
)

echo.
goto:eof

:minidump
echo Minidump目录: && dir %WINDIR%\Minidump |findstr 文件
echo.
goto:eof

:ipv6state
wmic nicConfig where "IPEnabled='True'" get IPAddress |find ":" |findstr /i "[0-9][a-f]*: [a-f][0-9]*:" >nul
if "%errorlevel%"=="0" (
echo IPv6协议: 开启中 (已设置IPv4优先^)
for /f "tokens=1,2,3" %%i in ('netsh interface ipv6 show prefixpolicies ^|findstr [0-9]') do netsh interface ipv6 set prefixpolicy %%k %%i %%j >nul 2>nul
netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 100 4 >nul 2>nul
) else (
echo IPv6协议: 已关闭
)
echo.
goto:eof

:ieproxy
rem 读取代理配置信息
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2>nul >nul
if %ERRORLEVEL%==0 (
for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2^>nul') do set autoconfigurl=%%i
) else (
set autoconfigurl=无
)

rem 代理配置状态
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2>nul >nul
if %ERRORLEVEL% equ 0 (
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /f >nul 2>nul
	reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2>nul >nul
	if !ERRORLEVEL! equ 0 (
		set autoconfigurlresult=本地代理配置异常: 修复失败
	) else (
		set autoconfigurlresult=本地代理配置异常: 修复成功
	)
) else (
	echo. >nul 2>nul
)

for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do set proxyenable=%%i
if DEFINED proxyenable (
if %proxyenable%==0x0 set proxyenable=关
if %proxyenable%==0x1 set proxyenable=开
) else (
echo. >nul 2>nul
)

for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2^>nul') do set proxyserver=%%i
rem 截取变量最后10个字符串
echo 代理配置: AutoConfigURL: %autoconfigurl:~0,20% %autoconfigurlresult%
echo    代理状态: %proxyenable%
if not "!proxyserver!" == "" (
echo    地址/端口: %proxyserver%
)
set autoconfigurl=<nul
echo.

if "%systemver%"=="10" (
rem 禁用自动检测设置
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" /v DefaultConnectionSettings /t REG_BINARY /d 4600000000 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" /v SavedLegacySettings /t REG_BINARY /d 4600000000 /f >nul 2>nul
) else (
echo. >nul
)
rem 禁用自动配置URL
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /f >nul 2>nul

rem 手动代理设置
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f >nul 2>nul
goto:eof

:systemfirewalloff
netsh advfirewall set allprofiles state off >nul 2>nul
echo Windows系统防火墙: 已关闭
echo.
goto:eof

:systemfirewallon
netsh advfirewall set allprofiles state on >nul 2>nul
echo Windows系统防火墙: 已开启
echo.
goto:eof

:systemtime
for /f tokens^=4^ delims^=^" %%i in ('curl -s curl -s http://quan.suning.com/getSysTime.do') do (
	set timeonline=%%i
	set timeonline=!timeonline:-=/!
	for /f "tokens=1" %%a in ('echo !timeonline!') do (
		set dateol=%%a
		set dateol=!dateol:/=!
	)
	echo 本地系统时间: %date:~0,10% %time:~0,8%  在线北京时间: !timeonline!
	echo.
)

rem 数据诊断
echo %date% |findstr /c:- >nul 2>nul
if %ERRORLEVEL% equ 0 (set datedelims=-) else ( echo. >nul 2>nul )
echo %date% |findstr /c:. >nul 2>nul
if %ERRORLEVEL% equ 0 (set datedelims=.) else (set datedelims=/)
for /f "tokens=1" %%i in ('echo %date%') do (
for /f "tokens=1,2,3 delims=%datedelims%" %%a in ('echo %%i') do (
rem 年/月/日, 日/月/年, 月/日/年
set date1=%%a%%b%%c
set date2=%%c%%b%%a
set date3=%%b%%c%%a
)
)
if DEFINED dateol (
if "!dateol!" equ "!date1!" (
	echo. >nul 2>nul
) else (
	if "!dateol!" equ "!date2!" (
	echo. >nul 2>nul
	) else (
		if "!dateol!" equ "!date3!" (
			echo. >nul 2>nul
		) else (
			set dateresult=系统日期异常%date% 
		)
	)
)
) else (
echo. >nul 2>nul
)
goto:eof

:systemtimereset
net stop w32time 2>nul >nul
w32tm /unregister 2>nul >nul
w32tm /register 2>nul >nul
net start w32time 2>nul >nul
w32tm /resync 2>nul >nul
goto:eof

:ipaddress
if "%systemver%"=="10" (
for /f "tokens=2,3 delims=：" %%i in ('powershell -executionpolicy bypass Invoke-RestMethod %2 -TimeoutSec 15 2^>nul') do (
echo %1 %%i: %%j
for /f "tokens=2,3*" %%a in ('echo %%j') do set MyNetworkresult=%%a%%b%%c
)
goto:win10exip
) else (
goto:win7exip
)
:win7exip
set "URL=%2"
(echo Set objDOM = WScript.GetObject("%URL%"^)
echo Do Until objDOM.ReadyState = "complete"
echo WScript.Sleep 100
echo Loop
echo WScript.Echo objDOM.DocumentElement.OuterText
)>%temp%\download.vbs
for /f "delims=" %%i in ('cscript //nologo //e:vbscript %temp%\download.vbs 2^>nul') do (
echo %1 %%i
for /f "tokens=3 delims=: " %%a in ('echo %%i') do (
for /f "tokens=2,3*" %%o in ('echo %%a') do set MyNetworkresult=%%o%%p%%q
)
)
echo.
:win10exip
goto:eof


:systemver
ping -n 1 /f -l 1372 www.baidu.com |findstr DF >nul
if "%errorlevel%"=="0" (
set mturesult=警告: 上层设备MTU小于1400
) else (
set mturesult=
)
for /f "tokens=3" %%i in ('netsh int ip show interfaces ^|findstr /r "\<connected" ^|findstr /r "以太网 本地连接"') do set mtuvalue=%%i
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ReleaseId 2^>nul') do set systemversion=%%i
for /f "delims=." %%i in ('wmic datafile where name^="C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE" get Version 2^>nul ^|findstr /i /c:"."') do set ieversion=%%i

echo.
for /f "tokens=1,*" %%i in ('ver') do echo %%i %%j %systemversion%
echo 计算机名: %COMPUTERNAME%
echo IE浏览器: %ieversion%
echo 网卡MTU: %mtuvalue%
if not "!mturesult!" == "" (
	echo %mturesult%
)

rem 数据诊断

if DEFINED systemversion (
	if "%systemversion%" GTR "1809" (
		echo. >nul 2>nul
	) else (
		set systemversionresult=Win10系统版本%systemversion%过低, 建议升级
		echo !systemversionresult!
	)
) else (
echo. >nul 2>nul
)
echo.
goto:eof

:tracerttable
rem IPV4路由行数统计
for /f %%i in ('route print -4 300.300.300.300 ^|find /c /v ""') do set routeexclude=%%i
for /f %%i in ('route print -4 ^|find /c /v ""') do set routeall=%%i
set /a routeall=%routeall%-%routeexclude%-2
rem vpn网关
for /f "tokens=4" %%i in ('route print 10.33.0.0 ^|findstr "10.33.0.0"') do set vpngateway=%%i

rem 数据诊断
if DEFINED vpngateway (
	if %routeall% GEQ 10 ( echo. >nul 2>nul ) else ( set routeresult=模式B路由表异常 )
) else (
	echo. >nul 2>nul
)

echo 路由跟踪结果
echo    IPv4路由表统计: %routeall%(行)
if not "!vpngateway!" == "" (
	echo    模式B网关: %vpngateway%
)
set vpngateway=<nul
if "%powershellver%" GEQ "3" (
for /f "delims==" %%i in ('tracert -d -w 20 -h 5 114.114.114.114 ^|findstr ^[1-9] ^|findstr /v "114.114.114.114" ^|findstr /i "%ipv4ipv6%"') do (
set tracestr=%%i
set tracestr=!tracestr:ms=!
set tracestr=!tracestr:^<=!
set tracestr=!tracestr:毫秒=!
for /f "tokens=1,2,3,4,5" %%i in ('echo !tracestr!') do (
for /f %%a in ('powershell -executionpolicy bypass Invoke-RestMethod http://whois.pconline.com.cn/ip.jsp?ip^=%%m -TimeoutSec 15 2^>nul') do set IPquyu=%%a
echo  %%i   %%j ms   %%k ms   %%l ms    %%m !IPquyu! |%temp%\mtee /a /+ %temp%\traceroute.txt
)
)
) else (
for /f "tokens=*" %%i in ('tracert -w 100 -d -h 5 114.114.114.114 ^|findstr ^[1-9] ^|findstr /v "114.114.114.114" ^|findstr /i "%ipv4ipv6%"') do echo    %%i |%temp%\mtee /a /+ %temp%\traceroute.txt
)

rem 诊断数据
type %temp%\traceroute.txt 2>nul |findstr /N "." |findstr "\<2:" |findstr "172.1[0-9]\. 10.[0-9]\. 10.10\." >nul 2>nul
if %ERRORLEVEL% equ 0 (
	set tracertresult=多重内网
) else (
	type %temp%\traceroute.txt 2>nul |findstr /N "." |findstr "\<3:" |findstr "192.168\. 172.1[0-9]\. 10.[0-9]\. 10.10\." >nul 2>nul
	if !ERRORLEVEL! equ 0 (
		set tracertresult=多重内网
	) else (
		echo. >nul 2>nul
	)
)
del /f /q %temp%\traceroute.txt >nul 2>nul

echo.
goto:eof

:nicinterface
echo 网卡: 
rem 网卡列表
	for /f "tokens=1,2,4 delims=," %%i in ('Getmac /v /nh /fo csv') do (
		set networkstatus=%%k
		echo    %%i %%j  !networkstatus:~1,7! |%temp%\mtee /a /+ %temp%\networkadapter.txt
	)

netsh wlan show Interfaces |findstr /R "\<SSID" >nul
if "%errorlevel%"=="0" (

	rem 获取无线WIFI字段信息
	set WF=0
	for /f "tokens=2 delims=:" %%i in ('netsh wlan show Interfaces') do (
		for /f "tokens=1" %%a in ('echo %%i') do (
		set /a WF+=1
		set wifi!WF!=%%a
		)
	)

	echo    WiFi:!wifi7!   状态:!wifi6!   信道:!wifi14!   信号:!wifi17!   速度:!wifi16!Mbps

	rem WIFI网络质量判断
	if "!wifi17:~0,-1!" LEQ "95" ( set wifiresult1=WIFI信号不稳定 ) else ( echo. >nul 2>nul )
	if "!wifi14!" GEQ "36" ( set wifiresult2=当前5G的WIFI,网络游戏建议使用2.4G,有线最佳 ) else ( echo. >nul 2>nul )

	rem wifi驱动信息
	for /f "tokens=2,4 delims=," %%i in ('DRIVERQUERY /fo csv ^|findstr "Wireless" ^|findstr "[0-9]/[0-9]/[0-9]"') do echo    %%i 驱动日期%%j

) else (
	echo >nul 2>nul
)

rem 统计网卡个数
	call:textlines %temp%\networkadapter.txt -100
	if "!textlinesnum!" GEQ "2" (
			type %temp%\networkadapter.txt 2>nul |findstr /i "tap SangforVNIC yltap" >nul 2>nul
			if !ERRORLEVEL! equ 0 (
				set networkcardresult1=网卡数量:!textlinesnum!,存在其它加速器VPN设备虚拟网卡
			) else (
				echo. >nul 2>nul
			)

			type %temp%\networkadapter.txt 2>nul |findstr /i "vmware virtualbox" >nul 2>nul
			if !ERRORLEVEL! equ 0 (
				set networkcardresult2=存在虚拟机网卡
			) else (
				echo. >nul 2>nul
			)

	) else (
		echo. >nul 2>nul
	)

	del /f /q %temp%\networkadapter.txt >nul 2>nul

echo.
goto:eof

:hardware
echo 硬件配置信息: 
for /f "tokens=*" %%i in ('wmic cpu get name ^|findstr /v "Name" ^|findstr "[^\S]"') do echo    CPU:  %%i
for /f %%i in ('wmic os get TotalVisibleMemorySize ^|findstr [0-9]') do set /a ram=%%i/1024
for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualram=%%i/1024
echo    内存: %ram% MB; 当前分配虚拟内存: %VirtualRAM% MB
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get AdapterRAM^,Name /value ^|findstr Name') do set vganame=%%i
echo    显卡: %vganame%
for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do echo    分辨率: %%j*%%i
rem 应用程序错误信息
if "%systemver%"=="10" (
for /f "tokens=1,2,4* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName Application -EntryType Error -Newest 2 -After %year%-%month%-%day% -Source 'Application Error' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo    %%i %%j 错误: %%k %%l
) else (
echo. >nul 2>nul
)

rem 数据诊断
if DEFINED ram (
	if %ram% LSS 8000 (
		set /a ram=%ram%/1000
		set ramresult=系统内存!ram!G, 建议升级
		echo    !ramresult!
	) else (
		echo. >nul 2>nul
	)
) else (
echo. >nul 2>nul
)

echo.
goto:eof

:dnsserver
for /f "tokens=1-2" %%i in ('wmic nicConfig where "IPEnabled='True'" get DNSServerSearchOrder ^|findstr "{"') do set dnsserverip=%%i %%j
set dnsserverip=%dnsserverip:"=%
set dnsserverip=%dnsserverip:{=%
set dnsserverip=%dnsserverip:}=%

nslookup whether.114dns.com 114.114.114.114 2>nul |findstr 127.0.0 >nul
If %ERRORLEVEL% equ 0 (
set dnsresult=运营商可能DNS劫持
echo.
) else (
echo. >nul 2>nul
)

echo %1 %dnsserverip% %dnsresult%
goto:eof

:dnseventlog
if "%systemver%"=="10" (
for /f "tokens=1,2,4,6* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName System -EntryType Warning -Newest 3 -After %year%-%month%-%day% -Source 'Microsoft-Windows-DNS-Client' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo    %%i %%j %%k响应域名: %%l %%m
) else (
echo. >nul 2>nul
)
echo.
goto:eof

:hostsdiag
rem hosts文件最后修改时间
IF EXIST %WINDIR%\system32\drivers\etc\hosts (
cd /d %WINDIR%\system32\drivers\etc >nul 2>nul
for /f "tokens=*" %%i in ('forfiles /M hosts /C "cmd /c echo @fdate @ftime" 2^>nul') do set filetime=%%i
rem 统计hosts非注释行数
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|findstr "." ^|find /c /v ""') do set hostsnumber=%%i
rem #UHE工具行
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|find /c "#UHE_"') do set hostsnumberUHE=%%i
rem 统计127.0.0行
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|find /c "127.0.0"') do set hostsnumber127=%%i
rem 统计155.89行
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|find /c "155.89"') do set hostsnumber155=%%i
echo hosts修改时间:    !filetime!
echo     有效解析条目总数: !hostsnumber!(行^)
echo     带UHE注释条目数:  !hostsnumberUHE!(行^)
echo     127开头条目数:    !hostsnumber127!(行^)
echo     155开头条目数:    !hostsnumber155!(行^)
) else (
echo hosts文件: 不存在
)
echo.

rem 数据诊断
for /f %%i in ("%WINDIR%\system32\drivers\etc\hosts") do set hostsize1=%%~zi
echo. >> %WINDIR%\system32\drivers\etc\hosts 2>nul
for /f %%i in ("%WINDIR%\system32\drivers\etc\hosts") do set hostsize2=%%~zi
if %hostsize1% equ %hostsize2% (
set hostsresult=hosts文件权限异常
) else (
echo. >nul 2>nul
)
goto:eof

:disableuac
echo.
echo 彻底禁用UAC
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d "3" /f
echo.
echo 请重新启动计算机
echo.
pause
goto menu

:enableuac
echo.
echo 恢复UAC
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d "5" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d "3" /f
echo.
echo 请重新启动计算机
echo.
pause
goto menu


:xboxfix
echo.
echo 修复Xbox多人游戏
echo.
echo 临时禁用Teredo隧道
netsh int teredo set state disable > NUL

echo 禁用华硕GameFirst(建议卸载！)
sc config AsusGameFirstService start= DISABLED > NUL
sc stop AsusGameFirstService > NUL

echo 暂时停止系统服务
sc stop XblAuthManager > NUL
sc stop XboxNetApiSvc > NUL
sc stop iphlpsvc > NUL
sc stop upnphost > NUL
sc stop SSDPSRV > NUL
sc stop FDResPub > NUL

echo 修复系统时间同步服务
sc stop w32time > NUL
w32tm /unregister > NUL
w32tm /register > NUL
sc start w32time > NUL

echo 重置Windows防火墙策略
netsh advfirewall reset > NUL
netsh advfirewall set allprofiles state on > NUL
echo 排除冲突的Windows防火墙策略
netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound > NUL
netsh advfirewall firewall set rule name="4jxr4b3r3du76ina39a98x8k2" new enable=no > NUL

echo 同步系统时间
w32tm /resync /force > NUL

echo 修复服务自启项
sc config IKEEXT start= AUTO > NUL
sc config FDResPub start= AUTO > NUL
sc config SSDPSRV start= AUTO > NUL
sc config upnphost start= AUTO > NUL
sc config XblAuthManager start= AUTO > NUL
sc config XboxNetApiSvc start= AUTO > NUL

echo 重置系统IPv6设置
netsh int ipv6 reset
reg delete HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\TCPIP\v6Transition /v Teredo_DefaultQualified /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v Force_Tunneling /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v Teredo_DefaultQualified /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v Teredo_ClientPort /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v Teredo_RefreshRate /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v Teredo_ServerName /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v Teredo_State /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v 6to4_RouterNameResolutionInterval /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v 6to4_RouterName /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v 6to4_State /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v ISATAP_RouterName /f > NUL
reg delete HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\TCPIP\v6Transition /v ISATAP_State /f > NUL
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" /v DisabledComponents /t REG_DWORD /d 0x20 /f > NUL

echo 启动系统服务
sc start IKEEXT > NUL
sc start FDResPub > NUL
sc start SSDPSRV > NUL
sc start upnphost > NUL

echo 设置IPv6前缀优先级
netsh int ipv6 set prefix ::1/128 50 0 > NUL
netsh int ipv6 set prefix ::/0 40 1 > NUL
netsh int ipv6 set prefix 2002::/16 30 2 > NUL
netsh int ipv6 set prefix ::/96 20 3 > NUL
netsh int ipv6 set prefix ::ffff:0:0/96 100 4 > NUL

echo 启动IP Helper服务
sc start iphlpsvc > NUL

echo 配置Teredo隧道参数
route delete ::/0 > NUL
netsh int teredo set state type=default > NUL
netsh int teredo set state enterpriseclient teredo.remlab.net 20 0 > NUL
netsh int ipv6 add route ::/0 "Teredo Tunneling Pseudo-Interface" > NUL

echo 启动Xbox网络服务
sc start XboxNetApiSvc > NUL
sc start XblAuthManager > NUL

echo 修复工具运行结束！
echo Teredo配置状态：
netsh int teredo show state
echo.
echo 已修复Xbox多人游戏 请重启系统后尝试联机
pause
exit

:nslookvalue
ping -n 1 -w 10 %1 |findstr "[" >nul
if "%errorlevel%"=="0" (set a1=1) else (set a1=0)

ping -n 1 -w 10 %2 |findstr "[" >nul
if "%errorlevel%"=="0" (set a2=1) else (set a2=0)

ping -n 1 -w 10 %3 |findstr "[" >nul
if "%errorlevel%"=="0" (set a3=1) else (set a3=0)

ping -n 1 -w 10 %4 |findstr "[" >nul
if "%errorlevel%"=="0" (set a4=1) else (set a4=0)

ping -n 1 -w 10 %5 |findstr "[" >nul
if "%errorlevel%"=="0" (set a5=1) else (set a5=0)

ping -n 1 -w 10 %6 |findstr "[" >nul
if "%errorlevel%"=="0" (set a6=1) else (set a6=0)

set /a sum=a1+a2+a3+a4+a5+a6
goto:eof

:infocollect
rem Win10系统版本
if DEFINED systemversionresult ( echo *%systemversionresult% >> %temp%\infocollect.txt 2>nul & set systemversionresult=<nul ) else ( echo. >nul 2>nul )

rem 内存大小
if DEFINED ramresult ( echo *%ramresult% >> %temp%\infocollect.txt 2>nul ) else ( echo. >nul 2>nul )

rem lsp相关
if DEFINED lspresult ( echo *%lspresult% >> %temp%\infocollect.txt 2>nul & set lspresult=<nul ) else ( echo. >nul 2>nul )
if DEFINED wegamelsp ( echo *%wegamelsp% >> %temp%\infocollect.txt 2>nul & set wegamelsp=<nul ) else ( echo. >nul 2>nul )

rem 多重内网
if DEFINED tracertresult ( echo *%tracertresult% >> %temp%\infocollect.txt 2>nul & set tracertresult=<nul ) else ( echo. >nul 2>nul )

rem 路由表
if DEFINED routeresult ( echo *%routeresult% >> %temp%\infocollect.txt 2>nul & set routeresult=<nul ) else ( echo. >nul 2>nul )

rem 系统时间
if DEFINED dateresult ( echo *%dateresult% >> %temp%\infocollect.txt 2>nul & set dateresult=<nul ) else ( echo. >nul 2>nul )

rem 2345提示
if DEFINED softwareresult2345 ( echo *%softwareresult2345% >> %temp%\infocollect.txt 2>nul & set softwareresult2345=<nul ) else ( echo. >nul 2>nul )

rem 运营商dns劫持
if DEFINED dnsresult ( echo *%dnsresult% >> %temp%\infocollect.txt 2>nul & set dnsresult=<nul ) else ( echo. >nul 2>nul )

rem hosts判断
if DEFINED hostsresult ( echo *%hostsresult% >> %temp%\infocollect.txt 2>nul & set hostsresult=<nul ) else ( echo. >nul 2>nul )

rem AutoConfigURL判断
if DEFINED autoconfigurlresult ( echo *%autoconfigurlresult% >> %temp%\infocollect.txt 2>nul & set autoconfigurlresult=<nul ) else ( echo. >nul 2>nul )

rem WIFI信号信道
if DEFINED wifiresult1 ( echo *%wifiresult1% >> %temp%\infocollect.txt 2>nul & set wifiresult1=<nul ) else ( echo. >nul 2>nul )
if DEFINED wifiresult2 ( echo *%wifiresult2% >> %temp%\infocollect.txt 2>nul & set wifiresult2=<nul ) else ( echo. >nul 2>nul )
if DEFINED networkcardresult1 ( echo *%networkcardresult1% >> %temp%\infocollect.txt 2>nul & set networkcardresult1=<nul ) else ( echo. >nul 2>nul )
if DEFINED networkcardresult2 ( echo *%networkcardresult2% >> %temp%\infocollect.txt 2>nul & set networkcardresult2=<nul ) else ( echo. >nul 2>nul )

type %temp%\netdiag.txt 2>nul >> %temp%\infocollect.txt 2>nul
type %temp%\vkgameprocessip.txt 2>nul >> %temp%\infocollect.txt 2>nul
del /f /q %temp%\netdiag.txt >nul 2>nul

rem 游戏数据信息备份桌面
	if EXIST %temp%\infocollect.txt (
		taskkill /F /FI "WINDOWTITLE eq netdiag.txt*" >nul 2>nul
		echo F| xcopy "%temp%\infocollect.txt" "%userprofile%\desktop\NetDiagLog\netdiag.txt" /s /c /y /i >nul 2>nul
	) else (
		echo. >nul 2>nul
	)
goto:eof

:systempath
rem 检查系统环境变量
for /f "tokens=3" %%i in ('%systemroot%\system32\reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /s ^|%systemroot%\system32\findstr "\<Path"') do set syspath=%%i
if defined syspath (
if defined %%1 (
%systemroot%\system32\reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "!!syspath!!;%1" /f >nul 2>nul
set PATH=!syspath!;%1
)
) else (
%systemroot%\system32\reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32;%%SystemRoot%%;%%SystemRoot%%\system32\Wbem;%%SystemRoot%%\system32\WindowsPowerShell\v1.0;%%SystemRoot%%\system32\OpenSSH" /f >nul 2>nul
set PATH=%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\system32\Wbem;%SystemRoot%\system32\WindowsPowerShell\v1.0;%SystemRoot%\system32\OpenSSH
)
echo 已修复用户环境变量, 请重启系统后重新打开检查工具
pause
exit
goto:eof

:textlines
rem 获取文件中行数,参数1文本路径 参数2, 显示最后n行, n为数字, n可以为负值, 网卡个数变量textlinesnum
set LINES=0
for /f "delims==" %%I in ('type %1 2^>nul') do ( set /a LINES=LINES+1 & set textlinesnum=!LINES! )
rem 显示行数
set /a LINES=LINES-%2
more +!LINES! < %1 2>nul
goto:eof

:IconRepair
echo 开始修复图标变白问题
ping 127.1 -n 3 >nul
echo 暂时结束资源管理器进程
taskkill /im explorer.exe /f
echo 清理图标缓存
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
echo 重启资源管理器
start explorer.exe
echo 修复完成，按任意键完成修复
echo pause
goto menu

:BootTime
echo 输入秒数后回车确认，请勿输入字母！！！
set /p usertime=设定开机启动项选择的等待时间（秒）：
bcdedit /timeout %usertime%
echo 已设置开机启动项选择等待时间为%usertime%秒
echo 按任意键返回菜单
pause
goto menu

:WinFocus
echo.
echo 开始修复Windows聚焦异常问题
echo 清理缓存
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings"
echo 重新部署程序包
PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage *ContentDeliveryManager*).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
echo 修复完成，请重启电脑，保持网络通畅，耐心等待10分钟。（建议白天修复，夜间聚焦推送不稳定）
pause
goto menu

:borecover
echo 开始恢复电源选项设置（部分机型可能无效，例如Surface）
echo 恢复节能模式
powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
echo 恢复平衡模式
powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
echo 恢复高性能模式
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo 恢复卓越性能模式（仅限于Win10/11专业版以上）
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

echo 设置电源选项为高性能
powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo 电源选项恢复完成
pause
goto menu

:wu0205
SC config wuauserv start= auto
SC config bits start= auto
SC config cryptsvc start= auto
SC config trustedinstaller start= auto
SC config wuauserv type=share
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
rd /s /q C:\Windows\SoftwareDistribution.old
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
echo 修复完成，请重启电脑重试更新
pause
goto menu

:taskmgrexeErr
echo 开始修复taskmgr.exe关联问题
echo 重建注册表值
reg add "HKEY_CLASSES_ROOT\Folder\shell\open" /v "MultiSelectModel" /t REG_SZ >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\open\command" /ve /t REG_EXPAND_SZ /d "%SystemRoot%\Explorer.exe" >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\open\command" /v "DelegateExecute" /t REG_SZ >nul
echo 修复完成，请重启电脑
pause
goto menu

:exeError
echo 开始修复exe关联问题
echo 重建注册表值
reg add "HKEY_CLASSES_ROOT\.exe" /ve /t REG_SZ /d exefile
reg add "HKEY_CLASSES_ROOT\.exe" /v "Content Type" /t REG_SZ /d "application/x-msdownload"
reg add "HKEY_CLASSES_ROOT\.exe\PersistentHandler" /ve /t REG_SZ /d "{098f2470-bae0-11cd-b579-08002b30bfeb}"
echo 重建exe关联
assoc .exe=exefile
echo 修复完成，请重启电脑
pause
goto menu

:uautorunon
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 00000095
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 00000095
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\cdrom" /v Autorun /t REG_DWORD /d 00000001
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom" /v Autorun /t REG_DWORD /d 00000001
echo 设置完成，可移动设备自动运行已开启
pause
goto menu



:uautorunoff
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 000000ff
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 000000ff
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\cdrom" /v Autorun /t REG_DWORD /d 00000000
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom" /v Autorun /t REG_DWORD /d 00000000
echo 设置完成，可移动设备自动运行已关闭
pause
goto menu

:hibernateon
powercfg -h on
echo 系统休眠已开启
pause
goto menu

:hibernateoff
powercfg -h off
echo 系统休眠已关闭
pause
goto menu

:deactivate
echo 警告：使用此功能将会导致Windows变为未激活状态！
echo 一般情况下，此功能仅在出现激活异常或者密钥异常的情况下使用
echo 如果您不知道您在做什么，请退出程序或者输入其他并确认回到主页面
echo 如果您明白并能承担操作后果，请在下方输入Confirm来继续操作（区分大小写）
ping 127.1 -n 2 >nul
set /p input=请确认您的操作（区分大小写）：
if %input% equ Confirm goto deaconfirm
echo 确认操作异常，已取消操作
pause
goto menu
:deaconfirm
echo 卸载Windows密钥
slmgr /upk
echo 重置Windows评估期
slmgr /rearm
echo 重置完成，Windows已变为未激活状态，请重启计算机
pause
goto menu

:gpeditfix
echo 开始修复组策略问题
pushd "%~dp0"
dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt
dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt
for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"C:\Windows\servicing\Packages\%%i"
echo 完成修复，请重启计算机
pause
goto menu

:junkclean
echo 开始垃圾清理
echo 系统盘扫描
echo.

echo 清理自动更新补丁日志
del /f /s /q "%windir%\SoftwareDistribution\DataStore\Logs\*.log"
del /f /s /q "%windir%\SoftwareDistribution\DataStore\Logs\*.jrs"
echo.

echo 清理错误报告
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*.wer"
del /f /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*.*"
echo.

echo 清理Windows Search日志文件
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jcp"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jtx"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jr"
echo.

echo 清理IIS日志文件
del /f /s /q "%windir%\System32\LogFiles\Fax\Incoming\*.*"
del /f /s /q "%windir%\System32\LogFiles\Fax\outcoming\*.*"
del /f /s /q "%windir%\System32\LogFiles\setupcln\setupact.log"
del /f /s /q "%windir%\System32\LogFiles\setupcln\setuperr.log"
echo.

echo 清理Windows设置日志文件
del /f /s /q "%windir%\setupact.log"
del /f /s /q "%windir%\setuperr.log"
echo.

echo 清理.Net Framework日志
del /f /s /q "%windir%\Microsoft.NET\Framework\*.log"
echo.

echo 清理Windows日志
del /f /s /q "%windir%\*.log"
echo.

echo 清理系统临时文件
rd /s /q %windir%\temp & md %windir%\temp
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
echo.

echo 清理崩溃转储文件
del /f /q %userprofile%\AppData\Local\CrashDumps\*.*
echo.

echo 清理Cookies
del /f /q %userprofile%\cookies\*.*
echo Recent & Jump list
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*.*"
echo.

echo 清理临时Internet文件
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\AppData\Local\Temporary Internet Files\*.*"
echo.

echo 清理字体缓存
del /f /s /q "%windir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat"
echo.

echo 清理CryptoAPI证书缓存
del /f /s /q "%userprofile%\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*"
echo.

echo 清理预加载文件
del /f /s /q "%windir%\Prefetch\*.pf"
echo.

echo 清理自动更新补丁文件
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*"
echo.

echo 清理缩略图缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*.db"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\IconCacheToDelete\*.tmp"
echo.

echo 清理Microsoft Edge缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Extension State\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Session Storage\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\JumpListIconsRecentClosed\*.tmp"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*"
echo.

echo 清理Internet Explorer缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Internet Explorer\DOMStore\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\container.dat"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\deprecated.cookie"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\WebCache\*.*"
echo.

echo 系统盘整体清理
del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
echo.

echo 清理完成
pause
goto menu