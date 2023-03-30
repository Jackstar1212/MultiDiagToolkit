@echo off
rem 取得管理员权限
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    echo.
    echo     声明：脚本修复功能不一定适用于您的问题，作者对使用脚本后果概不负责，请自行斟酌使用
    echo     声明：继续使用代表您同意免除脚本作者对您电脑进行修改缩造成后果的责任，自行承担后果
    echo.
    echo     若要使用请允许此脚本以管理员权限运行
    echo     当出现“你要允许此应用对您的设备进行更改吗？”对话框时，请选“是”
    echo     请检查是否已退出杀毒软件、管家软件等安全软件
    echo.
    echo     若不同意请关闭程序，或在出现“你要允许此应用对您的设备进行更改吗？”对话框时，选择“否”
    echo.

    timeout /t 5 /nobreak > NUL
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    cls
    Exit /b
)

rem 系统诊断修复工具

rem 设置窗口大小及颜色
rem color 2f
color 70
mode con cols=92 lines=54
rem cols 设置宽度；lines 设置长度
rem 颜色属性由两个十六进制数字指定 -- 第一个对应于背景，第二个对应于前景。每个数字可以为以下任何值:
rem 0 = 黑色 1 = 蓝色 2 = 绿色 3= 浅绿色 4 = 红色 5 = 紫色 6 = 黄色 7 = 白色 8 = 灰色 9 = 淡蓝色 A = 淡绿色 B = 淡浅绿色 C = 淡红色 D = 淡紫色 E = 淡黄色 F = 亮白色
rem 检查系统环境变量

echo.
echo     正在初始化程序...
echo.
echo     检查环境变量...
echo.
wmic /? >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	rem call:systempath %%SystemRoot%%\system32\Wbem
	echo     诊断工具功能可能受限，请手动修复 C:\Windows\system32\Wbem 环境变量
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
	echo     已修复用户环境变量, 请重新打开检查工具
)
echo     操作执行完成
echo.
echo     检查软件兼容性问题
%systemroot%\system32\tasklist /fi "IMAGENAME eq 360tray.exe" |findstr /i 360tray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出360安全卫士, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出360安全卫士, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq kxetray.exe" |findstr /i kxetray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出金山毒霸, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出金山毒霸, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq BaiduSdSvc.exe" |findstr /i BaiduSdSvc.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出百度杀毒软件, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出百度杀毒软件, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq ksafe.exe" |findstr /i ksafe.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出金山卫士, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出金山卫士, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq ccSvcHst.exe" |findstr /i ccSvcHst.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出Norton杀毒, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出Norton杀毒, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq avp.exe" |findstr /i avp.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出卡巴斯基, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出卡巴斯基, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq 360sd.exe" |findstr /i 360sd.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出360杀毒, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出360杀毒, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq QQPCSoftMgr.exe" |findstr /i QQPCSoftMgr.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出腾讯电脑管家, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出腾讯电脑管家, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq HipsTray.exe" |findstr /i HipsTray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出火绒安全软件, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出火绒安全软件, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)
echo.
echo     操作执行完成

rem 设置程序版本、作者信息
set "progver=2.6"
set "Author=LonelyFish"

setlocal enabledelayedexpansion
powershell -executionpolicy bypass -command "&{$H=get-host;$W=$H.ui.rawui;$B=$W.buffersize;$B.width=128;$B.height=300;$W.buffersize=$B;$W.windowtitle='系统诊断修复工具'}"
chcp 936 2>nul >nul

title 系统诊断修复工具 v%progver% by %Author%

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

:preGetOSinfo
rem 提前读取，避免重复读取加快目录加载速度
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"

rem 生成文件夹说明文件
echo.>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo 此文件夹为 MutiDiagToolkit（MDT）程序的日志输出文件夹>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo MDT 生成的所有日志均会保存在此文件夹内>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo 如不再需要日志信息，可以在 MDT 程序退出后删除此文件夹>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo 以下为日志名称说明：>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo 此文件夹是干什么的？_ReadMe.txt  说明文件                      由 MDT 主程序初始化生成，用于告知用户此文件夹的作用与用途>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo AllProcess.log                  系统所有进程列表日志          由查看系统当前所有进程功能生成>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo AllProcess_Running.log          系统所有正在运行的进程列表日志 由查看系统当前所有正在运行的进程功能生成>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo Battery_Report.html             电池健康度报告                由查看电池健康度功能生成，可以查看电池健康度相关信息>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo GET_HASH.log                    HASH 值日志                  由查看文件 HASH 值功能生成，可查看生成的文件 HASH 值记录>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo NetDiag.txt                     内网信息日志                  由系统环境诊断功能生成，可以查看内网情况信息>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo OS_Info.txt                     系统信息转储文件              由 MDT 主程序初始化生成，可以查看系统相关信息>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo ProgramList.log                 此设备安装的程序列表日志       由导出程序列表功能生成，可以查看此设备安装的程序>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo Sys_ipconfig_Basic.log          系统网络 IP 配置信息基础日志   由查看本机网络连接信息功能生成，可以查看系统网络连接基础情况>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo Sys_ipconfig_Detail.log         系统网络 IP 配置信息详细日志   由查看本机网络连接信息功能生成，可以查看系统网络连接详细情况>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo Userlist_Basic.log              用户列表基础信息日志           由列出此计算机的所有用户功能生成，可以查看此设备用户的基础信息>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo Userlist_Detail.log             用户列表详细信息日志           由列出此计算机的所有用户功能生成，可以查看此设备用户的详细信息>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo 如果没有以上部分文件，是因为用户没有调用相关功能，因此不会生成相关日志文件>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt
echo 生成此文件的 MDT 程序版本：%progver%>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt 
echo 作者：%Author%>>%userprofile%\desktop\MDT\此文件夹是干什么的？_ReadMe.txt

echo.
echo     正在生成系统信息转储文件
rem 调用生成系统信息方法
call :generatesysinfo
echo.
rem 存储首次生成系统信息文件MD5值，作为校验标准
for /f %%i in ('certutil -hashfile %userprofile%\desktop\MDT\OS_Info.txt MD5 ^|findstr /v "[^0-9a-z]"') do set osinfoMD5=%%i
echo osinfoMD5 = %osinfoMD5% >nul
echo     已保存系统信息校验值
echo     已保存系统信息，路径：%userprofile%\desktop\MDT\OS_Info.txt
echo.
echo     程序初始化完成
timeout /t 1 /nobreak > NUL

:menu
for /f "tokens=4" %%i in ('powercfg /LIST ^|findstr /v "Active" ^|findstr "*"') do set powerstate=%%i
set powerstate=!powerstate:(=! 2>nul
set powerstate=!powerstate:)=! 2>nul

rem 再次设置颜色，避免MAS覆盖
color 70
rem Win10游戏模式
if "%systemver%"=="10" (
for /f "tokens=3" %%i in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gamebar=%%i
if defined gamebar (
if !gamebar!==0x0 set gamebar=    游戏模式:                     关
if !gamebar!==0x1 set gamebar=    游戏模式:                     开
) else (
set "gamebar=    游戏模式:                     开"
)
) else (
echo. >nul
)

cls
echo.
echo     基本系统信息: 
echo.
rem 此处不再执行systeminfo命令，直接读取预加载的文件，但是做MD55校验，与最开始生成的文件不同则重新生成文件
rem 文件不存在则重新生成
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
if not exist "%userprofile%\desktop\MDT\OS_Info.txt" (
  echo     系统信息转储文件丢失，重新读取系统信息
  call :generatesysinfo
  echo     已重新保存系统信息
)
rem 开始MD5校验，不通过则重新生成
for /f %%i in ('certutil -hashfile %userprofile%\desktop\MDT\OS_Info.txt MD5 ^|findstr /v "[^0-9a-z]"') do set osinfoMD5New=%%i
if %osinfoMD5% neq %osinfoMD5New% (
  echo     系统信息校验值不匹配，重新读取系统信息
  call :generatesysinfo
  echo     已重新保存系统信息
)
rem 进入菜单，输出记录
type %userprofile%\desktop\MDT\OS_Info.txt
rem 以下每次返回目录输出
echo     登录用户：                    %USERNAME%
echo     计算机名：                    %COMPUTERNAME%
echo     系统时间:                     %time:~0,8%
echo     系统时区:                     %timezone%
echo     安装语言:                     %Languages% %SystemLanguages%
echo     电源模式:                     %powerstate%
if "%systemver%"=="10" (
echo %gamebar%
)
echo.
echo     欢迎使用多合一系统诊断修复工具！
echo.
rem 主菜单：多合一系统诊断修复工具

echo ------------------------------------------------------------------------------------------
echo                                    多合一系统诊断修复工具
echo ------------------------------------------------------------------------------------------
echo     0. 关于脚本的疑难解答（不知道这玩意干嘛的，选我）
echo.
echo     1. 系统诊断修复（电脑常见问题选我）
echo.
echo     2. 网络诊断修复（网炸了选我）
echo.
echo     3. 系统优化调整（Windows 功能调整选我）
echo.
echo     4. 常用软件修复（Steam 异常等选我）
echo.
echo     5. 其他功能杂项（其他的选我）
echo ------------------------------------------------------------------------------------------
echo.
echo     脚本作者：%Author%
echo     脚本版本：v%progver%
echo.
echo     声明：脚本修复功能不一定适用于您的问题，作者对使用脚本后果概不负责，请自行斟酌使用
echo     声明：继续使用代表您同意免除脚本作者对您电脑进行修改缩造成后果的责任，自行承担后果
echo     声明：如果不同意，请点击右上角关闭按钮关闭脚本并删除脚本文件
echo     首次使用建议阅读关于脚本的疑难解答
echo.
echo ------------------------------------------------------------------------------------------
set /p maininput=→  请选择项目：
if %maininput% equ 0 goto QA
if %maininput% equ 1 goto menusysrepairP1
if %maininput% equ 2 goto menunetfix
if %maininput% equ 3 goto menusysoptimizeP1
if %maininput% equ 4 goto menusoft
if %maininput% equ 5 goto menuotherP1
echo →  输入异常，请检查输入选项
pause
goto menu

rem 系统诊断修复菜单

:menusysrepairP1
cls
echo ------------------------------------------------------------------------------------------
echo                                       系统诊断修复菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 系统环境诊断（我想了解系统啊网络环境啊大概啥样）
echo.
echo     2. 系统修复（电脑这个不行那个不行，又不想重装，试试我）
echo.
echo     3. 显示程序列表（看看老子/老娘电脑里装了些啥）
echo.
echo     4. 重置 IE（上古神器 IE 浏览器，没人用，但是有时候网寄了也可以选我试试）
echo.
echo     5. Xbox 平台修复（打游戏用到 xbox 了，这玩意出问题选我）
echo.
echo     6. 图标变白修复（桌面图标咋都变成白色的了？选我）
echo.
echo     7. Windows 聚焦壁纸修复（我的锁屏壁纸之前总是会自动换的，咋不换了或者变默认了？选我）
echo.
echo     8. Windows 电源选项恢复（想要高性能、节能、平衡等那些电源选项，找不到了，选我）
echo.
echo     9. Windows Update 更新安装问题（0x80070002/0x80070005）其他故障请使用系统修复
echo.
echo     10. taskmgr.exe 没有与之关联的程序运行（任务管理器定位程序进程路径出问题，选我）
echo.
echo     11. 多种 exe 没有与之关联的程序运行（打开软件报这个错选我）
echo.
echo     12. 取消 Windows 激活状态并重置评估期（慎用！会使 Windows 变为未激活状态！）（小白别点）
echo.
echo     13. 组策略添加、修复（适用于家庭版添加组策略或者升级专业版后组策略丢失异常等问题）
echo.
echo     14. 修复桌面图标间距异常、窗口右上角关闭最大化最小化按钮异常
echo     （桌面图标间距好大，怪怪的，右上角关闭图标也怪怪的，选我）
echo.
echo     15. 修复微软商店打不开、转圈、白屏等问题（微软商店打不开选我）
echo.
echo     16. IE 主页劫持修复（主页被乱改了）
echo.
echo     17. 修复由于远程连接导致的剪贴板复制粘贴失效问题
echo.
echo     18. 停用 vmmem ，解决 vmmem 占用过高问题
echo.
echo     19. 查看电池健康度（看看电脑电池损耗如何）
echo.
echo     20. 查看下一页（当前页面为：P1）
echo ------------------------------------------------------------------------------------------
set /p sysdiaginput1=→  请选择项目：
if %sysdiaginput1% equ 0 goto menu
if %sysdiaginput1% equ 1 goto envdiag
if %sysdiaginput1% equ 2 goto systemrepair
if %sysdiaginput1% equ 3 goto programlist
if %sysdiaginput1% equ 4 goto iereset
if %sysdiaginput1% equ 5 goto xboxfix
if %sysdiaginput1% equ 6 goto IconRepair
if %sysdiaginput1% equ 7 goto WinFocus
if %sysdiaginput1% equ 8 goto borecover
if %sysdiaginput1% equ 9 goto wu0205
if %sysdiaginput1% equ 10 goto taskmgrexeErr
if %sysdiaginput1% equ 11 goto exeError
if %sysdiaginput1% equ 12 goto deactivate
if %sysdiaginput1% equ 13 goto gpeditfix
if %sysdiaginput1% equ 14 goto winbutton
if %sysdiaginput1% equ 15 goto msstorefix
if %sysdiaginput1% equ 16 goto iemainpagefix
if %sysdiaginput1% equ 17 goto RDclipboard
if %sysdiaginput1% equ 18 goto vmmemstop
if %sysdiaginput1% equ 19 goto batteryreport
if %sysdiaginput1% equ 20 goto menusysrepairP2
echo →  输入异常，请检查输入选项
pause
goto menusysrepairP1

:menusysrepairP2
cls
echo ------------------------------------------------------------------------------------------
echo                                       系统诊断修复菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 返回上一页（当前页面为：P2）
echo.
echo     2. 加入Windows预览体验计划（Windows Insider Channel）
echo.
echo     3. 运行系统自带磁盘清理工具（Cleanmgr）
echo.
echo     4. MAS 微软激活脚本（系统激活用我）
echo.
echo     5. 列出当前计算机正在运行的所有进程
echo.
echo     6. 列出所有进程（不论活跃与否）
echo.
echo     7. 列出此计算机的所有用户
echo ------------------------------------------------------------------------------------------
set /p sysdiaginput2=→  请选择项目：
if %sysdiaginput2% equ 0 goto menu
if %sysdiaginput2% equ 1 goto menusysrepairP1
if %sysdiaginput2% equ 2 goto insiderchannel
if %sysdiaginput2% equ 3 goto diskcleanmgr
if %sysdiaginput2% equ 4 goto MAS_ACTIVATOR
if %sysdiaginput2% equ 5 goto allprocessrunning
if %sysdiaginput2% equ 6 goto allprocess
if %sysdiaginput2% equ 7 goto userlist
echo →  输入异常，请检查输入选项
pause
goto menusysrepairP2

rem 网络诊断修复菜单

:menunetfix
cls
echo ------------------------------------------------------------------------------------------
echo                                       网络诊断修复菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 代理程序诊断（有没有奇怪的代理程序影响我上网选我）
echo.
echo     2. HOSTS 修复工具（高级操作，改改影响网络解析的玩意）
echo.
echo     3. DNS 设置工具（上网打开网页慢，换个dns也许可以解决？）
echo.
echo     4. 网络协议栈重置（网炸了选我）
echo.
echo     5. LSP 修复（网炸了选我先，不行选上面的那个）
echo.
echo     6. 关闭 Windows 防火墙（碍手碍脚总弹窗问联网权限？选我关掉，当然不是那么推荐）
echo.
echo     7. 开启 Windows 防火墙（我后悔了，或者遇到问题了，重新打开选我）
echo.
echo     8. 重置 IE（上古神器 IE 浏览器，没人用，但是有时候网寄了也可以选我试试）
echo.
echo     9. DNS 缓存域名记录（看看网页解析）
echo.
echo     10. 查看本机网络连接信息详情
echo.
echo     11. 网络完全重置（我不知道哪里出问题了，帮我全部重置一遍，含 Steam、Xbox 修复）
echo.
echo     12. 打开网络连接设置（传统设置）
echo ------------------------------------------------------------------------------------------
set /p netdiaginput=→  请选择项目：
if %netdiaginput% equ 0 goto menu
if %netdiaginput% equ 1 goto proxydiag
if %netdiaginput% equ 2 goto hsfile
if %netdiaginput% equ 3 goto dnsfix
if %netdiaginput% equ 4 goto networkreset
if %netdiaginput% equ 5 goto lspfix
if %netdiaginput% equ 6 goto systemfirewalloff
if %netdiaginput% equ 7 goto systemfirewallon
if %netdiaginput% equ 8 goto iereset
if %netdiaginput% equ 9 goto dnscachelist
if %netdiaginput% equ 10 goto ipconfigsys
if %netdiaginput% equ 11 goto NetworkAllReset
if %netdiaginput% equ 12 goto netconnectcenter
echo →  输入异常，请检查输入选项
pause
goto menunetfix

rem 系统优化调整菜单

:menusysoptimizeP1
cls
echo ------------------------------------------------------------------------------------------
echo                                       系统优化调整菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 关闭Windows防火墙（碍手碍脚总弹窗问联网权限？选我关掉，当然不是那么推荐）
echo.
echo     2. 开启Windows防火墙（我后悔了，或者遇到问题了，重新打开选我）
echo.
echo     3. 设置计算机使用的电源选项（切换电源选项）
echo.
echo     4. 卓越性能模式（解锁电脑系统层面的一些功耗限制，让电脑尽可能满功耗运行）
echo.
echo     5. 恢复UAC（我后悔禁用了，还是想要权限在自己手里控制舒服）
echo.
echo     6. 禁用UAC（关了uac，打开软件不会再申请管理员权限，省的选是选否不知道）
echo.
echo     7. 自定义开机选择系统启动项等待时间（高级操作：不想开机等30秒选择系统，选我输入自定义秒数）
echo.
echo     8. 打开可移动磁盘自动运行（想一插u盘自动播放选我，可能会让病毒也自动启动嗷）
echo.
echo     9. 关闭可移动磁盘自动运行（不要自动播放选我）
echo.
echo     10. 开启系统休眠（想要一盖电脑就冻结，打开电脑就恢复之前样子，选我，默认开）
echo.
echo     11. 关闭系统休眠（极致性能，我就一个臭打游戏的，台式机巴拉巴拉，选我）
echo.
echo     12. 系统盘缓存垃圾清理（使用有风险，会清理日志文件等，请做好备份）（删个垃圾选我）
echo.
echo     13. （WIN7限定）在较老的电脑上开启Aero透明毛玻璃效果
echo.
echo     14. 清除快捷方式小箭头（美化类：不要桌面上快捷方式左下角的小箭头）
echo.
echo     15. 恢复快捷方式小箭头（美化类：恢复桌面上快捷方式左下角的小箭头）
echo.
echo     16. 停用vmmem，解决vmmem占用过高问题
echo.
echo     17. 停用TabletPC功能
echo.
echo     18. 记事本默认保存编码修改（高版本Windows不一定适用）
echo.
echo     19. 加入Windows预览体验计划（Windows Insider Channel）
echo.
echo     20. 查看下一页（当前页面为：P1）
echo ------------------------------------------------------------------------------------------
set /p sysopt1=→  请选择项目：
if %sysopt1% equ 0 goto menu
if %sysopt1% equ 1 goto systemfirewalloff
if %sysopt1% equ 2 goto systemfirewallon
if %sysopt1% equ 3 goto setbatteryoption
if %sysopt1% equ 4 goto powercfgperf
if %sysopt1% equ 5 goto enableuac
if %sysopt1% equ 6 goto disableuac
if %sysopt1% equ 7 goto BootTime
if %sysopt1% equ 8 goto uautorunon
if %sysopt1% equ 9 goto uautorunoff
if %sysopt1% equ 10 goto hibernateon
if %sysopt1% equ 11 goto hibernateoff
if %sysopt1% equ 12 goto junkclean
if %sysopt1% equ 13 goto win7aero
if %sysopt1% equ 14 goto noshortcut
if %sysopt1% equ 15 goto restoreshortcut
if %sysopt1% equ 16 goto vmmemstop
if %sysopt1% equ 17 goto deltabletpc
if %sysopt1% equ 18 goto notepadsaveencoder
if %sysopt1% equ 19 goto insiderchannel
if %sysopt1% equ 20 goto menusysoptimizeP2
echo →  输入异常，请检查输入选项
pause
goto menusysoptimizeP1

:menusysoptimizeP2
cls
echo ------------------------------------------------------------------------------------------
echo                                       系统优化调整菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 返回上一页（当前页面为：P2）
echo.
echo     2. 运行系统自带磁盘清理工具（Cleanmgr）
echo.
echo     3. 禁用遥测系统跟踪等服务（系统隐私优化）
echo.
echo     4. 恢复遥测系统跟踪等服务（遇到异常了选我恢复）
echo.
echo     5. 禁用 Windows Defender（文件一直被系统拦截选我）
echo.
echo     6. 启用 Windows Defender（恢复Defender功能选我）
echo.
echo     7. 禁用 Windows Update
echo.
echo     8. 启用、重置、修复 Windows Update
echo ------------------------------------------------------------------------------------------
set /p sysopt2=→  请选择项目：
if %sysopt2% equ 0 goto menu
if %sysopt2% equ 1 goto menusysoptimizeP1
if %sysopt2% equ 2 goto diskcleanmgr
if %sysopt2% equ 3 goto PrivCtrloff
if %sysopt2% equ 4 goto PrivCtrlon
if %sysopt2% equ 5 goto defenderoff
if %sysopt2% equ 6 goto defenderon
if %sysopt2% equ 7 goto wudisable
if %sysopt2% equ 8 goto wureset
echo →  输入异常，请检查输入选项
pause
goto menusysoptimizeP2

rem 常用软件修复菜单

:menusoft
cls
echo ------------------------------------------------------------------------------------------
echo                                       常用软件修复菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 导出程序列表（看看老子/老娘电脑里装了些啥）
echo.
echo     2. Xbox平台修复（打游戏用到xbox了，这玩意出问题选我）
echo.
echo     3. Steam VAC屏蔽修复与闪退问题修复工具（打csgo报vac验证错误断开连接之类的选我）
echo.
echo     4. 清理本地FlashPlayer播放器记录（单文件FlashPlayer播放器的记录清理）
echo.
echo     5. 记事本默认保存编码修改
echo.
echo     6. 获取文件HASH值
echo.
echo     7. 杀死特定进程
echo.
echo     8. EasyAntiCheat 异常、启动失败、卸载（EAC小蓝熊删除重装）
echo.
echo     9. Apex Legends 商店图片不显示出现禁用标志（ASSET FAILED TO LOAD）
echo ------------------------------------------------------------------------------------------
set /p softinput=→  请选择项目：
if %softinput% equ 0 goto menu
if %softinput% equ 1 goto programlist
if %softinput% equ 2 goto xboxfix
if %softinput% equ 3 goto vacfix
if %softinput% equ 4 goto fpclean
if %softinput% equ 5 goto notepadsaveencoder
if %softinput% equ 6 goto GETHASH
if %softinput% equ 7 goto killprocess
if %softinput% equ 8 goto eacuninstall
if %softinput% equ 9 goto apexshopimgerr
echo →  输入异常，请检查输入选项
pause
goto menusoft

rem 其他功能杂项菜单

:menuotherP1
cls
echo ------------------------------------------------------------------------------------------
echo                                       其他功能杂项菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 将管理员取得所有权添加到右键菜单
echo     （文件夹打不开？删文件权限不够？试试这个，添加后右键文件取得所有权再试试）
echo.
echo     2. 将管理员取得所有权从右键菜单删除（不想要了）
echo.
echo     3. 获取文件 HASH 值
echo.
echo     4. 列出当前计算机正在运行的所有进程
echo.
echo     5. 列出所有进程（不论活跃与否）
echo.
echo     6. 杀死特定进程
echo.
echo     7. 启动 CMD 命令行（CMD.exe 管理员身份运行）
echo.
echo     8. 启动 Windows PowerShell 命令行（Powershell.exe 管理员身份运行）
echo.
echo     9. 列出此计算机的所有用户
echo.
echo     10. 启动本地组策略编辑器（gpedit.msc）
echo.
echo     11. 启动服务管理单元（services.msc）
echo.
echo     12. 启动注册表编辑器（regedit.exe）
echo.
echo     13. 启动计算机管理（compmgmt.msc）
echo.
echo     14. 启动事件查看器（eventvwr.msc）
echo.
echo     15. 启动控制面板
echo.
echo     16. 查看系统版本信息（关于“Windows”）
echo.
echo     17. 打开系统设置页面（老版本 Windows 不适用）
echo.
echo     18. 启动磁盘管理（diskmgmt.msc）
echo.
echo     19. 启动任务管理器（taskmgr.exe）
echo.
echo     20. 查看下一页（当前页面为：P1）
echo ------------------------------------------------------------------------------------------
set /p otherinput1=→  请选择项目：
if %otherinput1% equ 0 goto menu
if %otherinput1% equ 1 goto rightadmadd
if %otherinput1% equ 2 goto rightadmdel
if %otherinput1% equ 3 goto GETHASH
if %otherinput1% equ 4 goto allprocessrunning
if %otherinput1% equ 5 goto allprocess
if %otherinput1% equ 6 goto killprocess
if %otherinput1% equ 7 goto cmdstart
if %otherinput1% equ 8 goto psstart
if %otherinput1% equ 9 goto userlist
if %otherinput1% equ 10 goto gpeditmsc
if %otherinput1% equ 11 goto servicesmsc
if %otherinput1% equ 12 goto regeditexe
if %otherinput1% equ 13 goto compmgmtmsc
if %otherinput1% equ 14 goto eventvwrmsc
if %otherinput1% equ 15 goto ctrlpanel
if %otherinput1% equ 16 goto winversion
if %otherinput1% equ 17 goto startmssetting
if %otherinput1% equ 18 goto startdiskmgr
if %otherinput1% equ 19 goto starttaskmgr
if %otherinput1% equ 20 goto menuotherP2

echo →  输入异常，请检查输入选项
pause
goto menuotherP1



:menuotherP2
cls
echo ------------------------------------------------------------------------------------------
echo                                       其他功能杂项菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 返回上一页（当前页面为：P2）
echo.
echo     2. 启动 Windows 功能管理（启用或关闭 Windows 功能）
echo.
echo     3. 启动系统配置（启动、引导管理）
echo.
echo     4. 启动系统信息
echo.
echo     5. 启动 Windows 内存诊断
echo.
echo     6. 启动组件服务管理
echo.
echo     7. 启动共享文件夹管理（fsmgmt.msc）
echo.
echo     8. 启动性能监视器（perfmon.msc）
echo.
echo     9. 启动本地安全组策略（secpol.msc）
echo.
echo     10. 启动 DirectX 检测工具（dxdiag）
echo.
echo     11. 启动远程桌面连接
echo.
echo     12. 用户资料数据备份（便捷备份用户数据，重装电脑前选我备份数据）
echo.
echo     13. 打开桌面图标设置（计算机、此电脑我的文档不见了，只有回收站，选我）
echo.
echo     14. 打开用户账户设置
echo.
echo     15. 打开 Windows Defender 防火墙设置
echo.
echo     16. 打开程序和功能（卸载或更改程序）
echo.
echo     17. 打开系统属性设置（虚拟内存、分页文件等高级系统设置）
echo.
echo     18. 打开时间和区域设置（时间格式调整、时区调整）
echo.
echo     19. 打开网络连接设置（传统设置）
echo.
echo     20. 查看下一页（当前页面为：P2）
echo ------------------------------------------------------------------------------------------
set /p otherinput2=→  请选择项目：
if %otherinput2% equ 0 goto menu
if %otherinput2% equ 1 goto menuotherP1
if %otherinput2% equ 2 goto optionalfunc
if %otherinput2% equ 3 goto ms_config
if %otherinput2% equ 4 goto startsysinfo
if %otherinput2% equ 5 goto memcheckprogram
if %otherinput2% equ 6 goto componentmgr
if %otherinput2% equ 7 goto sharemanage
if %otherinput2% equ 8 goto startperfmon
if %otherinput2% equ 9 goto securemgr
if %otherinput2% equ 10 goto dxcheck
if %otherinput2% equ 11 goto rdapp
if %otherinput2% equ 12 goto sysuserbackup
if %otherinput2% equ 13 goto desktopiconset
if %otherinput2% equ 14 goto useraccset
if %otherinput2% equ 15 goto firewallset
if %otherinput2% equ 16 goto applistset
if %otherinput2% equ 17 goto computerpropset
if %otherinput2% equ 18 goto timezoneset
if %otherinput2% equ 19 goto netconnectcenter
if %otherinput2% equ 20 goto menuotherP3
echo →  输入异常，请检查输入选项
pause
goto menuotherP2

:menuotherP3
cls
echo ------------------------------------------------------------------------------------------
echo                                       其他功能杂项菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 返回上一页（当前页面为：P3）
echo.
echo     2. 打开轻松使用设置中心（放大镜等辅助工具设置页面）
echo.
echo     3. 打开显示属性（屏幕设置）
echo.
echo     4. 打开安全和维护（Windows 安全中心）
rem echo.
rem echo 20. 查看下一页（当前页面为：P3）
echo ------------------------------------------------------------------------------------------
set /p otherinput3=→  请选择项目：
if %otherinput3% equ 0 goto menu
if %otherinput3% equ 1 goto menuotherP2
if %otherinput3% equ 2 goto easyuseset
if %otherinput3% equ 3 goto scrpropset
if %otherinput3% equ 4 goto securitycenter
rem if %otherinput3% equ 20 goto menuotherP4
echo →  输入异常，请检查输入选项
pause
goto menuotherP3

rem 功能区

:QA
cls
echo ------------------------------------------------------------------------------------------
echo.
echo     常见问题：为什么会报毒？
echo.
echo     脚本内容涉及到系统敏感文件及设置还原，因此需要管理员权限提权，本质与杀毒软件的系统
echo     修复功能一致，并不涉及其他操作。杀毒软件检测到提权代码以及修改系统设置操作，会认定
echo     脚本具有恶意行为，而实际上脚本仅仅是还原被恶意软件修改过的系统设置。
echo.
echo     常见问题：为什么用这个不用杀毒软件？
echo.
echo     杀毒软件修复功能有限，并不能修复所有问题。而一些常见问题在本人使用系统过程中遇见，
echo     自行修复之后为了方便以后遇到相同问题能快速修复，于是利用命令行制作了一键修复脚本。
echo     脚本会不断更新加入新的功能，但也并非全能。同样也相信部分用户深受某些厂家的安全软件
echo     打着免费杀毒的旗号疯狂占用用户系统资源还弹出大量广告，以此来谋取利益。此脚本便是为
echo     方便一些裸奔用户而制成的，文件体积小、功能强大、修复方便快捷，也是对本人的使用修复
echo     的一些心得做的总结，希望能帮到各位。
echo.
echo     常见问题：有这个脚本是不是可以不用装杀毒软件了？
echo.
echo     脚本和杀毒软件并不冲突，之所以脚本会检测杀毒软件进程，是因为部分新手用户很容易会让
echo     杀毒软件做默认的拒绝操作，而不是放行。一旦杀毒软件对脚本的修复操作进行拦截操作，那
echo     脚本的修复功能便不能正常工作，更不要说对问题进行修复了。如果是稍微专业一点的用户，
echo     完全可以用杀毒软件来监视脚本操作，只是需要频繁放行罢了。脚本仅仅只是修复一些系统的
echo     异常问题，并不具备杀毒能力，不可替代杀毒软件，杀毒还请使用专业的杀毒软件。如果是对
echo     自己的技术有信心，那当然另谈。
echo.
echo     常见问题：导出的日志报告在哪里？
echo.
echo     导出的日志报告路径： %userprofile%\Desktop\MDT 
echo     即用户桌面上的 MDT 文件夹。
echo     软件所有的日志都保存在此文件夹内，如不需要可以在程序运行完毕后删除。如果不知道哪个
echo     日志对应哪个功能，可以查看文件夹内的 此文件夹是干什么的？_ReadMe.txt 文件。
echo.
echo     当前程序版本：%progver%
echo     作者：%Author%
echo.
echo ------------------------------------------------------------------------------------------
timeout /t 3 /nobreak > NUL
echo →  按任意键即可返回菜单
pause
goto menu

:generatesysinfo
rem 生成系统信息，读取信息
rem 操作系统名称
for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"OS 名称"') do set osnametmp=%%i
for /f "tokens=2 delims=:" %%i in ('echo %osnametmp%') do set osname=%%i
rem 系统版本
for /f "tokens=*" %%i in ('ver') do set sysv=%%i
rem CPU信息
for /f "tokens=*" %%i in ('wmic cpu get name ^|findstr /v "Name" ^|findstr "[^\S]"') do set cpuinfo=%%i
rem 内存信息
for /f %%i in ('wmic os get TotalVisibleMemorySize ^|findstr [0-9]') do set /a ram=%%i/1024
rem 虚拟内存信息
for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualram=%%i/1024
rem 显卡信息
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get AdapterRAM^,Name /value ^|findstr Name') do set vganame=%%i
rem 屏幕分辨率信息
for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do set scrresolution=%%j*%%i
rem 应用程序错误信息
if "%systemver%"=="10" (
for /f "tokens=1,2,4* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName Application -EntryType Error -Newest 2 -After %year%-%month%-%day% -Source 'Application Error' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo    %%i %%j 错误: %%k %%l
) else (
echo. >nul 2>nul
)
rem 统一输出信息
echo     操作系统名称:                %osname%>%userprofile%\desktop\MDT\OS_Info.txt
echo     系统版本:                     %sysv%>>%userprofile%\desktop\MDT\OS_Info.txt
echo     中央处理器 CPU:               %cpuinfo%>>%userprofile%\desktop\MDT\OS_Info.txt
echo     图形处理器 GPU（独立显卡）:   %vganame%>>%userprofile%\desktop\MDT\OS_Info.txt
echo     屏幕分辨率:                   %scrresolution%>>%userprofile%\desktop\MDT\OS_Info.txt
echo     内存:                         %ram% MB>>%userprofile%\desktop\MDT\OS_Info.txt
echo     当前分配虚拟内存:             %VirtualRAM% MB>>%userprofile%\desktop\MDT\OS_Info.txt
goto :eof

:envdiag
cls
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
echo 本地 DNS 解析测试 (预计耗时5-10秒): 
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
call:nslookvalue www.baidu.com cn.bing.com www.bilibili.com www.douyin.com www.sohu.com www.microsoft.com
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
cls
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
cls
rem 结束VeryKuai加速器
taskkill /F /IM VeryKuai.exe >nul 2>nul
rem 结束雷神加速器
taskkill /F /IM Leigod.exe >nul 2>nul
rem 结束uu加速器
taskkill /F /IM uu.exe >nul 2>nul
rem 结束zz加速器（AK旗下，征云网络科技）
taskkill /F /im ZZ.exe >nul 2>nul
rem 结束迅游加速器
taskkill /F /im xunyou.exe >nul 2>nul
rem 结束鲜牛加速器
taskkill /F /im XianNiu.exe >nul 2>nul
rem 结束奇游加速器
taskkill /F /im QiYou.exe >nul 2>nul
rem 结束小黑盒加速器
taskkill /F /im heyboxacc.exe >nul 2>nul
taskkill /f /im heyboxbrowser.exe >nul 2>nul
rem 结束nn加速器(雷神旗下)
taskkill /F /im nn.exe >nul 2>nul
rem 结束AK加速器（征云网络科技）
taskkill /F /im AK.exe>nul 2>nul

echo 请关闭加速器以获得最佳修复效果
echo.
echo 前置修复：重置 LSP
netsh winsock reset >nul 2>nul
echo.

goto modeselect

:modeselect
echo 即将开始网络协议栈重置
echo.
set /p a=→  请选择重置模式（模式1普通重置，模式2暴力重置）: 
if %a% equ 1 goto regularreset
if %a% equ 2 goto brutereset
goto menu

:brutereset
echo.
echo 重置 TCP/IP 协议
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

echo 禁用 Killer 服务
sc config "Killer Network Service x64" start= disabled >nul 2>nul
sc config "Killer Network Service" start= disabled >nul 2>nul
sc config "Killer Bandwidth Service" start= disabled >nul 2>nul
sc config "Rivet Bandwidth Service" start= disabled >nul 2>nul

:regularreset
echo.
echo 重置 LSP
netsh winsock reset >nul 2>nul
netsh winsock reset >nul 2>nul
echo.

echo 重置 Hosts 文件权限并清空
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
call:host1fix

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

echo 刷新 DNS/ARP 缓存
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

echo IE 组件修复
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
cls
echo.
echo LSP 修复
netsh winsock reset
netsh winsock reset
netsh winsock reset
echo.
echo 已修复
echo.
pause
goto menu

:systemrepair
cls
echo.
echo     系统修复菜单
echo.
echo     0. 前置服务修复
echo     1. SFC 修复（基础修复）
echo     2. DISM 检查修复（高级修复）
echo     3. 返回主菜单

set /p user_input=→  请选择一个项目：
if %user_input% equ 0 goto PreSFix
if %user_input% equ 1 goto SFCFIX
if %user_input% equ 2 goto DISMFIX
if %user_input% equ 3 goto menu
echo.
echo     无效的代码，请重新输入。
timeout /t 3 /nobreak > NUL
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
echo 即将使用 SFC 工具进行修复，如遇服务异常请先运行前置服务修复
echo 如遇进度条卡死超过 10 分钟，请退出程序重新运行并选择 DISM 工具修复
timeout /t 3 /nobreak > NUL
echo 运行 SCANNOW 命令修复系统
sfc /scannow
echo SFC 基础修复完成
goto menu

:DISMFIX
echo.
echo 即将使用 DISM 工具进行修复，如遇服务异常请先运行前置服务修复
echo 如遇进度条卡死超过 10 分钟，请退出程序重新运行 DISM 工具修复
echo 若出现 DISM 工具异常或者仍然卡死，请考虑使用原版系统镜像覆盖安装系统修复文件（系统文件遭到 DISM 工具不可修复的破坏）
timeout /t 3 /nobreak > NUL
echo 使用 DISM 工具校验系统文件
Dism /Online /Cleanup-Image /ScanHealth
echo DISM扫描完成

:dismbreak
echo     DISM 工具扫描完成，请检查结果并选择：
echo.
echo     1. 可以修复组件存储
echo     2. 未检测到组件存储损坏
echo     3. 其他问题
set /p host=→  请根据情况选择项目：
if %host% equ 1 goto DISMRestore
if %host% equ 2 goto DISMFin
if %host% equ 3 goto DISMother
echo.
echo 无效的代码，请重新输入。
timeout /t 3 /nobreak > NUL
goto dismbreak

:DISMRestore
echo 使用 DISM 工具修复系统文件
Dism /Online /Cleanup-Image /RestoreHealth
echo DISM 修复组件存储完成
goto DISMFin

:DISMother
echo     以下列出几种常见问题：
echo     1. 存储组件已损坏，建议下载原版镜像覆盖安装系统修复
echo     2. 找不到映像源，找不到源文件，先检查网络是否通畅，重新运行
echo     若仍存在问题，请找原版镜像里的 install.wim 文件挂载，再利用 StartComponent 参数修复
echo     最推荐的方法是下载原版镜像覆盖安装系统修复
echo     3. 诊断策略服务未运行，请先运行前置修复，如果仍存在问题，建议下载原版镜像文件覆盖安装系统修复
echo     普通用户推荐使用微软官方的 MediaCreationTool 无损覆盖、安装、升级系统
echo     专业用户可自行寻找 iso 文件通过多种方式修复系统，不多赘述
timeout /t 3 /nobreak > NUL
echo     按任意键返回菜单
echo pause
goto menu

:DISMFin
echo DISM 修复完成，推荐重启系统
timeout /t 3 /nobreak > NUL
goto menu

:hsfile
cls
echo.
echo     Hosts 修复菜单
echo.
echo     0. 返回主菜单
echo     1. Hosts 文件丢失修复
echo     2. 修改 Hosts
echo     3. 修复权限并清空 Hosts
echo     4. 使 Hosts 只读
echo     5. 使 Hosts 可写
echo     6. 设置指定路径文件拒绝访问
echo     7. 设置指定路径文件完全访问

echo.
set /p host=→  请选择: 
if %host% equ 0 goto host0
if %host% equ 1 goto host1
if %host% equ 2 goto host2
if %host% equ 3 goto host3
if %host% equ 4 goto host4
if %host% equ 5 goto host5
if %host% equ 6 goto host6
if %host% equ 7 goto host7
echo.
echo     无效的代码，请重新输入。
goto hsfile

:host0
echo.
goto menu

:host1err
echo.
set /p choice="→  存在 Hosts 文件，是否继续修复？ (y/N) "
if %choice% equ Y goto host1fix
if %choice% equ y goto host1fix
if %choice% equ N goto hsfile
if %choice% equ n goto hsfile
goto hsfile

:host1
cls
echo 开始修复 Hosts 文件丢失问题
echo.
echo 检测 Hosts 文件是否存在
echo.
if exist "%WINDIR%\system32\drivers\etc\hosts" goto host1err

echo 检测到 Hosts 文件丢失，创建 Hosts 文件
echo.
rem 此处为多余的判断，前面已经判断了是否存在 hosts 文件，因此这里可以不用判断
rem 但是为了学习写法，此处保留。精简写法可以直接 type 甚至不用写这行直接写入即可
rem 此写法是多一步多一个echo，一步一步来，学习过程还是条理清晰一点
if not exist "%WINDIR%\system32\drivers\etc\hosts" type nul>"%WINDIR%\system32\drivers\etc\hosts"
call:host1fix
pause
goto menu

:host1fix
echo 开始写入默认 Hosts 数据
echo # Copyright (c) 1993-2009 Microsoft Corp.>>"%WINDIR%\system32\drivers\etc\hosts"
echo #>>"%WINDIR%\system32\drivers\etc\hosts"
echo # This is a sample HOSTS file used by Microsoft TCP/IP for Windows.>>"%WINDIR%\system32\drivers\etc\hosts"
echo #>>"%WINDIR%\system32\drivers\etc\hosts"
echo # This file contains the mappings of IP addresses to host names. Each>>"%WINDIR%\system32\drivers\etc\hosts"
echo # entry should be kept on an individual line. The IP address should>>"%WINDIR%\system32\drivers\etc\hosts"
echo # be placed in the first column followed by the corresponding host name.>>"%WINDIR%\system32\drivers\etc\hosts"
echo # The IP address and the host name should be separated by at least one>>"%WINDIR%\system32\drivers\etc\hosts"
echo # space.>>"%WINDIR%\system32\drivers\etc\hosts"
echo #>>"%WINDIR%\system32\drivers\etc\hosts"
echo # Additionally, comments (such as these) may be inserted on individual>>"%WINDIR%\system32\drivers\etc\hosts"
echo # lines or following the machine name denoted by a '#' symbol.>>"%WINDIR%\system32\drivers\etc\hosts"
echo #>>"%WINDIR%\system32\drivers\etc\hosts"
echo # For example:>>"%WINDIR%\system32\drivers\etc\hosts"
echo #>>"%WINDIR%\system32\drivers\etc\hosts"
echo #      102.54.94.97     rhino.acme.com          # source server>>"%WINDIR%\system32\drivers\etc\hosts"
echo #       38.25.63.10     x.acme.com              # x client host>>"%WINDIR%\system32\drivers\etc\hosts"
echo # localhost name resolution is handled within DNS itself.>>"%WINDIR%\system32\drivers\etc\hosts"
echo #	127.0.0.1       localhost>>"%WINDIR%\system32\drivers\etc\hosts"
echo #	::1             localhost>>"%WINDIR%\system32\drivers\etc\hosts"
echo.
echo 写入完成
echo.
echo 恢复默认 Hosts 完成
echo.
goto :EOF

:host2
echo.
rem 清除空行
type %WINDIR%\system32\drivers\etc\hosts 2>nul |findstr "." >> %WINDIR%\system32\drivers\etc\hosts_bak
copy /y %WINDIR%\system32\drivers\etc\hosts_bak %WINDIR%\system32\drivers\etc\hosts >nul
rem 使hosts可写
cacls.exe %WINDIR%\system32\drivers\etc\hosts /e /t /g Administrators:F
rem 删除备份文件
del /s /q %WINDIR%\system32\drivers\etc\hosts_bak >nul 2>nul
start notepad.exe %WINDIR%\system32\drivers\etc\hosts
echo 已启动记事本，Hosts 修改完成后请按任意键继续
echo.
pause
ipconfig /flushdns >nul 2>nul
goto menu

:host3
echo.
echo 修复权限并清空 Hosts
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
echo.
echo 已清空 Hosts
echo.
call:host1fix
echo.
pause
goto menu

:host4
echo.
rem 使hosts只读
echo →  按Y使 Hosts 只读: 
cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:R
echo.
pause
goto menu

:host5
echo.
rem 使hosts可写
echo →  按Y使 Hosts 可写: 
cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F
cd. > %WINDIR%\system32\drivers\etc\hosts 2>nul
echo.
pause
goto menu

:host6
echo.
set /p files=→  请输入文件完整路径: 
cacls.exe "%files%" /e /t /p Administrators:N
echo 设置指定路径文件拒绝访问
echo.
pause
goto menu

:host7
echo.
set /p files=→  请输入文件完整路径: 
cacls.exe "%files%" /e /t /g Administrators:F
echo 设置指定路径文件完全访问
echo.
pause
goto menu




:iereset
cls
echo.
del /f /q "%temp%\mb" >nul 2>nul
echo Miniblink 缓存清理成功
Rundll32 InetCpl.cpl,ClearMyTracksByProcess 255
echo IE 缓存清理成功
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
echo IE 已重置
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo IE 组件已修复
echo.
pause
goto menu

:dnsfix
cls
echo.
echo     DNS 设置菜单
echo.
echo     0. 返回主菜单
echo     1. 首选: 119.29.29.29    备用: 8.8.8.8
echo     2. 首选: 223.5.5.5       备用: 8.8.8.8
echo     3. 首选: 114.114.114.114 备用: 8.8.8.8
echo     4. 首选: 180.76.76.76    备用: 8.8.8.8
echo     5. 首选: 8.8.8.8         备用: 223.5.5.5
echo     6. 首选: 9.9.9.9         备用: 223.5.5.5(防运营商劫持^)
echo     7. 首选: 4.2.2.2         备用: 223.5.5.5
echo     8. 移动: 101.226.4.6     备用: 223.5.5.5
echo     9. 首选: 80.80.80.80     备用: 223.5.5.5(防运营商劫持^)
echo.
set /p dns=→  请选择: 
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
goto menu

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
echo.
echo 开始导出用户程序列表
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
echo.
(for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k) >%userprofile%\desktop\MDT\ProgramList.log
(for /f "tokens=3,4*" %%i in ('reg query HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k) >%userprofile%\desktop\MDT\ProgramList.log
(for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k) >%userprofile%\desktop\MDT\ProgramList.log

echo 导出用户程序列表完成，请查看桌面 MDT 文件夹中的 ProgramList.log 文件
start %userprofile%\desktop\MDT\ProgramList.log
echo 路径：%userprofile%\desktop\MDT\ProgramList.log
pause
goto menu

:powercfgperf
cls
echo.
echo 正在设置电源选项...
echo.
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
echo 设置电源选项完成
echo 如遇设置异常，可在系统诊断修复菜单中，选择电源选项恢复进行修复
echo.
echo     提醒：如果帧率仍然比预想的要低或者不正常，请检查系统问题
echo     包括但不限于软件层面：OEM 定制驱动软件限制功耗影响帧率（节能模式、办公模式等）
echo     NVIDIA Experience、AMD 等控制面板限制功耗影响帧率
echo     系统虚拟内存设置异常、各种系统小问题堆积导致大异常
echo     某些软件环境后台（不一定显示）占用大量系统资源进行运算（模型训练、挖矿软件、木马病毒等）
echo     硬件层面：电池电压不稳，计算机供电异常，运行内存过小、内存条接触异常识别异常
echo     固态硬盘损坏，机械硬盘老化（推荐除了文件存储需求外，软件均安装至固态硬盘内）
echo     请自行排查重试，若均难以解决，请联系专业用户。
pause
goto menu

:dnscachelist
cls
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
echo 安全/拨号/代理/模拟器/限速软件: && for /f "tokens=1,10 delims=," %%i in ('tasklist /v /fo csv ^|findstr /I "%securitysoftwareprocess%"') do echo     %%i 名称:%%j

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
echo Minidump 目录: && dir %WINDIR%\Minidump |findstr 文件
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
echo     代理状态: %proxyenable%
if not "!proxyserver!" == "" (
echo     地址/端口: %proxyserver%
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
cls
echo.
netsh advfirewall set allprofiles state off >nul 2>nul
echo Windows系统防火墙: 已关闭
echo.
goto:eof

:systemfirewallon
cls
echo.
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
set mturesult=警告: 上层设备 MTU 小于 1400
) else (
set mturesult=
)
for /f "tokens=3" %%i in ('netsh int ip show interfaces ^|findstr /r "\<connected" ^|findstr /r "以太网 本地连接"') do set mtuvalue=%%i
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ReleaseId 2^>nul') do set systemversion=%%i
for /f "delims=." %%i in ('wmic datafile where name^="C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE" get Version 2^>nul ^|findstr /i /c:"."') do set ieversion=%%i

echo.
for /f "tokens=1,*" %%i in ('ver') do echo %%i %%j %systemversion%
echo 计算机名: %COMPUTERNAME%
echo IE 浏览器: %ieversion%
echo 网卡 MTU: %mtuvalue%
if not "!mturesult!" == "" (
	echo %mturesult%
)

rem 数据诊断

if DEFINED systemversion (
	if "%systemversion%" GTR "1809" (
		echo. >nul 2>nul
	) else (
		set systemversionresult=Win10 系统版本 %systemversion% 过低, 建议升级
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

echo %1路由跟踪结果
echo     IPv4路由表统计: %routeall%(行)
if not "!vpngateway!" == "" (
	echo     模式B网关: %vpngateway%
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
		echo     %%i %%j  !networkstatus:~1,7! |%temp%\mtee /a /+ %temp%\networkadapter.txt
	)

netsh wlan show Interfaces |findstr /R "\<SSID" >nul
if "%errorlevel%"=="0" (

	rem 获取无线 WIFI 字段信息
	set WF=0
	for /f "tokens=2 delims=:" %%i in ('netsh wlan show Interfaces') do (
		for /f "tokens=1" %%a in ('echo %%i') do (
		set /a WF+=1
		set wifi!WF!=%%a
		)
	)

	echo     WiFi:!wifi7!   状态:!wifi6!   信道:!wifi14!   信号:!wifi17!   速度:!wifi16!Mbps

	rem WIFI 网络质量判断
	if "!wifi17:~0,-1!" LEQ "95" ( set wifiresult1=WIFI信号不稳定 ) else ( echo. >nul 2>nul )
	if "!wifi14!" GEQ "36" ( set wifiresult2=当前正在使用 5GHz WIFI，网络游戏建议使用 2.4GHz，有线网络最佳 ) else ( echo. >nul 2>nul )

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
				set networkcardresult1=网卡数量:!textlinesnum!，存在其它加速器VPN设备虚拟网卡
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
for /f "tokens=*" %%i in ('wmic cpu get name ^|findstr /v "Name" ^|findstr "[^\S]"') do echo     CPU:  %%i
for /f %%i in ('wmic os get TotalVisibleMemorySize ^|findstr [0-9]') do set /a ram=%%i/1024
for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualram=%%i/1024
echo     内存:  %ram% MB; 当前分配虚拟内存:  %VirtualRAM% MB
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get AdapterRAM^,Name /value ^|findstr Name') do set vganame=%%i
echo     独立显卡 GPU:  %vganame%
for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do echo     分辨率:  %%j*%%i
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
		set ramresult=系统运行内存!ram!G, 建议升级
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
set dnsresult=运营商可能 DNS 劫持
echo.
) else (
echo. >nul 2>nul
)

echo %1 %dnsserverip% %dnsresult%
goto:eof

:dnseventlog
if "%systemver%"=="10" (
for /f "tokens=1,2,4,6* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName System -EntryType Warning -Newest 3 -After %year%-%month%-%day% -Source 'Microsoft-Windows-DNS-Client' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo     %%i %%j %%k响应域名: %%l %%m
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
echo Hosts 修改时间:    !filetime!
echo     有效解析条目总数: !hostsnumber!(行^)
echo     带 UHE 注释条目数:  !hostsnumberUHE!(行^)
echo     127 开头条目数:    !hostsnumber127!(行^)
echo     155 开头条目数:    !hostsnumber155!(行^)
) else (
echo Hosts 文件: 不存在
)
echo.

rem 数据诊断
for /f %%i in ("%WINDIR%\system32\drivers\etc\hosts") do set hostsize1=%%~zi
echo. >> %WINDIR%\system32\drivers\etc\hosts 2>nul
for /f %%i in ("%WINDIR%\system32\drivers\etc\hosts") do set hostsize2=%%~zi
if %hostsize1% equ %hostsize2% (
set hostsresult=Hosts 文件权限异常
) else (
echo. >nul 2>nul
)
goto:eof

:disableuac
echo.
echo 禁用 UAC
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d "0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d "0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d "3" /f >nul
echo.
echo 操作执行完成，请重新启动计算机
echo.
pause
goto menu

:enableuac
echo.
echo 恢复 UAC
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d "1" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d "5" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d "3" /f >nul
echo.
echo 操作执行完成，请重新启动计算机
echo.
pause
goto menu


:xboxfix
echo.
echo 修复 Xbox 多人游戏
echo.
echo 临时禁用 Teredo 隧道
netsh int teredo set state disable > NUL

echo 禁用华硕 GameFirst (建议卸载！)
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

echo 重置 Windows 防火墙策略
netsh advfirewall reset > NUL
netsh advfirewall set allprofiles state on > NUL
echo 排除冲突的 Windows 防火墙策略
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

echo 重置系统 IPv6 设置
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

echo 设置 IPv6 前缀优先级
netsh int ipv6 set prefix ::1/128 50 0 > NUL
netsh int ipv6 set prefix ::/0 40 1 > NUL
netsh int ipv6 set prefix 2002::/16 30 2 > NUL
netsh int ipv6 set prefix ::/96 20 3 > NUL
netsh int ipv6 set prefix ::ffff:0:0/96 100 4 > NUL

echo 启动 IP Helper 服务
sc start iphlpsvc > NUL

echo 配置 Teredo 隧道参数
route delete ::/0 > NUL
netsh int teredo set state type=default > NUL
netsh int teredo set state enterpriseclient teredo.remlab.net 20 0 > NUL
netsh int ipv6 add route ::/0 "Teredo Tunneling Pseudo-Interface" > NUL

echo 启动 Xbox 网络服务
sc start XboxNetApiSvc > NUL
sc start XblAuthManager > NUL

echo 修复工具运行结束！
echo Teredo 配置状态：
netsh int teredo show state
echo.
echo 已修复 Xbox 多人游戏 请重启系统后尝试联机
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

type %temp%\NetDiag.txt 2>nul >> %temp%\infocollect.txt 2>nul
type %temp%\gameprocessip.txt 2>nul >> %temp%\infocollect.txt 2>nul
del /f /q %temp%\NetDiag.txt >nul 2>nul

rem 游戏数据信息备份桌面
	if EXIST %temp%\infocollect.txt (
		taskkill /F /FI "WINDOWTITLE eq NetDiag.txt*" >nul 2>nul
		echo F| xcopy "%temp%\infocollect.txt" "%userprofile%\desktop\MDT\NetDiag.txt" /s /c /y /i >nul 2>nul
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
cls
echo.
echo 开始修复图标变白问题
timeout /t 3 /nobreak > NUL
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
cls
echo.
echo 正在设置开机启动项选择等待时间
echo 输入秒数后回车确认，请勿输入字母！！！
echo 若不想修改设置请关闭程序
set /p usertime=设定开机启动项选择的等待时间（秒）：
bcdedit /timeout %usertime%
echo 已设置开机启动项选择等待时间为%usertime%秒
echo 按任意键返回菜单
pause
goto menu

:WinFocus
cls
echo.
echo 开始修复 Windows 聚焦异常问题
echo 清理缓存
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings"
echo 重新部署程序包
PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage *ContentDeliveryManager*).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
echo 修复完成，请重启电脑，保持网络通畅，耐心等待10分钟。（建议白天修复，夜间聚焦推送不稳定）
pause
goto menu

:borecover
cls
:borecmenu
echo.
echo     请选择你要恢复的电源选项：
echo.
echo     0. 返回主菜单
echo     1. 恢复节能模式
echo     2. 恢复平衡模式
echo     3. 恢复高性能模式
echo     4. 恢复卓越性能模式（仅限于Win10/11专业版以上）
set /p binput=→  请输入：
if %binput% equ 0 goto menu
if %binput% equ 1 goto lowbatteryrec
if %binput% equ 2 goto medbatteryrec
if %binput% equ 3 goto highperfbatteryrec
if %binput% equ 4 goto extremeperfbatteryrec
echo →  输入异常，请检查输入选项
goto borecover
:lowbatteryrec
echo 开始恢复电源选项设置（部分机型可能无效，例如Surface）
echo.
echo 恢复节能模式
powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
echo.
goto batteryrecfin

:medbatteryrec
echo 开始恢复电源选项设置（部分机型可能无效，例如Surface）
echo.
echo 恢复平衡模式
powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
goto batteryrecfin

:highperfbatteryrec
echo 开始恢复电源选项设置（部分机型可能无效，例如Surface）
echo.
echo 恢复高性能模式
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo.
goto batteryrecfin

:extremeperfbatteryrec
echo 开始恢复电源选项设置（部分机型可能无效，例如Surface）
echo.
echo 恢复卓越性能模式（仅限于Win10/11专业版以上）
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
goto batteryrecfin

:batteryrecfin
echo.
echo     电源选项恢复完成
echo.
echo     请选择你要继续的操作：
echo     0. 返回主菜单
echo     1. 恢复其他电源选项
echo     2. 设置计算机使用的电源选项
set /p bfinput=→  请输入：
if %bfinput% equ 0 goto menu
if %bfinput% equ 1 goto borecmenu
if %bfinput% equ 2 goto setbatteryoption
echo →  输入异常，请检查输入选项
goto batteryrecfin

:wu0205
cls
echo.
echo 开始修复 Windows Update 异常问题
echo 配置系统服务
SC config wuauserv start= auto
SC config bits start= auto
SC config cryptsvc start= auto
SC config trustedinstaller start= auto
SC config wuauserv type=share
echo 临时停止系统服务
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
echo 备份系统补丁路径并删除旧的备份
rd /s /q C:\Windows\SoftwareDistribution.old
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
echo 重启系统服务
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
echo 修复完成，请重启电脑重试更新
echo 若仍存在问题，请使用系统修复功能进行修复
pause
goto menu

:taskmgrexeErr
cls
echo.
echo 开始修复 taskmgr.exe 关联问题
echo 重建注册表值

reg add "HKCR\Folder\shell\open" /v "MultiSelectModel" /d "Document" /f >nul
reg add "HKCR\Folder\shell\open\command" /ve /t REG_EXPAND_SZ /d "%%SystemRoot%%\Explorer.exe" /f >nul
reg add "HKCR\Folder\shell\open\command" /v "DelegateExecute" /f >nul
echo 操作执行完成
echo 修复完成，请重启电脑
pause
goto menu

:exeError
cls
echo.
echo 开始修复 exe 关联问题
echo 重建注册表值
timeout /t 1 /nobreak > NUL
reg add "HKCR\.exe" /ve /d "exefile" /f
reg add "HKCR\.exe" /v "Content Type" /d "application/x-msdownload" /f
reg add "HKCR\.exe\PersistentHandler" /ve /d "{098f2470-bae0-11cd-b579-08002b30bfeb}" /f

reg add "HKCR\exefile" /ve /d "Application" /f
reg add "HKCR\exefile" /v "EditFlags" /t REG_BINARY /d "38070000" /f
reg add "HKCR\exefile" /v "FriendlyTypeName" /t REG_EXPAND_SZ /d "@%%SystemRoot%%\System32\shell32.dll,-10156" /f
reg add "HKCR\exefile\DefaultIcon" /ve /d "%%1" /f
reg add "HKCR\exefile\shell" /f
reg add "HKCR\exefile\shell\Enable/Disable Digital Signature Icons" /f
reg add "HKCR\exefile\shell\Enable/Disable Digital Signature Icons\command" /ve /d "acsignopt.exe" /f
reg add "HKCR\exefile\shell\open" /v "EditFlags" /t REG_BINARY /d "00000000" /f
reg add "HKCR\exefile\shell\open\command" /ve /d "\"%%1\" %%*" /f
reg add "HKCR\exefile\shell\open\command" /v "IsolatedCommand" /d "\"%%1\" %%*" /f
reg add "HKCR\exefile\shell\runas" /v "HasLUAShield" /d "" /f
reg add "HKCR\exefile\shell\runas\command" /ve /d "\"%%1\" %%*" /f
reg add "HKCR\exefile\shell\runas\command" /v "IsolatedCommand" /d "\"%%1\" %%*" /f
reg add "HKCR\exefile\shell\runasuser" /ve /d "@shell32.dll,-50944" /f
reg add "HKCR\exefile\shell\runasuser" /v "Extended" /d "" /f
reg add "HKCR\exefile\shell\runasuser" /v "SuppressionPolicyEx" /d "{F211AA05-D4DF-4370-A2A0-9F19C09756A7}" /f
reg add "HKCR\exefile\shell\runasuser\command" /v "DelegateExecute" /d "{ea72d00e-4960-42fa-ba92-7792a7944c1d}" /f
reg add "HKCR\exefile\shellex" /f
reg add "HKCR\exefile\shellex\ContextMenuHandlers" /ve /d "Compatibility" /f
reg add "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f
reg add "HKCR\exefile\shellex\ContextMenuHandlers\NvAppShExt" /ve /d "{A929C4CE-FD36-4270-B4F5-34ECAC5BD63C}" /f
reg add "HKCR\exefile\shellex\ContextMenuHandlers\OpenGLShExt" /ve /d "{E97DEC16-A50D-49bb-AE24-CF682282E08D}" /f
reg add "HKCR\exefile\shellex\ContextMenuHandlers\PintoStartScreen" /ve /d "{470C0EBD-5D73-4d58-9CED-E91E22E23282}" /f
reg add "HKCR\exefile\shellex\DropHandler" /ve /d "{86C86720-42A0-1069-A2E8-08002B30309D}" /f
reg add "HKCR\exefile\shellex\PropertySheetHandlers" /f
reg add "HKCR\exefile\shellex\PropertySheetHandlers\Digital Signatures" /ve /d "{22391867-2469-4DEC-8091-901A5AA1EF12}" /f
reg add "HKCR\exefile\shellex\PropertySheetHandlers\ShimLayer Property Page" /ve /d "{513D916F-2A8E-4F51-AEAB-0CBC76FB1AF8}" /f
reg add "HKCR\exefile\shellex\PropertySheetHandlers\{B41DB860-64E4-11D2-9906-E49FADC173CA}" /ve /d "" /f
reg add "HKCR\exefile\shellex\PropertySheetHandlers\{B41DB860-8EE4-11D2-9906-E49FADC173CA}" /ve /d "" /f
echo 操作执行完成
echo.

echo 重建 exe 关联
assoc .exe=exefile
echo 操作执行完成
echo 所有操作已执行完成
echo 修复完成，请重启电脑
pause
goto menu

:uautorunon
cls
echo.
echo 更新注册表信息
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 149 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 149 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\cdrom" /v "Autorun" /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom" /v "Autorun" /t REG_DWORD /d 1 /f
echo 设置完成，可移动设备自动运行已开启
pause
goto menu



:uautorunoff
cls
echo.
echo 更新注册表信息
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f
reg add "HKLM\SYSTEM\ControlSet001\Services\cdrom" /v "Autorun" /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\cdrom" /v "Autorun" /t REG_DWORD /d 0 /f
echo 设置完成，可移动设备自动运行已关闭
pause
goto menu

:hibernateon
cls
echo.
powercfg -h on
echo 系统休眠已开启
pause
goto menu

:hibernateoff
cls
echo.
powercfg -h off
echo 系统休眠已关闭
pause
goto menu

:deactivate
cls
echo.
echo     警告：使用此功能将会导致 Windows 变为未激活状态！
echo     一般情况下，此功能仅在出现激活异常或者密钥异常的情况下使用
echo     如果您不知道您在做什么，请退出程序或者输入其他并确认回到主页面
echo     如果您明白并能承担操作后果，请在下方输入 Yes 来继续操作（区分大小写）
timeout /t 3 /nobreak > NUL
set /p input=→  请确认您的操作（区分大小写）：
if %input% equ Yes goto deaconfirm
echo     确认操作异常，已取消操作
pause
goto menu
:deaconfirm
echo 卸载 Windows 密钥
slmgr /upk
echo 重置 Windows 评估期
slmgr /rearm
echo 重置完成，Windows 已变为未激活状态，请重启计算机
pause
goto menu

:gpeditfix
cls
echo.
echo 开始修复组策略问题
pushd "%~dp0"
dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt
dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt
for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"C:\Windows\servicing\Packages\%%i"
echo 完成修复，请重启计算机
pause
goto menu

:junkclean
cls
echo.
echo 开始垃圾清理进程
echo.
echo 系统盘扫描
echo.

echo 清理自动更新补丁日志
del /f /s /q "%windir%\SoftwareDistribution\DataStore\Logs\*.log" >nul 2>nul
del /f /s /q "%windir%\SoftwareDistribution\DataStore\Logs\*.jrs" >nul 2>nul
echo 操作执行完成
echo.

echo 清理错误报告
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*.wer" >nul 2>nul
del /f /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 Windows Search 日志文件
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jcp" >nul 2>nul
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jtx" >nul 2>nul
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jr" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 IIS 日志文件
del /f /s /q "%windir%\System32\LogFiles\Fax\Incoming\*.*" >nul 2>nul
del /f /s /q "%windir%\System32\LogFiles\Fax\outcoming\*.*" >nul 2>nul
del /f /s /q "%windir%\System32\LogFiles\setupcln\setupact.log" >nul 2>nul
del /f /s /q "%windir%\System32\LogFiles\setupcln\setuperr.log" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 Windows 设置日志文件
del /f /s /q "%windir%\setupact.log" >nul 2>nul
del /f /s /q "%windir%\setuperr.log" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 .Net Framework 日志
del /f /s /q "%windir%\Microsoft.NET\Framework\*.log" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 Windows 日志
del /f /s /q "%windir%\*.log" >nul 2>nul
echo 操作执行完成
echo.

echo 清理系统临时文件
rd /s /q %windir%\temp & md %windir%\temp >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*" >nul 2>nul
del /f /s /q "%userprofile%\Local Settings\Temp\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理崩溃转储文件
del /f /q %userprofile%\AppData\Local\CrashDumps\*.* >nul 2>nul
echo 操作执行完成
echo.

echo 清理 Cookies
del /f /q %userprofile%\cookies\*.* >nul 2>nul
echo 操作执行完成
echo.

echo 清理最近使用文件和跳转列表
del /f /q %userprofile%\recent\*.* >nul 2>nul
del /f /s /q "%userprofile%\recent\*.*" >nul 2>nul
del /f /s /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理临时 Internet 文件
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Temporary Internet Files\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理字体缓存
del /f /s /q "%windir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 CryptoAPI 证书缓存
del /f /s /q "%userprofile%\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理预加载文件
del /f /s /q "%windir%\Prefetch\*.pf" >nul 2>nul
echo 操作执行完成
echo.

echo 清理自动更新补丁文件
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理缩略图缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*.db" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\IconCacheToDelete\*.tmp" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 Microsoft Edge 缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Extension State\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Session Storage\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\JumpListIconsRecentClosed\*.tmp" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 清理 Internet Explorer 缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Internet Explorer\DOMStore\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\container.dat" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\deprecated.cookie" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\WebCache\*.*" >nul 2>nul
echo 操作执行完成
echo.

echo 系统盘整体清理
del /f /s /q %systemdrive%\*.tmp >nul 2>nul
del /f /s /q %systemdrive%\*._mp >nul 2>nul
del /f /s /q %systemdrive%\*.log >nul 2>nul
del /f /s /q %systemdrive%\*.gid >nul 2>nul
del /f /s /q %systemdrive%\*.chk >nul 2>nul
del /f /s /q %systemdrive%\*.old >nul 2>nul
del /f /s /q %systemdrive%\recycled\*.* >nul 2>nul
del /f /s /q %windir%\*.bak >nul 2>nul
del /f /s /q %windir%\prefetch\*.* >nul 2>nul
echo 操作执行完成
echo.

echo 所有操作已执行完成
echo 清理完成
pause
goto menu

:winbutton
cls
echo.
echo 开始修复桌面图标间距异常、窗口右上角关闭最大化最小化按钮异常问题
echo 修复注册表异常信息(还原默认值)
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "BorderWidth" /d "-15" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionHeight" /d "-330" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "CaptionWidth" /d "-330" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconTitleWrap" /d "1" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuHeight" /d "-285" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MenuWidth" /d "-285" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollHeight" /d "-255" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "ScrollWidth" /d "-255" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "Shell Icon Size" /d "32" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionHeight" /d "-330" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "SmCaptionWidth" /d "-330" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "PaddedBorderWidth" /d "-60" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconSpacing" /d "-1125" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "IconVerticalSpacing" /d "-1125" /f >nul
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v "MinAnimate" /d "1" /f >nul
echo 修复完成，请重启电脑
pause
goto menu

:msstorefix
cls
echo 开始修复微软商店异常问题
echo 前置修复：注册表修复
echo 修复 SSL 3.0 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "CheckedValue" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "DefaultValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "HelpID" /d "iexplore.hlp#50129" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "Mask" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-4753" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "Text" /d "SSL 3.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.0 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "CheckedValue" /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "DefaultValue" /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "Mask" /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-4754" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "Text" /d "TLS 1.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.1 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "CheckedValue" /t REG_DWORD /d 512 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "DefaultValue" /t REG_DWORD /d 512 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "Mask" /t REG_DWORD /d 512 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "OSVersion" /d "3.6.1.0.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-6800" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "Text" /d "TLS 1.1" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.2 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "CheckedValue" /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "DefaultValue" /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "Mask" /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "OSVersion" /d "3.6.1.0.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-6801" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "Text" /d "TLS 1.2" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.3 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "CheckedValue" /t REG_DWORD /d 8192 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "DefaultValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "Mask" /t REG_DWORD /d 8192 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "OSVersion" /d "3.6.1.0.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-6802" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "Text" /d "TLS 1.3" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.
echo 前置修复：重置 IE
del /f /q "%temp%\mb" >nul 2>nul
echo Miniblink 缓存清理成功
Rundll32 InetCpl.cpl,ClearMyTracksByProcess 255
echo IE 缓存清理成功
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
echo IE 已重置
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo IE 组件已修复
echo 清空 IE 代理设置
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
echo.
echo 前置修复：重置 LSP 设置
netsh winsock reset 
echo 修改 DNS 为微软 DNS
call:dnssetting 4.2.2.2 223.5.5.5
echo 再次重置 LSP 设置
netsh winsock reset 
echo 重新部署微软商店
powershell get-appxpackage *store* | remove-Appxpackage 
powershell add-appxpackage -register "C:\Program Files\WindowsApps\*Store*\AppxManifest.xml" -disabledevelopmentmode 
echo 调用原生重置
wsreset
echo 在接下来的弹窗（Internet属性）中，请点击高级选项卡，勾选如下选项：
echo “使用 SSL 3.0”（可选）、“使用 TLS 1.0”、“使用 TLS 1.1”（可选）、“使用 TLS 1.2”、“使用 TLS 1.3”
timeout /t 3 /nobreak > NUL
rundll32.exe shell32.dll,Control_RunDLL inetcpl.cpl
rem start inetcpl.cpl
echo 勾选完成后，点击确定
timeout /t 3 /nobreak > NUL
echo 修复完成，请重启电脑后再次打开微软商城
pause
goto menu

:rightadmadd
cls
echo.
echo 添加右键菜单（管理员取得所有权）
echo 更新注册表信息
reg add "HKCR\*\shell\runas" /ve /d "Grant Administrator Access" /f
reg add "HKCR\*\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\*\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\*\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\exefile\shell\runas2" /ve /d "Grant Administrator Access" /f
reg add "HKCR\exefile\shell\runas2" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\exefile\shell\runas2\command" /ve /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\exefile\shell\runas2\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant administrators:F" /f
reg add "HKCR\Directory\shell\runas" /ve /d "Grant Administrator Access" /f
reg add "HKCR\Directory\shell\runas" /v "NoWorkingDirectory" /d "" /f
reg add "HKCR\Directory\shell\runas\command" /ve /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
reg add "HKCR\Directory\shell\runas\command" /v "IsolatedCommand" /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant administrators:F /t" /f
echo 右键菜单添加完毕（管理员取得所有权）
pause
goto menu

:rightadmdel
cls
echo.
echo 取消右键菜单（管理员取得所有权）
echo 更新注册表信息
reg delete "HKEY_CLASSES_ROOT\*\shell\runas" /f
reg delete "HKEY_CLASSES_ROOT\exefile\shell\runas2" /f
reg delete "HKEY_CLASSES_ROOT\Directory\shell\runas" /f
echo 已移除右键菜单（管理员取得所有权）
pause
goto menu

:iemainpagefix
cls
echo.
echo 开始修复 IE 主页
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:start" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "https://www.msn.cn/zh-cn" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /d "http://go.microsoft.com/fwlink/?LinkId=54896" /f
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "http://go.microsoft.com/fwlink/?LinkId=625115" /f
echo 修复完成
pause
goto menu

:win7aero
cls
echo.
echo 设置注册表信息，强制开启 Aero
reg add "HKCU\Software\Microsoft\Windows\DWM" /v Composition /t reg_dword /d 00000001 /f
reg add "HKCU\Software\Microsoft\Windows\DWM" /v CompositionPolicy /t reg_dword /d 00000002 /f
echo 服务重启
net stop uxsms
net start uxsms
echo 修复完成，请重启电脑开启 Aero 效果
pause
goto menu

:vacfix
cls
echo.
echo 前置修复：重置网络服务
netsh winsock reset
echo 前置修复：清理 DNS 缓存
ipconfig /flushdns

goto steam

:steam
echo 正在检测 Steam 是否开启......
tasklist | find /I "Steam.exe"
if errorlevel 1 goto steamchina
if not errorlevel 1 goto startvacfix

:steamchina
echo 正在检测国服启动器是否开启......
tasklist | find /I "steamchina.exe"
if errorlevel 1 goto stopsteam
if not errorlevel 1 goto startvacfix

:stopsteam
echo Steam 和国服启动器均未开启
goto startvacfix

:killsteam
echo Steam已开启
echo 正在强制关闭
taskkill /F /IM Steam.exe
echo 已强制关闭
goto startvacfix

:killsteamchina
echo Steam 已开启
echo 正在强制关闭
taskkill /F /IM steamchina.exe
echo 已强制关闭
goto startvacfix

:startvacfix
echo 开始解决 VAC 屏蔽

echo 开启 Network Connections
sc config Netman start= AUTO
sc start Netman

echo 开启 Remote Access Connection Manager
sc config RasMan start= AUTO
sc start RasMan

echo 开启 Telephony
sc config TapiSrv start= AUTO
sc start TapiSrv

echo 开启 Windows Firewall
sc config MpsSvc start= AUTO
sc start MpsSvc
netsh advfirewall set allprofiles state on

echo 恢复 Data Execution Prevention 启动设置为默认值
bcdedit /deletevalue nointegritychecks
bcdedit /deletevalue loadoptions
bcdedit /debug off
bcdedit /deletevalue nx

echo 正在获取你的 Steam 或国服启动器目录
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\SOFTWARE\Valve\Steam" ^| find /i "SteamPath"') do set "SteamPath=%%k" 
if "%SteamPath%" NEQ "0x1" (goto Autosteampath) else (goto Manualerr)

:Autosteampath
echo Steam 或国服启动器目录为%SteamPath% 

echo 开始安装 Steam Services
cd /d "%SteamPath%\bin"
steamservice  /install
ping -n 3 127.0.0.1>nul
echo 开始修复 Steam Services
steamservice  /repair
ping -n 3 127.0.0.1>nul
echo .
echo 修复 Steam Services 完毕
echo 出现"Steam client service installation complete"且无任何"Fail"字样
echo (如"Add firewall exception failed for steamservice.exe"出现)才可以结束，
echo 否则请检查您的防火墙设置(关闭“不允许例外”选项)

echo 启动 Steam Services 服务
sc config "Steam Client Service" start= AUTO
sc start "Steam Client Service"

echo 修复完成，请重启 Steam
pause
goto menu

:Manualerr
echo 获取路径异常，修复终止，请重新安装 Steam
pause
goto menu

:fpclean
cls
echo.
echo 开始清理 Flash Player 播放器缓存
reg delete "HKCU\Software\Macromedia\FlashPlayer" /f >nul
echo 清理完成
pause
goto menu

:noshortcut
cls
echo.
echo 修改注册表设置
reg delete "HKCR\lnkfile" /v "IsShortcut" /f
reg delete "HKCR\piffile" /v "IsShortcut" /f
taskkill /im explorer.exe /F
start explorer.exe
echo 快捷方式小箭头清除完成，推荐重启计算机
pause
goto menu

:restoreshortcut
cls
echo.
echo 还原注册表设置
reg add "HKCR\lnkfile" /v "IsShortcut" /d "" /f
reg add "HKCR\piffile" /v "IsShortcut" /d "" /f
taskkill /im explorer.exe /F
start explorer.exe
echo 快捷方式小箭头恢复完成，推荐重启计算机
pause
goto menu

:RDclipboard
cls
echo.
echo 重启远程剪贴板服务程序
taskkill -im rdpclip.exe -f
start rdpclip.exe
echo 修复完成
pause
goto menu

:vmmemstop
cls
echo.
echo 即将开始停止 vmmem 服务
echo 请按任意键开始操作，若不想继续操作请关闭程序
pause
echo.
echo 停止 vmmem 服务
sc stop HvHost
echo 完成
pause
goto menu

:deltabletpc
cls
echo.
echo 即将开始删除 TabletPC 组件
echo 请按任意键开始操作，若不想继续操作请关闭程序
pause
echo.
echo 开始删除 TabletPC 组件
dism /NoRestart /Quiet /Online /Disable-Feature /FeatureName:"TabletPCOC"
echo 完成，如需重新启用，请转到“启用或关闭Windows功能”面板中再次勾选启用
pause
goto menu

:notepadsaveencoder
cls
echo.
echo     记事本常见编码格式：
echo.
echo     0. 返回主菜单
echo     1. ANSI （Win7 默认）
echo     2. UTF-16 LE
echo     3. UTF-16 BE
echo     4. UTF-8 BOM
echo     5. UTF-8 （Win7 以上默认）
set /p encode=→  输入你要设置的编码代号：
if %encode% equ 0 goto menu
if %encode% equ 1 goto npansi
if %encode% equ 2 goto nputf16le
if %encode% equ 3 goto nputf16be
if %encode% equ 4 goto nputf8bom
if %encode% equ 5 goto nputf8
echo.
echo →  输入异常，请检查输入选项
echo.
pause >nul
goto notepadsaveencoder

:npansi
cls
echo.
reg add "HKCU\Software\Microsoft\Notepad" /v "iDefaultEncoding" /t REG_DWORD /d 1 /f >nul
echo 已设置记事本默认保存编码格式为 ANSI
pause
goto menu

:nputf16le
cls
echo.
reg add "HKCU\Software\Microsoft\Notepad" /v "iDefaultEncoding" /t REG_DWORD /d 2 /f >nul
echo 已设置记事本默认保存编码格式为 UTF-16 LE
pause
goto menu

:nputf16be
cls
echo.
reg add "HKCU\Software\Microsoft\Notepad" /v "iDefaultEncoding" /t REG_DWORD /d 3 /f >nul
echo 已设置记事本默认保存编码格式为 UTF-16 BE
pause
goto menu

:nputf8bom
cls
echo.
reg add "HKCU\Software\Microsoft\Notepad" /v "iDefaultEncoding" /t REG_DWORD /d 4 /f >nul
echo 已设置记事本默认保存编码格式为 UTF-8 BOM
pause
goto menu

:nputf8
cls
echo.
reg add "HKCU\Software\Microsoft\Notepad" /v "iDefaultEncoding" /t REG_DWORD /d 5 /f >nul
echo 已设置记事本默认保存编码格式为 UTF-8
pause
goto menu

:insiderchannel
echo 初始化脚本
@setlocal DisableDelayedExpansion
rem @echo off
set "scriptver=2.6.4"

set "_args=%*"
set "_elv="
if not defined _args goto :NoProgArgs
if "%~1"=="" set "_args="&goto :NoProgArgs
set _args=%_args:"=%
for %%A in (%_args%) do (
if /i "%%A"=="-wow" (set _rel1=1) else if /i "%%A"=="-arm" (set _rel2=1)
)
:NoProgArgs
set "_cmdf=%~f0"
if exist "%SystemRoot%\Sysnative\cmd.exe" if not defined _rel1 (
setlocal EnableDelayedExpansion
start %SystemRoot%\Sysnative\cmd.exe /c ""!_cmdf!" -wow %*"
exit /b
)
if exist "%SystemRoot%\SysArm32\cmd.exe" if /i %PROCESSOR_ARCHITECTURE%==AMD64 if not defined _rel2 (
setlocal EnableDelayedExpansion
start %SystemRoot%\SysArm32\cmd.exe /c ""!_cmdf!" -arm %*"
exit /b
)
set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "SysPath=%SystemRoot%\Sysnative"
set "Path=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)

for /f "tokens=6 delims=[]. " %%i in ('ver') do set build=%%i

if %build% LSS 17763 (
    echo ==========================================
    echo 此脚本仅适用于 Windows 10 v1809 及更高版本
    echo ==========================================
    echo.
    pause
    goto :EOF
)

reg query HKU\S-1-5-19 1>nul 2>nul
if %ERRORLEVEL% equ 0 goto :START_SCRIPT
rem 此部分冗余，但保留，后续权限验证可参考
echo ==========================
echo 此脚本需要以管理员身份运行
echo ==========================
echo.
pause
goto :EOF

:START_SCRIPT
set "FlightSigningEnabled=0"
bcdedit /enum {current} | findstr /I /R /C:"^flightsigning *Yes$" >nul 2>&1
if %ERRORLEVEL% equ 0 set "FlightSigningEnabled=1"

:CHOICE_MENU
cls
title 离线Windows预览体验计划强制报名脚本 v%scriptver% 汉化版
set "choice="
echo.
echo 0 - Canary Channel 金丝雀通道（最不稳定，更新最为频繁，大概率一天一更）
echo 1 - Dev Channel 开发者通道（不稳定，更新较为频繁，几天一更）
echo 2 - Beta 渠道 测试版通道（相对稳定，更新相对频繁，周更）
echo 3 - Release Preview Channel 发布预览通道（较为稳定，最接近正式版的版本）
echo.
echo 4 - 停止接收Windows预览计划的先行版本
echo 5 - 不做任何修改直接退出
echo.
set /p choice="请选择你的选项："
echo.
if /I "%choice%"=="0" goto :ENROLL_CAN
if /I "%choice%"=="1" goto :ENROLL_DEV
if /I "%choice%"=="2" goto :ENROLL_BETA
if /I "%choice%"=="3" goto :ENROLL_RP
if /I "%choice%"=="4" goto :STOP_INSIDER
if /I "%choice%"=="5" goto :menu
goto :CHOICE_MENU

:ENROLL_RP
set "Channel=ReleasePreview"
set "Fancy=Release Preview Channel"
set "BRL=8"
set "Content=Mainline"
set "Ring=External"
set "RID=11"
goto :ENROLL

:ENROLL_BETA
set "Channel=Beta"
set "Fancy=Beta Channel"
set "BRL=4"
set "Content=Mainline"
set "Ring=External"
set "RID=11"
goto :ENROLL

:ENROLL_DEV
set "Channel=Dev"
set "Fancy=Dev Channel"
set "BRL=2"
set "Content=Mainline"
set "Ring=External"
set "RID=11"
goto :ENROLL

:ENROLL_CAN
set "Channel=CanaryChannel"
set "Fancy=Canary Channel"
set "BRL="
set "Content=Mainline"
set "Ring=External"
set "RID=11"
goto :ENROLL

:RESET_INSIDER_CONFIG
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Account" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Cache" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Restricted" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ToastNotification" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\WUMUDCat" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\Ring%Ring%" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\RingExternal" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\RingPreview" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\RingInsiderSlow" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\RingInsiderFast" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /f /v AllowTelemetry
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /f /v AllowTelemetry
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f /v BranchReadinessLevel
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\Setup\WindowsUpdate" /f /v AllowWindowsUpdate
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup" /f /v AllowUpgradesWithUnsupportedTPMOrCPU
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /v BypassRAMCheck
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /v BypassSecureBootCheck
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /v BypassStorageCheck
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /v BypassTPMCheck
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\PCHC" /f /v UpgradeEligibility
goto :EOF

:ADD_INSIDER_CONFIG
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator" /f /t REG_DWORD /v EnableUUPScan /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\Ring%Ring%" /f /t REG_DWORD /v Enabled /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\SLS\Programs\WUMUDCat" /f /t REG_DWORD /v WUMUDCATEnabled /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v EnablePreviewBuilds /d 2
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v IsBuildFlightingEnabled /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v IsConfigSettingsFlightingEnabled /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v IsConfigExpFlightingEnabled /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v TestFlags /d 32
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v RingId /d %RID%
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_SZ /v Ring /d "%Ring%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_SZ /v ContentType /d "%Content%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_SZ /v BranchName /d "%Channel%"
if %build% LSS 21990 reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Strings" /f /t REG_SZ /v StickyXaml /d "<StackPanel xmlns="^""http://schemas.microsoft.com/winfx/2006/xaml/presentation"^""><TextBlock Style="^""{StaticResource BodyTextBlockStyle }"^"">This device has been enrolled to the Windows Insider program using OfflineInsiderEnroll v%scriptver%. If you want to change settings of the enrollment or stop receiving Windows Insider builds, please use the script. <Hyperlink NavigateUri="^""https://github.com/abbodi1406/offlineinsiderenroll"^"" TextDecorations="^""None"^"">Learn more</Hyperlink></TextBlock><TextBlock Text="^""Applied configuration"^"" Margin="^""0,20,0,10"^"" Style="^""{StaticResource SubtitleTextBlockStyle}"^"" /><TextBlock Style="^""{StaticResource BodyTextBlockStyle }"^"" Margin="^""0,0,0,5"^""><Run FontFamily="^""Segoe MDL2 Assets"^"">&#xECA7;</Run> <Span FontWeight="^""SemiBold"^"">%Fancy%</Span></TextBlock><TextBlock Text="^""Channel: %Channel%"^"" Style="^""{StaticResource BodyTextBlockStyle }"^"" /><TextBlock Text="^""Content: %Content%"^"" Style="^""{StaticResource BodyTextBlockStyle }"^"" /><TextBlock Text="^""Telemetry settings notice"^"" Margin="^""0,20,0,10"^"" Style="^""{StaticResource SubtitleTextBlockStyle}"^"" /><TextBlock Style="^""{StaticResource BodyTextBlockStyle }"^"">Windows Insider Program requires your diagnostic data collection settings to be set to <Span FontWeight="^""SemiBold"^"">Full</Span>. You can verify or modify your current settings in <Span FontWeight="^""SemiBold"^"">Diagnostics &amp; feedback</Span>.</TextBlock><Button Command="^""{StaticResource ActivateUriCommand}"^"" CommandParameter="^""ms-settings:privacy-feedback"^"" Margin="^""0,10,0,0"^""><TextBlock Margin="^""5,0,5,0"^"">Open Diagnostics &amp; feedback</TextBlock></Button></StackPanel>"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /f /t REG_DWORD /v UIHiddenElements /d 65535
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /f /t REG_DWORD /v UIDisabledElements /d 65535
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /f /t REG_DWORD /v UIServiceDrivenElementVisibility /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /f /t REG_DWORD /v UIErrorMessageVisibility /d 192
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /f /t REG_DWORD /v AllowTelemetry /d 3
if defined BRL reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f /t REG_DWORD /v BranchReadinessLevel /d %BRL%
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /f /t REG_DWORD /v UIHiddenElements_Rejuv /d 65534
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility" /f /t REG_DWORD /v UIDisabledElements_Rejuv /d 65535
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_SZ /v UIRing /d "%Ring%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_SZ /v UIContentType /d "%Content%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_SZ /v UIBranch /d "%Channel%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_DWORD /v UIOptin /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_SZ /v RingBackup /d "%Ring%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_SZ /v RingBackupV2 /d "%Ring%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_SZ /v BranchBackup /d "%Channel%"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Cache" /f /t REG_SZ /v PropertyIgnoreList /d "AccountsBlob;;CTACBlob;FlightIDBlob;ServiceDrivenActionResults"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Cache" /f /t REG_SZ /v RequestedCTACAppIds /d "WU;FSS"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Account" /f /t REG_DWORD /v SupportedTypes /d 3
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Account" /f /t REG_DWORD /v Status /d 8
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" /f /t REG_DWORD /v UseSettingsExperience /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v AllowFSSCommunications /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v UICapabilities /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v IgnoreConsolidation /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v MsaUserTicketHr /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v MsaDeviceTicketHr /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v ValidateOnlineHr /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v LastHR /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v ErrorState /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v PilotInfoRing /d 3
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v RegistryAllowlistVersion /d 4
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\ClientState" /f /t REG_DWORD /v FileAllowlistVersion /d 1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI" /f /t REG_DWORD /v UIControllableState /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_DWORD /v UIDialogConsent /d 0
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_DWORD /v UIUsage /d 26
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_DWORD /v OptOutState /d 25
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" /f /t REG_DWORD /v AdvancedToggleState /d 24
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\WindowsUpdate" /f /t REG_DWORD /v AllowWindowsUpdate /d 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\MoSetup" /f /t REG_DWORD /v AllowUpgradesWithUnsupportedTPMOrCPU /d 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /t REG_DWORD /v BypassRAMCheck /d 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /t REG_DWORD /v BypassSecureBootCheck /d 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /t REG_DWORD /v BypassStorageCheck /d 1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\Setup\LabConfig" /f /t REG_DWORD /v BypassTPMCheck /d 1
reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\PCHC" /f /t REG_DWORD /v UpgradeEligibility /d 1
if %build% LSS 21990 goto :EOF
(
echo Windows Registry Editor Version 5.00
echo.
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Strings]
echo "StickyMessage"="{\"Message\":\"Device Enrolled Using OfflineInsiderEnroll\",\"LinkTitle\":\"\",\"LinkUrl\":\"\",\"DynamicXaml\":\"^<StackPanel xmlns=\\\"http://schemas.microsoft.com/winfx/2006/xaml/presentation\\\"^>^<TextBlock Style=\\\"{StaticResource BodyTextBlockStyle }\\\"^>This device has been enrolled to the Windows Insider program using OfflineInsiderEnroll v%scriptver%. If you want to change settings of the enrollment or stop receiving Windows Insider builds, please use the script. ^<Hyperlink NavigateUri=\\\"https://github.com/abbodi1406/offlineinsiderenroll\\\" TextDecorations=\\\"None\\\"^>Learn more^</Hyperlink^>^</TextBlock^>^<TextBlock Text=\\\"Applied configuration\\\" Margin=\\\"0,20,0,10\\\" Style=\\\"{StaticResource SubtitleTextBlockStyle}\\\" /^>^<TextBlock Style=\\\"{StaticResource BodyTextBlockStyle }\\\" Margin=\\\"0,0,0,5\\\"^>^<Run FontFamily=\\\"Segoe MDL2 Assets\\\"^>^&#xECA7;^</Run^> ^<Span FontWeight=\\\"SemiBold\\\"^>%Fancy%^</Span^>^</TextBlock^>^<TextBlock Text=\\\"Channel: %Channel%\\\" Style=\\\"{StaticResource BodyTextBlockStyle }\\\" /^>^<TextBlock Text=\\\"Content: %Content%\\\" Style=\\\"{StaticResource BodyTextBlockStyle }\\\" /^>^<TextBlock Text=\\\"Telemetry settings notice\\\" Margin=\\\"0,20,0,10\\\" Style=\\\"{StaticResource SubtitleTextBlockStyle}\\\" /^>^<TextBlock Style=\\\"{StaticResource BodyTextBlockStyle }\\\"^>Windows Insider Program requires your diagnostic data collection settings to be set to ^<Span FontWeight=\\\"SemiBold\\\"^>Full^</Span^>. You can verify or modify your current settings in ^<Span FontWeight=\\\"SemiBold\\\"^>Diagnostics ^&amp; feedback^</Span^>.^</TextBlock^>^<Button Command=\\\"{StaticResource ActivateUriCommand}\\\" CommandParameter=\\\"ms-settings:privacy-feedback\\\" Margin=\\\"0,10,0,0\\\"^>^<TextBlock Margin=\\\"5,0,5,0\\\"^>Open Diagnostics ^&amp; feedback^</TextBlock^>^</Button^>^</StackPanel^>\",\"Severity\":0}"
echo.
)>"%SystemRoot%\oie.reg"
reg.exe import "%SystemRoot%\oie.reg"
del /f /q "%SystemRoot%\oie.reg"
goto :EOF

:ENROLL
echo 正在应用更改...
call :RESET_INSIDER_CONFIG 1>NUL 2>NUL
call :ADD_INSIDER_CONFIG 1>NUL 2>NUL
bcdedit /set {current} flightsigning yes >nul 2>&1
echo 完成

echo.
if %FlightSigningEnabled% neq 1 goto :ASK_FOR_REBOOT
echo 请按任意键回到主菜单
pause >nul
goto menu

:STOP_INSIDER
echo 正在应用更改...
call :RESET_INSIDER_CONFIG 1>nul 2>nul
bcdedit /deletevalue {current} flightsigning >nul 2>&1
echo 完成

echo.
if %FlightSigningEnabled% neq 0 goto :ASK_FOR_REBOOT
echo 请按任意键回到主菜单
pause >nul
goto menu

:ASK_FOR_REBOOT
set "choice="
echo 需要重启计算机以完成应用更改
set /p choice="你想要现在重启计算机吗？ (y/N) "
if /I "%choice%"=="y" shutdown -r -t 0
if /I "%choice%"=="Y" shutdown -r -t 0
goto :EOF

:batteryreport
cls
echo ##############################
echo # 此脚本用于查看电池健康报告 #
echo ##############################
echo.
echo 部分电脑可能执行失败，请先检查主板电源相关设置
echo 启动诊断服务...
sc start DPS
echo 导出电池健康报告...
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
powercfg /batteryreport /output "%userprofile%\Desktop\MDT\Battery_Report.html"
echo.
echo 定位报告路径...
start %userprofile%\Desktop\MDT
echo.
echo 正在打开报告...
start %userprofile%\Desktop\MDT\Battery_Report.html
echo.
echo 导出报告操作执行完成，如遇异常请重新检查 BIOS 设置、服务与组策略设置
echo 请尽量避免使用精简版、定制版系统
echo 打开弹出的文件夹里的 Battery_Report.html 即可查看电池健康报告
echo 此报告具有时效性，更换电池或是一段时间后需要查看新的报告仍需运行此脚本
echo.
echo 电池健康度计算方法：(FULL CHARGE CAPACITY) / (DESIGN CAPACITY) * 100%%
echo 电池损耗度计算方法：1 - (FULL CHARGE CAPACITY) / (DESIGN CAPACITY) * 100%%
echo.
echo 电池健康度在 95%% 至 100%% 之间可以认为是全新电池
echo 大于 100%% 可以多尝试几次充放电校准，如果还是一样则无需担心，是全新电池
echo 电池健康度低于 80%% 时，请检查电池情况并更换新电池
pause
goto menu

:diskcleanmgr
start cleanmgr.exe
echo 已启动 Windows 磁盘清理程序（以管理员身份运行）
pause
goto menu

:GETHASH
cls
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
echo.
echo     HASH 获取
echo.
echo     请在下方输入要获取 HASH 值的文件路径
echo     若路径含空格，请用英文半角双引号将路径引用
echo     不引用会导致程序崩溃退出
echo     例如："C:\Test Path\example.exe"
echo     可以右键文件或文件夹，选择“复制文件地址”，再在此处粘贴
echo     或者选中文件或文件夹，按下“Ctrl + Shift + C”快捷键获取地址，再在此处粘贴
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在文件路径处输入 0 并回车确认

set /p input=→  请输入文件路径：

if %input% equ 0 goto menu

echo 程序识别到的文件路径为：%input%
echo 文件路径：%input%  >>%userprofile%\desktop\MDT\GET_HASH.log
echo.
echo. >>%userprofile%\desktop\MDT\GET_HASH.log
echo 开始计算 HASH 值
echo 提示：文件越大计算时间越久，请耐心等待...
echo 文件 MD2 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% MD2 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log

echo 文件 MD4 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% MD4 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log

echo 文件 MD5 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% MD5 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log

echo 文件 SHA1 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% SHA1 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log

echo 文件 SHA256 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% SHA256 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log

echo 文件 SHA384 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% SHA384 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log

echo 文件 SHA512 值： >>%userprofile%\desktop\MDT\GET_HASH.log
certutil -hashfile %input% SHA512 | findstr /v "[^0-9a-z]" >>%userprofile%\desktop\MDT\GET_HASH.log
echo.
echo ------------------------------------------------------------------------------------------ >>%userprofile%\desktop\MDT\GET_HASH.log

:finhash
echo HASH 值获取完成
echo 结果导出路径为： %userprofile%\desktop\MDT\GET_HASH.log
start %userprofile%\desktop\MDT\GET_HASH.log
echo.
echo     请选择你要继续的操作：
echo.
echo     1. 继续获取其他文件的HASH值
echo     2. 返回主菜单
set /p cinput=→  请输入选项：
if %cinput% equ 1 goto GETHASH
if %cinput% equ 2 goto menu
echo →  输入异常，请检查输入选项
goto finhash

:PrivCtrloff
cls
echo 禁用遥测系统跟踪服务
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul
sc stop DiagTrack
sc config "DiagTrack" start = Disabled
echo 遥测服务已禁用
pause
goto menu

:PrivCtrlon
cls
echo 启用遥测系统跟踪服务
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /f >nul
sc config "DiagTrack" start = auto
sc start DiagTrack
echo 遥测服务已启用
pause
goto menu

:defenderoff
cls
echo 更新注册表信息
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 1 /t REG_DWORD
echo 已禁用 Windows Defender
pause
goto menu

:defenderon
cls
echo 更新注册表信息
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /d 0 /t REG_DWORD
echo 已启用 Windows Defender
pause
goto menu



rem 微软激活脚本 Start
:MAS_ACTIVATOR

::  For command line switches, check https://massgrave.dev/command_line_switches.html
::  If you want to better understand script, read from MAS separate files version. 
::
::============================================================================
::
::   This script is a part of 'Microsoft Activation Scripts' (MAS) project.
::
::   Homepage: massgrave.dev
::      Email: windowsaddict@protonmail.com
::
::============================================================================




::========================================================================================================================================

:: Re-launch the script with x64 process if it was initiated by x86 process on x64 bit Windows
:: or with ARM64 process if it was initiated by x86/ARM32 process on ARM64 Windows

set "_cmdf=%~f0"
for %%# in (%*) do (
if /i "%%#"=="r1" set r1=1
if /i "%%#"=="r2" set r2=1
)

if exist %SystemRoot%\Sysnative\cmd.exe if not defined r1 (
setlocal EnableDelayedExpansion
start %SystemRoot%\Sysnative\cmd.exe /c ""!_cmdf!" %* r1"
exit /b
)

:: Re-launch the script with ARM32 process if it was initiated by x64 process on ARM64 Windows

if exist %SystemRoot%\SysArm32\cmd.exe if %PROCESSOR_ARCHITECTURE%==AMD64 if not defined r2 (
setlocal EnableDelayedExpansion
start %SystemRoot%\SysArm32\cmd.exe /c ""!_cmdf!" %* r2"
exit /b
)

::  Set Path variable, it helps if it is misconfigured in the system

set "PATH=%SystemRoot%\System32;%SystemRoot%\System32\wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "PATH=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%PATH%"
)

::  Check LF line ending

pushd "%~dp0"
>nul findstr /rxc:".*" "%~nx0"
if not %errorlevel%==0 (
echo:
echo Error: Script either has LF line ending issue, or it failed to read itself.
echo:
popd
ping 127.0.0.1 -n 6 > nul
exit /b
)
popd

::========================================================================================================================================

cls
color 07
title  Microsoft Activation Scripts

set _args=
set _elev=
set _MASunattended=

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args (
for %%A in (%_args%) do (
if /i "%%A"=="-el"                    set _elev=1
)
)

if defined _args echo "%_args%" | find /i "/" >nul && set _MASunattended=1

::========================================================================================================================================

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

call :_colorprep

set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :_color %Red% "==== ERROR ====" &echo:"

::========================================================================================================================================

if %winbuild% LSS 7600 (
%nceline%
echo Unsupported OS version detected.
echo Project is supported only for Windows 7/8/8.1/10/11 and their Server equivalent.
goto MASend
)

for %%# in (powershell.exe) do @if "%%~$PATH:#"=="" (
%nceline%
echo Unable to find powershell.exe in the system.
echo Aborting...
goto MASend
)

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"

setlocal EnableDelayedExpansion

::========================================================================================================================================

echo "!_batf!" | find /i "!_ttemp!" 1>nul && (
if /i not "!_work!"=="!_ttemp!" (
%nceline%
echo Script is launched from the temp folder,
echo Most likely you are running the script directly from the archive file.
echo:
echo Extract the archive file and launch the script from the extracted folder.
goto MASend
)
)

::========================================================================================================================================

::  Elevate script as admin and pass arguments and preventing loop

>nul fltmc || (
if not defined _elev %nul% %psc% "start cmd.exe -arg '/c \"!_PSarg:'=''!\"' -verb runas" && exit /b
%nceline%
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'.
goto MASend
)

if not exist "%SystemRoot%\Temp\" mkdir "%SystemRoot%\Temp" 1>nul 2>nul

::========================================================================================================================================

::  Run script with parameters in unattended mode

set _elev=
if defined _args echo "%_args%" | find /i "/S" %nul% && (set "_silent=%nul%") || (set _silent=)
if defined _args echo "%_args%" | find /i "/" %nul% && (
echo "%_args%" | find /i "/HWID"   %nul% && (setlocal & (call :HWIDActivation   %_args% %_silent%) & cls & endlocal)
echo "%_args%" | find /i "/KMS38"  %nul% && (setlocal & (call :KMS38Activation  %_args% %_silent%) & cls & endlocal)
echo "%_args%" | find /i "/KMS-"   %nul% && (setlocal & (call :KMSActivation    %_args% %_silent%) & cls & endlocal)
echo "%_args%" | find /i "/Insert" %nul% && (setlocal & (call :insert_hwidkey   %_args% %_silent%) & cls & endlocal)
exit /b
)

::========================================================================================================================================

setlocal DisableDelayedExpansion

::  Check desktop location

set _desktop_=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set "_desktop_=%%b"
if not defined _desktop_ for /f "delims=" %%a in ('%psc% "& {write-host $([Environment]::GetFolderPath('Desktop'))}"') do call set "_desktop_=%%a"

set "_pdesk=%_desktop_:'=''%"
setlocal EnableDelayedExpansion

::========================================================================================================================================

:MainMenu

cls
color 07
title  Microsoft Activation Scripts 1.8
rem mode 76, 30
set "mastemp=%SystemRoot%\Temp\__MAS"
if exist "%mastemp%\.*" rmdir /s /q "%mastemp%\" %nul%

echo:
echo:
echo:
echo:
echo:
echo:       ______________________________________________________________
echo:
echo:                 Activation Methods:
echo:
echo:             [1] HWID        ^|  Windows           ^|   Permanent
echo:             [2] KMS38       ^|  Windows           ^|   2038 Year
echo:             [3] Online KMS  ^|  Windows / Office  ^|    180 Days
echo:             __________________________________________________      
echo:
echo:             [4] Activation Status
echo:             [5] Troubleshoot
echo:             [6] Extras
echo:             [7] Help
echo:             [0] Exit
echo:       ______________________________________________________________
echo:
call :_color2 %_White% "          " %_Green% "Enter a menu option in the Keyboard [1,2,3,4,5,6,7,0] :"
choice /C:12345670 /N
set _erl=%errorlevel%

rem if %_erl%==8 exit /b
if %_erl%==8 goto :menu
if %_erl%==7 start https://massgrave.dev & goto :MainMenu
if %_erl%==6 goto:Extras
if %_erl%==5 setlocal & call :troubleshoot      & cls & endlocal & goto :MainMenu
if %_erl%==4 setlocal & call :_Check_Status_wmi & cls & endlocal & goto :MainMenu
if %_erl%==3 setlocal & call :KMSActivation     & cls & endlocal & goto :MainMenu
if %_erl%==2 setlocal & call :KMS38Activation   & cls & endlocal & goto :MainMenu
if %_erl%==1 setlocal & call :HWIDActivation    & cls & endlocal & goto :MainMenu
goto :MainMenu

::========================================================================================================================================

:Extras

cls
title  Extras
mode 76, 30
echo:
echo:
echo:
echo:
echo:
echo:
echo:       ______________________________________________________________
echo:
echo:             [1] Change Windows Edition
echo:
echo:             [2] Extract $OEM$ Folder
echo:             [3] Insert Windows HWID Key
echo:             [4] Activation Status [vbs]
echo:             __________________________________________________      
echo:                                                                     
echo:             [0] Go to Main Menu
echo:       ______________________________________________________________
echo:
call :_color2 %_White% "           " %_Green% "Enter a menu option in the Keyboard [1,2,3,4,0] :"
choice /C:12340 /N
set _erl=%errorlevel%

if %_erl%==5 goto :MainMenu
if %_erl%==4 setlocal & call :_Check_Status_vbs & cls & endlocal & goto :Extras
if %_erl%==3 setlocal & call :insert_hwidkey    & cls & endlocal & goto :Extras
if %_erl%==2 goto:Extract$OEM$
if %_erl%==1 setlocal & call :change_edition    & cls & endlocal & goto :Extras
goto :Extras

::========================================================================================================================================

:Extract$OEM$

cls
title  Extract $OEM$ Folder
mode 76, 30

if not exist "!_desktop_!\" (
%eline%
echo Desktop location was not detected, aborting...
echo _____________________________________________________
echo:
call :_color %_Yellow% "Press any key to go back..."
pause >nul
goto Extras
)

if exist "!_desktop_!\$OEM$\" (
%eline%
echo $OEM$ folder already exists on the Desktop.
echo _____________________________________________________
echo:
call :_color %_Yellow% "Press any key to go back..."
pause >nul
goto Extras
)

:Extract$OEM$2

cls
title  Extract $OEM$ Folder
mode 76, 30

echo:
echo:
echo:
echo:
echo:
echo:                    Extract $OEM$ folder on the desktop             
echo:       ______________________________________________________________
echo:                                                            
echo:             [1] HWID
echo:             [2] KMS38
echo:             [3] Online KMS
echo:             
echo:             [4] HWID  ^(Windows^) ^+ Online KMS ^(Office^)
echo:             [5] KMS38 ^(Windows^) ^+ Online KMS ^(Office^)
echo:             __________________________________________________      
echo:                                                                   
echo:             [0] Go Back
echo:       ______________________________________________________________
echo:  
call :_color2 %_White% "           " %_Green% "Enter a menu option in the Keyboard:"
choice /C:123450 /N
set _erl=%errorlevel%

if %_erl%==6 goto:Extras
if %_erl%==5 (set "_oem=KMS38 [Windows] + Online KMS [Office]" & set "para=/KMS38 /KMS-ActAndRenewalTask /KMS-Office" &goto:Extract$OEM$3)
if %_erl%==4 (set "_oem=HWID [Windows] + Online KMS [Office]" & set "para=/HWID /KMS-ActAndRenewalTask /KMS-Office" &goto:Extract$OEM$3)
if %_erl%==3 (set "_oem=Online KMS" & set "para=/KMS-ActAndRenewalTask /KMS-WindowsOffice" &goto:Extract$OEM$3)
if %_erl%==2 (set "_oem=KMS38" & set "para=/KMS38" &goto:Extract$OEM$3)
if %_erl%==1 (set "_oem=HWID" & set "para=/HWID" &goto:Extract$OEM$3)
goto :Extract$OEM$2

::========================================================================================================================================

:Extract$OEM$3

cls
set "_dir=!_desktop_!\$OEM$\$$\Setup\Scripts"
md "!_dir!\"
copy /y /b "!_batf!" "!_dir!\MAS_AIO.cmd" %nul%

(
echo @echo off
echo fltmc ^>nul ^|^| exit /b
echo call "%%~dp0MAS_AIO.cmd" %para%
echo cd \
echo ^(goto^) 2^>nul ^& ^(if "%%~dp0"=="%%SystemRoot%%\Setup\Scripts\" rd /s /q "%%~dp0"^)
)>"!_dir!\SetupComplete.cmd"

set _error=
if not exist "!_dir!\MAS_AIO.cmd" set _error=1
if not exist "!_dir!\SetupComplete.cmd" set _error=1

if defined _error (
%eline%
echo Failed to extract $OEM$ folder on the Desktop.
) else (
echo:
call :_color %Magenta% "%_oem%"
call :_color %Green% "$OEM$ folder is successfully created on the Desktop."
)
echo "%_oem%" | find /i "KMS38" 1>nul && (
echo:
echo To KMS38 activate Server Cor/Acor editions ^(No GUI Versions^),
echo Check this page https://massgrave.dev/oem-folder
)
echo ___________________________________________________________________
echo:
call :_color %_Yellow% "Press any key to go back..."
pause >nul
goto Extras

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:HWIDActivation
@setlocal DisableDelayedExpansion
@echo off

::  To activate, run the script with "/HWID" parameter or change 0 to 1 in below line
set _act=0

::  To disable changing edition if current edition doesn't support HWID activation, change the value to 1 from 0 or run the script with "/HWID-NoEditionChange" parameter
set _NoEditionChange=0

::  If value is changed in above lines or parameter is used then script will run in unattended mode



::========================================================================================================================================

cls
color 07
title  HWID Activation

set _args=
set _elev=
set _unattended=0

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args (
for %%A in (%_args%) do (
if /i "%%A"=="/HWID"                  set _act=1
if /i "%%A"=="/HWID-NoEditionChange"  set _NoEditionChange=1
if /i "%%A"=="-el"                    set _elev=1
)
)

for %%A in (%_act% %_NoEditionChange%) do (if "%%A"=="1" set _unattended=1)

::========================================================================================================================================

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"
set     "Red="41;97m""
set    "Gray="100;97m""
set   "Green="42;97m""
set "Magenta="45;97m""
set  "_White="40;37m""
set  "_Green="40;92m""
set "_Yellow="40;93m""
) else (
set     "Red="Red" "white""
set    "Gray="Darkgray" "white""
set   "Green="DarkGreen" "white""
set "Magenta="Darkmagenta" "white""
set  "_White="Black" "Gray""
set  "_Green="Black" "Green""
set "_Yellow="Black" "Yellow""
)

set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :dk_color %Red% "==== ERROR ====" &echo:"
if %~z0 GEQ 200000 (set "_exitmsg=Go back") else (set "_exitmsg=Exit")

::========================================================================================================================================

if %winbuild% LSS 10240 (
%eline%
echo Unsupported OS version detected.
echo HWID Activation is supported only for Windows 10/11.
echo Use Online KMS Activation option.
goto dk_done
)

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
%eline%
echo HWID Activation is not supported for Windows Server.
echo Use KMS38 or Online KMS Activation option.
goto dk_done
)

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"

setlocal EnableDelayedExpansion

::========================================================================================================================================

cls
mode 102, 34
title  HWID Activation

echo:
echo Initializing...
call :dk_product
call :dk_ckeckwmic

::  Show info for potential script stuck scenario

sc start sppsvc %nul%
if %errorlevel% NEQ 1056 if %errorlevel% NEQ 0 (
echo:
echo Error code: %errorlevel%
call :dk_color %Red% "Failed to start [sppsvc] service, rest of the process may take a long time..."
echo:
)

::========================================================================================================================================

::  Check if system is permanently activated or not

call :dk_checkperm
if defined _perm (
cls
echo ___________________________________________________________________________________________
echo:
call :dk_color2 %_White% "     " %Green% "Checking: %winos% is Permanently Activated."
call :dk_color2 %_White% "     " %Gray% "Activation is not required."
echo ___________________________________________________________________________________________
if %_unattended%==1 goto dk_done
echo:
choice /C:10 /N /M ">    [1] Activate [0] %_exitmsg% : "
if errorlevel 2 exit /b
)
cls

::========================================================================================================================================

::  Check Evaluation version

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" (
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID 2>nul | find /i "Eval" 1>nul && (
%eline%
echo [%winos% ^| %winbuild%]
echo:
echo Evaluation Editions cannot be activated. 
echo You need to install full version of %winos%
echo:
echo Download it from here,
echo https://massgrave.dev/genuine-installation-media.html
goto dk_done
)
)

::========================================================================================================================================

::  Check SKU value / Check in multiple places to find Edition change corruption

set osSKU=
set regSKU=
set wmiSKU=

for /f "tokens=3 delims=." %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v OSProductPfn 2^>nul') do set "regSKU=%%a"
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%a in ('"wmic Path Win32_OperatingSystem Get OperatingSystemSKU /format:LIST" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"
if %_wmic% EQU 0 for /f "tokens=1" %%a in ('%psc% "([WMI]'Win32_OperatingSystem=@').OperatingSystemSKU" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"

set osSKU=%wmiSKU%
if not defined osSKU set osSKU=%regSKU%

if not defined osSKU (
%eline%
echo SKU value was not detected properly. Aborting...
goto dk_done
)

::========================================================================================================================================

set error=

cls
echo:
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') do set arch=%%b
echo Checking OS Info                        [%winos% ^| %winbuild% ^| %arch%]

::  Check Internet connection

set _int=
for %%a in (l.root-servers.net resolver1.opendns.com download.windowsupdate.com google.com) do if not defined _int (
for /f "delims=[] tokens=2" %%# in ('ping -n 1 %%a') do (if not [%%#]==[] set _int=1)
)

if not defined _int (
%psc% "If([Activator]::CreateInstance([Type]::GetTypeFromCLSID([Guid]'{DCB00C01-570F-4A9B-8D69-199FDBA5723B}')).IsConnectedToInternet){Exit 0}Else{Exit 1}"
if !errorlevel!==0 set _int=1
)

if defined _int (
echo Checking Internet Connection            [Connected]
) else (
set error=1
call :dk_color %Red% "Checking Internet Connection            [Not Connected]"
)

::========================================================================================================================================

::  Check Windows Script Host

set _WSH=1
reg query "HKCU\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled 2>nul | find /i "0x0" 1>nul && (set _WSH=0)
reg query "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled 2>nul | find /i "0x0" 1>nul && (set _WSH=0)

if %_WSH% EQU 0 (
reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f %nul%
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f %nul%
if not "%arch%"=="x86" reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f /reg:32 %nul%
echo Enabling Windows Script Host            [Successful]
)

::========================================================================================================================================

echo Initiating Diagnostic Tests...

set "_serv=ClipSVC wlidsvc sppsvc KeyIso LicenseManager Winmgmt wuauserv"

::  Client License Service (ClipSVC)
::  Microsoft Account Sign-in Assistant
::  Software Protection
::  CNG Key Isolation
::  Windows License Manager Service
::  Windows Management Instrumentation
::  Windows Update

call :dk_errorcheck

::  Check Windows updates and store app blockers

set updatesblock=
echo: %serv_ste% | findstr /i "wuauserv" %nul% && set updatesblock=1
for /f "skip=2 tokens=2*" %%a in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc /v Start 2^>nul') do if /i %%b equ 0x4 set updatesblock=1
if exist "%SystemRoot%\System32\WaaSMedicSvc.dll" (
for /f "skip=2 tokens=2*" %%a in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc /v Start 2^>nul') do if /i %%b equ 0x4 set updatesblock=1
)

reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer /v SettingsPageVisibility 2>nul | find /i "windowsupdate" %nul% && set updatesblock=1
reg query HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdateSysprepInProgress %nul% && set updatesblock=1
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate /s 2>nul | findstr /i "NoAutoUpdate DisableWindowsUpdateAccess" %nul% && set updatesblock=1

if defined updatesblock (
call :dk_color %Gray% "Checking Windows Update Blockers        [Found]"
if defined applist echo: %serv_e% | find /i "wuauserv" %nul% && (
call :dk_color %Magenta% "Windows Update Service [wuauserv] is not working. Enable it incase if you have disabled it."
)
)

reg query "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v DisableStoreApps 2>nul | find /i "0x1" %nul% && (
call :dk_color %Gray% "Checking Store App Blocker              [Found]"
)

::========================================================================================================================================

::  Detect Key

set key=
set altkey=
set changekey=
set curedition=
set altedition=
set notworking=
set actidnotfound=

for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildBranch 2^>nul') do set "branch=%%b"

if defined applist call :hwiddata key attempt1
if not defined key call :hwiddata key attempt2

if defined notworking call :hwidfallback
if not defined key call :hwidfallback

if defined altkey (set key=%altkey%&set changekey=1&set notworking=)

if defined notworking if defined notfoundaltactID (
call :dk_color %Red% "Checking Alternate Edition For HWID     [%altedition% Activation ID Not Found]"
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" (
call :dk_color %Magenta% "Evaluation Windows Found. Install Full version of %winos%"
call :dk_color %Magenta% "Download it from https://massgrave.dev/genuine-installation-media.html"
)
)

if not defined key (
%eline%
echo [%winos% ^| %winbuild% ^| SKU:%osSKU%]
echo Unable to find this product in the supported product list.
echo Make sure you are using updated version of the script.
echo https://massgrave.dev
echo:
goto dk_done
)

if defined notworking set error=1

::========================================================================================================================================

::  Install key

echo:
if defined changekey (
call :dk_color %Magenta% "[%altedition%] Edition product key will be used to enable HWID activation."
echo:
)

if %_wmic% EQU 1 wmic path SoftwareLicensingService where __CLASS='SoftwareLicensingService' call InstallProductKey ProductKey="%key%" %nul%
if %_wmic% EQU 0 %psc% "(([WMISEARCHER]'SELECT Version FROM SoftwareLicensingService').Get()).InstallProductKey('%key%')" %nul%
if not %errorlevel%==0 cscript //nologo %windir%\system32\slmgr.vbs /ipk %key% %nul%
set errorcode=%errorlevel%
cmd /c exit /b %errorcode%
if %errorcode% NEQ 0 set "errorcode=[0x%=ExitCode%]"

if %errorcode% EQU 0 (
call :dk_refresh
echo Installing Generic Product Key          [%key%] [Successful]
) else (
call :dk_color %Red% "Installing Generic Product Key          [%key%] [Failed] %errorcode%"
if not defined error (
call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
if defined actidnotfound call :dk_color %Red% "Activation ID not found for this key. Make sure you are using updated version of MAS."
set showfix=1
)
set error=1
)

::========================================================================================================================================

::  Change Windows region to USA to avoid activation issues as Windows store license is not available in many countries 

for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Control Panel\International\Geo" /v Name 2^>nul') do set "name=%%b"
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Control Panel\International\Geo" /v Nation 2^>nul') do set "nation=%%b"

set regionchange=
if not "%name%"=="US" (
set regionchange=1
%psc% "Set-WinHomeLocation -GeoId 244" %nul%
if !errorlevel! EQU 0 (
echo Changing Windows Region To USA          [Successful]
) else (
call :dk_color %Red% "Changing Windows Region To USA          [Failed]"
)
)

::==========================================================================================================================================

::  Generate GenuineTicket.xml and apply
::  In some cases clipup -v -o method fails and in some cases service restart method fails as well
::  To maximize success rate and get better error details, script will install tickets two times (service restart + clipup -v -o)

set "tdir=%ProgramData%\Microsoft\Windows\ClipSVC\GenuineTicket"
if not exist "%tdir%\" md "%tdir%\" %nul%

if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%
if exist "%tdir%\*.xml" del /f /q "%tdir%\*.xml" %nul%
if exist "%ProgramData%\Microsoft\Windows\ClipSVC\Install\Migration\*" del /f /q "%ProgramData%\Microsoft\Windows\ClipSVC\Install\Migration\*" %nul%

call :hwiddata ticket

copy /y /b "%tdir%\GenuineTicket" "%tdir%\GenuineTicket.xml" %nul%

if not exist "%tdir%\GenuineTicket.xml" (
call :dk_color %Red% "Generating GenuineTicket.xml            [Failed]"
echo [%encoded%]
if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%
goto :dl_final
) else (
echo Generating GenuineTicket.xml            [Successful]
)

set "_xmlexist=if exist "%tdir%\GenuineTicket.xml""

%_xmlexist% (
net stop ClipSVC /y %nul%
net start ClipSVC /y %nul%
%_xmlexist% timeout /t 2 %nul%
%_xmlexist% timeout /t 2 %nul%

%_xmlexist% (
set error=1
if exist "%tdir%\*.xml" del /f /q "%tdir%\*.xml" %nul%
call :dk_color %Red% "Installing GenuineTicket.xml            [Failed With ClipSVC Service Restart, Wait...]"
)
)

copy /y /b "%tdir%\GenuineTicket" "%tdir%\GenuineTicket.xml" %nul%
clipup -v -o

set rebuildinfo=

%_xmlexist% (
set error=1
set rebuildinfo=1
call :dk_color %Red% "Installing GenuineTicket.xml            [Failed With clipup -v -o]"
)

if exist "%ProgramData%\Microsoft\Windows\ClipSVC\Install\Migration\*.xml" (
set error=1
set rebuildinfo=1
call :dk_color %Red% "Checking Ticket Migration               [Failed]"
)

if defined applist if not defined showfix if defined rebuildinfo (
set showfix=1
call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
)

if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%

::==========================================================================================================================================

call :dk_product

echo:
echo Activating...

call :dk_act
call :dk_checkperm
if defined _perm (
echo:
call :dk_color %Green% "%winos% is permanently activated with a digital license."
goto :dl_final
)

::  Extended licensing servers tests incase error not found and activation failed

set resfail=
if not defined error (

ipconfig /flushdns %nul%
set "tls=$Tls12 = [Enum]::ToObject([System.Net.SecurityProtocolType], 3072); [System.Net.ServicePointManager]::SecurityProtocol = $Tls12;"

for %%# in (
login.live.com/ppsecure/deviceaddcredential.srf
purchase.mp.microsoft.com/v7.0/users/me/orders
) do if not defined resfail (
set "d1=Add-Type -AssemblyName System.Net.Http;"
set "d1=!d1! $client = [System.Net.Http.HttpClient]::new();"
set "d1=!d1! $response = $client.GetAsync('https://%%#').GetAwaiter().GetResult();"
set "d1=!d1! $response.Content.ReadAsStringAsync().GetAwaiter().GetResult()"
%psc% "!tls! !d1!" 2>nul | findstr /i "PurchaseFD DeviceAddResponse" 1>nul || set resfail=1
)

if not defined resfail (
%psc% "!tls! irm https://licensing.mp.microsoft.com/v7.0/licenses/content -Method POST" | find /i "traceId" 1>nul || set resfail=1
)

if defined resfail (
set error=1
echo:
call :dk_color %Red% "Checking Licensing Servers              [Failed To Connect]"
call :dk_color2 %Magenta% "Check this page for help" %_Yellow% " https://massgrave.dev/licensing-servers-issue"
)
)

::  Clear store ID related registry to fix activation incase error not found

if not defined error (
echo:
set "_ident=HKU\S-1-5-19\SOFTWARE\Microsoft\IdentityCRL"
reg delete "!_ident!" /f %nul%
reg query "!_ident!" %nul% && (
call :dk_color %Red% "Deleting a Registry                     [Failed] [!_ident!]"
) || (
echo Deleting a Registry                     [Successful] [!_ident!]
)

REM Refresh some services and license status

for %%# in (wlidsvc LicenseManager sppsvc) do (net stop %%# /y %nul% & net start %%# /y %nul%)
call :dk_refresh
call :dk_act
call :dk_checkperm
)

echo:
if defined _perm (
call :dk_color %Green% "%winos% is permanently activated with a digital license."
) else (
call :dk_color %Red% "Activation Failed %error_code%"
if defined notworking (
call :dk_color %Magenta% "At the time of writing this, HWID Activation was not supported for this product."
call :dk_color %Magenta% "Use KMS38 Activation option."
) else (
if not defined error call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
call :dk_color2 %Magenta% "Check this page for help" %_Yellow% " https://massgrave.dev/troubleshoot"
)
)

::========================================================================================================================================

:dl_final

echo:

if defined regionchange (
%psc% "Set-WinHomeLocation -GeoId %nation%" %nul%
if !errorlevel! EQU 0 (
echo Restoring Windows Region                [Successful]
) else (
call :dk_color %Red% "Restoring Windows Region                [Failed] [%name% - %nation%]"
)
)

if %osSKU%==175 call :dk_color %Red% "%winos% does not support activation on non-azure platforms."

goto :dk_done

::========================================================================================================================================

::  Get Windows permanent activation status

:dk_checkperm

if %_wmic% EQU 1 wmic path SoftwareLicensingProduct where (LicenseStatus='1' and GracePeriodRemaining='0' and PartialProductKey is not NULL) get Name /value 2>nul | findstr /i "Windows" 1>nul && set _perm=1||set _perm=
if %_wmic% EQU 0 %psc% "(([WMISEARCHER]'SELECT Name FROM SoftwareLicensingProduct WHERE LicenseStatus=1 AND GracePeriodRemaining=0 AND PartialProductKey IS NOT NULL').Get()).Name | %% {echo ('Name='+$_)}" 2>nul | findstr /i "Windows" 1>nul && set _perm=1||set _perm=
exit /b

::  Refresh license status

:dk_refresh

if %_wmic% EQU 1 wmic path SoftwareLicensingService where __CLASS='SoftwareLicensingService' call RefreshLicenseStatus %nul%
if %_wmic% EQU 0 %psc% "$null=(([WMICLASS]'SoftwareLicensingService').GetInstances()).RefreshLicenseStatus()" %nul%
exit /b

::  Activation command

:dk_act

set error_code=
if %_wmic% EQU 1 wmic path SoftwareLicensingProduct where "ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f' and PartialProductKey<>null" call Activate %nul%
if %_wmic% EQU 0 %psc% "(([WMISEARCHER]'SELECT ID FROM SoftwareLicensingProduct WHERE ApplicationID=''55c92734-d682-4d71-983e-d6ec3f16059f'' AND PartialProductKey IS NOT NULL').Get()).Activate()" %nul%
if not %errorlevel%==0 cscript //nologo %windir%\system32\slmgr.vbs /ato %nul%
set error_code=%errorlevel%
cmd /c exit /b %error_code%
if %error_code% NEQ 0 (set "error_code=[Error Code: 0x%=ExitCode%]") else (set error_code=)
exit /b

::  Get Windows Activation IDs

:dk_actids

set applist=
if %_wmic% EQU 1 set "chkapp=for /f "tokens=2 delims==" %%a in ('"wmic path SoftwareLicensingProduct where (ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f') get ID /VALUE" 2^>nul')"
if %_wmic% EQU 0 set "chkapp=for /f "tokens=2 delims==" %%a in ('%psc% "(([WMISEARCHER]'SELECT ID FROM SoftwareLicensingProduct WHERE ApplicationID=''55c92734-d682-4d71-983e-d6ec3f16059f''').Get()).ID ^| %% {echo ('ID='+$_)}" 2^>nul')"
%chkapp% do (if defined applist (call set "applist=!applist! %%a") else (call set "applist=%%a"))
exit /b

::  Check wmic.exe

:dk_ckeckwmic

set _wmic=0
for %%# in (wmic.exe) do @if not "%%~$PATH:#"=="" (
wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul && set _wmic=1
)
exit /b

::  Get Product name (WMI/REG methods are not reliable in all conditions, hence winbrand.dll method is used)

:dk_product

call :dk_reflection

set d1=%ref% $meth = $TypeBuilder.DefinePInvokeMethod('BrandingFormatString', 'winbrand.dll', 'Public, Static', 1, [String], @([String]), 1, 3);
set d1=%d1% $meth.SetImplementationFlags(128); $TypeBuilder.CreateType()::BrandingFormatString('%%WINDOWS_LONG%%')

set winos=
for /f "delims=" %%s in ('"%psc% %d1%"') do if not errorlevel 1 (set winos=%%s)
echo "%winos%" | find /i "Windows" 1>nul || (
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName 2^>nul') do set "winos=%%b"
if %winbuild% GEQ 22000 (
set winos=!winos:Windows 10=Windows 11!
)
)
exit /b

::  Common lines used in PowerShell reflection code

:dk_reflection

set ref=$AssemblyBuilder = [AppDomain]::CurrentDomain.DefineDynamicAssembly(4, 1);
set ref=%ref% $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule(2, $False);
set ref=%ref% $TypeBuilder = $ModuleBuilder.DefineType(0);
exit /b

::========================================================================================================================================

:dk_errorcheck

::  Check disabled services

set serv_ste=
for %%# in (%_serv%) do (
set serv_dis=
reg query HKLM\SYSTEM\CurrentControlSet\Services\%%# /v ImagePath %nul% || set serv_dis=1
for /f "skip=2 tokens=2*" %%a in ('reg query HKLM\SYSTEM\CurrentControlSet\Services\%%# /v Start 2^>nul') do if /i %%b equ 0x4 set serv_dis=1
sc start %%# %nul%
if !errorlevel! EQU 1058 set serv_dis=1
sc query %%# %nul% || set serv_dis=1
if defined serv_dis (if defined serv_ste (set "serv_ste=!serv_ste! %%#") else (set "serv_ste=%%#"))
)

::  Change disabled services startup type to default

set serv_csts=
set serv_cste=

if defined serv_ste (
for %%# in (%serv_ste%) do (
if /i %%#==ClipSVC        (reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%#" /v "Start" /t REG_DWORD /d "3" /f %nul% & sc config %%# start= demand %nul%)
if /i %%#==wlidsvc        sc config %%# start= demand %nul%
if /i %%#==sppsvc         (reg add "HKLM\SYSTEM\CurrentControlSet\Services\%%#" /v "Start" /t REG_DWORD /d "2" /f %nul% & sc config %%# start= delayed-auto %nul%)
if /i %%#==KeyIso         sc config %%# start= demand %nul%
if /i %%#==LicenseManager sc config %%# start= demand %nul%
if /i %%#==Winmgmt        sc config %%# start= auto %nul%
if /i %%#==wuauserv       sc config %%# start= demand %nul%
if !errorlevel!==0 (
if defined serv_csts (set "serv_csts=!serv_csts! %%#") else (set "serv_csts=%%#")
) else (
if defined serv_cste (set "serv_cste=!serv_cste! %%#") else (set "serv_cste=%%#")
)
)
)

if defined serv_csts call :dk_color %Gray% "Enabling Disabled Services              [Successful] [%serv_csts%]"

if defined serv_cste (
set error=1
call :dk_color %Red% "Enabling Disabled Services              [Failed] [%serv_cste%]"
)

::========================================================================================================================================

::  Check if the services are able to run or not
::  Workarounds are added to get correct status and error code because sc query doesn't output correct results in some conditions

set serv_e=
for %%# in (%_serv%) do (
set errorcode=
set checkerror=
net start %%# /y %nul%
set errorcode=!errorlevel!
sc query %%# | find /i "4  RUNNING" %nul% || set checkerror=1

sc start %%# %nul%
if !errorlevel! NEQ 1056 if !errorlevel! NEQ 0 (set errorcode=!errorlevel!&set checkerror=1)
if defined checkerror if defined serv_e (set "serv_e=!serv_e!, %%#-!errorcode!") else (set "serv_e=%%#-!errorcode!")
)

if defined serv_e (
set error=1
call :dk_color %Red% "Starting Services                       [Failed] [%serv_e%]"
echo %serv_e% | findstr /i "ClipSVC-1058 sppsvc-1058" %nul% && (
call :dk_color %Magenta% "Restart the system to fix disabled service error 1058."
)
)

::========================================================================================================================================

::  Various error checks

if defined safeboot_option (
set error=1
call :dk_color2 %Red% "Checking Boot Mode                      " %Magenta% "[System is running in safe mode. Run in normal mode.]"
)


reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Setup\State" 2>nul | find /i "IMAGE_STATE_COMPLETE" 1>nul || (
set error=1
call :dk_color2 %Red% "Checking Audit Mode                     " %Magenta% "[System is running in Audit mode. Run in normal mode.]"
)


reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinPE" /v InstRoot %nul% && (
set error=1
call :dk_color2 %Red% "Checking WinPE                          " %Magenta% "[System is running in WinPE mode. Run in normal mode.]"
)


for %%# in (wmic.exe) do @if "%%~$PATH:#"=="" (
call :dk_color %Gray% "Checking WMIC.exe                       [Not Found]"
)


%psc% $ExecutionContext.SessionState.LanguageMode 2>nul | find /i "Full" 1>nul || (
set error=1
call :dk_color %Red% "Checking Powershell                     [Not Responding]"
)


set wmifailed=
if %_wmic% EQU 1 wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul
if %_wmic% EQU 0 %psc% "Get-CIMInstance -Class Win32_ComputerSystem | Select-Object -Property CreationClassName" 2>nul | find /i "computersystem" 1>nul
if %errorlevel% NEQ 0 (
set error=1
set wmifailed=1
call :dk_color %Red% "Checking WMI                            [Not Responding] %_wmic%"
call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix WMI option."
)


if not "%regSKU%"=="%wmiSKU%" (
call :dk_color %Red% "Checking WMI/REG SKU                    [Difference Found - WMI:%wmiSKU% Reg:%regSKU%]"
)


DISM /English /Online /Get-CurrentEdition %nul%
set error_code=%errorlevel%
cmd /c exit /b %error_code%
if %error_code% NEQ 0 set "error_code=[0x%=ExitCode%]"
if %error_code% NEQ 0 (
call :dk_color %Red% "Checking DISM                           [Not Responding] %error_code%"
)


if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" (
set error=1
call :dk_color %Red% "Checking Eval Packages                  [Non-Eval Licenses are installed in Eval Windows]"
)


cscript //nologo %windir%\system32\slmgr.vbs /dlv %nul%
set error_code=%errorlevel%
cmd /c exit /b %error_code%
if %error_code% NEQ 0 set "error_code=0x%=ExitCode%"
if %error_code% NEQ 0 (
set error=1
call :dk_color %Red% "Checking slmgr /dlv                     [Not Responding] %error_code%"
)


reg query "HKU\S-1-5-20\Software\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\PersistedTSReArmed" %nul% && (
set error=1
call :dk_color2 %Red% "Checking Rearm                          " %Magenta% "[System Restart Is Required]"
)


reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ClipSVC\Volatile\PersistedSystemState" %nul% && (
set error=1
call :dk_color2 %Red% "Checking ClipSVC                        " %Magenta% "[System Restart Is Required]"
)


for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v "SkipRearm" 2^>nul') do if /i %%b NEQ 0x0 (
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v "SkipRearm" /t REG_DWORD /d "0" /f %nul%
call :dk_color %Red% "Checking SkipRearm                      [Default 0 Value Not Found, Changing To 0]"
net stop sppsvc /y %nul%
net start sppsvc /y %nul%
set error=1
)


reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\Plugins\Objects\msft:rm/algorithm/hwid/4.0" /f ba02fed39662 /d %nul% || (
call :dk_color %Red% "Checking SPP Registry Key               [Incorrect ModuleId Found]"
set error=1
)


call :dk_actids
if not defined applist (
net stop sppsvc /y %nul%
cscript //nologo %windir%\system32\slmgr.vbs /rilc %nul%
if !errorlevel! NEQ 0 cscript //nologo %windir%\system32\slmgr.vbs /rilc %nul%
call :dk_refresh
call :dk_actids
if not defined applist (
set error=1
call :dk_color %Red% "Checking Activation IDs                 [Not Found]"
)
)


set tokenstore=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v TokenStore 2^>nul') do call set "tokenstore=%%b"
if not exist "%tokenstore%\" (
set error=1
call :dk_color %Red% "Checking SPP Token Folder               [Not Found] [%tokenstore%\]"
)


if exist "%tokenstore%\" if not exist "%tokenstore%\tokens.dat" (
set error=1
call :dk_color %Red% "Checking SPP tokens.dat                 [Not Found] [%tokenstore%\]"
)


if not exist %ProgramData%\Microsoft\Windows\ClipSVC\tokens.dat (
set error=1
call :dk_color %Red% "Checking ClipSVC tokens.dat             [Not Found]"
)


if not exist %SystemRoot%\system32\sppsvc.exe (
set error=1
call :dk_color %Red% "Checking sppsvc.exe File                [Not Found]"
)


::  Below checks are performed if required services are not disabled + slmgr /dlv errorlevel is not Zero + Rearm restart is not required + WMI is working fine

set showfix=
set wpaerror=
set permerror=
if not defined serv_cste if /i not %error_code%==0 if /i not %error_code%==0xC004D302 if not defined wmifailed (

REM  This code checks for invalid registry keys in HKLM\SYSTEM\WPA. This issue may appear even on healthy systems.

if %winbuild% GEQ 14393 (
set /a count=0
for /f %%a in ('reg query "HKLM\SYSTEM\WPA" 2^>nul') do set /a count+=1
for /L %%# in (1,1,!count!) do (
reg query "HKLM\SYSTEM\WPA\8DEC0AF1-0341-4b93-85CD-72606C2DF94C-7P-%%#" /ve /t REG_BINARY %nul% || set wpaerror=1
)
if defined wpaerror call :dk_color %Red% "Checking WPA Registry Keys              [Error Found] [Registry Count - !count!]"
)

REM  This code checks if NT SERVICE\sppsvc has permission access to tokens folder and required registry keys. It's often caused by gaming spoofers. 

if not exist "%tokenstore%\" set permerror=1

for %%# in (
"%tokenstore%"
"HKLM:\SYSTEM\WPA"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
) do if not defined permerror (
%psc% "$acl = Get-Acl '%%#'; if ($acl.Access.Where{ $_.IdentityReference -eq 'NT SERVICE\sppsvc' -and $_.AccessControlType -eq 'Deny' -or $acl.Access.IdentityReference -notcontains 'NT SERVICE\sppsvc'}) {Exit 2}" %nul%
if !errorlevel!==2 set permerror=1
)
if defined permerror call :dk_color %Red% "Checking SPP Permissions                [Error Found]"

set showfix=1
call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
if not defined permerror call :dk_color %Magenta% "If activation still fails then run Fix WPA Registry option."
)

exit /b

::========================================================================================================================================

:dk_color

if %_NCS% EQU 1 (
echo %esc%[%~1%~2%esc%[0m
) else (
%psc% write-host -back '%1' -fore '%2' '%3'
)
exit /b

:dk_color2

if %_NCS% EQU 1 (
echo %esc%[%~1%~2%esc%[%~3%~4%esc%[0m
) else (
%psc% write-host -back '%1' -fore '%2' '%3' -NoNewline; write-host -back '%4' -fore '%5' '%6'
)
exit /b

::========================================================================================================================================

:dk_done

echo:
if %_unattended%==1 timeout /t 2 & exit /b
call :dk_color %_Yellow% "Press any key to %_exitmsg%..."
pause >nul
exit /b

::========================================================================================================================================

::  1st column = Activation ID
::  2nd column = Generic Retail/OEM/MAK Key
::  3rd column = SKU ID
::  4th column = Key part number
::  5th column = Ticket signature value. It's as it is, it's not encoded. (Check https://massgrave.dev/hwid.html#Manual_Activation to see how it's generated)
::  6th column = 1 = activation is not working (at the time of writing this), 0 = activation is working
::  7th column = Key Type
::  8th column = WMI Edition ID
::  9th column = Version name incase same Edition ID is used in different OS versions with different key
::  Separator  = _


:hwiddata

set f=
for %%# in (
8b351c9c-f398-4515-9900-09df49427262_XGV%f%PP-NM%f%H47-7TT%f%HJ-W3%f%FW7-8H%f%V2C___4_X19-99683_X9J5T0gPQprYpz2euPvoJGlkurIO9h6N8ypE0KWYVpy0nbCKYnqSUCD7u8ReXAmc085jX2uM5PKurSee9Yq/PxesgiysQHDBsOhr98MXZZiIgy4ssnz2gZF70KB8tO3X7kk9LHwxXfz3rlquYPod9swe90nqvVaJMWCpQK0InUw_0_OEM:NONSLP_Enterprise
c83cef07-6b72-4bbc-a28f-a00386872839_3V6%f%Q6-NQ%f%XCX-V8Y%f%XR-9Q%f%CYV-QP%f%FCT__27_X19-98746_WFZBjlVtHQumoaVE28/NHsRvv1lgkkfav6NPHqr6OC2u4vxkjjJkkl9OTF6DpHJu0IFrrQv+HYcdZ/WC5EzhOMqMxcujTBSAN7xLIVEbs72Db0Bi5iDAbOltJpk8QKKe18otQJ6vajW5WOPXjbgSJfDFaZQfiwvIJ1ICXt+stog_0_Volume:MAK_EnterpriseN
4de7cb65-cdf1-4de9-8ae8-e3cce27b9f2c_VK7%f%JG-NP%f%HTM-C97%f%JM-9M%f%PGT-3V%f%66T__48_X19-98841_K3qev/5gQpX1RK1F9M9beEWWv/di1GsRF7OUcEMGTGDTYnaRenRcJaO8zOHQQvKDc57fon/v77ZpHQHT/jWWhWnLm7Ssory+s8tOs72fPjivVBDwpSPIEC1v+8Vpb4a3XCZet2e/Z5wmpCq9XDkowys3IcxYM0mHWBaNPu8gIe4_0_____Retail_Professional
9fbaf5d6-4d83-4422-870d-fdda6e5858aa_2B8%f%7N-8K%f%FHP-DKV%f%6R-Y2%f%C8J-PK%f%CKT__49_X19-98859_WcAcor6kQgxgkTRzcoxnb8UIoo5/ueYeaOKqy9/xAzlruHAKxhatXeGtSI58lXcCK5hxXkDmcyrRFwWSwdvg0txwTi7VusYcTNCLdmNWU/62iDrBhzMrCYtuhW9EV/g4+TlbjSm4PBJ0HMlI4YzAEnyJiBgKPDgBQ8Gj9LRbEgU_0_____Retail_ProfessionalN
f742e4ff-909d-4fe9-aacb-3231d24a0c58_4CP%f%RK-NM%f%3K3-X6X%f%XQ-RX%f%X86-WX%f%CHW__98_X19-98877_MBDSEqlayxtVVEgIeAl8milgjS/BVHow6+MmpCyh9nweuctlT1+LbEHmDlnqDeLr9FQrN2FpEJtNr26rE0niMdvcAP51MfJsREyhWOEbrWwWyMH0KwDAci2WxWZTJp/SEZnq5HYYT1pPPLMWAkKRHJksJJFtg4zBtoyHvLjc35c_0_____Retail_CoreN
1d1bac85-7365-4fea-949a-96978ec91ae0_N24%f%34-X9%f%D7W-8PF%f%6X-8D%f%V9T-8T%f%YMD__99_X19-99652_mpjCoh6soA/rwJutsjekZpA9vDUD8znR20V/c8FwSjuCcSbPhmP6bpJR9rfptAZqpagliMxA/OUZsx0Knt0n/hgOy2mv8pr24gI9uYXK8EfhG74bVdsyvZz1tyA6CaVR02ZahQvbKYzCmXUvsI+Wge3bHbKbVpn9Mvl+itn2a4g_0_____Retail_CoreCountrySpecific
3ae2cc14-ab2d-41f4-972f-5e20142771dc_BT7%f%9Q-G7%f%N6G-PGB%f%YW-4Y%f%WX6-6F%f%4BT_100_X19-99661_KaUs6KwvtthPOsxd3x0tU/baKSv1DWSFOqbq7PbU/uYEY95p0Skzv3y4aXq+xVmfwSt8STL/4vSfFIAlsaRh7Vnq6Y/Ael8joeqI8hBN461fykoHxSELRMJ+eed50T0cJUS79ol6OTBOCCVeHgmtGVbHuL88TMWW69fGNdIMM3U_0_____Retail_CoreSingleLanguage
2b1f36bb-c1cd-4306-bf5c-a0367c2d97d8_YTM%f%G3-N6%f%DKC-DKB%f%77-7M%f%9GH-8H%f%VX7_101_X19-98868_NpHxrAtA+GL6kawAP5Z2UdfUVcKFvf9UzEe6FIV/HztZqxpMBDFv2hdxCjD9+T8PKcW8j3n04McelOAgr3lD37Fu+wrvJIGX0dG3xEtU/MG9L9X5baBS8H6AmC6rq2+w5NUY8EchK9W2oatBflFb8IcfCSeAyOfsJei6bdu4mp8_0_____Retail_Core
2a6137f3-75c0-4f26-8e3e-d83d802865a4_XKC%f%NC-J2%f%6Q9-KFH%f%D2-FK%f%THY-KD%f%72Y_119_X19-99606_gtywgqIP3j+bliKdunuseeZWtsOzWhj+DmSBq7nqeNarHutgbWEwvcRiGo+nwxONt9Ak/VyuO76ZWH/db3iRVTk1y61vFv15gVlOy1ovLjVHBvmPVdQXIne2N+pIMb0eBhZWHRX63mYdkZRZ0wg/+bj4xsjJv+qLpWhVCzNMge4_0_OEM:NONSLP_PPIPro
e558417a-5123-4f6f-91e7-385c1c7ca9d4_YNM%f%GQ-8R%f%YV3-4PG%f%Q3-C8%f%XTP-7C%f%FBY_121_X19-98886_VuBmoSUdF63Cvwm9wNlc2yhD2tP9B72iVVWFNcbAwDGXF6o06oNMsIJ0VqGJDdBzZjVGw2wHokMabxZNDyIl90CO7trwgV8S0lLJVLymxyUaE3ThvN3YUsi9Q3H+5Kr0RpsojCWb+UQd/GY4bSXfyStXFylj6im7yv0db/ZWGbw_0_____Retail_Education
c5198a66-e435-4432-89cf-ec777c9d0352_84N%f%GF-MH%f%BT6-FXB%f%X8-QW%f%JK7-DR%f%R8H_122_X19-98892_jQ6S2bbNoVrp/zvi8BEUwCf7fge1nAdspcjXyTeTySUiR+hXPiKQEWgyLqAdZ5Or+X2JGT/LZN1/eZ9P+REmzG/WQotZ+fyyPguoSsES+d312RkfmQoI5gVanEkGjZSU4YohREM/Vyf9MOO7dbH9MMEpFm2mje6OnhyJo2gux0g_0_____Retail_EducationN
cce9d2de-98ee-4ce2-8113-222620c64a27_KCN%f%VH-YK%f%WX8-GJJ%f%B9-H9%f%FDT-6F%f%7W2_125_X22-66075_wJ/BPDFz+13PVJtBqBo+E4LCm3LoMVALCQUun9kXGBULr7V8FQ5nKUudUGHDLNNVIIicdw9Uh26BKAt0/hnE7BpBkzwdi4qAdZgKXQ1t06Ek4+zXmoT225NvpaHsuhDkE687TtCB1ZWvAulA8G9ehE3HTJSoNm4wCFOQyIQQtqQ_1_Volume:MAK_EnterpriseS_VB
d06934ee-5448-4fd1-964a-cd077618aa06_43T%f%BQ-NH%f%92J-XKT%f%M7-KT%f%3KK-P3%f%9PB_125_X21-83233_V+y0SFmAnGwRwgNz+0sO0mj+XxSjbdRDpom1Iqx2BJcsf96Q5ittJOcMhKiNswyKuq5suM5vy60tA/AUdb1mrnnrnXfmz7nFam/BIOOfa18GA7vd1aNFufhpmCiMWxoGSewH/T1pnCZrsvGYIj//qC7aiQVKYBngO7UYWGaytgc_0_OEM:NONSLP_EnterpriseS_RS5
706e0cfd-23f4-43bb-a9af-1a492b9f1302_NK9%f%6Y-D9%f%CD8-W44%f%CQ-R8%f%YTK-DY%f%JWX_125_X21-05035_U2DIv+LAhSGz0rNbTiMQYaP3M41+0+ZioF7vh0COeeJSIruDFCZ3Li7ZM3dSleg6QTCxG04uZ3i3r1bCZv0+WAfU9rG+3BqLAwKlJS/31rETeRWvrxB1UK4mTMHwAJc9txDAc15ureqF+2b9pIIpwLljmFer6fI7z0iI6I/ZuTU_0_OEM:NONSLP_EnterpriseS_RS1
faa57748-75c8-40a2-b851-71ce92aa8b45_FWN%f%7H-PF%f%93Q-4GG%f%P8-M8%f%RF3-MD%f%WWW_125_X19-99617_0frpwr4N/wBVRA/nOvAMqkxmRj6Vv9mA+jVNtnurAL1TjkPN/y+6YVUd5MP/Y4As4kddHoHiZXI+2siKHJsaV95ppXoHKR8d7FRVitr1F+82TbB7OVvdCclGrRZymnq25HvtSC3BROHt7ZXTgSCWMyB7MlbLiqHiTymOj5OMX1g_0_OEM:NONSLP_EnterpriseS_TH
2c060131-0e43-4e01-adc1-cf5ad1100da8_RQF%f%NW-9T%f%PM3-JQ7%f%3T-QV%f%4VQ-DV%f%9PT_126_X22-66108_UeA6O2iIW6zFMJzLMCQjVA7gUHOGRTiFB6LPrgjhgfJEXSZnDjxw8wsR+tp+JQWeaQDsVt06c2byH3z7Ft2wNk8n3gcXUknIjlcCckNjw05WDI64/wCqz+gtf1RajMEoV/mODpBx7rdLtCg03FyV7Z9LOib4/WLSmnxjDPKMG7s_1_Volume:MAK_EnterpriseSN_VB
e8f74caa-03fb-4839-8bcc-2e442b317e53_M33%f%WV-NH%f%Y3C-R7F%f%PM-BQ%f%GPT-23%f%9PG_126_X21-83264_NtP6sMWmOTCdABAbgIZfxZzRs8zaqzfaabLeFXQJvfJvQPLQPk2UxMliASJG+7YwwbTD8pyhUoQqUYrlCzJZ6jDSDyUTJkXgo9akR4fBOg6Z5wn5fW8NGAMDcLND5d9XxHl0gWH/HZNIs/GZaPJsCVVqPr7X8bk/y0DeIofxICU_1_Volume:MAK_EnterpriseSN_RS5
3d1022d8-969f-4222-b54b-327f5a5af4c9_2DB%f%W3-N2%f%PJG-MVH%f%W3-G7%f%TDK-9H%f%KR4_126_X21-04921_WeNSkuiC3iyNT9tDqlj6KvM17UYMsYjEelyyMEyPEXSAbYA08lYtYJjCzxSE9T30p9dxqPIuj370OwHhAxG8a51/HoLNWR0grj08HmdOXUA8Ap4clEivxKM0zRvwPR6L2M2HQP0nN54c9It7ikzweJ0X2HHOb58oEw9LbMeUM/Y_0_Volume:MAK_EnterpriseSN_RS1
60c243e1-f90b-4a1b-ba89-387294948fb6_NTX%f%6B-BR%f%YC2-K67%f%86-F6%f%MVQ-M7%f%V2X_126_X19-98770_QLG40WW/TtUqtir9K6FJCQXU1mfn27uutdOunHJ3gXk6v0Mbxaqu9GKqpg5xFzdFiOPb/8Bmk/ylwceXgoaUx1nKcBGb/Bg+jICiNMEYIbGyMuYiHb0iJeVbjbBLLfWuAAuUPftfnKPH3dAu1YvhaS5nv7a5wICrXdJWeVNpBxk_0_Volume:MAK_EnterpriseSN_TH
eb6d346f-1c60-4643-b960-40ec31596c45_DXG%f%7C-N3%f%6C4-C4H%f%TG-X4%f%T3X-2Y%f%V77_161_X21-43626_vHO/5UEtrsDzGC30A2Ya5DYXlNMs7hVYiLvM7X31xkaFMxogbiy3ZDxBbjRku3VXyW+TYsFX/D/wdJgFmMrhsNrObkxqzYMMRjx+BpwOx2PspKpS2RyzovyRl8v93SvHB5IyoO2/3pm2YqJDK1hXLhms6+DDPuiofQt36q47reQ_0_____Retail_ProfessionalWorkstation
89e87510-ba92-45f6-8329-3afa905e3e83_WYP%f%NQ-8C%f%467-V2W%f%6J-TX%f%4WX-WT%f%2RQ_162_X21-43644_phlxNLr+sk8cCCmAVU3k3XrtD6sFDeoaODc+21soKqePbVQbzPHgokS73ccok6/gDfu/u5UKc7omL8pm2IhIhf70oC+8M/FFp0zRFeC/ZFXdF2tL23oKWI9kZbvcaoZBiqaDGc1bNYi5KAZYaJU8wwqw16ZnohQJZ7QR9cgUfFQ_0_____Retail_ProfessionalWorkstationN
62f0c100-9c53-4e02-b886-a3528ddfe7f6_8PT%f%T6-RN%f%W4C-6V7%f%J2-C2%f%D3X-MH%f%BPB_164_X21-04955_Px7QWdfy0esrMzQoydKlmIcGdfV0pQvbnumyrh4evDNF9gpENm8OIfZfljIynury0qZAkw4AG3uGyp+5IxZGIh6U3dz41uNVfEcA9NZ34OEBXMtjEOU1ZbJ8wp8JecQKwlORclvsri9OOi0GbGc0TYRanlci2jJL/3x/gSuWXCs_0_____Retail_ProfessionalEducation
13a38698-4a49-4b9e-8e83-98fe51110953_GJT%f%YN-HD%f%MQY-FRR%f%76-HV%f%GC7-QP%f%F8P_165_X21-04956_GRSYno4+yqU/JMxHLDKdvdFWRz1uT90n5JkTvSqztDvXMf/mBhSV/OpppJWGo6UL0FwqYcu9oXl+Vx336pLAE5/EDzQHh+QCwOCDJiTKnd3hW/zrGMe6Sb0OAIkNNML9gcOBbr1IHFWhN99r8ZWl5JjpzMs2nPjejB1Ec8NCcpE_0_____Retail_ProfessionalEducationN
df96023b-dcd9-4be2-afa0-c6c871159ebe_NJC%f%F7-PW%f%8QT-332%f%4D-68%f%8JX-2Y%f%V66_175_X21-41295_kkJyX1AwYgDYcGK1eIRdocybkbAfEtQkDxhRUhY89X2i2PSD9jcsGQgHWyD3KUKWb3bzR8QkDS3MTeieOw3EzD0RyAQhHc6lRR+rk18lh5UOVCgrZ6byxn29Ur+jAh0LJXImggC9JMGb2cTYaZckxzm3ICoAKwrmI9JnrzBTVmY_0_____Retail_ServerRdsh
d4ef7282-3d2c-4cf0-9976-8854e64a8d1e_V3W%f%VW-N2%f%PV2-CGW%f%C3-34%f%QGF-VM%f%J2C_178_X21-32983_YIMgXu2dZ9x1r1NLs3egTc/8EYc1RndYDvoX7QquQQLnhnhbSNBw3hmlqrQ0zNsTLut3EKpGZK2CwPspJJWE60lecdxI4211K748P6vkuqHPL4uFqXyKxTG3qRrtDIra5nnMn4GqG2fWuguzTXaumu8cJU3H1uTOsR1E/DQnJJ0_0_____Retail_Cloud
af5c9381-9240-417d-8d35-eb40cd03e484_NH9%f%J3-68%f%WK7-6FB%f%93-4K%f%3DF-DJ%f%4F6_179_X21-32987_H0qrFdf+FQxcSRJDtEwd8OfwC4iH/25Q01jz3QuB9yhEqB0W1i83u0WDpVK04pvU1EDCCRRI/DhXynbkWpLC0chdTOW4k5jIy+aa0cD3fccz9ChSjVHMzyTg3abEVFAvy9rttUyxcFIOKcINXHTxTRp5cZPwOa393tlJyBiliAo_0_____Retail_CloudN
8ab9bdd1-1f67-4997-82d9-8878520837d9_XQQ%f%YW-NF%f%FMW-XJP%f%BH-K8%f%732-CK%f%FFD_188_X21-99378_Bwx3E7qmE6M8UR6+KPqLnnavI6ThNHHUO717RJY9di2YI9rzC3O0LceXOHjshSKwfwxosqFsD/p/inrJmabed1yA/ZWwISyGtAIGTtRgpuSE4TAfW6KEW0v7rcr2wwwDq7DHSuz4QN4odEGe9bvtx4zIZKufQzzN4TN2rd/BJkE_0_____OEM:DM_IoTEnterprise
ed655016-a9e8-4434-95d9-4345352c2552_QPM%f%6N-7J%f%2WJ-P88%f%HH-P3%f%YRH-YY%f%74H_191_X21-99682_lE8qL1p4m68mv9wcxU2sdKZPIccybtOjr+aMAdV+sLHs9wzE26oz5GiSZ3UzpU7yoYrNMqwGkKX6mrCEGRLh+XR2Ricp7ELA1PkzaGm0FLUqaK2GNVQ00i+s6KcA2XRr/gWOhhGTqSCjpSi9cMiqMbftf9Bo/BJVK3ib9xU4OQw_0_OEM:NONSLP_IoTEnterpriseS_VB
d4bdc678-0a4b-4a32-a5b3-aaa24c3b0f24_K9V%f%KN-3B%f%GWV-Y62%f%4W-MC%f%RMQ-BH%f%DCD_202_X22-53884_hPcIn0dF9Dq6zlXd3RxBqVDPDnf5sTasTjUqhD6lGc9IkTc8476NHd1PV1Ds++VO34/dw2H2PWk33LT5Es6PnUi32Ypva4POy4QJo5W3qyduiJiHUOM5GS9yAkKfdHFgUXaUVwopYKq+EwmgxFmEvHYdWgREHgIMyNoKAZQK0Ok_0_____Retail_CloudEditionN
92fb8726-92a8-4ffc-94ce-f82e07444653_KY7%f%PN-VR%f%6RX-83W%f%6Y-6D%f%DYQ-T6%f%R4W_203_X22-53847_DCP6QzPj+BD1EEmlBelBt7x9AmvQOfd7kdkUB0b0x6/TNHRnZtdyix3pNX2IDQtJbLnNLc2ZlMmupbZQrtyxe3xl8+xlCnHByXZpzFty9sGzq3MozHHA9u9WsJEf5R7tnFDplNM1UitlTVTAyuCGk83brY4zjmz/52pUQyQHzjI_0_____Retail_CloudEdition
d4f9b41f-205c-405e-8e08-3d16e88e02be_J7N%f%JW-V6%f%KBM-CC8%f%RW-Y2%f%9Y4-HQ%f%2MJ_205_X23-15027_U9eyfIBXrs++lyP6OjHHaF/wjieAxQeSKwzSkGBeTTpyCDcenq8t4cKvqDHnauSZzaVPWNoVcASkMCdlJi3EkR29KSgvx9/K2OB8LVH2PPpqvwjm1ZZdrvLMGhW83A/KRrtN9AOx7bnPC8MNLErnzbRRS9/aOrmp4Uzo8EIVagI_0_OEM:NONSLP_IoTEnterpriseSK
) do (
for /f "tokens=1-10 delims=_" %%A in ("%%#") do (

if %1==key if %osSKU%==%%C (

REM Detect key attempt 1

if "%2"=="attempt1" if not defined key (
echo "!applist!" | find /i "%%A" 1>nul && (
if %%F==1 set notworking=1
set key=%%B
)
)

REM Detect key attempt 2

if "%2"=="attempt2" if not defined key (
set actidnotfound=1
set 9th=%%I
if not defined 9th (
if %%F==1 set notworking=1
set key=%%B
) else (
echo "%branch%" | find /i "%%I" 1>nul && (
if %%F==1 set notworking=1
set key=%%B
)
)
)
)

REM Generate ticket

if %1==ticket if "%key%"=="%%B" (
set "string=OSMajorVersion=5;OSMinorVersion=1;OSPlatformId=2;PP=0;Pfn=Microsoft.Windows.%%C.%%D_8wekyb3d8bbwe;DownlevelGenuineState=1;$([char]0)"
for /f "tokens=* delims=" %%i in ('%psc% [conv%f%ert]::ToBas%f%e64String([Text.En%f%coding]::Uni%f%code.GetBytes("""!string!"""^)^)') do set "encoded=%%i"
echo "!encoded!" | find "AAAA" 1>nul || exit /b

<nul set /p "=<?xml version="1.0" encoding="utf-8"?><genuineAuthorization xmlns="http://www.microsoft.com/DRM/SL/GenuineAuthorization/1.0"><version>1.0</version><genuineProperties origin="sppclient"><properties>OA3xOriginalProductId=;OA3xOriginalProductKey=;SessionId=!encoded!;TimeStampClient=2022-10-11T12:00:00Z</properties><signatures><signature name="clientLockboxKey" method="rsa-sha256">%%E=</signature></signatures></genuineProperties></genuineAuthorization>" >"%tdir%\GenuineTicket"
)

)
)
exit /b

::========================================================================================================================================

::  Below code is used to get alternate edition name and key if current edition doesn't support HWID activation

::  ProfessionalCountrySpecific won't be converted because it's not a good idea to change CountrySpecific editions

::  1st column = Current SKU ID
::  2nd column = Current Edition Name
::  3rd column = Current Edition Activation ID
::  4th column = Alternate Edition Activation ID
::  5th column = Alternate Edition HWID Key
::  6th column = Alternate Edition Name
::  Separator  = _


:hwidfallback

set notfoundaltactID=
if %_NoEditionChange%==1 exit /b

for %%# in (
125_EnterpriseS-2021___________cce9d2de-98ee-4ce2-8113-222620c64a27_ed655016-a9e8-4434-95d9-4345352c2552_QPM%f%6N-7J2%f%WJ-P8%f%8HH-P3Y%f%RH-YY%f%74H_IoTEnterpriseS-2021
191_IoTEnterpriseS-Win11_______59eb965c-9150-42b7-a0ec-22151b9897c5_d4f9b41f-205c-405e-8e08-3d16e88e02be_J7N%f%JW-V6K%f%BM-CC%f%8RW-Y29%f%Y4-HQ%f%2MJ_IoTEnterpriseSK-Win11
138_ProfessionalSingleLanguage_a48938aa-62fa-4966-9d44-9f04da3f72f2_4de7cb65-cdf1-4de9-8ae8-e3cce27b9f2c_VK7%f%JG-NPH%f%TM-C9%f%7JM-9MP%f%GT-3V%f%66T_Professional
) do (
for /f "tokens=1-6 delims=_" %%A in ("%%#") do if %osSKU%==%%A (
echo "!applist!" | find /i "%%C" 1>nul && (
echo "!applist!" | find /i "%%D" 1>nul && (
set altkey=%%E
set curedition=%%B
set altedition=%%F
) || (
set altedition=%%F
set notfoundaltactID=1
)
)
)
)
exit /b

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:KMS38Activation
@setlocal DisableDelayedExpansion
@echo off

::  To activate, run the script with "/KMS38" parameter or change 0 to 1 in below line
set _act=0

::  To remove KMS38 protection, run the script with /KMS38-RemoveProtection parameter or change 0 to 1 in below line
set _rem=0

::  To disable changing edition if current edition doesn't support KMS38 activation, change the value to 1 from 0 or run the script with "/KMS38-NoEditionChange" parameter
set _NoEditionChange=0

::  If value is changed in above lines or parameter is used then script will run in unattended mode



::========================================================================================================================================

cls
color 07
title  KMS38 Activation

set _args=
set _elev=
set _unattended=0

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args (
for %%A in (%_args%) do (
if /i "%%A"=="/KMS38"                  set _act=1
if /i "%%A"=="/KMS38-RemoveProtection" set _rem=1
if /i "%%A"=="/KMS38-NoEditionChange"  set _NoEditionChange=1
if /i "%%A"=="-el"                     set _elev=1
)
)

for %%A in (%_act% %_rem% %_NoEditionChange%) do (if "%%A"=="1" set _unattended=1)

::========================================================================================================================================

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"
set     "Red="41;97m""
set    "Gray="100;97m""
set   "Green="42;97m""
set "Magenta="45;97m""
set  "_White="40;37m""
set  "_Green="40;92m""
set "_Yellow="40;93m""
) else (
set     "Red="Red" "white""
set    "Gray="Darkgray" "white""
set   "Green="DarkGreen" "white""
set "Magenta="Darkmagenta" "white""
set  "_White="Black" "Gray""
set  "_Green="Black" "Green""
set "_Yellow="Black" "Yellow""
)

set _k38=
set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :dk_color %Red% "==== ERROR ====" &echo:"
if %~z0 GEQ 200000 (set "_exitmsg=Go back") else (set "_exitmsg=Exit")
set "specific_kms=SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\55c92734-d682-4d71-983e-d6ec3f16059f"

::========================================================================================================================================

if %winbuild% LSS 14393 (
%eline%
echo Unsupported OS version detected.
echo KMS38 Activation is supported for Windows 10/11/Server, build 14393 and later.
goto dk_done
)

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"

setlocal EnableDelayedExpansion

::========================================================================================================================================

if %_rem%==1 goto :k_uninstall

:k_menu

if %_unattended%==0 (
cls
mode 76, 25
title  KMS38 Activation

echo:
echo:
echo:
echo:
echo         ____________________________________________________________
echo:
echo                 [1] KMS38 Activation
echo                 ____________________________________________
echo:
echo                 [2] Remove KM38 Protection
echo:
echo                 [0] %_exitmsg%
echo         ____________________________________________________________
echo: 
call :dk_color2 %_White% "              " %_Green% "Enter a menu option in the Keyboard [1,2,0]"
choice /C:120 /N
set _el=!errorlevel!
if !_el!==3  exit /b
if !_el!==2  goto :k_uninstall
if !_el!==1  goto :k_menu2
goto :k_menu
)

::========================================================================================================================================

:k_menu2

cls
mode 102, 33
title  KMS38 Activation

echo:
echo Initializing...
call :dk_product
call :dk_ckeckwmic

::  Show info for potential script stuck scenario

sc start sppsvc %nul%
if %errorlevel% NEQ 1056 if %errorlevel% NEQ 0 (
echo:
echo Error code: %errorlevel%
call :dk_color %Red% "Failed to start [sppsvc] service, rest of the process may take a long time..."
echo:
)

::========================================================================================================================================

::  Check if system is permanently activated or not

call :dk_checkperm
if defined _perm (
cls
echo ___________________________________________________________________________________________
echo:
call :dk_color2 %_White% "     " %Green% "Checking: %winos% is Permanently Activated."
call :dk_color2 %_White% "     " %Gray% "Activation is not required."
echo ___________________________________________________________________________________________
if %_unattended%==1 goto dk_done
echo:
choice /C:10 /N /M ">    [1] Activate [0] %_exitmsg% : "
if errorlevel 2 exit /b
)
cls

::========================================================================================================================================

::  Check Evaluation version

set _eval=
set _evalserv=

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" set _eval=1
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*EvalEdition~*.mum" set _evalserv=1
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*EvalCorEdition~*.mum" set _eval=1 & set _evalserv=1

if defined _eval (
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID 2>nul | find /i "Eval" 1>nul && (
%eline%
echo [%winos% ^| %winbuild%]
if defined _evalserv (
echo Server Evaluation cannot be activated. Convert it to full Server OS.
echo:
echo In MAS, goto Extras and use 'Change Edition' option.
) else (
echo Evaluation Editions cannot be activated. 
echo You need to install full version of %winos%
echo:
echo Download it from here,
echo https://massgrave.dev/genuine-installation-media.html
)
goto dk_done
)
)

::========================================================================================================================================

:: Check clipup.exe for the detection and activation of server cor and acor editions

set a_cor=
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*CorEdition~*.mum" if not exist "%systemroot%\System32\clipup.exe" set a_cor=1

if defined a_cor (
if not exist "!_work!\clipup.exe" (
%eline%
echo clipup.exe doesn't exist in Server Cor/Acor [No GUI] version.
echo It's required for KMS38 Activation.
echo Check below page on how to activate it.
echo https://massgrave.dev/kms38.html
goto dk_done
)
)

::========================================================================================================================================

::  Check SKU value / Check in multiple places to find Edition change corruption

set osSKU=
set regSKU=
set wmiSKU=

for /f "tokens=3 delims=." %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v OSProductPfn 2^>nul') do set "regSKU=%%a"
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%a in ('"wmic Path Win32_OperatingSystem Get OperatingSystemSKU /format:LIST" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"
if %_wmic% EQU 0 for /f "tokens=1" %%a in ('%psc% "([WMI]'Win32_OperatingSystem=@').OperatingSystemSKU" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"

set osSKU=%wmiSKU%
if not defined osSKU set osSKU=%regSKU%

if not defined osSKU (
%eline%
echo SKU value was not detected properly. Aborting...
goto dk_done
)

::========================================================================================================================================

set error=

cls
echo:
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') do set arch=%%b
echo Checking OS Info                        [%winos% ^| %winbuild% ^| %arch%]

::========================================================================================================================================

::  Check Windows Script Host

set _WSH=1
reg query "HKCU\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled 2>nul | find /i "0x0" 1>nul && (set _WSH=0)
reg query "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled 2>nul | find /i "0x0" 1>nul && (set _WSH=0)

if %_WSH% EQU 0 (
reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f %nul%
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f %nul%
if not "%arch%"=="x86" reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f /reg:32 %nul%
echo Enabling Windows Script Host            [Successful]
)

::========================================================================================================================================

echo Initiating Diagnostic Tests...

set "_serv=ClipSVC sppsvc KeyIso Winmgmt"

::  Client License Service (ClipSVC)
::  Software Protection
::  CNG Key Isolation
::  Windows Management Instrumentation

call :dk_errorcheck

::========================================================================================================================================

::  Check if GVLK (KMS key) is already installed or not

set _gvlk=
call :dk_channel
if /i "Volume:GVLK"=="%_channel%" set _gvlk=1

::  Detect Key

set key=
set pkey=
set altkey=
set changekey=
set curedition=
set altedition=

if defined applist call :kms38data getkey

if not defined key call :dk_gvlk %nul%
if defined applist if not defined key call :kms38fallback

if defined altkey (set key=%altkey%&set changekey=1)

if not defined key if defined notfoundaltactID (
call :dk_color %Red% "Checking Alternate Edition For KMS38    [%altedition% Activation ID Not Found]"
)

if not defined key if not defined _gvlk (
%eline%
echo [%winos% ^| %winbuild% ^| SKU:%osSKU%]
echo Unable to find this product in the supported product list.
echo Make sure you are using updated version of the script.
echo https://massgrave.dev
echo:
goto dk_done
)

::========================================================================================================================================

::  Install key

echo:
if defined changekey (
call :dk_color %Magenta% "[%altedition%] Edition product key will be used to enable KMS38 activation."
echo:
)

set _partial=
if not defined key (
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%# in ('wmic path SoftwareLicensingProduct where "ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f' and PartialProductKey<>null" Get PartialProductKey /value 2^>nul') do set "_partial=%%#"
if %_wmic% EQU 0 for /f "tokens=2 delims==" %%# in ('%psc% "(([WMISEARCHER]'SELECT PartialProductKey FROM SoftwareLicensingProduct WHERE ApplicationID=''55c92734-d682-4d71-983e-d6ec3f16059f'' AND PartialProductKey IS NOT NULL').Get()).PartialProductKey | %% {echo ('PartialProductKey='+$_)}" 2^>nul') do set "_partial=%%#"
call echo Checking Installed Product Key          [Partial Key - %%_partial%%] [Volume:GVLK]
)

set error_code=
if defined key (
if %_wmic% EQU 1 wmic path SoftwareLicensingService where __CLASS='SoftwareLicensingService' call InstallProductKey ProductKey="%key%" %nul%
if %_wmic% EQU 0 %psc% "(([WMISEARCHER]'SELECT Version FROM SoftwareLicensingService').Get()).InstallProductKey('%key%')" %nul%
if not !errorlevel!==0 cscript //nologo %windir%\system32\slmgr.vbs /ipk %key% %nul%
set error_code=!errorlevel!
cmd /c exit /b !error_code!
if !error_code! NEQ 0 set "error_code=[0x!=ExitCode!]"

if !error_code! EQU 0 (
call :dk_refresh
echo Installing KMS Client Setup Key         [%key%] [Successful]
) else (
call :dk_color %Red% "Installing KMS Client Setup Key         [%key%] [Failed] !error_code!"
if not defined error (
call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
set showfix=1
)
set error=1
)
)

::========================================================================================================================================

::  Check activation ID for setting specific KMS host

set app=
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%a in ('"wmic path SoftwareLicensingProduct where (ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL) get ID /VALUE" 2^>nul') do call set "app=%%a"
if %_wmic% EQU 0 for /f "tokens=2 delims==" %%a in ('%psc% "(([WMISEARCHER]'SELECT ID FROM SoftwareLicensingProduct WHERE ApplicationID=''55c92734-d682-4d71-983e-d6ec3f16059f'' AND Description like ''%%KMSCLIENT%%'' AND PartialProductKey IS NOT NULL').Get()).ID | %% {echo ('ID='+$_)}" 2^>nul') do call set "app=%%a"

if not defined app (
call :dk_color %Red% "Checking Installed GVLK Activation ID   [Not Found] Aborting..."
goto :dk_done
)

::========================================================================================================================================

::  Set specific KMS host to Local Host
::  By doing this, global KMS IP can not replace KMS38 activation but can be used with Office and other Windows Editions

echo:
%nul% reg delete "HKLM\%specific_kms%" /f
%nul% reg delete "HKU\S-1-5-20\%specific_kms%" /f

%nul% reg query "HKLM\%specific_kms%" && (
%psc% "$f=[io.file]::ReadAllText('!_batp!') -split ':regdel\:.*';iex ($f[1]);"
%nul% reg delete "HKLM\%specific_kms%" /f
)

set k_error=
%nul% reg add "HKLM\%specific_kms%\%app%" /f /v KeyManagementServiceName /t REG_SZ /d "127.0.0.2" || set k_error=1
%nul% reg add "HKLM\%specific_kms%\%app%" /f /v KeyManagementServicePort /t REG_SZ /d "1688" || set k_error=1

if not defined k_error (
echo Adding Specific KMS Host                [LocalHost 127.0.0.2] [Successful]
) else (
call :dk_color %Red% "Adding Specific KMS Host                [LocalHost 127.0.0.2] [Failed]"
)

::========================================================================================================================================

::  Copy clipup.exe to System32 directory to activate Server Cor/Acor editions

if defined a_cor (
set "_clipup=%systemroot%\System32\clipup.exe"
pushd "!_work!\"
copy /y /b "ClipUp.exe" "!_clipup!" %nul%
popd

echo:
if exist "!_clipup!" (
echo Copying clipup.exe File to              [%systemroot%\System32\] [Successful]
) else (
call :dk_color %Red% "Copying clipup.exe File to              [%systemroot%\System32\] [Failed] Aborting..."
goto :k_final
)
)

::========================================================================================================================================

::  Generate GenuineTicket.xml and apply
::  In some cases clipup -v -o method fails and in some cases service restart method fails as well
::  To maximize success rate and get better error details, script will install tickets two times (service restart + clipup -v -o)

set "tdir=%ProgramData%\Microsoft\Windows\ClipSVC\GenuineTicket"
if not exist "%tdir%\" md "%tdir%\" %nul%

if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%
if exist "%tdir%\*.xml" del /f /q "%tdir%\*.xml" %nul%
if exist "%ProgramData%\Microsoft\Windows\ClipSVC\Install\Migration\*" del /f /q "%ProgramData%\Microsoft\Windows\ClipSVC\Install\Migration\*" %nul%

::  Signature value is as it is, it's not encoded
::  Session ID is in Base64 encoded format. It's decoded value is "OSMajorVersion=5;OSMinorVersion=1;OSPlatformId=2;PP=0;GVLKExp=2038-01-19T03:14:07Z;DownlevelGenuineState=1;"
::  Check https://massgrave.dev/kms38.html#Manual_Activation to see how it's generated

set "signature=C52iGEoH+1VqzI6kEAqOhUyrWuEObnivzaVjyef8WqItVYd/xGDTZZ3bkxAI9hTpobPFNJyJx6a3uriXq3HVd7mlXfSUK9ydeoUdG4eqMeLwkxeb6jQWJzLOz41rFVSMtBL0e+ycCATebTaXS4uvFYaDHDdPw2lKY8ADj3MLgsA="
set "sessionId=TwBTAE0AYQBqAG8AcgBWAGUAcgBzAGkAbwBuAD0ANQA7AE8AUwBNAGkAbgBvAHIAVgBlAHIAcwBpAG8AbgA9ADEAOwBPAFMAUABsAGEAdABmAG8AcgBtAEkAZAA9ADIAOwBQAFAAPQAwADsARwBWAEwASwBFAHgAcAA9ADIAMAAzADgALQAwADEALQAxADkAVAAwADMAOgAxADQAOgAwADcAWgA7AEQAbwB3AG4AbABlAHYAZQBsAEcAZQBuAHUAaQBuAGUAUwB0AGEAdABlAD0AMQA7AAAA"
<nul set /p "=<?xml version="1.0" encoding="utf-8"?><genuineAuthorization xmlns="http://www.microsoft.com/DRM/SL/GenuineAuthorization/1.0"><version>1.0</version><genuineProperties origin="sppclient"><properties>OA3xOriginalProductId=;OA3xOriginalProductKey=;SessionId=%sessionId%;TimeStampClient=2022-10-11T12:00:00Z</properties><signatures><signature name="clientLockboxKey" method="rsa-sha256">%signature%</signature></signatures></genuineProperties></genuineAuthorization>" >"%tdir%\GenuineTicket"

copy /y /b "%tdir%\GenuineTicket" "%tdir%\GenuineTicket.xml" %nul%

if not exist "%tdir%\GenuineTicket.xml" (
call :dk_color %Red% "Generating GenuineTicket.xml            [Failed]"
if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%
goto :k_final
) else (
echo Generating GenuineTicket.xml            [Successful]
)

set "_xmlexist=if exist "%tdir%\GenuineTicket.xml""

::  Stop sppsvc

net stop sppsvc /y %nul%
net stop sppsvc /y %nul%
net stop sppsvc /y %nul%

sc query sppsvc | find /i "1  STOPPED" %nul% && (
echo Stopping sppsvc Service                 [Successful]
) || (
call :dk_color %Red% "Stopping sppsvc Service                 [Failed]"
)

%_xmlexist% (
net stop ClipSVC /y %nul%
net start ClipSVC /y %nul%
%_xmlexist% timeout /t 2 %nul%
%_xmlexist% timeout /t 2 %nul%

%_xmlexist% (
set error=1
if exist "%tdir%\*.xml" del /f /q "%tdir%\*.xml" %nul%
call :dk_color %Red% "Installing GenuineTicket.xml            [Failed With ClipSVC Service Restart, Wait...]"
)
)

copy /y /b "%tdir%\GenuineTicket" "%tdir%\GenuineTicket.xml" %nul%
clipup -v -o

set rebuildinfo=

%_xmlexist% (
set error=1
set rebuildinfo=1
call :dk_color %Red% "Installing GenuineTicket.xml            [Failed With clipup -v -o]"
)

if exist "%ProgramData%\Microsoft\Windows\ClipSVC\Install\Migration\*.xml" (
set error=1
set rebuildinfo=1
call :dk_color %Red% "Checking Ticket Migration               [Failed]"
)

if defined applist if not defined showfix if defined rebuildinfo (
set showfix=1
call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
)

if exist "%tdir%\Genuine*" del /f /q "%tdir%\Genuine*" %nul%

::==========================================================================================================================================

call :dk_product

echo:
echo Activating...
echo:

call :k_checkexp
if defined _k38 (
call :k_actinfo
goto :k_final
)

::  Clear 180 Days KMS Activation lock with Windows SKU specific rearm and without the need to restart the system

if %_wmic% EQU 1 wmic path SoftwareLicensingProduct where ID='%app%' call ReArmsku %nul%
if %_wmic% EQU 0 %psc% "$null=([WMI]'SoftwareLicensingProduct=''%app%''').ReArmsku()" %nul%

if %errorlevel%==0 (
echo Applying SKU-ID Rearm                   [Successful]
) else (
call :dk_color %Red% "Applying SKU-ID Rearm                   [Failed]"
)
call :dk_refresh

echo:
call :k_checkexp
if defined _k38 (
call :k_actinfo
goto :k_final
)

call :dk_color %Red% "Activation Failed"
if not defined error call :dk_color %Magenta% "In MAS, Goto Troubleshoot and run Fix Licensing option."
call :dk_color2 %Magenta% "Check this page for help" %_Yellow% " https://massgrave.dev/troubleshoot"

::========================================================================================================================================

:k_final

::  Remove the added Specific KMS Host (Local Host) if activation is not completed

echo:
if not defined _k38 (
%nul% reg delete "HKLM\%specific_kms%" /f
%nul% reg delete "HKU\S-1-5-20\%specific_kms%" /f
%nul% reg query "HKLM\%specific_kms%" && (
call :dk_color %Red% "Removing The Added Specific KMS Host    [Failed]"
) || (
echo Removing The Added Specific KMS Host    [Successful]
)
)

::  Protect KMS38 if opted by the user and conditions are correct

if defined _k38 (
%psc% "$f=[io.file]::ReadAllText('!_batp!') -split ':regdel\:.*';& ([ScriptBlock]::Create($f[1])) -protect;"
%nul% reg delete "HKLM\%specific_kms%" /f
%nul% reg query "HKLM\%specific_kms%" && (
call :dk_color %Magenta% "Protect KMS38 By KMS                    [Successful] [Locked A Registry Key]"
) || (
call :dk_color %Red% "Protect KMS38 By KMS                    [Failed To Lock A Registry Key]"
)
)

::  clipup.exe does not exist in server cor and acor editions by default, it was copied there with this script

if defined a_cor if exist "%_clipup%" del /f /q "%_clipup%" %nul%

if defined a_cor (
if exist "%_clipup%" (
call :dk_color %Red% "Deleting copied clipup.exe file         [Failed]"
) else (
echo Deleting copied clipup.exe file         [Successful]
)
)

for %%# in (175 407) do if %osSKU%==%%# (
call :dk_color %Red% "%winos% does not support activation on non-azure platforms."
)

goto :dk_done

::========================================================================================================================================

:k_uninstall

cls
mode 99, 28
title  Remove KMS38 Protection

%nul% reg delete "HKLM\%specific_kms%" /f
%nul% reg delete "HKU\S-1-5-20\%specific_kms%" /f

%nul% reg query "HKLM\%specific_kms%" && (
%psc% "$f=[io.file]::ReadAllText('!_batp!') -split ':regdel\:.*';iex ($f[1]);"
%nul% reg delete "HKLM\%specific_kms%" /f
)

echo:
%nul% reg query "HKLM\%specific_kms%" && (
call :dk_color %Red% "Removing Specific KMS Host              [Failed]"
) || (
echo Removing Specific KMS Host              [Successful]
)

goto :dk_done

::========================================================================================================================================

::  This code runs to protect/undo below registry key for KMS38 protection
::  HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\55c92734-d682-4d71-983e-d6ec3f16059f

::  KMS38 protection stops 180 days KMS Activation from replacing KMS38 activation

:regdel:
param (
    [switch]$protect
)

$SID = New-Object System.Security.Principal.SecurityIdentifier('S-1-5-32-544')
$Admin = ($SID.Translate([System.Security.Principal.NTAccount])).Value

if($protect) {
$ruleArgs = @("$Admin", "Delete, SetValue", "ContainerInherit", "None", "Deny")
} else {
$ruleArgs = @("$Admin", "FullControl", "Allow")
}

$path = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform\55c92734-d682-4d71-983e-d6ec3f16059f'
$key = [Microsoft.Win32.RegistryKey]::OpenBaseKey('LocalMachine', 'Registry64').OpenSubKey($path, 'ReadWriteSubTree', 'ChangePermissions')
$acl = $key.GetAccessControl()

$rule = [System.Security.AccessControl.RegistryAccessRule]::new.Invoke($ruleArgs)
$acl.ResetAccessRule($rule)
$key.SetAccessControl($acl)
:regdel:

::========================================================================================================================================

::  Check KMS activation status

:k_actinfo

set xpr=
for /f "tokens=* delims=" %%# in ('%psc% "$([DateTime]::Now.addMinutes(%gpr%)).ToString('yyyy-MM-dd HH:mm:ss')" 2^>nul') do set "xpr=%%#"
call :dk_color %Green% "%winos% is activated till !xpr!"
exit /b

::  Check remaining KMS activation grace period

:k_checkexp

set gpr=0
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%# in ('"wmic path SoftwareLicensingProduct where (ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL) get GracePeriodRemaining /VALUE" 2^>nul') do set "gpr=%%#"
if %_wmic% EQU 0 for /f "tokens=2 delims==" %%# in ('%psc% "(([WMISEARCHER]'SELECT GracePeriodRemaining FROM SoftwareLicensingProduct WHERE ApplicationID=''55c92734-d682-4d71-983e-d6ec3f16059f'' AND Description like ''%%KMSCLIENT%%'' AND PartialProductKey IS NOT NULL').Get()).GracePeriodRemaining | %% {echo ('GracePeriodRemaining='+$_)}" 2^>nul') do set "gpr=%%#"
if %gpr% GTR 259200 (set _k38=1) else (set _k38=)
exit /b

::  Get Windows installed key channel

:dk_channel

if %_wmic% EQU 1 for /f "tokens=2 delims==" %%# in ('wmic path SoftwareLicensingProduct where "ApplicationID='55c92734-d682-4d71-983e-d6ec3f16059f' and PartialProductKey<>null" Get ProductKeyChannel /value 2^>nul') do set "_channel=%%#"
if %_wmic% EQU 0 for /f "tokens=2 delims==" %%# in ('%psc% "(([WMISEARCHER]'SELECT ProductKeyChannel FROM SoftwareLicensingProduct WHERE ApplicationID=''55c92734-d682-4d71-983e-d6ec3f16059f'' AND PartialProductKey IS NOT NULL').Get()).ProductKeyChannel | %% {echo ('ProductKeyChannel='+$_)}" 2^>nul') do set "_channel=%%#"
exit /b

::========================================================================================================================================

::  Get Product Key from pkeyhelper.dll for future new editions
::  It works on Windows 10 1803 (17134) and later builds.

:dk_pkey

call :dk_reflection

set d1=%ref% [void]$TypeBuilder.DefinePInvokeMethod('SkuGetProductKeyForEdition', 'pkeyhelper.dll', 'Public, Static', 1, [int], @([int], [String], [String].MakeByRefType(), [String].MakeByRefType()), 1, 3);
set d1=%d1% $out = ''; [void]$TypeBuilder.CreateType()::SkuGetProductKeyForEdition(%1, %2, [ref]$out, [ref]$null); $out

set pkey=
for /f %%a in ('%psc% "%d1%"') do if not errorlevel 1 (set pkey=%%a)
exit /b

::  Get channel name for the key which was extracted from pkeyhelper.dll

:dk_pkeychannel

set k=%1
set m=[Runtime.InteropServices.Marshal]
set p=%SystemRoot%\System32\spp\tokens\pkeyconfig\pkeyconfig.xrm-ms

set d1=%ref% [void]$TypeBuilder.DefinePInvokeMethod('PidGenX', 'pidgenx.dll', 'Public, Static', 1, [int], @([String], [String], [String], [int], [IntPtr], [IntPtr], [IntPtr]), 1, 3);
set d1=%d1% $r = [byte[]]::new(0x04F8); $r[0] = 0xF8; $r[1] = 0x04; $f = %m%::AllocHGlobal(0x04F8); %m%::Copy($r, 0, $f, 0x04F8);
set d1=%d1% [void]$TypeBuilder.CreateType()::PidGenX('%k%', '%p%', '00000', 0, 0, 0, $f); %m%::Copy($f, $r, 0, 0x04F8); %m%::FreeHGlobal($f); [Text.Encoding]::Unicode.GetString($r, 1016, 128)

set pkeychannel=
for /f %%a in ('%psc% "%d1%"') do if not errorlevel 1 (set pkeychannel=%%a)
exit /b

:dk_gvlk

for %%# in (pkeyhelper.dll) do @if "%%~$PATH:#"=="" exit /b
for %%# in (Volume:GVLK) do (
call :dk_pkey %osSKU% '%%#'
if defined pkey call :dk_pkeychannel !pkey!
if /i [!pkeychannel!]==[%%#] (
set key=!pkey!
exit /b
)
)
exit /b

::========================================================================================================================================

::  1st column = Activation ID
::  2nd column = GVLK (Generic volume licensing key)
::  3rd column = SKU ID
::  4th column = WMI Edition ID (For reference only)
::  5th column = Build Branch name incase same Edition ID is used in different OS versions with different key (For reference only)
::  Separator  = "_"

:kms38data

set f=
for %%# in (
73111121-5638-40f6-bc11-f1d7b0d64300_NPP%f%R9-FW%f%DCX-D2C%f%8J-H8%f%72K-2Y%f%T43___4_Enterprise
9bd77860-9b31-4b7b-96ad-2564017315bf_VDY%f%BN-27%f%WPP-V4H%f%QT-9V%f%MD4-VM%f%K7H___7_ServerStandard_FE
de32eafd-aaee-4662-9444-c1befb41bde2_N69%f%G4-B8%f%9J2-4G8%f%F4-WW%f%YCC-J4%f%64C___7_ServerStandard_RS5
8c1c5410-9f39-4805-8c9d-63a07706358f_WC2%f%BQ-8N%f%RM3-FDD%f%YY-2B%f%FGV-KH%f%KQY___7_ServerStandard_RS1
ef6cfc9f-8c5d-44ac-9aad-de6a2ea0ae03_WX4%f%NM-KY%f%WYW-QJJ%f%R4-XV%f%3QB-6V%f%M33___8_ServerDatacenter_FE
34e1ae55-27f8-4950-8877-7a03be5fb181_WMD%f%GN-G9%f%PQG-XVV%f%XX-R3%f%X43-63%f%DFG___8_ServerDatacenter_RS5
21c56779-b449-4d20-adfc-eece0e1ad74b_CB7%f%KF-BW%f%N84-R7R%f%2Y-79%f%3K2-8X%f%DDG___8_ServerDatacenter_RS1
e272e3e2-732f-4c65-a8f0-484747d0d947_DPH%f%2V-TT%f%NVB-4X9%f%Q3-TJ%f%R4H-KH%f%JW4__27_EnterpriseN
2de67392-b7a7-462a-b1ca-108dd189f588_W26%f%9N-WF%f%GWX-YVC%f%9B-4J%f%6C9-T8%f%3GX__48_Professional
a80b5abf-76ad-428b-b05d-a47d2dffeebf_MH3%f%7W-N4%f%7XK-V7X%f%M9-C7%f%227-GC%f%QG9__49_ProfessionalN
034d3cbb-5d4b-4245-b3f8-f84571314078_WVD%f%HN-86%f%M7X-466%f%P6-VH%f%XV7-YY%f%726__50_ServerSolution_RS5
2b5a1b0f-a5ab-4c54-ac2f-a6d94824a283_JCK%f%RF-N3%f%7P4-C2D%f%82-9Y%f%XRT-4M%f%63B__50_ServerSolution_RS1
7b9e1751-a8da-4f75-9560-5fadfe3d8e38_3KH%f%Y7-WN%f%T83-DGQ%f%KR-F7%f%HPR-84%f%4BM__98_CoreN
a9107544-f4a0-4053-a96a-1479abdef912_PVM%f%JN-6D%f%FY6-9CC%f%P6-7B%f%KTT-D3%f%WVR__99_CoreCountrySpecific
cd918a57-a41b-4c82-8dce-1a538e221a83_7HN%f%RX-D7%f%KGG-3K4%f%RQ-4W%f%PJ4-YT%f%DFH_100_CoreSingleLanguage
58e97c99-f377-4ef1-81d5-4ad5522b5fd8_TX9%f%XD-98%f%N7V-6WM%f%Q6-BX%f%7FG-H8%f%Q99_101_Core
7b4433f4-b1e7-4788-895a-c45378d38253_QN4%f%C6-GB%f%JD2-FB4%f%22-GH%f%WJK-GJ%f%G2R_110_ServerCloudStorage
8de8eb62-bbe0-40ac-ac17-f75595071ea3_GRF%f%BW-QN%f%DC4-6QB%f%HG-CC%f%K3B-2P%f%R88_120_ServerARM64_RS5
43d9af6e-5e86-4be8-a797-d072a046896c_K9F%f%YF-G6%f%NCK-73M%f%32-XM%f%VPY-F9%f%DRR_120_ServerARM64_RS4
e0c42288-980c-4788-a014-c080d2e1926e_NW6%f%C2-QM%f%PVW-D7K%f%KK-3G%f%KT6-VC%f%FB2_121_Education
3c102355-d027-42c6-ad23-2e7ef8a02585_2WH%f%4N-8Q%f%GBV-H22%f%JP-CT%f%43Q-MD%f%WWJ_122_EducationN
32d2fab3-e4a8-42c2-923b-4bf4fd13e6ee_M7X%f%TQ-FN%f%8P6-TTK%f%YV-9D%f%4CC-J4%f%62D_125_EnterpriseS_RS5,VB
2d5a5a60-3040-48bf-beb0-fcd770c20ce0_DCP%f%HK-NF%f%MTC-H88%f%MJ-PF%f%HPY-QJ%f%4BJ_125_EnterpriseS_RS1
7b51a46c-0c04-4e8f-9af4-8496cca90d5e_WNM%f%TR-4C%f%88C-JK8%f%YV-HQ%f%7T2-76%f%DF9_125_EnterpriseS_TH1
7103a333-b8c8-49cc-93ce-d37c09687f92_92N%f%FX-8D%f%JQP-P6B%f%BQ-TH%f%F9C-7C%f%G2H_126_EnterpriseSN_RS5,VB
9f776d83-7156-45b2-8a5c-359b9c9f22a3_QFF%f%DN-GR%f%T3P-VKW%f%WX-X7%f%T3R-8B%f%639_126_EnterpriseSN_RS1
87b838b7-41b6-4590-8318-5797951d8529_2F7%f%7B-TN%f%FGY-69Q%f%QF-B8%f%YKP-D6%f%9TJ_126_EnterpriseSN_TH1
39e69c41-42b4-4a0a-abad-8e3c10a797cc_QFN%f%D9-D3%f%Y9C-J3K%f%KY-6R%f%PVP-2D%f%PYV_145_ServerDatacenterACor_FE
90c362e5-0da1-4bfd-b53b-b87d309ade43_6NM%f%RW-2C%f%8FM-D24%f%W7-TQ%f%WMY-CW%f%H2D_145_ServerDatacenterACor_RS5
e49c08e7-da82-42f8-bde2-b570fbcae76c_2HX%f%DN-KR%f%XHB-GPY%f%C7-YC%f%KFJ-7F%f%VDG_145_ServerDatacenterACor_RS3
f5e9429c-f50b-4b98-b15c-ef92eb5cff39_67K%f%N8-4F%f%YJW-248%f%7Q-MQ%f%2J7-4C%f%4RG_146_ServerStandardACor_FE
73e3957c-fc0c-400d-9184-5f7b6f2eb409_N2K%f%JX-J9%f%4YW-TQV%f%FB-DG%f%9YT-72%f%4CC_146_ServerStandardACor_RS5
61c5ef22-f14f-4553-a824-c4b31e84b100_PTX%f%N8-JF%f%HJM-4WC%f%78-MP%f%CBR-9W%f%4KR_146_ServerStandardACor_RS3
82bbc092-bc50-4e16-8e18-b74fc486aec3_NRG%f%8B-VK%f%K3Q-CXV%f%CJ-9G%f%2XF-6Q%f%84J_161_ProfessionalWorkstation
4b1571d3-bafb-4b40-8087-a961be2caf65_9FN%f%HH-K3%f%HBT-3W4%f%TD-63%f%83H-6X%f%YWF_162_ProfessionalWorkstationN
3f1afc82-f8ac-4f6c-8005-1d233e606eee_6TP%f%4R-GN%f%PTD-KYY%f%HQ-7B%f%7DP-J4%f%47Y_164_ProfessionalEducation
5300b18c-2e33-4dc2-8291-47ffcec746dd_YVW%f%GF-BX%f%NMC-HTQ%f%YQ-CP%f%Q99-66%f%QFC_165_ProfessionalEducationN
8c8f0ad3-9a43-4e05-b840-93b8d1475cbc_6N3%f%79-GG%f%TMK-23C%f%6M-XV%f%VTC-CK%f%FRQ_168_ServerAzureCor_FE
a99cc1f0-7719-4306-9645-294102fbff95_FDN%f%H6-VW%f%9RW-BXP%f%J7-4X%f%TYG-23%f%9TB_168_ServerAzureCor_RS5
3dbf341b-5f6c-4fa7-b936-699dce9e263f_VP3%f%4G-4N%f%PPG-79J%f%TQ-86%f%4T4-R3%f%MQX_168_ServerAzureCor_RS1
e0b2d383-d112-413f-8a80-97f373a5820c_YYV%f%X9-NT%f%FWV-6MD%f%M3-9P%f%T4T-4M%f%68B_171_EnterpriseG
e38454fb-41a4-4f59-a5dc-25080e354730_44R%f%PN-FT%f%Y23-9VT%f%TB-MP%f%9BX-T8%f%4FV_172_EnterpriseGN
ec868e65-fadf-4759-b23e-93fe37f2cc29_CPW%f%HC-NT%f%2C7-VYW%f%78-DH%f%DB2-PG%f%3GK_175_ServerRdsh_RS5
e4db50ea-bda1-4566-b047-0ca50abc6f07_7NB%f%T4-WG%f%BQX-MP4%f%H7-QX%f%FF8-YP%f%3KX_175_ServerRdsh_RS3
0df4f814-3f57-4b8b-9a9d-fddadcd69fac_NBT%f%WJ-3D%f%R69-3C4%f%V8-C2%f%6MC-GQ%f%9M6_183_CloudE
59eb965c-9150-42b7-a0ec-22151b9897c5_KBN%f%8V-HF%f%GQ4-MGX%f%VD-34%f%7P6-PD%f%QGT_191_IoTEnterpriseS_NI
d30136fc-cb4b-416e-a23d-87207abc44a9_6XN%f%7V-PC%f%BDC-BDB%f%RH-8D%f%QY7-G6%f%R44_202_CloudEditionN
ca7df2e3-5ea0-47b8-9ac1-b1be4d8edd69_37D%f%7F-N4%f%9CB-WQR%f%8W-TB%f%J73-FM%f%8RX_203_CloudEdition
19b5e0fb-4431-46bc-bac1-2f1873e4ae73_NTB%f%V8-9K%f%7Q8-V27%f%C6-M2%f%BTV-KH%f%MXV_407_ServerTurbine
) do (
for /f "tokens=1-5 delims=_" %%A in ("%%#") do if %osSKU%==%%C (
if %1==getkey if not defined key echo "!applist!" | find /i "%%A" >nul && set key=%%B
)
)
exit /b

::========================================================================================================================================

::  Below code is used to get alternate edition name and key if current edition doesn't support KMS38 activation
::  ProfessionalCountrySpecific won't be converted because it's not a good idea to change CountrySpecific editions

::  1st column = Current SKU ID
::  2nd column = Current Edition Name
::  3rd column = Current Edition Activation ID
::  4th column = Alternate Edition Activation ID
::  5th column = Alternate Edition GVLK
::  6th column = Alternate Edition Name
::  Separator  = _


:kms38fallback

set notfoundaltactID=
if %_NoEditionChange%==1 exit /b

for %%# in (
188_IoTEnterprise_______________8ab9bdd1-1f67-4997-82d9-8878520837d9_73111121-5638-40f6-bc11-f1d7b0d64300_NPP%f%R9-FWD%f%CX-D2%f%C8J-H872%f%K-2Y%f%T43_Enterprise
191_IoTEnterpriseS-2021_________ed655016-a9e8-4434-95d9-4345352c2552_32d2fab3-e4a8-42c2-923b-4bf4fd13e6ee_M7X%f%TQ-FN8%f%P6-TT%f%KYV-9D4C%f%C-J4%f%62D_EnterpriseS-2021
205_IoTEnterpriseSK_____________d4f9b41f-205c-405e-8e08-3d16e88e02be_59eb965c-9150-42b7-a0ec-22151b9897c5_KBN%f%8V-HFG%f%Q4-MG%f%XVD-347P%f%6-PD%f%QGT_IoTEnterpriseS-Win11
138_ProfessionalSingleLanguage__a48938aa-62fa-4966-9d44-9f04da3f72f2_2de67392-b7a7-462a-b1ca-108dd189f588_W26%f%9N-WFG%f%WX-YV%f%C9B-4J6C%f%9-T8%f%3GX_Professional
) do (
for /f "tokens=1-6 delims=_" %%A in ("%%#") do if %osSKU%==%%A (
echo "!applist!" | find /i "%%C" 1>nul && (
echo "!applist!" | find /i "%%D" 1>nul && (
set altkey=%%E
set curedition=%%B
set altedition=%%F
) || (
set altedition=%%F
set notfoundaltactID=1
)
)
)
)
exit /b

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:KMSActivation
@setlocal DisableDelayedExpansion
@echo off

cls
color 07
title  Online KMS Activation

::  You are not supposed to edit anything below this.

set WMI_VBS=0
set _Debug=0
set Silent=0
set Logger=0
set AutoR2V=1
set SkipKMS38=1
set vNextOverride=1
set ActWindows=1
set ActOffice=1

set _uni=
set _args=
set _elev=
set _renetask=
set _renacttask=
set _unattended=
set _unattendedact=

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args (
set _unattended=1
if "%_args%"=="-el"  set _unattended=

for %%A in (%_args%) do (
if /i "%%A"=="-el"  (set _elev=1
) else if /i "%%A"=="/KMS-RenewalTask"  (set _renetask=1
) else if /i "%%A"=="/KMS-ActAndRenewalTask" (set _renacttask=1
) else if /i "%%A"=="/KMS-Uninstall" (set _uni=1
) else if /i "%%A"=="/KMS-Windows"   (set ActWindows=1&set ActOffice=0&set _unattendedact=1
) else if /i "%%A"=="/KMS-Office"   (set ActWindows=0&set ActOffice=1&set _unattendedact=1
) else if /i "%%A"=="/KMS-WindowsOffice"  (set ActWindows=1&set ActOffice=1&set _unattendedact=1
) else if /i "%%A"=="/KMS-KeepvNext"  (set vNextOverride=0
) else if /i "%%A"=="/KMS-Debug"   (set _Debug=1
) else if /i "%%A"=="/KMS-Logger"   (set Logger=1&set Silent=1
)
)
)

::========================================================================================================================================

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

call :_colorprep
set "_buf={$W=$Host.UI.RawUI.WindowSize;$B=$Host.UI.RawUI.BufferSize;$W.Height=31;$B.Height=300;$Host.UI.RawUI.WindowSize=$W;$Host.UI.RawUI.BufferSize=$B;}"

set "nceline=echo. &echo ==== ERROR ==== &echo."
set "eline=echo. &call :_color %Red% "==== ERROR ====" &echo."
if %_Debug% EQU 1 set _unattended=1

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"
set "_Local=%LocalAppData%"

setlocal EnableDelayedExpansion

::========================================================================================================================================

if %~z0 GEQ 300000 (set "_exitmsg=Go back") else (set "_exitmsg=Exit")

::  Check not x86 Windows

set notx86=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') do set arch=%%b
if /i not "%arch%"=="x86" set notx86=1

::========================================================================================================================================

for %%# in (wmic.exe) do @if "%%~$PATH:#"=="" (
%nceline%
echo Unable to find wmic.exe in the system.
if %winbuild% GEQ 22621 echo Make sure WMIC is enabled in optional features.
goto Done
)

wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "ComputerSystem" 1>nul || (
%nceline%
echo WMI is not responding in the system.
echo:
echo In MAS, Goto Troubleshoot and run Fix WMI option.
goto Done
)

set _WSH=1
reg query "HKCU\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled 2>nul | find /i "0x0" 1>nul && (set _WSH=0)
reg query "HKLM\SOFTWARE\Microsoft\Windows Script Host\Settings" /v Enabled 2>nul | find /i "0x0" 1>nul && (set _WSH=0)

if %_WSH% EQU 0 (
reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f %nul%
reg add "HKCU\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f %nul%
if defined notx86 reg add "HKLM\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f /reg:32 %nul%
)

::========================================================================================================================================

if defined _uni goto _Complete_Uninstall

if defined _renetask set ActTask=&call:RenTask&timeout /t 2
cls
if defined _renacttask set ActTask=1&call:RenTask&timeout /t 2
cls
if defined _unattended if not defined _unattendedact goto Done

::========================================================================================================================================

set "_title=Online KMS Activation"
set _gui=

:_KMS_Menu

set sub_next=0
set sub_o365=0
set sub_proj=0
set sub_vsio=0
set kNext=HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Licensing\LicensingNext
reg query %kNext% /v MigrationToV5Done 2>nul | find /i "0x1" %nul% && call :officeSub %nul%

set _tskinstalled=
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\taskcache\tasks" /f Path /s | find /i "\Activation-Renewal" >nul && (
find /i "Ver:1.8" %ProgramData%\Activation-Renewal\Activation_task.cmd %nul% && set _tskinstalled=1
)

set _oldtsk=
if not defined _tskinstalled (
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\taskcache\tasks" /f Path /s | findstr /i "\Activation-Renewal \Online_KMS_Activation_Script-Renewal" >nul && (
set _oldtsk=1
)
)

if defined _unattended (
call :Activation_Start
timeout /t 2
goto Done
)

cls
set _gui=1
title  %_title%
mode con: cols=76 lines=30

echo.
echo.
echo.
echo.
echo.       ______________________________________________________________
echo.
echo.              [1] Activate - Windows
echo.              [2] Activate - Office
echo.              [3] Activate - All
echo.
if defined _tskinstalled call :_color2 %_White% "              [4] Install Auto-Renewal      " %_Green% "[Installed]"
if defined _oldtsk       call :_color2 %_White% "              [4] Install Auto-Renewal      " %_Red% "[Old Installed]"
if not defined _tskinstalled if not defined _oldtsk echo.              [4] Install Auto-Renewal
echo.              [5] Uninstall
echo.              _______________________________________________  
echo.
if %_Debug%==0 (
echo.              [6] Enable Debug Mode         [No]
) else (
call :_color2 %_White% "              [6] Enable Debug Mode         " %_Red% "[Yes]"
)
if %vNextOverride% EQU 1 (
if %sub_next% EQU 1 (
call :_color2 %_White% "              [7] Override Office vNext     " %_Red% "[Yes]"
) else (
echo               [7] Override Office vNext     [Yes]
)
) else (
if %sub_next% EQU 1 (
call :_color2 %_White% "              [7] Override Office vNext     " %_Yellow% "[No]"
) else (
echo               [7] Override Office vNext     [No]
)
)
echo.              _______________________________________________       
echo.
echo.              [0] %_exitmsg%
echo.       ______________________________________________________________
echo.
call :_color2 %_White% "           " %_Green% "Enter a menu option in the Keyboard [1,2,3,4,5,6,7,0]"
choice /C:12345670 /N
set _el=%errorlevel%

if %_el%==8 exit /b
if %_el%==7 (if %vNextOverride% EQU 0 (set vNextOverride=1) else (set vNextOverride=0))&goto _KMS_Menu
if %_el%==6 (if %_Debug%==0 (set _Debug=1) else (set _Debug=0)) &goto _KMS_Menu
if %_el%==5 call:_Complete_Uninstall&cls&goto _KMS_Menu
if %_el%==4 set ActTask=&call:RenTask&goto _KMS_Menu
if %_el%==3 cls&setlocal&set "ActWindows=1"&set "ActOffice=1"&call :Activation_Start&endlocal&cls&goto _KMS_Menu
if %_el%==2 cls&setlocal&set "ActWindows=0"&set "ActOffice=1"&call :Activation_Start&endlocal&cls&goto _KMS_Menu
if %_el%==1 cls&setlocal&set "ActWindows=1"&set "ActOffice=0"&call :Activation_Start&endlocal&cls&goto _KMS_Menu
goto _KMS_Menu

::========================================================================================================================================

:Done

if defined _unattended exit /b

echo.
echo Press any key to exit...
pause >nul
exit /b

:=========================================================================================================================================

:Activation_Start

@setlocal DisableDelayedExpansion

set nil=
for %%# in (SppE%nil%xtComObj.exe,sppsvc.exe,osppsvc.exe) do (
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Ima%nil%ge File Execu%nil%tion Options\%%#" /f %nul%)
)

call :Clear-KMS-Cache %nul%

set "_Null=1>nul 2>nul"
set KMS_Port=1688
if %_Debug% EQU 1 set _unattended=1
set "_run=nul"
if %Logger% EQU 1 set _run="%~dpn0_Silent.log"

set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "SysPath=%SystemRoot%\Sysnative"
set "Path=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)
set "_bit=64"
set "_wow=1"
if /i "%PROCESSOR_ARCHITECTURE%"=="amd64" set "xBit=x64"&set "xOS=x64"
if /i "%PROCESSOR_ARCHITECTURE%"=="arm64" set "xBit=x86"&set "xOS=A64"
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" if "%PROCESSOR_ARCHITEW6432%"=="" set "xBit=x86"&set "xOS=x86"&set "_wow=0"&set "_bit=32"
if /i "%PROCESSOR_ARCHITEW6432%"=="amd64" set "xBit=x64"&set "xOS=x64"
if /i "%PROCESSOR_ARCHITEW6432%"=="arm64" set "xBit=x86"&set "xOS=A64"
if not defined xBit set "xBit=x64"&set "xOS=x64"

set _cwmi=0
for %%# in (wmic.exe) do @if not "%%~$PATH:#"=="" (
wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "ComputerSystem" 1>nul && set _cwmi=1
)

set "_Local=%LocalAppData%"
set "_temp=%SystemRoot%\Temp"
set "_log=%~dpn0"
set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"
set _UNC=0
if "%_work:~0,2%"=="\\" set _UNC=1
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set "_dsk=%%b"
if exist "%PUBLIC%\Desktop\desktop.ini" set "_dsk=%PUBLIC%\Desktop"
set "_mO21a=Detected Office 2021 C2R Retail is activated"
set "_mO19a=Detected Office 2019 C2R Retail is activated"
set "_mO16a=Detected Office 2016 C2R Retail is activated"
set "_mO15a=Detected Office 2013 C2R Retail is activated"
set "_mO21c=Detected Office 2021 C2R Retail could not be converted to Volume"
set "_mO19c=Detected Office 2019 C2R Retail could not be converted to Volume"
set "_mO16c=Detected Office 2016 C2R Retail could not be converted to Volume"
set "_mO15c=Detected Office 2013 C2R Retail could not be converted to Volume"
set "_mO14c=Detected Office 2010 C2R Retail is not supported by this script"
set "_mO14m=Detected Office 2010 MSI Retail is not supported by this script"
set "_mO15m=Detected Office 2013 MSI Retail is not supported by this script"
set "_mO16m=Detected Office 2016 MSI Retail is not supported by this script"
set "_mOuwp=Detected Office 365/2016 UWP is not supported by this script"
set DO15Ids=ProPlus,Standard,Access,Lync,Excel,Groove,InfoPath,OneNote,Outlook,PowerPoint,Publisher,Word
set DO16Ids=ProPlus,Standard,Access,SkypeforBusiness,Excel,Outlook,PowerPoint,Publisher,Word
set LV16Ids=Mondo,ProPlus,ProjectPro,VisioPro,Standard,ProjectStd,VisioStd,Access,SkypeforBusiness,OneNote,Excel,Outlook,PowerPoint,Publisher,Word
set LR16Ids=%LV16Ids%,Professional,HomeBusiness,HomeStudent,O365Business,O365SmallBusPrem,O365HomePrem,O365EduCloud
set "ESUEditions=Enterprise,EnterpriseE,EnterpriseN,Professional,ProfessionalE,ProfessionalN,Ultimate,UltimateE,UltimateN"
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
set "ESUEditions=ServerDatacenter,ServerDatacenterCore,ServerDatacenterV,ServerDatacenterVCore,ServerStandard,ServerStandardCore,ServerStandardV,ServerStandardVCore,ServerEnterprise,ServerEnterpriseCore,ServerEnterpriseV,ServerEnterpriseVCore"
)
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G
set "_csq=cscript.exe //NoLogo //Job:WmiQuery "%~nx0?.wsf""
set "_csm=cscript.exe //NoLogo //Job:WmiMethod "%~nx0?.wsf""
set "_csp=cscript.exe //NoLogo //Job:WmiPKey "%~nx0?.wsf""
set "_csd=cscript.exe //NoLogo //Job:MPS "%~nx0?.wsf""
if %_cwmi% EQU 0 set WMI_VBS=1
if %WMI_VBS% EQU 0 (
set "_zz1=wmic path"
set "_zz2=where"
set "_zz3=get"
set "_zz4=/value"
set "_zz5=("
set "_zz6=)"
set "_zz7="wmic path"
set "_zz8=/value""
) else (
set "_zz1=%_csq%"
set "_zz2="
set "_zz3="
set "_zz4="
set "_zz5=""
set "_zz6=""
set "_zz7=%_csq%"
set "_zz8="
)

setlocal EnableDelayedExpansion
pushd "!_work!"

if not defined _unattended (
mode con cols=98 lines=31
%nul% %psc% "&%_buf%"
title  %_title%
) else (
title  Online KMS Activation
)

if defined _gui if %_Debug%==1 mode con cols=98 lines=30

if %_Debug% EQU 0 (
  set "_Nul1=1>nul"
  set "_Nul2=2>nul"
  set "_Nul6=2^>nul"
  set "_Nul3=1>nul 2>nul"
  set "_Pause=pause >nul"
  if %Silent% EQU 0 (call :Begin) else (call :Begin >!_run! 2>&1)
) else (
  set "_Nul1="
  set "_Nul2="
  set "_Nul6="
  set "_Nul3="
  set "_log=!_dsk!\%~n0"
  if %Silent% EQU 0 (
  echo.
  echo Running in Debug Mode...
  if not defined _args (echo The window will be closed when finished) else (echo please wait...)
  echo.
  echo Writing debug log to:
  echo "!_log!_Debug.log"
  )
  @echo on
  @prompt $G
  @call :Begin >"!_log!_tmp.log" 2>&1 &cmd /u /c type "!_log!_tmp.log">"!_log!_Debug.log"&del "!_log!_tmp.log"
)
@echo off
if defined _gui if %_Debug%==1 (
echo.
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b
)
@exit /b

:Begin

::========================================================================================================================================

set act_failed=0
set /a act_attempt=0

echo.
echo Initializing...

:: Check Internet connection. Works even if ICMP echo is disabled.

call :setserv
for %%a in (%srvlist%) do (
for /f "delims=[] tokens=2" %%# in ('ping -n 1 %%a') do (
if not [%%#]==[] goto IntConnected
)
)

nslookup dns.msftncsi.com 2>nul | find "131.107.255.255" 1>nul
if [%errorlevel%]==[0] goto IntConnected

cls
if %_Debug%==1 (
echo Error: Internet is not connected.
exit /b
)

if defined _unattended (
echo.
call :_color %_Red% "Internet is not connected, continuing the process anyway."
) else (
%eline%
echo Internet is not connected.
echo:
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b
)

:IntConnected

call :getserv

::========================================================================================================================================

set "_wApp=55c92734-d682-4d71-983e-d6ec3f16059f"
set "_oApp=0ff1ce15-a989-479d-af46-f275c6370663"
set "_oA14=59a52881-a989-479d-af46-f275c6370663"
set "IFEO=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"
set "OPPk=SOFTWARE\Microsoft\OfficeSoftwareProtectionPlatform"
set "SPPk=SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
set SSppHook=0
for /f %%A in ('dir /b /ad %SysPath%\spp\tokens\skus') do (
  if %winbuild% GEQ 9200 if exist "%SysPath%\spp\tokens\skus\%%A\*GVLK*.xrm-ms" set SSppHook=1
  if %winbuild% LSS 9200 if exist "%SysPath%\spp\tokens\skus\%%A\*VLKMS*.xrm-ms" set SSppHook=1
  if %winbuild% LSS 9200 if exist "%SysPath%\spp\tokens\skus\%%A\*VL-BYPASS*.xrm-ms" set SSppHook=1
)
set OsppHook=1
sc query osppsvc %_Nul3%
if %errorlevel% EQU 1060 set OsppHook=0

set ESU_KMS=0
if %winbuild% LSS 9200 for /f %%A in ('dir /b /ad %SysPath%\spp\tokens\channels') do (
  if exist "%SysPath%\spp\tokens\channels\%%A\*VL-BYPASS*.xrm-ms" set ESU_KMS=1
)
if %ESU_KMS% EQU 1 (set "adoff=and LicenseDependsOn is NULL"&set "addon=and LicenseDependsOn is not NULL") else (set "adoff="&set "addon=")
set ESU_EDT=0
if %ESU_KMS% EQU 1 for %%A in (%ESUEditions%) do (
  if exist "%SysPath%\spp\tokens\skus\Security-SPP-Component-SKU-%%A\*.xrm-ms" set ESU_EDT=1
)
:: if %ESU_EDT% EQU 1 set SSppHook=1
set ESU_ADD=0

if %winbuild% GEQ 9200 (
  set OSType=Win8
  set SppVer=SppExtComObj.exe
) else if %winbuild% GEQ 7600 (
  set OSType=Win7
  set SppVer=sppsvc.exe
) else (
  goto :UnsupportedVersion
)
if %OSType% EQU Win8 reg query "%IFEO%\sppsvc.exe" %_Nul3% && (
reg delete "%IFEO%\sppsvc.exe" /f %_Nul3%
call :StopService sppsvc
)

if %ActWindows% EQU 0 if %ActOffice% EQU 0 set ActWindows=1
set _AUR=1
if %winbuild% GEQ 9600 (
  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f %_Nul3%
  if %winbuild% EQU 14393 reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoAcquireGT /t REG_DWORD /d 1 /f %_Nul3%
)
call :StopService sppsvc
if %OsppHook% NEQ 0 call :StopService osppsvc

:ReturnHook
call :UpdateOSPPEntry osppsvc.exe

SET Win10Gov=0
SET "EditionWMI="
SET "EditionID="
IF %winbuild% LSS 14393 if %SSppHook% NEQ 0 GOTO :Main
SET "RegKey=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages"
SET "Pattern=Microsoft-Windows-*Edition~31bf3856ad364e35"
SET "EditionPKG=FFFFFFFF"
FOR /F "TOKENS=8 DELIMS=\" %%A IN ('REG QUERY "%RegKey%" /f "%Pattern%" /k %_Nul6% ^| FIND /I "CurrentVersion"') DO (
  REG QUERY "%RegKey%\%%A" /v "CurrentState" %_Nul2% | FIND /I "0x70" %_Nul1% && (
    FOR /F "TOKENS=3 DELIMS=-~" %%B IN ('ECHO %%A') DO SET "EditionPKG=%%B"
  )
)
IF /I "%EditionPKG:~-7%"=="Edition" (
SET "EditionID=%EditionPKG:~0,-7%"
) ELSE (
FOR /F "TOKENS=3 DELIMS=: " %%A IN ('DISM /English /Online /Get-CurrentEdition %_Nul6% ^| FIND /I "Current Edition :"') DO SET "EditionID=%%A"
)
net start sppsvc /y %_Nul3%
set "_qr=%_zz7% SoftwareLicensingProduct %_zz2% %_zz5%ApplicationID='%_wApp%' %adoff% AND PartialProductKey is not NULL%_zz6% %_zz3% LicenseFamily %_zz8%"
FOR /F "TOKENS=2 DELIMS==" %%A IN ('%_qr% %_Nul6%') DO SET "EditionWMI=%%A"
IF "%EditionWMI%"=="" (
IF %winbuild% GEQ 17063 FOR /F "SKIP=2 TOKENS=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionId') DO SET "EditionID=%%B"
IF %winbuild% LSS 14393 (
  FOR /F "SKIP=2 TOKENS=2*" %%A IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionId') DO SET "EditionID=%%B"
  GOTO :Main
  )
)
IF NOT "%EditionWMI%"=="" SET "EditionID=%EditionWMI%"
IF /I "%EditionID%"=="IoTEnterprise" SET "EditionID=Enterprise"
IF /I "%EditionID%"=="IoTEnterpriseS" IF %winbuild% LSS 22610 SET "EditionID=EnterpriseS"
IF /I "%EditionID%"=="ProfessionalSingleLanguage" SET "EditionID=Professional"
IF /I "%EditionID%"=="ProfessionalCountrySpecific" SET "EditionID=Professional"
IF /I "%EditionID%"=="EnterpriseG" SET Win10Gov=1
IF /I "%EditionID%"=="EnterpriseGN" SET Win10Gov=1

:Main
if defined EditionID (set "_winos=Windows %EditionID% edition") else (set "_winos=Detected Windows")
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName %_Nul6%') do if not errorlevel 1 set "_winos=%%b"
set "nKMS=does not support KMS activation..."
set "nEval=Evaluation Editions cannot be activated. Please install full Windows OS."
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-*EvalEdition~*.mum" set _eval=1
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*EvalEdition~*.mum" set "nEval=Server Evaluation cannot be activated. Please convert to full Server OS."
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*EvalCorEdition~*.mum" set _eval=1&set "nEval=Server Evaluation cannot be activated. Please convert to full Server OS."
set "_C16R="
reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath %_Nul3% && for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses16\ProPlus*.xrm-ms" (
reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v ProductReleaseIds %_Nul3% && set "_C16R=HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
)
if not defined _C16R reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath %_Nul3% && for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses16\ProPlus*.xrm-ms" (
reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun\Configuration /v ProductReleaseIds %_Nul3% && set "_C16R=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun\Configuration"
)
set "_C15R="
reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun /v InstallPath %_Nul3% && for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses\ProPlus*.xrm-ms" (
reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Configuration /v ProductReleaseIds %_Nul3% && call set "_C15R=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Configuration"
if not defined _C15R reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid %_Nul3% && call set "_C15R=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\propertyBag"
)
set "_C14R="
if %_wow%==0 (reg query HKLM\SOFTWARE\Microsoft\Office\14.0\CVH /f Click2run /k %_Nul3% && set "_C14R=1") else (reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\CVH /f Click2run /k %_Nul3% && set "_C14R=1")
for %%A in (14,15,16,19,21) do call :officeLoc %%A
if %_O14MSI% EQU 1 set "_C14R="

set S_OK=1
call :RunSPP
if %ActOffice% NEQ 0 call :RunOSPP
if %ActOffice% EQU 0 (echo.&echo Office activation is OFF...)

if exist "!_temp!\crv*.txt" del /f /q "!_temp!\crv*.txt"
if exist "!_temp!\*chk.txt" del /f /q "!_temp!\*chk.txt"
if exist "!_temp!\slmgr.vbs" del /f /q "!_temp!\slmgr.vbs"
call :StopService sppsvc
if %OsppHook% NEQ 0 call :StopService osppsvc

sc start sppsvc trigger=timer;sessionid=0 %_Nul3%

goto TheEnd

:RunSPP
set spp=SoftwareLicensingProduct
set sps=SoftwareLicensingService
set W1nd0ws=1
set WinPerm=0
set WinVL=0
set Off1ce=0
set RanR2V=0
set aC2R21=0
set aC2R19=0
set aC2R16=0
set aC2R15=0
if %winbuild% GEQ 9200 if %ActOffice% NEQ 0 call :sppoff
set "_qr=%_zz1% %spp% %_zz2% %_zz5%Description like '%%KMSCLIENT%%' %_zz6% %_zz3% Name %_zz4%"
%_qr% %_Nul2% | findstr /i Windows %_Nul1% && (set WinVL=1)
if %WinVL% EQU 0 (
if %ActWindows% EQU 0 (
  echo.&echo Windows activation is OFF...
  ) else (
  if %SSppHook% EQU 0 (
    echo.&echo %_winos% %nKMS%
    if defined _eval echo %nEval%
    ) else (
    echo.&echo Failed checking KMS Activation ID^(s^) for Windows. &call :CheckWS
    exit /b
    )
  )
)
if %WinVL% EQU 0 if %Off1ce% EQU 0 exit /b
set _gvlk=0
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL%_zz6% %_zz3% Name %_zz4%"
if %winbuild% GEQ 10240 %_qr% %_Nul2% | findstr /i Windows %_Nul1% && (set _gvlk=1)
set gpr=0
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL%_zz6% %_zz3% GracePeriodRemaining %_zz8%"
if %winbuild% GEQ 10240 if %SkipKMS38% NEQ 0 if %_gvlk% EQU 1 for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set "gpr=%%A"
set "_qr=%_zz1% %spp% %_zz2% "ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL" %_zz3% LicenseFamily %_zz4%"
if %gpr% NEQ 0 if %gpr% GTR 259200 (
set W1nd0ws=0
%_qr% %_Nul2% | findstr /i EnterpriseG %_Nul1% && (call set W1nd0ws=1)
)
set "_qr=%_zz7% %sps% %_zz3% Version %_zz8%"
for /f "tokens=2 delims==" %%A in ('%_qr%') do set slsv=%%A
reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" %_Nul3%
reg add "HKLM\%SPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" %_Nul3%
if %winbuild% GEQ 9200 (
if not %xOS%==x86 (
reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" /reg:32 %_Nul3%
reg add "HKLM\%SPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" /reg:32 %_Nul3%
reg delete "HKLM\%SPPk%\%_oApp%" /f /reg:32 %_Null%
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" /reg:32 %_Nul3%
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" /reg:32 %_Nul3%
)
reg delete "HKLM\%SPPk%\%_oApp%" /f %_Null%
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" %_Nul3%
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" %_Nul3%
)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' %_zz6% %_zz3% ID %_zz8%"
if %W1nd0ws% EQU 0 for /f "tokens=2 delims==" %%G in ('%_qr%') do (set app=%%G&call :sppchkwin)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' %adoff% %_zz6% %_zz3% ID %_zz8%"
if %W1nd0ws% EQU 1 if %ActWindows% NEQ 0 for /f "tokens=2 delims==" %%G in ('%_qr%') do (set app=%%G&call :sppchkwin)
:: set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' %addon% %_zz6% %_zz3% ID %_zz8%"
:: if %ESU_EDT% EQU 1 if %ActWindows% NEQ 0 for /f "tokens=2 delims==" %%G in ('%_qr%') do (set app=%%G&call :esuchk)
if %W1nd0ws% EQU 1 if %ActWindows% EQU 0 (echo.&echo Windows activation is OFF...)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_oApp%' and Description like '%%KMSCLIENT%%' %_zz6% %_zz3% ID %_zz8%"
if %Off1ce% EQU 1 if %ActOffice% NEQ 0 for /f "tokens=2 delims==" %%G in ('%_qr%') do (set app=%%G&call :sppchkoff 1)
reg delete "HKLM\%SPPk%" /f /v DisableDnsPublishing %_Null%
reg delete "HKLM\%SPPk%" /f /v DisableKeyManagementServiceHostCaching %_Null%
exit /b

:sppoff
set OffUWP=0
if %winbuild% GEQ 10240 reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msoxmled.exe" %_Nul3% && (
dir /b "%ProgramFiles%\WindowsApps\Microsoft.Office.Desktop*" %_Nul3% && set OffUWP=1
if not %xOS%==x86 dir /b "%ProgramW6432%\WindowsApps\Microsoft.Office.Desktop*" %_Nul3% && set OffUWP=1
)
rem nothing installed
if %loc_off21% EQU 0 if %loc_off19% EQU 0 if %loc_off16% EQU 0 if %loc_off15% EQU 0 (
if %winbuild% GEQ 9200 (
  if %OffUWP% EQU 0 (echo.&echo No Installed Office 2013-2021 Product Detected...) else (echo.&echo %_mOuwp%)
  exit /b
  )
if %winbuild% LSS 9200 (if %loc_off14% EQU 0 (echo.&echo No Installed Office %aword% Product Detected...&exit /b))
)
if %vNextOverride% EQU 1 if %AutoR2V% EQU 1 (
set sub_o365=0
set sub_proj=0
set sub_vsio=0
if %sub_next% EQU 1 reg delete HKCU\SOFTWARE\Microsoft\Office\16.0\Common\Licensing /f %_Nul3%
)
set Off1ce=1
set _sC2R=sppoff
set _fC2R=ReturnSPP

set vol_off14=0&set vol_off15=0&set vol_off16=0&set vol_off19=0&set vol_off21=0
set "_qr=%_zz1% %spp% %_zz2% %_zz5%Description like '%%KMSCLIENT%%' AND NOT Name like '%%MondoR_KMS_Automation%%' %_zz6% %_zz3% Name %_zz4%"
%_qr% > "!_temp!\sppchk.txt" 2>&1
find /i "Office 21" "!_temp!\sppchk.txt" %_Nul1% && (set vol_off21=1)
find /i "Office 19" "!_temp!\sppchk.txt" %_Nul1% && (set vol_off19=1)
find /i "Office 16" "!_temp!\sppchk.txt" %_Nul1% && (set vol_off16=1)
find /i "Office 15" "!_temp!\sppchk.txt" %_Nul1% && (set vol_off15=1)
if %winbuild% LSS 9200 find /i "Office 14" "!_temp!\sppchk.txt" %_Nul1% && (set vol_off14=1)
for %%A in (14,15,16,19,21) do if !loc_off%%A! EQU 0 set vol_off%%A=0
set "_qr=%_zz1% %spp% %_zz2% "ApplicationID='%_oApp%' AND LicenseFamily like 'Office16O365%%'" %_zz3% LicenseFamily %_zz4%"
if %vol_off16% EQU 1 find /i "Office16MondoVL_KMS_Client" "!_temp!\sppchk.txt" %_Nul1% && (
%_qr% %_Nul2% | find /i "O365" %_Nul1% || (set vol_off16=0)
)
set "_qr=%_zz1% %spp% %_zz2% "ApplicationID='%_oApp%' AND LicenseFamily like 'OfficeO365%%'" %_zz3% LicenseFamily %_zz4%"
if %vol_off15% EQU 1 find /i "OfficeMondoVL_KMS_Client" "!_temp!\sppchk.txt" %_Nul1% && (
%_qr% %_Nul2% | find /i "O365" %_Nul1% || (set vol_off15=0)
)

set ret_off14=0&set ret_off15=0&set ret_off16=0&set ret_off19=0&set ret_off21=0
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_oApp%' AND NOT Name like '%%O365%%' %_zz6% %_zz3% Name %_zz4%"
%_qr% > "!_temp!\sppchk.txt" 2>&1
find /i "R_Retail" "!_temp!\sppchk.txt" %_Nul2% | find /i "Office 21" %_Nul1% && (set ret_off21=1)
find /i "R_Retail" "!_temp!\sppchk.txt" %_Nul2% | find /i "Office 19" %_Nul1% && (set ret_off19=1)
find /i "R_Retail" "!_temp!\sppchk.txt" %_Nul2% | find /i "Office 16" %_Nul1% && (set ret_off16=1)
find /i "R_Retail" "!_temp!\sppchk.txt" %_Nul2% | find /i "Office 15" %_Nul1% && (set ret_off15=1)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_oA14%'%_zz6% %_zz3% Description %_zz4%"
if %winbuild% LSS 9200 if %vol_off14% EQU 0 %_qr% %_Nul2% | findstr /i channel %_Nul1% && (set ret_off14=1)

set run_off21=0&set prr_off21=0&set prv_off21=0
if %loc_off21% EQU 1 if %ret_off21% EQU 1 if %_O16MSI% EQU 0 if %vol_off21% EQU 0 set run_off21=1
if %loc_off21% EQU 1 if %ret_off21% EQU 1 if %_O16MSI% EQU 0 if %vol_off21% EQU 1 (
for %%a in (%DO16Ids%) do find /i "Office21%%a2021R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off21+=1
  find /i "Office21%%a2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off21+=1
  )
for %%a in (Professional) do find /i "Office21%%a2021R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off21+=1
  find /i "Office21ProPlus2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off21+=1
  )
for %%a in (HomeBusiness,HomeStudent) do find /i "Office21%%a2021R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off21+=1
  find /i "Office21Standard2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off21+=1
  )
if %sub_proj% EQU 0 for %%a in (ProjectPro,ProjectStd) do find /i "Office21%%a2021R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off21+=1
  find /i "Office21%%a2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off21+=1
  )
if %sub_vsio% EQU 0 for %%a in (VisioPro,VisioStd) do find /i "Office21%%a2021R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off21+=1
  find /i "Office21%%a2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off21+=1
  )
)
if %loc_off21% EQU 1 if %ret_off21% EQU 1 if %_O16MSI% EQU 0 if %vol_off21% EQU 1 if %prv_off21% LSS %prr_off21% (set vol_off21=0&set run_off21=1)

set run_off19=0&set prr_off19=0&set prv_off19=0
if %loc_off19% EQU 1 if %ret_off19% EQU 1 if %_O16MSI% EQU 0 if %vol_off19% EQU 0 set run_off19=1
if %loc_off19% EQU 1 if %ret_off19% EQU 1 if %_O16MSI% EQU 0 if %vol_off19% EQU 1 (
for %%a in (%DO16Ids%) do find /i "Office19%%a2019R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off19+=1
  find /i "Office19%%a2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off19+=1
  )
for %%a in (Professional) do find /i "Office19%%a2019R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off19+=1
  find /i "Office19ProPlus2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off19+=1
  )
for %%a in (HomeBusiness,HomeStudent) do find /i "Office19%%a2019R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off19+=1
  find /i "Office19Standard2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off19+=1
  )
if %sub_proj% EQU 0 for %%a in (ProjectPro,ProjectStd) do find /i "Office19%%a2019R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off19+=1
  find /i "Office19%%a2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off19+=1
  )
if %sub_vsio% EQU 0 for %%a in (VisioPro,VisioStd) do find /i "Office19%%a2019R" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off19+=1
  find /i "Office19%%a2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off19+=1
  )
)
if %loc_off19% EQU 1 if %ret_off19% EQU 1 if %_O16MSI% EQU 0 if %vol_off19% EQU 1 if %prv_off19% LSS %prr_off19% (set vol_off19=0&set run_off19=1)

set run_off16=0&set prr_off16=0&set prv_off16=0
if %loc_off16% EQU 1 if %ret_off16% EQU 1 if %_O16MSI% EQU 0 if defined _C16R (
for %%a in (%DO16Ids%) do find /i "Office16%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off16+=1
  if %vol_off16% EQU 1 if %vol_off21% EQU 0 if %vol_off19% EQU 0 find /i "Office16%%aVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off21% EQU 1 find /i "Office21%%a2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off19% EQU 1 find /i "Office19%%a2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  )
for %%a in (Professional) do find /i "Office16%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off16+=1
  if %vol_off16% EQU 1 if %vol_off21% EQU 0 if %vol_off19% EQU 0 find /i "Office16ProPlusVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off21% EQU 1 find /i "Office21ProPlus2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off19% EQU 1 find /i "Office19ProPlus2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  )
for %%a in (HomeBusiness,HomeStudent) do find /i "Office16%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off16+=1
  if %vol_off16% EQU 1 if %vol_off21% EQU 0 if %vol_off19% EQU 0 find /i "Office16StandardVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off21% EQU 1 find /i "Office21Standard2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off19% EQU 1 find /i "Office19Standard2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  )
if %sub_proj% EQU 0 for %%a in (ProjectPro,ProjectStd) do find /i "Office16%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off16+=1
  if %vol_off16% EQU 1 if %vol_off21% EQU 0 if %vol_off19% EQU 0 find /i "Office16%%aVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off21% EQU 1 find /i "Office21%%a2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off19% EQU 1 find /i "Office19%%a2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  )
if %sub_vsio% EQU 0 for %%a in (VisioPro,VisioStd) do find /i "Office16%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off16+=1
  if %vol_off16% EQU 1 if %vol_off21% EQU 0 if %vol_off19% EQU 0 find /i "Office16%%aVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off21% EQU 1 find /i "Office21%%a2021VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  if %vol_off16% EQU 0 if %vol_off19% EQU 1 find /i "Office19%%a2019VL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off16+=1
  )
)
if %loc_off16% EQU 1 if %ret_off16% EQU 1 if %_O16MSI% EQU 0 if defined _C16R if %prv_off16% LSS %prr_off16% (set vol_off16=0&set run_off16=1)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_oApp%' AND LicenseFamily like 'Office16O365%%' %_zz6% %_zz3% LicenseFamily %_zz4%"
if %loc_off16% EQU 1 if %run_off16% EQU 0 if %sub_o365% EQU 0 if defined _C16R %_qr% %_Nul2% | find /i "O365" %_Nul1% && (
find /i "Office16MondoVL" "!_temp!\sppchk.txt" %_Nul1% || set run_off16=1
)

set run_off15=0&set prr_off15=0&set prv_off15=0
if %loc_off15% EQU 1 if %ret_off15% EQU 1 if %_O15MSI% EQU 0 if %vol_off15% EQU 0 if defined _C15R set run_off15=1
if %loc_off15% EQU 1 if %ret_off15% EQU 1 if %_O15MSI% EQU 0 if %vol_off15% EQU 1 if defined _C15R (
for %%a in (%DO15Ids%) do find /i "Office%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off15+=1
  find /i "Office%%aVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off15+=1
  )
for %%a in (Professional) do find /i "Office%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off15+=1
  find /i "OfficeProPlusVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off15+=1
  )
for %%a in (HomeBusiness,HomeStudent) do find /i "Office%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off15+=1
  find /i "OfficeStandardVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off15+=1
  )
if %sub_proj% EQU 0 for %%a in (ProjectPro,ProjectStd) do find /i "Office%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off15+=1
  find /i "Office%%aVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off15+=1
  )
if %sub_vsio% EQU 0 for %%a in (VisioPro,VisioStd) do find /i "Office%%aR" "!_temp!\sppchk.txt" %_Nul1% && (
  call set /a prr_off15+=1
  find /i "Office%%aVL" "!_temp!\sppchk.txt" %_Nul1% && call set /a prv_off15+=1
  )
)
if %loc_off15% EQU 1 if %ret_off15% EQU 1 if %_O15MSI% EQU 0 if %vol_off15% EQU 1 if defined _C15R if %prv_off15% LSS %prr_off15% (set vol_off15=0&set run_off15=1)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_oApp%' AND LicenseFamily like 'OfficeO365%%' %_zz6% %_zz3% LicenseFamily %_zz4%"
if %loc_off15% EQU 1 if %run_off15% EQU 0 if defined _C15R %_qr% %_Nul2% | find /i "O365" %_Nul1% && (
find /i "OfficeMondoVL" "!_temp!\sppchk.txt" %_Nul1% || set run_off15=1
)

set vol_offgl=1
if %vol_off21% EQU 0 if %vol_off19% EQU 0 if %vol_off16% EQU 0 if %vol_off15% EQU 0 (
if %winbuild% GEQ 9200 set vol_offgl=0
if %winbuild% LSS 9200 if %vol_off14% EQU 0 set vol_offgl=0
)
rem mixed Volume + Retail
if %run_off21% EQU 1 if %AutoR2V% EQU 1 if %RanR2V% EQU 0 goto :C2RR2V
if %run_off19% EQU 1 if %AutoR2V% EQU 1 if %RanR2V% EQU 0 goto :C2RR2V
if %run_off16% EQU 1 if %AutoR2V% EQU 1 if %RanR2V% EQU 0 goto :C2RR2V
if %run_off15% EQU 1 if %AutoR2V% EQU 1 if %RanR2V% EQU 0 goto :C2RR2V
rem all supported Volume + message for unsupported
if %loc_off16% EQU 0 if %ret_off16% EQU 1 if %_O16MSI% EQU 0 if %OffUWP% EQU 1 (echo.&echo %_mOuwp%)
if %vol_offgl% EQU 1 (
if %ret_off16% EQU 1 if %_O16MSI% EQU 1 (echo.&echo %_mO16m%)
if %ret_off15% EQU 1 if %_O15MSI% EQU 1 (echo.&echo %_mO15m%)
if %winbuild% LSS 9200 if %loc_off14% EQU 1 if %vol_off14% EQU 0 (if defined _C14R (echo.&echo %_mO14c%) else if %_O14MSI% EQU 1 (if %ret_off14% EQU 1 echo.&echo %_mO14m%))
exit /b
)
set Off1ce=0
rem Retail C2R
if %AutoR2V% EQU 1 if %RanR2V% EQU 0 goto :C2RR2V
:ReturnSPP
rem Retail MSI/C2R or failed C2R-R2V
if %loc_off21% EQU 1 if %vol_off21% EQU 0 (
if %aC2R21% EQU 1 (echo.&echo %_mO21a%) else (echo.&echo %_mO21c%)
)
if %loc_off19% EQU 1 if %vol_off19% EQU 0 (
if %aC2R19% EQU 1 (echo.&echo %_mO19a%) else (echo.&echo %_mO19c%)
)
if %loc_off16% EQU 1 if %vol_off16% EQU 0 (
if defined _C16R (if %aC2R16% EQU 1 (echo.&echo %_mO16a%) else (if %sub_o365% EQU 0 echo.&echo %_mO16c%)) else if %_O16MSI% EQU 1 (if %ret_off16% EQU 1 echo.&echo %_mO16m%)
)
if %loc_off15% EQU 1 if %vol_off15% EQU 0 (
if defined _C15R (if %aC2R15% EQU 1 (echo.&echo %_mO15a%) else (echo.&echo %_mO15c%)) else if %_O15MSI% EQU 1 (if %ret_off15% EQU 1 echo.&echo %_mO15m%)
)
if %winbuild% LSS 9200 if %loc_off14% EQU 1 if %vol_off14% EQU 0 (
if defined _C14R (echo.&echo %_mO14c%) else if %_O14MSI% EQU 1 (if %ret_off14% EQU 1 echo.&echo %_mO14m%)
)
exit /b

:sppchkoff
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% Name %_zz4%"
%_qr% > "!_temp!\sppchk.txt"
if %winbuild% LSS 9200 find /i "Office 14" "!_temp!\sppchk.txt" %_Nul1% && (if %loc_off14% EQU 0 exit /b)
find /i "Office 15" "!_temp!\sppchk.txt" %_Nul1% && (if %loc_off15% EQU 0 exit /b)
find /i "Office 16" "!_temp!\sppchk.txt" %_Nul1% && (if %loc_off16% EQU 0 exit /b)
find /i "Office 19" "!_temp!\sppchk.txt" %_Nul1% && (if %loc_off19% EQU 0 exit /b)
find /i "Office 21" "!_temp!\sppchk.txt" %_Nul1% && (if %loc_off21% EQU 0 exit /b)
if %1 EQU 1 (set _officespp=1) else (set _officespp=0)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%PartialProductKey is not NULL%_zz6% %_zz3% ID %_zz4%"
%_qr% %_Nul2% | findstr /i "%app%" %_Nul1% && (echo.&call :activate&exit /b)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% Name %_zz8%"
for /f "tokens=3 delims==, " %%G in ('%_qr%') do set OffVer=%%G
call :offchk%OffVer%
exit /b

:sppchkwin
set _officespp=0
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL%_zz6% %_zz3% Name %_zz4%"
if %winbuild% GEQ 14393 if %WinPerm% EQU 0 if %_gvlk% EQU 0 %_qr% %_Nul2% | findstr /i Windows %_Nul1% && (set _gvlk=1)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% LicenseStatus %_zz4%"
%_qr% %_Nul2% | findstr "1" %_Nul1% && (echo.&call :activate&exit /b)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%PartialProductKey is not NULL%_zz6% %_zz3% ID %_zz4%"
%_qr% %_Nul2% | findstr /i "%app%" %_Nul1% && (echo.&call :activate&exit /b)
if %winbuild% GEQ 14393 if %_gvlk% EQU 1 exit /b
if %WinPerm% EQU 1 exit /b
if %winbuild% LSS 10240 (call :winchk&exit /b)
for %%A in (
b71515d9-89a2-4c60-88c8-656fbcca7f3a,af43f7f0-3b1e-4266-a123-1fdb53f4323b,075aca1f-05d7-42e5-a3ce-e349e7be7078
11a37f09-fb7f-4002-bd84-f3ae71d11e90,43f2ab05-7c87-4d56-b27c-44d0f9a3dabd,2cf5af84-abab-4ff0-83f8-f040fb2576eb
6ae51eeb-c268-4a21-9aae-df74c38b586d,ff808201-fec6-4fd4-ae16-abbddade5706,34260150-69ac-49a3-8a0d-4a403ab55763
4dfd543d-caa6-4f69-a95f-5ddfe2b89567,5fe40dd6-cf1f-4cf2-8729-92121ac2e997,903663f7-d2ab-49c9-8942-14aa9e0a9c72
2cc171ef-db48-4adc-af09-7c574b37f139,5b2add49-b8f4-42e0-a77c-adad4efeeeb1
) do (
if /i '%app%' EQU '%%A' exit /b
)
if not defined EditionID (call :winchk&exit /b)
if %winbuild% LSS 14393 (call :winchk&exit /b)
if /i '%app%' EQU '32d2fab3-e4a8-42c2-923b-4bf4fd13e6ee' if /i %EditionID% NEQ EnterpriseS exit /b
if /i '%app%' EQU 'ca7df2e3-5ea0-47b8-9ac1-b1be4d8edd69' if /i %EditionID% NEQ CloudEdition exit /b
if /i '%app%' EQU 'd30136fc-cb4b-416e-a23d-87207abc44a9' if /i %EditionID% NEQ CloudEditionN exit /b
if /i '%app%' EQU '0df4f814-3f57-4b8b-9a9d-fddadcd69fac' if /i %EditionID% NEQ CloudE exit /b
if /i '%app%' EQU 'e0c42288-980c-4788-a014-c080d2e1926e' if /i %EditionID% NEQ Education exit /b
if /i '%app%' EQU '73111121-5638-40f6-bc11-f1d7b0d64300' if /i %EditionID% NEQ Enterprise exit /b
if /i '%app%' EQU '2de67392-b7a7-462a-b1ca-108dd189f588' if /i %EditionID% NEQ Professional exit /b
if /i '%app%' EQU '3f1afc82-f8ac-4f6c-8005-1d233e606eee' if /i %EditionID% NEQ ProfessionalEducation exit /b
if /i '%app%' EQU '82bbc092-bc50-4e16-8e18-b74fc486aec3' if /i %EditionID% NEQ ProfessionalWorkstation exit /b
if /i '%app%' EQU '3c102355-d027-42c6-ad23-2e7ef8a02585' if /i %EditionID% NEQ EducationN exit /b
if /i '%app%' EQU 'e272e3e2-732f-4c65-a8f0-484747d0d947' if /i %EditionID% NEQ EnterpriseN exit /b
if /i '%app%' EQU 'a80b5abf-76ad-428b-b05d-a47d2dffeebf' if /i %EditionID% NEQ ProfessionalN exit /b
if /i '%app%' EQU '5300b18c-2e33-4dc2-8291-47ffcec746dd' if /i %EditionID% NEQ ProfessionalEducationN exit /b
if /i '%app%' EQU '4b1571d3-bafb-4b40-8087-a961be2caf65' if /i %EditionID% NEQ ProfessionalWorkstationN exit /b
if /i '%app%' EQU '58e97c99-f377-4ef1-81d5-4ad5522b5fd8' if /i %EditionID% NEQ Core exit /b
if /i '%app%' EQU 'cd918a57-a41b-4c82-8dce-1a538e221a83' if /i %EditionID% NEQ CoreSingleLanguage exit /b
if /i '%app%' EQU 'ec868e65-fadf-4759-b23e-93fe37f2cc29' if /i %EditionID% NEQ ServerRdsh exit /b
if /i '%app%' EQU 'e4db50ea-bda1-4566-b047-0ca50abc6f07' if /i %EditionID% NEQ ServerRdsh exit /b
set "_qr=%_zz1% %spp% %_zz2% "Description like '%%KMSCLIENT%%'" %_zz3% ID %_zz4%"
if /i "%app%" EQU "e4db50ea-bda1-4566-b047-0ca50abc6f07" (
%_qr% | findstr /i "ec868e65-fadf-4759-b23e-93fe37f2cc29" %_Nul3% && (exit /b)
)
call :winchk
exit /b

:winchk
if not defined tok (if %winbuild% GEQ 9200 (set "tok=4") else (set "tok=7"))
set "_qr=%_zz1% %spp% %_zz2% %_zz5%LicenseStatus='1' and Description like '%%KMSCLIENT%%' %adoff% %_zz6% %_zz3% Name %_zz4%"
%_qr% %_Nul2% | findstr /i "Windows" %_Nul3% && (exit /b)
echo.
set "_qr=%_zz1% %spp% %_zz2% %_zz5%LicenseStatus='1' and GracePeriodRemaining='0' %adoff% and PartialProductKey is not NULL%_zz6% %_zz3% Name %_zz4%"
%_qr% %_Nul2% | findstr /i "Windows" %_Nul3% && (
set WinPerm=1
)
set WinOEM=0
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and LicenseStatus='1' %adoff% %_zz6% %_zz3% Name %_zz4%"
if %WinPerm% EQU 0 %_qr% %_Nul2% | findstr /i "Windows" %_Nul3% && set WinOEM=1
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and LicenseStatus='1' %adoff% %_zz6% %_zz3% Description %_zz8%"
if %WinOEM% EQU 1 (
for /f "tokens=%tok% delims=, " %%G in ('%_qr%') do set "channel=%%G"
for %%A in (VOLUME_MAK, RETAIL, OEM_DM, OEM_SLP, OEM_COA, OEM_COA_SLP, OEM_COA_NSLP, OEM_NONSLP, OEM) do if /i "%%A"=="!channel!" set WinPerm=1
)
if %WinPerm% EQU 0 (
copy /y %SysPath%\slmgr.vbs "!_temp!\slmgr.vbs" %_Nul3%
cscript //nologo "!_temp!\slmgr.vbs" /xpr %_Nul2% | findstr /i "permanently" %_Nul3% && set WinPerm=1
)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ApplicationID='%_wApp%' and LicenseStatus='1' %adoff% %_zz6% %_zz3% Name %_zz8%"
if %WinPerm% EQU 1 (
for /f "tokens=2 delims==" %%x in ('%_qr%') do echo Checking: %%x
echo Product is Permanently Activated.
exit /b
)
call :insKey
exit /b

:esuchk
set _officespp=0
set ESU_ADD=1
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% LicenseStatus %_zz4%"
%_qr% %_Nul2% | findstr "1" %_Nul1% && (echo.&call :activate&exit /b)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='77db037b-95c3-48d7-a3ab-a9c6d41093e0'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "3fcc2df2-f625-428d-909a-1f76efc849b6" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='0e00c25d-8795-4fb7-9572-3803d91b6880'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "dadfcd24-6e37-47be-8f7f-4ceda614cece" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='4220f546-f522-46df-8202-4d07afd26454'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "0c29c85e-12d7-4af8-8e4d-ca1e424c480c" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='553673ed-6ddf-419c-a153-b760283472fd'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "f2b21bfc-a6b0-4413-b4bb-9f06b55f2812" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='04fa0286-fa74-401e-bbe9-fbfbb158010d'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "bfc078d0-8c7f-475c-8519-accc46773113" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='16c08c85-0c8b-4009-9b2b-f1f7319e45f9'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "23c6188f-c9d8-457e-81b6-adb6dacb8779" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%ID='8e7bfb1e-acc1-4f56-abae-b80fce56cd4b'%_zz6% %_zz3% LicenseStatus %_zz4%"
if /i "%app%" EQU "e7cce015-33d6-41c1-9831-022ba63fe1da" (
%_qr% %_Nul2% | findstr "1" %_Nul1% && (exit /b)
)
set "_qr=%_zz1% %spp% %_zz2% %_zz5%PartialProductKey is not NULL%_zz6% %_zz3% ID %_zz4%"
%_qr% %_Nul2% | findstr /i "%app%" %_Nul1% && (echo.&call :activate&exit /b)
call :insKey
exit /b

:RunOSPP
set spp=OfficeSoftwareProtectionProduct
set sps=OfficeSoftwareProtectionService
set Off1ce=0
set RanR2V=0
set aC2R21=0
set aC2R19=0
set aC2R16=0
set aC2R15=0
if %winbuild% LSS 9200 (set "aword=2010-2021") else (set "aword=2010")
if %OsppHook% EQU 0 (echo.&echo No Installed Office %aword% Product Detected...&exit /b)
if %winbuild% GEQ 9200 if %loc_off14% EQU 0 (echo.&echo No Installed Office %aword% Product Detected...&exit /b)
set err_offsvc=0
net start osppsvc /y %_Nul3% || (
sc start osppsvc %_Nul3%
if !errorlevel! EQU 1053 set err_offsvc=1
)
if %err_offsvc% EQU 1 (echo.&echo Error: osppsvc service is not running...&exit /b)
if %winbuild% GEQ 9200 call :oppoff
if %winbuild% LSS 9200 call :sppoff
if %Off1ce% EQU 0 exit /b
set "vPrem="&set "vProf="
set "_qr=%_zz7% %spp% %_zz2% %_zz5%LicenseFamily='OfficeVisioPrem-MAK'%_zz6% %_zz3% LicenseStatus %_zz8%"
if %loc_off14% EQU 1 for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set vPrem=%%A
set "_qr=%_zz7% %spp% %_zz2% %_zz5%LicenseFamily='OfficeVisioPro-MAK'%_zz6% %_zz3% LicenseStatus %_zz8%"
if %loc_off14% EQU 1 for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set vProf=%%A
set "_qr=%_zz7% %sps% %_zz3% Version %_zz8%"
for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set slsv=%%A
reg add "HKLM\%OPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" %_Nul3%
reg add "HKLM\%OPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" %_Nul3%
set "_qr=%_zz7% %spp% %_zz2% %_zz5%Description like '%%KMSCLIENT%%' %_zz6% %_zz3% ID %_zz8%"
for /f "tokens=2 delims==" %%G in ('%_qr%') do (set app=%%G&call :sppchkoff 2)
reg delete "HKLM\%OPPk%" /f /v DisableDnsPublishing %_Null%
reg delete "HKLM\%OPPk%" /f /v DisableKeyManagementServiceHostCaching %_Null%
exit /b

:oppoff
set "_qr=%_zz1% %spp% %_zz3% Description %_zz4%"
%_qr% %_Nul2% | findstr /i KMSCLIENT %_Nul1% && (
set Off1ce=1
exit /b
)
set ret_off14=0
%_qr% %_Nul2% | findstr /i channel %_Nul1% && (set ret_off14=1)
if defined _C14R (echo.&echo %_mO14c%) else if %_O14MSI% EQU 1 (if %ret_off14% EQU 1 echo.&echo %_mO14m%)
exit /b

:offchk
set ls=0
set ls2=0
set ls3=0
set "_qr=%_zz7% %spp% %_zz2% %_zz5%LicenseFamily='Office%~1'%_zz6% %_zz3% LicenseStatus %_zz8%"
for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set /a ls=%%A
set "_qr=%_zz7% %spp% %_zz2% %_zz5%LicenseFamily='Office%~3'%_zz6% %_zz3% LicenseStatus %_zz8%"
if /i not "%~3"=="" for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set /a ls2=%%A
set "_qr=%_zz7% %spp% %_zz2% %_zz5%LicenseFamily='Office%~5'%_zz6% %_zz3% LicenseStatus %_zz8%"
if /i not "%~5"=="" for /f "tokens=2 delims==" %%A in ('%_qr% %_Nul6%') do set /a ls3=%%A
if "%ls3%"=="1" (
echo Checking: %~6
echo Product is Permanently Activated.
exit /b
)
if "%ls2%"=="1" (
echo Checking: %~4
echo Product is Permanently Activated.
exit /b
)
if "%ls%"=="1" (
echo Checking: %~2
echo Product is Permanently Activated.
exit /b
)
call :insKey
exit /b

:offchk21
if /i '%app%' EQU 'f3fb2d68-83dd-4c8b-8f09-08e0d950ac3b' exit /b
if /i '%app%' EQU '76093b1b-7057-49d7-b970-638ebcbfd873' exit /b
if /i '%app%' EQU 'a3b44174-2451-4cd6-b25f-66638bfb9046' exit /b
if /i '%app%' EQU 'fbdb3e18-a8ef-4fb3-9183-dffd60bd0984' (
call :offchk "21ProPlus2021VL_MAK_AE1" "Office ProPlus 2021" "21ProPlus2021VL_MAK_AE2"
exit /b
)
if /i '%app%' EQU '080a45c5-9f9f-49eb-b4b0-c3c610a5ebd3' (
call :offchk "21Standard2021VL_MAK_AE" "Office Standard 2021"
exit /b
)
if /i '%app%' EQU '76881159-155c-43e0-9db7-2d70a9a3a4ca' (
call :offchk "21ProjectPro2021VL_MAK_AE1" "Project Pro 2021" "21ProjectPro2021VL_MAK_AE2"
exit /b
)
if /i '%app%' EQU '6dd72704-f752-4b71-94c7-11cec6bfc355' (
call :offchk "21ProjectStd2021VL_MAK_AE" "Project Standard 2021"
exit /b
)
if /i '%app%' EQU 'fb61ac9a-1688-45d2-8f6b-0674dbffa33c' (
call :offchk "21VisioPro2021VL_MAK_AE" "Visio Pro 2021"
exit /b
)
if /i '%app%' EQU '72fce797-1884-48dd-a860-b2f6a5efd3ca' (
call :offchk "21VisioStd2021VL_MAK_AE" "Visio Standard 2021"
exit /b
)
call :insKey
exit /b

:offchk19
if /i '%app%' EQU '0bc88885-718c-491d-921f-6f214349e79c' exit /b
if /i '%app%' EQU 'fc7c4d0c-2e85-4bb9-afd4-01ed1476b5e9' exit /b
if /i '%app%' EQU '500f6619-ef93-4b75-bcb4-82819998a3ca' exit /b
if /i '%app%' EQU '85dd8b5f-eaa4-4af3-a628-cce9e77c9a03' (
call :offchk "19ProPlus2019VL_MAK_AE" "Office ProPlus 2019"
exit /b
)
if /i '%app%' EQU '6912a74b-a5fb-401a-bfdb-2e3ab46f4b02' (
call :offchk "19Standard2019VL_MAK_AE" "Office Standard 2019"
exit /b
)
if /i '%app%' EQU '2ca2bf3f-949e-446a-82c7-e25a15ec78c4' (
call :offchk "19ProjectPro2019VL_MAK_AE" "Project Pro 2019"
exit /b
)
if /i '%app%' EQU '1777f0e3-7392-4198-97ea-8ae4de6f6381' (
call :offchk "19ProjectStd2019VL_MAK_AE" "Project Standard 2019"
exit /b
)
if /i '%app%' EQU '5b5cf08f-b81a-431d-b080-3450d8620565' (
call :offchk "19VisioPro2019VL_MAK_AE" "Visio Pro 2019"
exit /b
)
if /i '%app%' EQU 'e06d7df3-aad0-419d-8dfb-0ac37e2bdf39' (
call :offchk "19VisioStd2019VL_MAK_AE" "Visio Standard 2019"
exit /b
)
call :insKey
exit /b

:offchk16
if /i '%app%' EQU 'd450596f-894d-49e0-966a-fd39ed4c4c64' (
call :offchk "16ProPlusVL_MAK" "Office ProPlus 2016"
exit /b
)
if /i '%app%' EQU 'dedfa23d-6ed1-45a6-85dc-63cae0546de6' (
call :offchk "16StandardVL_MAK" "Office Standard 2016"
exit /b
)
if /i '%app%' EQU '4f414197-0fc2-4c01-b68a-86cbb9ac254c' (
call :offchk "16ProjectProVL_MAK" "Project Pro 2016"
exit /b
)
if /i '%app%' EQU 'da7ddabc-3fbe-4447-9e01-6ab7440b4cd4' (
call :offchk "16ProjectStdVL_MAK" "Project Standard 2016"
exit /b
)
if /i '%app%' EQU '6bf301c1-b94a-43e9-ba31-d494598c47fb' (
call :offchk "16VisioProVL_MAK" "Visio Pro 2016"
exit /b
)
if /i '%app%' EQU 'aa2a7821-1827-4c2c-8f1d-4513a34dda97' (
call :offchk "16VisioStdVL_MAK" "Visio Standard 2016"
exit /b
)
if /i '%app%' EQU '829b8110-0e6f-4349-bca4-42803577788d' (
call :offchk "16ProjectProXC2RVL_MAKC2R" "Project Pro 2016 C2R"
exit /b
)
if /i '%app%' EQU 'cbbaca45-556a-4416-ad03-bda598eaa7c8' (
call :offchk "16ProjectStdXC2RVL_MAKC2R" "Project Standard 2016 C2R"
exit /b
)
if /i '%app%' EQU 'b234abe3-0857-4f9c-b05a-4dc314f85557' (
call :offchk "16VisioProXC2RVL_MAKC2R" "Visio Pro 2016 C2R"
exit /b
)
if /i '%app%' EQU '361fe620-64f4-41b5-ba77-84f8e079b1f7' (
call :offchk "16VisioStdXC2RVL_MAKC2R" "Visio Standard 2016 C2R"
exit /b
)
call :insKey
exit /b

:offchk15
if /i '%app%' EQU 'b322da9c-a2e2-4058-9e4e-f59a6970bd69' (
call :offchk "ProPlusVL_MAK" "Office ProPlus 2013"
exit /b
)
if /i '%app%' EQU 'b13afb38-cd79-4ae5-9f7f-eed058d750ca' (
call :offchk "StandardVL_MAK" "Office Standard 2013"
exit /b
)
if /i '%app%' EQU '4a5d124a-e620-44ba-b6ff-658961b33b9a' (
call :offchk "ProjectProVL_MAK" "Project Pro 2013"
exit /b
)
if /i '%app%' EQU '427a28d1-d17c-4abf-b717-32c780ba6f07' (
call :offchk "ProjectStdVL_MAK" "Project Standard 2013"
exit /b
)
if /i '%app%' EQU 'e13ac10e-75d0-4aff-a0cd-764982cf541c' (
call :offchk "VisioProVL_MAK" "Visio Pro 2013"
exit /b
)
if /i '%app%' EQU 'ac4efaf0-f81f-4f61-bdf7-ea32b02ab117' (
call :offchk "VisioStdVL_MAK" "Visio Standard 2013"
exit /b
)
call :insKey
exit /b

:offchk14
if /i '%app%' EQU '6f327760-8c5c-417c-9b61-836a98287e0c' (
call :offchk "ProPlus-MAK" "Office ProPlus 2010" "ProPlusAcad-MAK" "Office Professional Academic 2010"
exit /b
)
if /i '%app%' EQU '9da2a678-fb6b-4e67-ab84-60dd6a9c819a' (
call :offchk "Standard-MAK" "Office Standard 2010" "StandardAcad-MAK"  "Office Standard Academic 2010"
exit /b
)
if /i '%app%' EQU 'ea509e87-07a1-4a45-9edc-eba5a39f36af' (
call :offchk "SmallBusBasics-MAK" "Office Small Business Basics 2010"
exit /b
)
if /i '%app%' EQU 'df133ff7-bf14-4f95-afe3-7b48e7e331ef' (
call :offchk "ProjectPro-MAK" "Project Pro 2010"
exit /b
)
if /i '%app%' EQU '5dc7bf61-5ec9-4996-9ccb-df806a2d0efe' (
call :offchk "ProjectStd-MAK" "Project Standard 2010" "ProjectStd-MAK2" "Project Standard 2010"
exit /b
)
if /i '%app%' EQU '92236105-bb67-494f-94c7-7f7a607929bd' (
call :offchk "VisioPrem-MAK" "Visio Premium 2010" "VisioPro-MAK" "Visio Pro 2010"
exit /b
)
if defined vPrem exit /b
if /i '%app%' EQU 'e558389c-83c3-4b29-adfe-5e4d7f46c358' (
call :offchk "VisioPro-MAK" "Visio Pro 2010" "VisioStd-MAK" "Visio Standard 2010"
exit /b
)
if defined vProf exit /b
if /i '%app%' EQU '9ed833ff-4f92-4f36-b370-8683a4f13275' (
call :offchk "VisioStd-MAK" "Visio Standard 2010"
exit /b
)
call :insKey
exit /b

:officeLoc
set loc_off%1=0
set _O%1MSI=0
if %1 EQU 19 (
if defined _C16R reg query %_C16R% /v ProductReleaseIds %_Nul2% | findstr 2019 %_Nul1% && set loc_off%1=1
exit /b
)
if %1 EQU 21 (
if defined _C16R reg query %_C16R% /v ProductReleaseIds %_Nul2% | findstr 2021 %_Nul1% && set loc_off%1=1
exit /b
)

for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\%1.0\Common\InstallRoot /v Path" %_Nul6%') do if exist "%%b\OSPP.VBS" (
set loc_off%1=1
set _O%1MSI=1
)
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\%1.0\Common\InstallRoot /v Path" %_Nul6%') do if exist "%%b\OSPP.VBS" (
set loc_off%1=1
set _O%1MSI=1
)

if %1 EQU 16 if defined _C16R (
for /f "skip=2 tokens=2*" %%a in ('reg query %_C16R% /v ProductReleaseIds') do echo %%b> "!_temp!\c2rchk.txt"
for %%a in (%LV16Ids%,ProjectProX,ProjectStdX,VisioProX,VisioStdX) do (
  findstr /I /C:"%%aVolume" "!_temp!\c2rchk.txt" %_Nul1% && set loc_off%1=1
  )
for %%a in (%LR16Ids%) do (
  findstr /I /C:"%%aRetail" "!_temp!\c2rchk.txt" %_Nul1% && set loc_off%1=1
  )
exit /b
)

if %1 EQU 15 if defined _C15R (
set loc_off%1=1
exit /b
)

if exist "%ProgramFiles%\Microsoft Office\Office%1\OSPP.VBS" set loc_off%1=1
if not %xOS%==x86 if exist "%ProgramW6432%\Microsoft Office\Office%1\OSPP.VBS" set loc_off%1=1
if not %xOS%==x86 if exist "%ProgramFiles(x86)%\Microsoft Office\Office%1\OSPP.VBS" set loc_off%1=1
exit /b

:officeSub
reg query %kNext% | findstr /i /r ".*retail" %_Nul2% | findstr /i /v "project visio" %_Nul2% | find /i "0x2" %_Nul1% && (set sub_o365=1)
reg query %kNext% | findstr /i /r ".*retail" %_Nul2% | findstr /i /v "project visio" %_Nul2% | find /i "0x3" %_Nul1% && (set sub_o365=1)
reg query %kNext% | findstr /i /r ".*volume" %_Nul2% | findstr /i /v "project visio" %_Nul2% | find /i "0x2" %_Nul1% && (set sub_o365=1)
reg query %kNext% | findstr /i /r ".*volume" %_Nul2% | findstr /i /v "project visio" %_Nul2% | find /i "0x3" %_Nul1% && (set sub_o365=1)
reg query %kNext% | findstr /i /r "project.*" %_Nul2% | find /i "0x2" %_Nul1% && set sub_proj=1
reg query %kNext% | findstr /i /r "project.*" %_Nul2% | find /i "0x3" %_Nul1% && set sub_proj=1
reg query %kNext% | findstr /i /r "visio.*" %_Nul2% | find /i "0x2" %_Nul1% && set sub_vsio=1
reg query %kNext% | findstr /i /r "visio.*" %_Nul2% | find /i "0x3" %_Nul1% && set sub_vsio=1
if %sub_o365% EQU 1 set sub_next=1
if %sub_proj% EQU 1 set sub_next=1
if %sub_vsio% EQU 1 set sub_next=1
exit /b

:insKey
set S_OK=1
echo.
set "_key="
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% Name %_zz8%"
if %ESU_ADD% EQU 0 for /f "tokens=2 delims==" %%x in ('%_qr%') do echo Installing Key: %%x
if %ESU_ADD% EQU 1 for /f "tokens=2 delims==f" %%x in ('%_qr%') do echo Installing Key: %%x
set ESU_ADD=0
call :keys %app%
if "%_key%"=="" (echo No associated KMS Client key found&exit /b)
set "_qr=wmic path %sps% where Version='%slsv%' call InstallProductKey ProductKey="%_key%""
if %WMI_VBS% NEQ 0 set "_qr=%_csp% %sps% "%_key%""
%_qr% %_Nul3%
set ERRORCODE=%ERRORLEVEL%
if %ERRORCODE% NEQ 0 (
cmd /c exit /b %ERRORCODE%
echo Failed: 0x!=ExitCode!
set S_OK=0
exit /b
)
set "_qr=wmic path %sps% where Version='%slsv%' call RefreshLicenseStatus"
if %WMI_VBS% NEQ 0 set "_qr=%_csm% "%sps%.Version='%slsv%'" RefreshLicenseStatus"
if %sps% EQU SoftwareLicensingService %_qr% %_Nul3%

:activate
set S_OK=1
if %sps% EQU SoftwareLicensingService (
if %_officespp% EQU 0 (reg delete "HKLM\%SPPk%\%_wApp%\%app%" /f %_Null%) else (reg delete "HKLM\%SPPk%\%_oApp%\%app%" /f %_Null%)
) else (
reg delete "HKLM\%OPPk%\%_oA14%\%app%" /f %_Null%
reg delete "HKLM\%OPPk%\%_oApp%\%app%" /f %_Null%
)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% Name %_zz8%"
if %W1nd0ws% EQU 0 if %_officespp% EQU 0 if %sps% EQU SoftwareLicensingService (
reg add "HKLM\%SPPk%\%_wApp%\%app%" /f /v KeyManagementServiceName /t REG_SZ /d "127.0.0.2" %_Nul3%
reg add "HKLM\%SPPk%\%_wApp%\%app%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" %_Nul3%
for /f "tokens=2 delims==" %%x in ('%_qr%') do echo Checking: %%x
echo Product is KMS 2038 Activated.
set _keepkms38=1
exit /b
)
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% Name %_zz8%"
if %act_attempt% LSS 1 (
if %ESU_ADD% EQU 0 for /f "tokens=2 delims==" %%x in ('%_qr%') do echo Activating: %%x
if %ESU_ADD% EQU 1 for /f "tokens=2 delims==f" %%x in ('%_qr%') do echo Activating: %%x
)

set ESU_ADD=0
set "_qr=wmic path %spp% where ID='%app%' call Activate"
if %WMI_VBS% NEQ 0 set "_qr=%_csm% "%spp%.ID='%app%'" Activate"
%_qr% %_Nul3%
call set ERRORCODE=%ERRORLEVEL%
if %act_attempt% LSS 1 if %ERRORCODE% EQU -1073418187 (
echo Product Activation Failed: 0xC004F035
if %OSType% EQU Win7 echo Windows 7 cannot be KMS-activated on this computer due to unqualified OEM BIOS.
echo See Read Me for details.
exit /b
)
if %act_attempt% LSS 1 if %ERRORCODE% EQU -1073417728 (
echo Product Activation Failed: 0xC004F200
echo Windows needs to rebuild the activation-related files.
echo See KB2736303 for details.
exit /b
)
if %act_attempt% LSS 1 if %ERRORCODE% EQU -1073422315 (
echo Product Activation Failed: 0xC004E015
echo Running slmgr.vbs /rilc to mitigate.
cscript //Nologo //B %SysPath%\slmgr.vbs /rilc
)
set gpr=0
set gpr2=0
set "_qr=%_zz7% %spp% %_zz2% %_zz5%ID='%app%'%_zz6% %_zz3% GracePeriodRemaining %_zz8%"
for /f "tokens=2 delims==" %%x in ('%_qr%') do (set gpr=%%x&set /a "gpr2=(%%x+1440-1)/1440")
if %act_attempt% LSS 1 if %ERRORCODE% EQU 0 if %gpr% EQU 0 (
echo Product Activation succeeded, but Remaining Period failed to increase.
if %OSType% EQU Win7 echo This could be related to the error described in KB4487266
exit /b
)
set Act_OK=0
if %gpr% EQU 43200 if %_officespp% EQU 0 if %winbuild% GEQ 9200 set Act_OK=1
if %gpr% EQU 64800 set Act_OK=1
if %gpr% GTR 259200 if %Win10Gov% EQU 1 set Act_OK=1
if %gpr% EQU 259200 set Act_OK=1

if %ERRORCODE% EQU 0 if %Act_OK% EQU 1 (
call :_color %_Green% "Product Activation Successful"
echo Remaining Period: %gpr2% days ^(%gpr% minutes^)
set /a act_attempt=0
exit /b
)

if not !server_num! gtr %max_servers% (
if %act_attempt% LSS 3 (
set /a act_attempt+=1
call :getserv
%nul% reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "!KMS_IP!"
%nul% reg add "HKLM\%OPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "!KMS_IP!"
if %winbuild% GEQ 9200 (
%nul% reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "!KMS_IP!"
if defined notx86 (
%nul% reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "!KMS_IP!" /reg:32
%nul% reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "!KMS_IP!" /reg:32
)
)
goto :activate
)
)

cmd /c exit /b %ERRORCODE%
if %ERRORCODE% NEQ 0 (
call :_color %_Red% "Product Activation Failed: 0x!=ExitCode!"
) else (
call :_color %_Red% "Product Activation Failed"
)
echo Remaining Period: %gpr2% days ^(%gpr% minutes^)
set S_OK=0
set act_failed=1
set /a act_attempt=0
exit /b

:StopService
sc query %1 | find /i "STOPPED" %_Nul1% || net stop %1 /y %_Nul3%
sc query %1 | find /i "STOPPED" %_Nul1% || sc stop %1 %_Nul3%
goto :eof

:UpdateOSPPEntry
if /i %1 EQU osppsvc.exe (
reg add "HKLM\%OPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "!KMS_IP!" %_Nul3%
reg add "HKLM\%OPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "%KMS_Port%" %_Nul3%
)
goto :eof

:CheckFR

set WMIe=0
call :CheckWS
if %WMIe% EQU 1 (
echo.
echo %_err%
echo Failed running WMI query check.
)
goto :eof

:CheckWS
set "_qrw=%_zz1% Win32_ComputerSystem %_zz3% CreationClassName %_zz4%"
set "_qrs=%_zz1% SoftwareLicensingService %_zz3% Version %_zz4%"

%_qrs% %_Nul2% | findstr /r "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" %_Nul1% || (
  set WMIe=1
  %_qrw% %_Nul2% | find /i "ComputerSystem" %_Nul1% && (
    echo Error: SPP is not responding
    ) || (
    echo Error: WMI ^& SPP are not responding
  )
)
goto :eof

:C2RR2V
set RanR2V=1
set "_SLMGR=%SysPath%\slmgr.vbs"
if %_Debug% EQU 0 (
set "_cscript=cscript //Nologo //B"
) else (
set "_cscript=cscript //Nologo"
)
set _LTSC=0
set "_tag="&set "_ons= 2016"
sc query ClickToRunSvc %_Nul3%
set error1=%errorlevel%
sc query OfficeSvc %_Nul3%
set error2=%errorlevel%
if %error1% EQU 1060 if %error2% EQU 1060 (
echo Error: Office C2R service is not detected
goto :%_fC2R%
)
set _Office16=0
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses16\ProPlus*.xrm-ms" (
  set _Office16=1
)
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses16\ProPlus*.xrm-ms" (
  set _Office16=1
)
set _Office15=0
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses\ProPlus*.xrm-ms" (
  set _Office15=1
)
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun /v InstallPath" %_Nul6%') do if exist "%%b\root\Licenses\ProPlus*.xrm-ms" (
  set _Office15=1
)
if %_Office16% EQU 0 if %_Office15% EQU 0 (
echo Error: Office C2R InstallPath is not detected
goto :%_fC2R%
)

:Reg16istry
if %_Office16% EQU 0 goto :Reg15istry
set "_InstallRoot="
set "_ProductIds="
set "_GUID="
set "_Config="
set "_PRIDs="
set "_LicensesPath="
set "_Integrator="
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do (set "_InstallRoot=%%b\root")
if not "%_InstallRoot%"=="" (
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do (set "_OSPPVBS=%%b\Office16\OSPP.VBS")
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v PackageGUID" %_Nul6%') do (set "_GUID=%%b")
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration /v ProductReleaseIds" %_Nul6%') do (set "_ProductIds=%%b")
  set "_Config=HKLM\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
  set "_PRIDs=HKLM\SOFTWARE\Microsoft\Office\ClickToRun\ProductReleaseIDs"
) else (
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do (set "_InstallRoot=%%b\root")
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath" %_Nul6%') do (set "_OSPPVBS=%%b\Office16\OSPP.VBS")
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v PackageGUID" %_Nul6%') do (set "_GUID=%%b")
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun\Configuration /v ProductReleaseIds" %_Nul6%') do (set "_ProductIds=%%b")
  set "_Config=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun\Configuration"
  set "_PRIDs=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun\ProductReleaseIDs"
)
set "_LicensesPath=%_InstallRoot%\Licenses16"
set "_Integrator=%_InstallRoot%\integration\integrator.exe"
for /f "skip=2 tokens=2*" %%a in ('"reg query %_PRIDs% /v ActiveConfiguration" %_Nul6%') do set "_PRIDs=%_PRIDs%\%%b"
if "%_ProductIds%"=="" (
if %_Office15% EQU 0 (echo Error: Office C2R ProductIDs are not detected&goto :%_fC2R%) else (goto :Reg15istry)
)
if not exist "%_LicensesPath%\ProPlus*.xrm-ms" (
if %_Office15% EQU 0 (echo Error: Office C2R Licenses files are not detected&goto :%_fC2R%) else (goto :Reg15istry)
)
if not exist "%_Integrator%" (
if %_Office15% EQU 0 (echo Error: Office C2R Licenses Integrator is not detected&goto :%_fC2R%) else (goto :Reg15istry)
)
if exist "%_LicensesPath%\Word2019VL_KMS_Client_AE*.xrm-ms" (set "_tag=2019"&set "_ons= 2019")
if exist "%_LicensesPath%\Word2021VL_KMS_Client_AE*.xrm-ms" (set _LTSC=1)
if %winbuild% LSS 10240 if !_LTSC! EQU 1 (set "_tag=2021"&set "_ons= 2021")
if %_Office15% EQU 0 goto :CheckC2R

:Reg15istry
set "_Install15Root="
set "_Product15Ids="
set "_Con15fig="
set "_PR15IDs="
set "_OSPP15Ready="
set "_Licenses15Path="
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun /v InstallPath" %_Nul6%') do (set "_Install15Root=%%b\root")
if not "%_Install15Root%"=="" (
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Configuration /v ProductReleaseIds" %_Nul6%') do (set "_Product15Ids=%%b")
  set "_Con15fig=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Configuration /v ProductReleaseIds"
  set "_PR15IDs=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\ProductReleaseIDs"
  set "_OSPP15Ready=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\Configuration"
) else (
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun /v InstallPath" %_Nul6%') do (set "_Install15Root=%%b\root")
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\Configuration /v ProductReleaseIds" %_Nul6%') do (set "_Product15Ids=%%b")
  set "_Con15fig=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\Configuration /v ProductReleaseIds"
  set "_PR15IDs=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\ProductReleaseIDs"
  set "_OSPP15Ready=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\Configuration"
)
set "_OSPP15ReadT=REG_SZ"
if "%_Product15Ids%"=="" (
reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid %_Nul3% && (
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid" %_Nul6%') do (set "_Product15Ids=%%b")
  set "_Con15fig=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid"
  set "_OSPP15Ready=HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun"
  set "_OSPP15ReadT=REG_DWORD"
  )
reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid %_Nul3% && (
  for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid" %_Nul6%') do (set "_Product15Ids=%%b")
  set "_Con15fig=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun\propertyBag /v productreleaseid"
  set "_OSPP15Ready=HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun"
  set "_OSPP15ReadT=REG_DWORD"
  )
)
set "_Licenses15Path=%_Install15Root%\Licenses"
if exist "%ProgramFiles%\Microsoft Office\Office15\OSPP.VBS" (
  set "_OSPP15VBS=%ProgramFiles%\Microsoft Office\Office15\OSPP.VBS"
) else if exist "%ProgramW6432%\Microsoft Office\Office15\OSPP.VBS" (
  set "_OSPP15VBS=%ProgramW6432%\Microsoft Office\Office15\OSPP.VBS"
) else if exist "%ProgramFiles(x86)%\Microsoft Office\Office15\OSPP.VBS" (
  set "_OSPP15VBS=%ProgramFiles(x86)%\Microsoft Office\Office15\OSPP.VBS"
)
if "%_Product15Ids%"=="" (
if %_Office16% EQU 0 (echo Error: Office 2013 C2R ProductIDs are not detected&goto :%_fC2R%) else (goto :CheckC2R)
)
if not exist "%_Licenses15Path%\ProPlus*.xrm-ms" (
if %_Office16% EQU 0 (echo Error: Office 2013 C2R Licenses files are not detected&goto :%_fC2R%) else (goto :CheckC2R)
)
if %winbuild% LSS 9200 if not exist "%_OSPP15VBS%" (
if %_Office16% EQU 0 (echo Error: Office 2013 C2R Licensing tool OSPP.vbs is not detected&goto :%_fC2R%) else (goto :CheckC2R)
)

:CheckC2R
set _OMSI=0
if %_Office16% EQU 0 (
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot /v Path" %_Nul6%') do if exist "%%b\OSPP.VBS" set _OMSI=1
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\InstallRoot /v Path" %_Nul6%') do if exist "%%b\OSPP.VBS" set _OMSI=1
)
if %_Office15% EQU 0 (
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\Common\InstallRoot /v Path" %_Nul6%') do if exist "%%b\OSPP.VBS" set _OMSI=1
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\InstallRoot /v Path" %_Nul6%') do if exist "%%b\OSPP.VBS" set _OMSI=1
)
if %winbuild% GEQ 9200 (
set _spp=SoftwareLicensingProduct
set _sps=SoftwareLicensingService
set "_vbsi=%_SLMGR% /ilc "
set "_vbsf=%_SLMGR% /ilc "
) else (
set _spp=OfficeSoftwareProtectionProduct
set _sps=OfficeSoftwareProtectionService
set _vbsi="!_OSPP15VBS!" /inslic:
set _vbsf="!_OSPPVBS!" /inslic:
)
set "_wmi="
set "_qr=%_zz7% %_sps% %_zz3% Version %_zz8%"
for /f "tokens=2 delims==" %%# in ('%_qr%') do set _wmi=%%#
if "%_wmi%"=="" (
echo Error: %_sps% WMI version is not detected
call :CheckWS
goto :%_fC2R%
)
set _Retail=0
set "_ocq=ApplicationID='%_oApp%' AND LicenseStatus='1' AND PartialProductKey is not NULL"
if %WMI_VBS% EQU 0 wmic path %_spp% where (%_ocq%) get Description %_Nul2% |findstr /V /R "^$" >"!_temp!\crvRetail.txt"
set "_qr=%_csq% %_spp% "%_ocq%" Description"
if %WMI_VBS% NEQ 0 %_qr% %_Nul2% >"!_temp!\crvRetail.txt"
find /i "RETAIL channel" "!_temp!\crvRetail.txt" %_Nul1% && set _Retail=1
find /i "RETAIL(MAK) channel" "!_temp!\crvRetail.txt" %_Nul1% && set _Retail=1
find /i "TIMEBASED_SUB channel" "!_temp!\crvRetail.txt" %_Nul1% && set _Retail=1
set rancopp=0
if %_Retail% EQU 0 if %_OMSI% EQU 0 (
set rancopp=1
%_Nul3% powershell "$f=[io.file]::ReadAllText('!_batp!') -split ':cleanlicense\:.*';iex ($f[1]);"
)
set _O16O365=0
set _C16Msg=0
set _C15Msg=0
set "_qr=%_csq% %_spp% "%_ocq%" LicenseFamily"
if %_Retail% EQU 1 if %WMI_VBS% EQU 0 wmic path %_spp% where (%_ocq%) get LicenseFamily %_Nul2% |findstr /V /R "^$" >"!_temp!\crvRetail.txt"
if %_Retail% EQU 1 if %WMI_VBS% NEQ 0 %_qr% %_Nul2% >"!_temp!\crvRetail.txt"
set "_qr=%_csq% %_spp% "ApplicationID='%_oApp%'" LicenseFamily"
if %WMI_VBS% EQU 0 wmic path %_spp% where "ApplicationID='%_oApp%'" get LicenseFamily %_Nul2% |findstr /V /R "^$" >"!_temp!\crvVolume.txt" 2>&1
if %WMI_VBS% NEQ 0 %_qr% %_Nul2% >"!_temp!\crvVolume.txt" 2>&1

if %_Office16% EQU 0 goto :R15V

set _O21Ids=ProPlus2021,ProjectPro2021,VisioPro2021,Standard2021,ProjectStd2021,VisioStd2021,Access2021,SkypeforBusiness2021
set _O19Ids=ProPlus2019,ProjectPro2019,VisioPro2019,Standard2019,ProjectStd2019,VisioStd2019,Access2019,SkypeforBusiness2019
set _O16Ids=ProjectPro,VisioPro,Standard,ProjectStd,VisioStd,Access,SkypeforBusiness
set _A21Ids=Excel2021,Outlook2021,PowerPoint2021,Publisher2021,Word2021
set _A19Ids=Excel2019,Outlook2019,PowerPoint2019,Publisher2019,Word2019
set _A16Ids=Excel,Outlook,PowerPoint,Publisher,Word
set _V21Ids=%_O21Ids%,%_A21Ids%
set _V19Ids=%_O19Ids%,%_A19Ids%
set _V16Ids=Mondo,%_O16Ids%,%_A16Ids%,OneNote
set _R16Ids=%_V16Ids%,Professional,HomeBusiness,HomeStudent,O365ProPlus,O365Business,O365SmallBusPrem,O365HomePrem,O365EduCloud
set _RetIds=%_V21Ids%,Professional2021,HomeBusiness2021,HomeStudent2021,%_V19Ids%,Professional2019,HomeBusiness2019,HomeStudent2019,%_R16Ids%
set _Suites=Mondo,O365ProPlus,O365Business,O365SmallBusPrem,O365HomePrem,O365EduCloud,ProPlus,Standard,Professional,HomeBusiness,HomeStudent,ProPlus2019,Standard2019,Professional2019,HomeBusiness2019,HomeStudent2019,ProPlus2021,Standard2021,Professional2021,HomeBusiness2021,HomeStudent2021
set _PrjSKU=ProjectPro,ProjectStd,ProjectPro2019,ProjectStd2019,ProjectPro2021,ProjectStd2021
set _VisSKU=VisioPro,VisioStd,VisioPro2019,VisioStd2019,VisioPro2021,VisioStd2021

echo %_ProductIds%>"!_temp!\crvProductIds.txt"
for %%a in (%_RetIds%,ProPlus) do (
set _%%a=0
)
for %%a in (%_RetIds%) do (
findstr /I /C:"%%aRetail" "!_temp!\crvProductIds.txt" %_Nul1% && set _%%a=1
)
if !_LTSC! EQU 0 for %%a in (%_V21Ids%) do (
set _%%a=0
)
if !_LTSC! EQU 1 for %%a in (%_V21Ids%) do (
findstr /I /C:"%%aVolume" "!_temp!\crvProductIds.txt" %_Nul1% && (
  find /i "Office21%%aVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _%%a=0) || (set _%%a=1)
  )
)
for %%a in (%_V19Ids%) do (
findstr /I /C:"%%aVolume" "!_temp!\crvProductIds.txt" %_Nul1% && (
  find /i "Office19%%aVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _%%a=0) || (set _%%a=1)
  )
)
for %%a in (%_V16Ids%) do (
findstr /I /C:"%%aVolume" "!_temp!\crvProductIds.txt" %_Nul1% && (
  find /i "Office16%%aVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _%%a=0) || (set _%%a=1)
  )
)
reg query %_PRIDs%\ProPlusRetail.16 %_Nul3% && (
  find /i "Office16ProPlusVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _ProPlus=0) || (set _ProPlus=1)
)
reg query %_PRIDs%\ProPlusVolume.16 %_Nul3% && (
  find /i "Office16ProPlusVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _ProPlus=0) || (set _ProPlus=1)
)
if %_Retail% EQU 1 for %%a in (%_RetIds%) do (
findstr /I /C:"%%aRetail" "!_temp!\crvProductIds.txt" %_Nul1% && (
  find /i "Office16%%aR_Retail" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aR_OEM" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aR_Sub" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aR_PIN" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aE5R_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aEDUR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aMSDNR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aO365R_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aCO365R_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aVL_MAK" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office16%%aXC2RVL_MAKC2R" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R16=1)
  find /i "Office19%%aR_Retail" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R19=1)
  find /i "Office19%%aR_OEM" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R19=1)
  find /i "Office19%%aMSDNR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R19=1)
  find /i "Office19%%aVL_MAK" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R19=1)
  find /i "Office21%%aR_Retail" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R21=1)
  find /i "Office21%%aR_OEM" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R21=1)
  find /i "Office21%%aMSDNR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R21=1)
  find /i "Office21%%aVL_MAK" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R21=1)
  )
)
if %_Retail% EQU 1 reg query %_PRIDs%\ProPlusRetail.16 %_Nul3% && (
  find /i "Office16ProPlusR_Retail" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R16=1)
  find /i "Office16ProPlusR_OEM" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R16=1)
  find /i "Office16ProPlusMSDNR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R16=1)
  find /i "Office16ProPlusVL_MAK" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R16=1)
)
set "_qr=%_zz1% %_spp% %_zz2% "ApplicationID='%_oApp%' AND LicenseFamily like 'Office16O365%%'" %_zz3% LicenseFamily %_zz4%"
find /i "Office16MondoVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (
%_qr% %_Nul2% | find /i "O365" %_Nul1% && (
  for %%a in (O365ProPlus,O365Business,O365SmallBusPrem,O365HomePrem,O365EduCloud) do set _%%a=0
  )
)
if %sub_o365% EQU 1 (
  for %%a in (%_Suites%) do set _%%a=0
echo.
echo Microsoft Office is activated with a vNext license.
)
if %sub_proj% EQU 1 (
  for %%a in (%_PrjSKU%) do set _%%a=0
echo.
echo Microsoft Project is activated with a vNext license.
)
if %sub_vsio% EQU 1 (
  for %%a in (%_VisSKU%) do set _%%a=0
echo.
echo Microsoft Visio is activated with a vNext license.
)

for %%a in (%_RetIds%,ProPlus) do if !_%%a! EQU 1 (
set _C16Msg=1
)
if %_C16Msg% EQU 1 (
echo.
echo Converting Office C2R Retail-to-Volume:
)
if %_C16Msg% EQU 0 (if %_Office15% EQU 1 (goto :R15V) else (goto :GVLKC2R))

for %%# in ("!_LicensesPath!\client-issuance-*.xrm-ms") do (
%_cscript% %_vbsf%"!_LicensesPath!\%%~nx#"
)
%_cscript% %_vbsf%"!_LicensesPath!\pkeyconfig-office.xrm-ms"

if !_Mondo! EQU 1 (
call :InsLic Mondo
)
if !_O365ProPlus! EQU 1 (
echo O365ProPlus 2016 Suite ^<-^> Mondo 2016 Licenses
call :InsLic O365ProPlus DRNV7-VGMM2-B3G9T-4BF84-VMFTK
if !_Mondo! EQU 0 call :InsLic Mondo
)
if !_O365Business! EQU 1 if !_O365ProPlus! EQU 0 (
set _O365ProPlus=1
echo O365Business 2016 Suite ^<-^> Mondo 2016 Licenses
call :InsLic O365Business NCHRJ-3VPGW-X73DM-6B36K-3RQ6B
if !_Mondo! EQU 0 call :InsLic Mondo
)
if !_O365SmallBusPrem! EQU 1 if !_O365Business! EQU 0 if !_O365ProPlus! EQU 0 (
set _O365ProPlus=1
echo O365SmallBusPrem 2016 Suite ^<-^> Mondo 2016 Licenses
call :InsLic O365SmallBusPrem 3FBRX-NFP7C-6JWVK-F2YGK-H499R
if !_Mondo! EQU 0 call :InsLic Mondo
)
if !_O365HomePrem! EQU 1 if !_O365SmallBusPrem! EQU 0 if !_O365Business! EQU 0 if !_O365ProPlus! EQU 0 (
set _O365ProPlus=1
echo O365HomePrem 2016 Suite ^<-^> Mondo 2016 Licenses
call :InsLic O365HomePrem 9FNY8-PWWTY-8RY4F-GJMTV-KHGM9
if !_Mondo! EQU 0 call :InsLic Mondo
)
if !_O365EduCloud! EQU 1 if !_O365HomePrem! EQU 0 if !_O365SmallBusPrem! EQU 0 if !_O365Business! EQU 0 if !_O365ProPlus! EQU 0 (
set _O365ProPlus=1
echo O365EduCloud 2016 Suite ^<-^> Mondo 2016 Licenses
call :InsLic O365EduCloud 8843N-BCXXD-Q84H8-R4Q37-T3CPT
if !_Mondo! EQU 0 call :InsLic Mondo
)
if !_O365ProPlus! EQU 1 set _O16O365=1
if !_Mondo! EQU 1 if !_O365ProPlus! EQU 0 (
echo Mondo 2016 Suite
call :InsLic O365ProPlus DRNV7-VGMM2-B3G9T-4BF84-VMFTK
if %_Office15% EQU 1 (goto :R15V) else (goto :GVLKC2R)
)
if !_ProPlus2021! EQU 1 if !_O365ProPlus! EQU 0 (
echo ProPlus 2021 Suite
call :InsLic ProPlus2021
)
if !_ProPlus2019! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 (
echo ProPlus 2019 Suite -^> ProPlus%_ons% Licenses
call :InsLic ProPlus%_tag%
)
if !_ProPlus! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 (
echo ProPlus 2016 Suite -^> ProPlus%_ons% Licenses
call :InsLic ProPlus%_tag%
)
if !_Professional2021! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 (
echo Professional 2021 Suite -^> ProPlus 2021 Licenses
call :InsLic ProPlus2021
)
if !_Professional2019! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 (
echo Professional 2019 Suite -^> ProPlus%_ons% Licenses
call :InsLic ProPlus%_tag%
)
if !_Professional! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 (
echo Professional 2016 Suite -^> ProPlus%_ons% Licenses
call :InsLic ProPlus%_tag%
)
if !_Standard2021! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 (
echo Standard 2021 Suite
call :InsLic Standard2021
)
if !_Standard2019! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 (
echo Standard 2019 Suite -^> Standard%_ons% Licenses
call :InsLic Standard%_tag%
)
if !_Standard! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 (
echo Standard 2016 Suite -^> Standard%_ons% Licenses
call :InsLic Standard%_tag%
)
for %%a in (ProjectPro,VisioPro,ProjectStd,VisioStd) do if !_%%a2021! EQU 1 (
  echo %%a 2021 SKU
  call :InsLic %%a2021
)
for %%a in (ProjectPro,VisioPro,ProjectStd,VisioStd) do if !_%%a2019! EQU 1 (
if !_%%a2021! EQU 0 (
  echo %%a 2019 SKU -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (ProjectPro,VisioPro,ProjectStd,VisioStd) do if !_%%a! EQU 1 (
if !_%%a2021! EQU 0 if !_%%a2019! EQU 0 (
  echo %%a 2016 SKU -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (HomeBusiness,HomeStudent) do if !_%%a2021! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 if !_Standard! EQU 0 (
  set _Standard2021=1
  echo %%a 2021 Suite -^> Standard 2021 Licenses
  call :InsLic Standard2021
  )
)
for %%a in (HomeBusiness,HomeStudent) do if !_%%a2019! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 if !_Standard! EQU 0 if !_%%a2021! EQU 0 (
  set _Standard2019=1
  echo %%a 2019 Suite -^> Standard%_ons% Licenses
  call :InsLic Standard%_tag%
  )
)
for %%a in (HomeBusiness,HomeStudent) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 if !_Standard! EQU 0 if !_%%a2021! EQU 0 if !_%%a2019! EQU 0 (
  set _Standard=1
  echo %%a 2016 Suite -^> Standard%_ons% Licenses
  call :InsLic Standard%_tag%
  )
)
for %%a in (%_A21Ids%,OneNote) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 if !_Standard! EQU 0 (
  echo %%a App
  call :InsLic %%a
  )
)
for %%a in (%_A16Ids%) do if !_%%a2019! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 if !_Standard! EQU 0 if !_%%a2021! EQU 0 (
  echo %%a 2019 App -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (%_A16Ids%) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_Standard2021! EQU 0 if !_Standard2019! EQU 0 if !_Standard! EQU 0 if !_%%a2021! EQU 0 if !_%%a2019! EQU 0 (
  echo %%a 2016 App -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (Access) do if !_%%a2021! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 (
  echo %%a 2021 App
  call :InsLic %%a2021
  )
)
for %%a in (Access) do if !_%%a2019! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_%%a2021! EQU 0 (
  echo %%a 2019 App -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (Access) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_Professional2021! EQU 0 if !_Professional2019! EQU 0 if !_Professional! EQU 0 if !_%%a2021! EQU 0 if !_%%a2019! EQU 0 (
  echo %%a 2016 App -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (SkypeforBusiness) do if !_%%a2021! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 (
  echo %%a 2021 App
  call :InsLic %%a2021
  )
)
for %%a in (SkypeforBusiness) do if !_%%a2019! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_%%a2021! EQU 0 (
  echo %%a 2019 App -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
for %%a in (SkypeforBusiness) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus2021! EQU 0 if !_ProPlus2019! EQU 0 if !_ProPlus! EQU 0 if !_%%a2021! EQU 0 if !_%%a2019! EQU 0 (
  echo %%a 2016 App -^> %%a%_ons% Licenses
  call :InsLic %%a%_tag%
  )
)
if %_Office15% EQU 1 (goto :R15V) else (goto :GVLKC2R)

:R15V
set _O15Ids=Standard,ProjectPro,VisioPro,ProjectStd,VisioStd,Access,Lync
set _A15Ids=Excel,Groove,InfoPath,OneNote,Outlook,PowerPoint,Publisher,Word
set _R15Ids=SPD,Mondo,%_O15Ids%,%_A15Ids%,Professional,HomeBusiness,HomeStudent,O365ProPlus,O365Business,O365SmallBusPrem,O365HomePrem
set _V15Ids=Mondo,%_O15Ids%,%_A15Ids%

echo %_Product15Ids%>"!_temp!\crvProduct15s.txt"
for %%a in (%_R15Ids%,ProPlus) do (
set _%%a=0
)
for %%a in (%_R15Ids%) do (
findstr /I /C:"%%aRetail" "!_temp!\crvProduct15s.txt" %_Nul1% && set _%%a=1
)
for %%a in (%_V15Ids%) do (
findstr /I /C:"%%aVolume" "!_temp!\crvProduct15s.txt" %_Nul1% && (
  find /i "Office%%aVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _%%a=0) || (set _%%a=1)
  )
)
reg query %_PR15IDs%\Active\ProPlusRetail\x-none %_Nul3% && (
  find /i "OfficeProPlusVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _ProPlus=0) || (set _ProPlus=1)
)
reg query %_PR15IDs%\Active\ProPlusVolume\x-none %_Nul3% && (
  find /i "OfficeProPlusVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (set _ProPlus=0) || (set _ProPlus=1)
)
if %_Retail% EQU 1 for %%a in (%_R15Ids%) do (
findstr /I /C:"%%aRetail" "!_temp!\crvProduct15s.txt" %_Nul1% && (
  find /i "Office%%aR_Retail" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aR_OEM" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aR_Sub" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aR_PIN" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aMSDNR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aO365R_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aCO365R_" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  find /i "Office%%aVL_MAK" "!_temp!\crvRetail.txt" %_Nul1% && (set _%%a=0 & set aC2R15=1)
  )
)
if %_Retail% EQU 1 reg query %_PR15IDs%\Active\ProPlusRetail\x-none %_Nul3% && (
  find /i "OfficeProPlusR_Retail" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R15=1)
  find /i "OfficeProPlusR_OEM" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R15=1)
  find /i "OfficeProPlusMSDNR_" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R15=1)
  find /i "OfficeProPlusVL_MAK" "!_temp!\crvRetail.txt" %_Nul1% && (set _ProPlus=0 & set aC2R15=1)
)
set "_qr=%_zz1% %_spp% %_zz2% "ApplicationID='%_oApp%' AND LicenseFamily like 'OfficeO365%%'" %_zz3% LicenseFamily %_zz4%"
find /i "OfficeMondoVL_KMS_Client" "!_temp!\crvVolume.txt" %_Nul1% && (
%_qr% %_Nul2% | find /i "O365" %_Nul1% && (
  for %%a in (O365ProPlus,O365Business,O365SmallBusPrem,O365HomePrem) do set _%%a=0
  )
)

for %%a in (%_R15Ids%,ProPlus) do if !_%%a! EQU 1 (
set _C15Msg=1
)
if %_C15Msg% EQU 1 if %_C16Msg% EQU 0 (
echo.
echo Converting Office C2R Retail-to-Volume:
)
if %_C15Msg% EQU 0 goto :GVLKC2R

for %%# in ("!_Licenses15Path!\client-issuance-*.xrm-ms") do (
%_cscript% %_vbsi%"!_Licenses15Path!\%%~nx#"
)
%_cscript% %_vbsi%"!_Licenses15Path!\pkeyconfig-office.xrm-ms"

if !_Mondo! EQU 1 (
call :Ins15Lic Mondo
)
if !_O365ProPlus! EQU 1 if !_O16O365! EQU 0 (
echo O365ProPlus 2013 Suite ^<-^> Mondo 2013 Licenses
call :Ins15Lic O365ProPlus DRNV7-VGMM2-B3G9T-4BF84-VMFTK
if !_Mondo! EQU 0 call :Ins15Lic Mondo
)
if !_O365SmallBusPrem! EQU 1 if !_O365ProPlus! EQU 0 if !_O16O365! EQU 0 (
set _O365ProPlus=1
echo O365SmallBusPrem 2013 Suite ^<-^> Mondo 2013 Licenses
call :Ins15Lic O365SmallBusPrem 3FBRX-NFP7C-6JWVK-F2YGK-H499R
if !_Mondo! EQU 0 call :Ins15Lic Mondo
)
if !_O365HomePrem! EQU 1 if !_O365SmallBusPrem! EQU 0 if !_O365ProPlus! EQU 0 if !_O16O365! EQU 0 (
set _O365ProPlus=1
echo O365HomePrem 2013 Suite ^<-^> Mondo 2013 Licenses
call :Ins15Lic O365HomePrem 9FNY8-PWWTY-8RY4F-GJMTV-KHGM9
if !_Mondo! EQU 0 call :Ins15Lic Mondo
)
if !_O365Business! EQU 1 if !_O365HomePrem! EQU 0 if !_O365SmallBusPrem! EQU 0 if !_O365ProPlus! EQU 0 if !_O16O365! EQU 0 (
set _O365ProPlus=1
echo O365Business 2013 Suite ^<-^> Mondo 2013 Licenses
call :Ins15Lic O365Business MCPBN-CPY7X-3PK9R-P6GTT-H8P8Y
if !_Mondo! EQU 0 call :Ins15Lic Mondo
)
if !_Mondo! EQU 1 if !_O365ProPlus! EQU 0 if !_O16O365! EQU 0 (
echo Mondo 2013 Suite
call :Ins15Lic O365ProPlus DRNV7-VGMM2-B3G9T-4BF84-VMFTK
goto :GVLKC2R
)
if !_SPD! EQU 1 if !_Mondo! EQU 0 if !_O365ProPlus! EQU 0 (
echo SharePoint Designer 2013 App -^> Mondo 2013 Licenses
call :Ins15Lic Mondo
goto :GVLKC2R
)
if !_ProPlus! EQU 1 if !_O365ProPlus! EQU 0 (
echo ProPlus 2013 Suite
call :Ins15Lic ProPlus
)
if !_Professional! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus! EQU 0 (
echo Professional 2013 Suite -^> ProPlus 2013 Licenses
call :Ins15Lic ProPlus
)
if !_Standard! EQU 1 if !_O365ProPlus! EQU 0 if !_ProPlus! EQU 0 if !_Professional! EQU 0 (
echo Standard 2013 Suite
call :Ins15Lic Standard
)
for %%a in (ProjectPro,VisioPro,ProjectStd,VisioStd) do if !_%%a! EQU 1 (
echo %%a 2013 SKU
call :Ins15Lic %%a
)
for %%a in (HomeBusiness,HomeStudent) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus! EQU 0 if !_Professional! EQU 0 if !_Standard! EQU 0 (
  set _Standard=1
  echo %%a 2013 Suite -^> Standard 2013 Licenses
  call :Ins15Lic Standard
  )
)
for %%a in (%_A15Ids%) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus! EQU 0 if !_Professional! EQU 0 if !_Standard! EQU 0 (
  echo %%a 2013 App
  call :Ins15Lic %%a
  )
)
for %%a in (Access) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus! EQU 0 if !_Professional! EQU 0 (
  echo %%a 2013 App
  call :Ins15Lic %%a
  )
)
for %%a in (Lync) do if !_%%a! EQU 1 (
if !_O365ProPlus! EQU 0 if !_ProPlus! EQU 0 (
  echo SkypeforBusiness 2015 App
  call :Ins15Lic %%a
  )
)
goto :GVLKC2R

:InsLic
set "_ID=%1Volume"
set "_patt=%1VL_"
set "_pkey="
set "_kpey="
if not "%2"=="" (
set "_ID=%1Retail"
set "_patt=%1R_"
set "_pkey=PidKey=%2"
set "_kpey=%2"
)
reg delete %_Config% /f /v %_ID%.OSPPReady %_Nul3%
"!_Integrator!" /I /License PRIDName=%_ID%.16 %_pkey% PackageGUID="%_GUID%" PackageRoot="!_InstallRoot!" %_Nul1%

set fallback=0
set "_qr=wmic path %_spp% where ApplicationID='%_oApp%' get LicenseFamily"
if %WMI_VBS% NEQ 0 set "_qr=%_csq% %_spp% "ApplicationID='%_oApp%'" LicenseFamily"
%_qr% %_Nul2% | find /i "%_patt%" %_Nul1% || (set fallback=1)
if %fallback% equ 0 goto :IntOK

set "_lsfs="
for %%# in ("!_LicensesPath!\%_patt%*.xrm-ms") do (
set "_lsfs=!_lsfs! %%~nx#"
)
if defined _kpey (
  for %%# in ("!_LicensesPath!\%1DemoR*.xrm-ms") do (
  set "_lsfs=!_lsfs! %%~nx#"
  )
  for %%# in ("!_LicensesPath!\%1E5R*.xrm-ms") do (
  set "_lsfs=!_lsfs! %%~nx#"
  )
  for %%# in ("!_LicensesPath!\%1EDUR*.xrm-ms") do (
  set "_lsfs=!_lsfs! %%~nx#"
  )
  for %%# in ("!_LicensesPath!\%1MSDNR*.xrm-ms") do (
  set "_lsfs=!_lsfs! %%~nx#"
  )
  for %%# in ("!_LicensesPath!\%1O365R*.xrm-ms") do (
  set "_lsfs=!_lsfs! %%~nx#"
  )
  for %%# in ("!_LicensesPath!\%1CO365R*.xrm-ms") do (
  set "_lsfs=!_lsfs! %%~nx#"
  )
)
for %%# in (!_lsfs!) do (
%_cscript% %_vbsf%"!_LicensesPath!\%%#"
)
set "_qr=wmic path %_sps% where Version='%_wmi%' call InstallProductKey ProductKey="%_kpey%""
if %WMI_VBS% NEQ 0 set "_qr=%_csp% %_sps% "%_kpey%""
if defined _kpey %_qr% %_Nul3%

:IntOK
reg add %_Config% /f /v %_ID%.OSPPReady /t REG_SZ /d 1 %_Nul1%
reg query %_Config% /v ProductReleaseIds | findstr /I "%_ID%" %_Nul1%
if %errorlevel% NEQ 0 (
for /f "skip=2 tokens=2*" %%a in ('reg query %_Config% /v ProductReleaseIds') do reg add %_Config% /v ProductReleaseIds /t REG_SZ /d "%%b,%_ID%" /f %_Nul1%
)
exit /b

:Ins15Lic
set "_ID=%1Volume"
set "_patt=%1VL_"
set "_pkey="
if not "%2"=="" (
set "_ID=%1Retail"
set "_patt=%1R_"
set "_pkey=%2"
)
reg delete %_OSPP15Ready% /f /v %_ID%.OSPPReady %_Nul3%
for %%# in ("!_Licenses15Path!\%_patt%*.xrm-ms") do (
%_cscript% %_vbsi%"!_Licenses15Path!\%%~nx#"
)
set "_qr=wmic path %_sps% where Version='%_wmi%' call InstallProductKey ProductKey="%_pkey%""
if %WMI_VBS% NEQ 0 set "_qr=%_csp% %_sps% "%_pkey%""
if defined _pkey %_qr% %_Nul3%
reg add %_OSPP15Ready% /f /v %_ID%.OSPPReady /t %_OSPP15ReadT% /d 1 %_Nul1%
reg query %_Con15fig% %_Nul2% | findstr /I "%_ID%" %_Nul1%
if %errorlevel% NEQ 0 (
for /f "skip=2 tokens=2*" %%a in ('reg query %_Con15fig% %_Nul6%') do reg add %_Con15fig% /t REG_SZ /d "%%b,%_ID%" /f %_Nul1%
)
exit /b

:GVLKC2R
set _CtRMsg=0
if %_C16Msg% EQU 1 set _CtRMsg=1
if %_C15Msg% EQU 1 set _CtRMsg=1
if %_Office16% EQU 1 (
for %%a in (%_RetIds%,ProPlus) do set "_%%a="
)
if %_Office15% EQU 1 (
for %%a in (%_R15Ids%,ProPlus) do set "_%%a="
)
set "_qr=wmic path %_sps% where version='%_wmi%' call RefreshLicenseStatus"
if %WMI_VBS% NEQ 0 set "_qr=%_csm% "%_sps%.Version='%_wmi%'" RefreshLicenseStatus"
if %winbuild% GEQ 9200 %_qr% %_Nul3%
if exist "%SysPath%\spp\store_test\2.0\tokens.dat" if %rancopp% EQU 1 if %_CtRMsg% EQU 1 (
%_cscript% %_SLMGR% /rilc
if !ERRORLEVEL! NEQ 0 %_cscript% %_SLMGR% /rilc
)
goto :%_sC2R%

:keys
if "%~1"=="" exit /b
set yh=-
goto :%1 %_Nul2%

:: Windows 11 [Ni]
:59eb965c-9150-42b7-a0ec-22151b9897c5
set "_key=KBN8V%yh%HFGQ4%yh%MGXVD%yh%347P6%yh%PDQGT" &:: IoT Enterprise LTSC
exit /b

:: Windows 11 [Co]
:ca7df2e3-5ea0-47b8-9ac1-b1be4d8edd69
set "_key=37D7F%yh%N49CB%yh%WQR8W%yh%TBJ73%yh%FM8RX" &:: SE {Cloud}
exit /b

:d30136fc-cb4b-416e-a23d-87207abc44a9
set "_key=6XN7V%yh%PCBDC%yh%BDBRH%yh%8DQY7%yh%G6R44" &:: SE N {Cloud N}
exit /b

:: Windows 10 [RS5]
:32d2fab3-e4a8-42c2-923b-4bf4fd13e6ee
set "_key=M7XTQ%yh%FN8P6%yh%TTKYV%yh%9D4CC%yh%J462D" &:: Enterprise LTSC 2019
exit /b

:7103a333-b8c8-49cc-93ce-d37c09687f92
set "_key=92NFX%yh%8DJQP%yh%P6BBQ%yh%THF9C%yh%7CG2H" &:: Enterprise LTSC 2019 N
exit /b

:ec868e65-fadf-4759-b23e-93fe37f2cc29
set "_key=CPWHC%yh%NT2C7%yh%VYW78%yh%DHDB2%yh%PG3GK" &:: Enterprise for Virtual Desktops
exit /b

:0df4f814-3f57-4b8b-9a9d-fddadcd69fac
set "_key=NBTWJ%yh%3DR69%yh%3C4V8%yh%C26MC%yh%GQ9M6" &:: Lean
exit /b

:: Windows 10 [RS3]
:82bbc092-bc50-4e16-8e18-b74fc486aec3
set "_key=NRG8B%yh%VKK3Q%yh%CXVCJ%yh%9G2XF%yh%6Q84J" &:: Pro Workstation
exit /b

:4b1571d3-bafb-4b40-8087-a961be2caf65
set "_key=9FNHH%yh%K3HBT%yh%3W4TD%yh%6383H%yh%6XYWF" &:: Pro Workstation N
exit /b

:e4db50ea-bda1-4566-b047-0ca50abc6f07
set "_key=7NBT4%yh%WGBQX%yh%MP4H7%yh%QXFF8%yh%YP3KX" &:: Enterprise Remote Server
exit /b

:: Windows 10 [RS2]
:e0b2d383-d112-413f-8a80-97f373a5820c
set "_key=YYVX9%yh%NTFWV%yh%6MDM3%yh%9PT4T%yh%4M68B" &:: Enterprise G
exit /b

:e38454fb-41a4-4f59-a5dc-25080e354730
set "_key=44RPN%yh%FTY23%yh%9VTTB%yh%MP9BX%yh%T84FV" &:: Enterprise G N
exit /b

:: Windows 10 [RS1]
:2d5a5a60-3040-48bf-beb0-fcd770c20ce0
set "_key=DCPHK%yh%NFMTC%yh%H88MJ%yh%PFHPY%yh%QJ4BJ" &:: Enterprise 2016 LTSB
exit /b

:9f776d83-7156-45b2-8a5c-359b9c9f22a3
set "_key=QFFDN%yh%GRT3P%yh%VKWWX%yh%X7T3R%yh%8B639" &:: Enterprise 2016 LTSB N
exit /b

:3f1afc82-f8ac-4f6c-8005-1d233e606eee
set "_key=6TP4R%yh%GNPTD%yh%KYYHQ%yh%7B7DP%yh%J447Y" &:: Pro Education
exit /b

:5300b18c-2e33-4dc2-8291-47ffcec746dd
set "_key=YVWGF%yh%BXNMC%yh%HTQYQ%yh%CPQ99%yh%66QFC" &:: Pro Education N
exit /b

:: Windows 10 [TH]
:58e97c99-f377-4ef1-81d5-4ad5522b5fd8
set "_key=TX9XD%yh%98N7V%yh%6WMQ6%yh%BX7FG%yh%H8Q99" &:: Home
exit /b

:7b9e1751-a8da-4f75-9560-5fadfe3d8e38
set "_key=3KHY7%yh%WNT83%yh%DGQKR%yh%F7HPR%yh%844BM" &:: Home N
exit /b

:cd918a57-a41b-4c82-8dce-1a538e221a83
set "_key=7HNRX%yh%D7KGG%yh%3K4RQ%yh%4WPJ4%yh%YTDFH" &:: Home Single Language
exit /b

:a9107544-f4a0-4053-a96a-1479abdef912
set "_key=PVMJN%yh%6DFY6%yh%9CCP6%yh%7BKTT%yh%D3WVR" &:: Home China
exit /b

:2de67392-b7a7-462a-b1ca-108dd189f588
set "_key=W269N%yh%WFGWX%yh%YVC9B%yh%4J6C9%yh%T83GX" &:: Pro
exit /b

:a80b5abf-76ad-428b-b05d-a47d2dffeebf
set "_key=MH37W%yh%N47XK%yh%V7XM9%yh%C7227%yh%GCQG9" &:: Pro N
exit /b

:e0c42288-980c-4788-a014-c080d2e1926e
set "_key=NW6C2%yh%QMPVW%yh%D7KKK%yh%3GKT6%yh%VCFB2" &:: Education
exit /b

:3c102355-d027-42c6-ad23-2e7ef8a02585
set "_key=2WH4N%yh%8QGBV%yh%H22JP%yh%CT43Q%yh%MDWWJ" &:: Education N
exit /b

:73111121-5638-40f6-bc11-f1d7b0d64300
set "_key=NPPR9%yh%FWDCX%yh%D2C8J%yh%H872K%yh%2YT43" &:: Enterprise
exit /b

:e272e3e2-732f-4c65-a8f0-484747d0d947
set "_key=DPH2V%yh%TTNVB%yh%4X9Q3%yh%TJR4H%yh%KHJW4" &:: Enterprise N
exit /b

:7b51a46c-0c04-4e8f-9af4-8496cca90d5e
set "_key=WNMTR%yh%4C88C%yh%JK8YV%yh%HQ7T2%yh%76DF9" &:: Enterprise 2015 LTSB
exit /b

:87b838b7-41b6-4590-8318-5797951d8529
set "_key=2F77B%yh%TNFGY%yh%69QQF%yh%B8YKP%yh%D69TJ" &:: Enterprise 2015 LTSB N
exit /b

:: Windows Server 2022 [Fe]
:9bd77860-9b31-4b7b-96ad-2564017315bf
set "_key=VDYBN%yh%27WPP%yh%V4HQT%yh%9VMD4%yh%VMK7H" &:: Standard
exit /b

:ef6cfc9f-8c5d-44ac-9aad-de6a2ea0ae03
set "_key=WX4NM%yh%KYWYW%yh%QJJR4%yh%XV3QB%yh%6VM33" &:: Datacenter
exit /b

:8c8f0ad3-9a43-4e05-b840-93b8d1475cbc
set "_key=6N379%yh%GGTMK%yh%23C6M%yh%XVVTC%yh%CKFRQ" &:: Azure Core
exit /b

:f5e9429c-f50b-4b98-b15c-ef92eb5cff39
set "_key=67KN8%yh%4FYJW%yh%2487Q%yh%MQ2J7%yh%4C4RG" &:: Standard ACor
exit /b

:39e69c41-42b4-4a0a-abad-8e3c10a797cc
set "_key=QFND9%yh%D3Y9C%yh%J3KKY%yh%6RPVP%yh%2DPYV" &:: Datacenter ACor
exit /b

:: Windows Server 2019 [RS5]
:de32eafd-aaee-4662-9444-c1befb41bde2
set "_key=N69G4%yh%B89J2%yh%4G8F4%yh%WWYCC%yh%J464C" &:: Standard
exit /b

:34e1ae55-27f8-4950-8877-7a03be5fb181
set "_key=WMDGN%yh%G9PQG%yh%XVVXX%yh%R3X43%yh%63DFG" &:: Datacenter
exit /b

:a99cc1f0-7719-4306-9645-294102fbff95
set "_key=FDNH6%yh%VW9RW%yh%BXPJ7%yh%4XTYG%yh%239TB" &:: Azure Core
exit /b

:73e3957c-fc0c-400d-9184-5f7b6f2eb409
set "_key=N2KJX%yh%J94YW%yh%TQVFB%yh%DG9YT%yh%724CC" &:: Standard ACor
exit /b

:90c362e5-0da1-4bfd-b53b-b87d309ade43
set "_key=6NMRW%yh%2C8FM%yh%D24W7%yh%TQWMY%yh%CWH2D" &:: Datacenter ACor
exit /b

:034d3cbb-5d4b-4245-b3f8-f84571314078
set "_key=WVDHN%yh%86M7X%yh%466P6%yh%VHXV7%yh%YY726" &:: Essentials
exit /b

:8de8eb62-bbe0-40ac-ac17-f75595071ea3
set "_key=GRFBW%yh%QNDC4%yh%6QBHG%yh%CCK3B%yh%2PR88" &:: ServerARM64
exit /b

:19b5e0fb-4431-46bc-bac1-2f1873e4ae73
set "_key=NTBV8%yh%9K7Q8%yh%V27C6%yh%M2BTV%yh%KHMXV" &:: Azure Datacenter - ServerTurbine
exit /b

:: Windows Server 2016 [RS4]
:43d9af6e-5e86-4be8-a797-d072a046896c
set "_key=K9FYF%yh%G6NCK%yh%73M32%yh%XMVPY%yh%F9DRR" &:: ServerARM64
exit /b

:: Windows Server 2016 [RS3]
:61c5ef22-f14f-4553-a824-c4b31e84b100
set "_key=PTXN8%yh%JFHJM%yh%4WC78%yh%MPCBR%yh%9W4KR" &:: Standard ACor
exit /b

:e49c08e7-da82-42f8-bde2-b570fbcae76c
set "_key=2HXDN%yh%KRXHB%yh%GPYC7%yh%YCKFJ%yh%7FVDG" &:: Datacenter ACor
exit /b

:: Windows Server 2016 [RS1]
:8c1c5410-9f39-4805-8c9d-63a07706358f
set "_key=WC2BQ%yh%8NRM3%yh%FDDYY%yh%2BFGV%yh%KHKQY" &:: Standard
exit /b

:21c56779-b449-4d20-adfc-eece0e1ad74b
set "_key=CB7KF%yh%BWN84%yh%R7R2Y%yh%793K2%yh%8XDDG" &:: Datacenter
exit /b

:3dbf341b-5f6c-4fa7-b936-699dce9e263f
set "_key=VP34G%yh%4NPPG%yh%79JTQ%yh%864T4%yh%R3MQX" &:: Azure Core
exit /b

:2b5a1b0f-a5ab-4c54-ac2f-a6d94824a283
set "_key=JCKRF%yh%N37P4%yh%C2D82%yh%9YXRT%yh%4M63B" &:: Essentials
exit /b

:7b4433f4-b1e7-4788-895a-c45378d38253
set "_key=QN4C6%yh%GBJD2%yh%FB422%yh%GHWJK%yh%GJG2R" &:: Cloud Storage
exit /b

:: Windows 8.1
:fe1c3238-432a-43a1-8e25-97e7d1ef10f3
set "_key=M9Q9P%yh%WNJJT%yh%6PXPY%yh%DWX8H%yh%6XWKK" &:: Core
exit /b

:78558a64-dc19-43fe-a0d0-8075b2a370a3
set "_key=7B9N3%yh%D94CG%yh%YTVHR%yh%QBPX3%yh%RJP64" &:: Core N
exit /b

:c72c6a1d-f252-4e7e-bdd1-3fca342acb35
set "_key=BB6NG%yh%PQ82V%yh%VRDPW%yh%8XVD2%yh%V8P66" &:: Core Single Language
exit /b

:db78b74f-ef1c-4892-abfe-1e66b8231df6
set "_key=NCTT7%yh%2RGK8%yh%WMHRF%yh%RY7YQ%yh%JTXG3" &:: Core China
exit /b

:ffee456a-cd87-4390-8e07-16146c672fd0
set "_key=XYTND%yh%K6QKT%yh%K2MRH%yh%66RTM%yh%43JKP" &:: Core ARM
exit /b

:c06b6981-d7fd-4a35-b7b4-054742b7af67
set "_key=GCRJD%yh%8NW9H%yh%F2CDX%yh%CCM8D%yh%9D6T9" &:: Pro
exit /b

:7476d79f-8e48-49b4-ab63-4d0b813a16e4
set "_key=HMCNV%yh%VVBFX%yh%7HMBH%yh%CTY9B%yh%B4FXY" &:: Pro N
exit /b

:096ce63d-4fac-48a9-82a9-61ae9e800e5f
set "_key=789NJ%yh%TQK6T%yh%6XTH8%yh%J39CJ%yh%J8D3P" &:: Pro with Media Center
exit /b

:81671aaf-79d1-4eb1-b004-8cbbe173afea
set "_key=MHF9N%yh%XY6XB%yh%WVXMC%yh%BTDCT%yh%MKKG7" &:: Enterprise
exit /b

:113e705c-fa49-48a4-beea-7dd879b46b14
set "_key=TT4HM%yh%HN7YT%yh%62K67%yh%RGRQJ%yh%JFFXW" &:: Enterprise N
exit /b

:0ab82d54-47f4-4acb-818c-cc5bf0ecb649
set "_key=NMMPB%yh%38DD4%yh%R2823%yh%62W8D%yh%VXKJB" &:: Embedded Industry Pro
exit /b

:cd4e2d9f-5059-4a50-a92d-05d5bb1267c7
set "_key=FNFKF%yh%PWTVT%yh%9RC8H%yh%32HB2%yh%JB34X" &:: Embedded Industry Enterprise
exit /b

:f7e88590-dfc7-4c78-bccb-6f3865b99d1a
set "_key=VHXM3%yh%NR6FT%yh%RY6RT%yh%CK882%yh%KW2CJ" &:: Embedded Industry Automotive
exit /b

:e9942b32-2e55-4197-b0bd-5ff58cba8860
set "_key=3PY8R%yh%QHNP9%yh%W7XQD%yh%G6DPH%yh%3J2C9" &:: with Bing
exit /b

:c6ddecd6-2354-4c19-909b-306a3058484e
set "_key=Q6HTR%yh%N24GM%yh%PMJFP%yh%69CD8%yh%2GXKR" &:: with Bing N
exit /b

:b8f5e3a3-ed33-4608-81e1-37d6c9dcfd9c
set "_key=KF37N%yh%VDV38%yh%GRRTV%yh%XH8X6%yh%6F3BB" &:: with Bing Single Language
exit /b

:ba998212-460a-44db-bfb5-71bf09d1c68b
set "_key=R962J%yh%37N87%yh%9VVK2%yh%WJ74P%yh%XTMHR" &:: with Bing China
exit /b

:e58d87b5-8126-4580-80fb-861b22f79296
set "_key=MX3RK%yh%9HNGX%yh%K3QKC%yh%6PJ3F%yh%W8D7B" &:: Pro for Students
exit /b

:cab491c7-a918-4f60-b502-dab75e334f40
set "_key=TNFGH%yh%2R6PB%yh%8XM3K%yh%QYHX2%yh%J4296" &:: Pro for Students N
exit /b

:: Windows Server 2012 R2
:b3ca044e-a358-4d68-9883-aaa2941aca99
set "_key=D2N9P%yh%3P6X9%yh%2R39C%yh%7RTCD%yh%MDVJX" &:: Standard
exit /b

:00091344-1ea4-4f37-b789-01750ba6988c
set "_key=W3GGN%yh%FT8W3%yh%Y4M27%yh%J84CP%yh%Q3VJ9" &:: Datacenter
exit /b

:21db6ba4-9a7b-4a14-9e29-64a60c59301d
set "_key=KNC87%yh%3J2TX%yh%XB4WP%yh%VCPJV%yh%M4FWM" &:: Essentials
exit /b

:b743a2be-68d4-4dd3-af32-92425b7bb623
set "_key=3NPTF%yh%33KPT%yh%GGBPR%yh%YX76B%yh%39KDD" &:: Cloud Storage
exit /b

:: Windows 8
:c04ed6bf-55c8-4b47-9f8e-5a1f31ceee60
set "_key=BN3D2%yh%R7TKB%yh%3YPBD%yh%8DRP2%yh%27GG4" &:: Core
exit /b

:197390a0-65f6-4a95-bdc4-55d58a3b0253
set "_key=8N2M2%yh%HWPGY%yh%7PGT9%yh%HGDD8%yh%GVGGY" &:: Core N
exit /b

:8860fcd4-a77b-4a20-9045-a150ff11d609
set "_key=2WN2H%yh%YGCQR%yh%KFX6K%yh%CD6TF%yh%84YXQ" &:: Core Single Language
exit /b

:9d5584a2-2d85-419a-982c-a00888bb9ddf
set "_key=4K36P%yh%JN4VD%yh%GDC6V%yh%KDT89%yh%DYFKP" &:: Core China
exit /b

:af35d7b7-5035-4b63-8972-f0b747b9f4dc
set "_key=DXHJF%yh%N9KQX%yh%MFPVR%yh%GHGQK%yh%Y7RKV" &:: Core ARM
exit /b

:a98bcd6d-5343-4603-8afe-5908e4611112
set "_key=NG4HW%yh%VH26C%yh%733KW%yh%K6F98%yh%J8CK4" &:: Pro
exit /b

:ebf245c1-29a8-4daf-9cb1-38dfc608a8c8
set "_key=XCVCF%yh%2NXM9%yh%723PB%yh%MHCB7%yh%2RYQQ" &:: Pro N
exit /b

:a00018a3-f20f-4632-bf7c-8daa5351c914
set "_key=GNBB8%yh%YVD74%yh%QJHX6%yh%27H4K%yh%8QHDG" &:: Pro with Media Center
exit /b

:458e1bec-837a-45f6-b9d5-925ed5d299de
set "_key=32JNW%yh%9KQ84%yh%P47T8%yh%D8GGY%yh%CWCK7" &:: Enterprise
exit /b

:e14997e7-800a-4cf7-ad10-de4b45b578db
set "_key=JMNMF%yh%RHW7P%yh%DMY6X%yh%RF3DR%yh%X2BQT" &:: Enterprise N
exit /b

:10018baf-ce21-4060-80bd-47fe74ed4dab
set "_key=RYXVT%yh%BNQG7%yh%VD29F%yh%DBMRY%yh%HT73M" &:: Embedded Industry Pro
exit /b

:18db1848-12e0-4167-b9d7-da7fcda507db
set "_key=NKB3R%yh%R2F8T%yh%3XCDP%yh%7Q2KW%yh%XWYQ2" &:: Embedded Industry Enterprise
exit /b

:: Windows Server 2012
:f0f5ec41-0d55-4732-af02-440a44a3cf0f
set "_key=XC9B7%yh%NBPP2%yh%83J2H%yh%RHMBY%yh%92BT4" &:: Standard
exit /b

:d3643d60-0c42-412d-a7d6-52e6635327f6
set "_key=48HP8%yh%DN98B%yh%MYWDG%yh%T2DCC%yh%8W83P" &:: Datacenter
exit /b

:7d5486c7-e120-4771-b7f1-7b56c6d3170c
set "_key=HM7DN%yh%YVMH3%yh%46JC3%yh%XYTG7%yh%CYQJJ" &:: MultiPoint Standard
exit /b

:95fd1c83-7df5-494a-be8b-1300e1c9d1cd
set "_key=XNH6W%yh%2V9GX%yh%RGJ4K%yh%Y8X6F%yh%QGJ2G" &:: MultiPoint Premium
exit /b

:: Windows 7
:b92e9980-b9d5-4821-9c94-140f632f6312
set "_key=FJ82H%yh%XT6CR%yh%J8D7P%yh%XQJJ2%yh%GPDD4" &:: Professional
exit /b

:54a09a0d-d57b-4c10-8b69-a842d6590ad5
set "_key=MRPKT%yh%YTG23%yh%K7D7T%yh%X2JMM%yh%QY7MG" &:: Professional N
exit /b

:5a041529-fef8-4d07-b06f-b59b573b32d2
set "_key=W82YF%yh%2Q76Y%yh%63HXB%yh%FGJG9%yh%GF7QX" &:: Professional E
exit /b

:ae2ee509-1b34-41c0-acb7-6d4650168915
set "_key=33PXH%yh%7Y6KF%yh%2VJC9%yh%XBBR8%yh%HVTHH" &:: Enterprise
exit /b

:1cb6d605-11b3-4e14-bb30-da91c8e3983a
set "_key=YDRBP%yh%3D83W%yh%TY26F%yh%D46B2%yh%XCKRJ" &:: Enterprise N
exit /b

:46bbed08-9c7b-48fc-a614-95250573f4ea
set "_key=C29WB%yh%22CC8%yh%VJ326%yh%GHFJW%yh%H9DH4" &:: Enterprise E
exit /b

:db537896-376f-48ae-a492-53d0547773d0
set "_key=YBYF6%yh%BHCR3%yh%JPKRB%yh%CDW7B%yh%F9BK4" &:: Embedded POSReady 7
exit /b

:e1a8296a-db37-44d1-8cce-7bc961d59c54
set "_key=XGY72%yh%BRBBT%yh%FF8MH%yh%2GG8H%yh%W7KCW" &:: Embedded Standard
exit /b

:aa6dd3aa-c2b4-40e2-a544-a6bbb3f5c395
set "_key=73KQT%yh%CD9G6%yh%K7TQG%yh%66MRP%yh%CQ22C" &:: Embedded ThinPC
exit /b

:: Windows Server 2008 R2
:a78b8bd9-8017-4df5-b86a-09f756affa7c
set "_key=6TPJF%yh%RBVHG%yh%WBW2R%yh%86QPH%yh%6RTM4" &:: Web
exit /b

:cda18cf3-c196-46ad-b289-60c072869994
set "_key=TT8MH%yh%CG224%yh%D3D7Q%yh%498W2%yh%9QCTX" &:: HPC
exit /b

:68531fb9-5511-4989-97be-d11a0f55633f
set "_key=YC6KT%yh%GKW9T%yh%YTKYR%yh%T4X34%yh%R7VHC" &:: Standard
exit /b

:7482e61b-c589-4b7f-8ecc-46d455ac3b87
set "_key=74YFP%yh%3QFB3%yh%KQT8W%yh%PMXWJ%yh%7M648" &:: Datacenter
exit /b

:620e2b3d-09e7-42fd-802a-17a13652fe7a
set "_key=489J6%yh%VHDMP%yh%X63PK%yh%3K798%yh%CPX3Y" &:: Enterprise
exit /b

:8a26851c-1c7e-48d3-a687-fbca9b9ac16b
set "_key=GT63C%yh%RJFQ3%yh%4GMB6%yh%BRFB9%yh%CB83V" &:: Itanium
exit /b

:f772515c-0e87-48d5-a676-e6962c3e1195
set "_key=736RG%yh%XDKJK%yh%V34PF%yh%BHK87%yh%J6X3K" &:: MultiPoint Server - ServerEmbeddedSolution
exit /b

:: Office 2021
:fbdb3e18-a8ef-4fb3-9183-dffd60bd0984
set "_key=FXYTK%yh%NJJ8C%yh%GB6DW%yh%3DYQT%yh%6F7TH" &:: Professional Plus
exit /b

:080a45c5-9f9f-49eb-b4b0-c3c610a5ebd3
set "_key=KDX7X%yh%BNVR8%yh%TXXGX%yh%4Q7Y8%yh%78VT3" &:: Standard
exit /b

:76881159-155c-43e0-9db7-2d70a9a3a4ca
set "_key=FTNWT%yh%C6WBT%yh%8HMGF%yh%K9PRX%yh%QV9H8" &:: Project Professional
exit /b

:6dd72704-f752-4b71-94c7-11cec6bfc355
set "_key=J2JDC%yh%NJCYY%yh%9RGQ4%yh%YXWMH%yh%T3D4T" &:: Project Standard
exit /b

:fb61ac9a-1688-45d2-8f6b-0674dbffa33c
set "_key=KNH8D%yh%FGHT4%yh%T8RK3%yh%CTDYJ%yh%K2HT4" &:: Visio Professional
exit /b

:72fce797-1884-48dd-a860-b2f6a5efd3ca
set "_key=MJVNY%yh%BYWPY%yh%CWV6J%yh%2RKRT%yh%4M8QG" &:: Visio Standard
exit /b

:1fe429d8-3fa7-4a39-b6f0-03dded42fe14
set "_key=WM8YG%yh%YNGDD%yh%4JHDC%yh%PG3F4%yh%FC4T4" &:: Access
exit /b

:ea71effc-69f1-4925-9991-2f5e319bbc24
set "_key=NWG3X%yh%87C9K%yh%TC7YY%yh%BC2G7%yh%G6RVC" &:: Excel
exit /b

:a5799e4c-f83c-4c6e-9516-dfe9b696150b
set "_key=C9FM6%yh%3N72F%yh%HFJXB%yh%TM3V9%yh%T86R9" &:: Outlook
exit /b

:6e166cc3-495d-438a-89e7-d7c9e6fd4dea
set "_key=TY7XF%yh%NFRBR%yh%KJ44C%yh%G83KF%yh%GX27K" &:: PowerPoint
exit /b

:aa66521f-2370-4ad8-a2bb-c095e3e4338f
set "_key=2MW9D%yh%N4BXM%yh%9VBPG%yh%Q7W6M%yh%KFBGQ" &:: Publisher
exit /b

:1f32a9af-1274-48bd-ba1e-1ab7508a23e8
set "_key=HWCXN%yh%K3WBT%yh%WJBKY%yh%R8BD9%yh%XK29P" &:: Skype for Business
exit /b

:abe28aea-625a-43b1-8e30-225eb8fbd9e5
set "_key=TN8H9%yh%M34D3%yh%Y64V9%yh%TR72V%yh%X79KV" &:: Word
exit /b

:: Office 2019
:85dd8b5f-eaa4-4af3-a628-cce9e77c9a03
set "_key=NMMKJ%yh%6RK4F%yh%KMJVX%yh%8D9MJ%yh%6MWKP" &:: Professional Plus
exit /b

:6912a74b-a5fb-401a-bfdb-2e3ab46f4b02
set "_key=6NWWJ%yh%YQWMR%yh%QKGCB%yh%6TMB3%yh%9D9HK" &:: Standard
exit /b

:2ca2bf3f-949e-446a-82c7-e25a15ec78c4
set "_key=B4NPR%yh%3FKK7%yh%T2MBV%yh%FRQ4W%yh%PKD2B" &:: Project Professional
exit /b

:1777f0e3-7392-4198-97ea-8ae4de6f6381
set "_key=C4F7P%yh%NCP8C%yh%6CQPT%yh%MQHV9%yh%JXD2M" &:: Project Standard
exit /b

:5b5cf08f-b81a-431d-b080-3450d8620565
set "_key=9BGNQ%yh%K37YR%yh%RQHF2%yh%38RQ3%yh%7VCBB" &:: Visio Professional
exit /b

:e06d7df3-aad0-419d-8dfb-0ac37e2bdf39
set "_key=7TQNQ%yh%K3YQQ%yh%3PFH7%yh%CCPPM%yh%X4VQ2" &:: Visio Standard
exit /b

:9e9bceeb-e736-4f26-88de-763f87dcc485
set "_key=9N9PT%yh%27V4Y%yh%VJ2PD%yh%YXFMF%yh%YTFQT" &:: Access
exit /b

:237854e9-79fc-4497-a0c1-a70969691c6b
set "_key=TMJWT%yh%YYNMB%yh%3BKTF%yh%644FC%yh%RVXBD" &:: Excel
exit /b

:c8f8a301-19f5-4132-96ce-2de9d4adbd33
set "_key=7HD7K%yh%N4PVK%yh%BHBCQ%yh%YWQRW%yh%XW4VK" &:: Outlook
exit /b

:3131fd61-5e4f-4308-8d6d-62be1987c92c
set "_key=RRNCX%yh%C64HY%yh%W2MM7%yh%MCH9G%yh%TJHMQ" &:: PowerPoint
exit /b

:9d3e4cca-e172-46f1-a2f4-1d2107051444
set "_key=G2KWX%yh%3NW6P%yh%PY93R%yh%JXK2T%yh%C9Y9V" &:: Publisher
exit /b

:734c6c6e-b0ba-4298-a891-671772b2bd1b
set "_key=NCJ33%yh%JHBBY%yh%HTK98%yh%MYCV8%yh%HMKHJ" &:: Skype for Business
exit /b

:059834fe-a8ea-4bff-b67b-4d006b5447d3
set "_key=PBX3G%yh%NWMT6%yh%Q7XBW%yh%PYJGG%yh%WXD33" &:: Word
exit /b

:0bc88885-718c-491d-921f-6f214349e79c
set "_key=VQ9DP%yh%NVHPH%yh%T9HJC%yh%J9PDT%yh%KTQRG" &:: Pro Plus 2019 Preview
exit /b

:fc7c4d0c-2e85-4bb9-afd4-01ed1476b5e9
set "_key=XM2V9%yh%DN9HH%yh%QB449%yh%XDGKC%yh%W2RMW" &:: Project Pro 2019 Preview
exit /b

:500f6619-ef93-4b75-bcb4-82819998a3ca
set "_key=N2CG9%yh%YD3YK%yh%936X4%yh%3WR82%yh%Q3X4H" &:: Visio Pro 2019 Preview
exit /b

:f3fb2d68-83dd-4c8b-8f09-08e0d950ac3b
set "_key=HFPBN%yh%RYGG8%yh%HQWCW%yh%26CH6%yh%PDPVF" &:: Pro Plus 2021 Preview
exit /b

:76093b1b-7057-49d7-b970-638ebcbfd873
set "_key=WDNBY%yh%PCYFY%yh%9WP6G%yh%BXVXM%yh%92HDV" &:: Project Pro 2021 Preview
exit /b

:a3b44174-2451-4cd6-b25f-66638bfb9046
set "_key=2XYX7%yh%NXXBK%yh%9CK7W%yh%K2TKW%yh%JFJ7G" &:: Visio Pro 2021 Preview
exit /b

:: Office 2016
:829b8110-0e6f-4349-bca4-42803577788d
set "_key=WGT24%yh%HCNMF%yh%FQ7XH%yh%6M8K7%yh%DRTW9" &:: Project Professional C2R-P
exit /b

:cbbaca45-556a-4416-ad03-bda598eaa7c8
set "_key=D8NRQ%yh%JTYM3%yh%7J2DX%yh%646CT%yh%6836M" &:: Project Standard C2R-P
exit /b

:b234abe3-0857-4f9c-b05a-4dc314f85557
set "_key=69WXN%yh%MBYV6%yh%22PQG%yh%3WGHK%yh%RM6XC" &:: Visio Professional C2R-P
exit /b

:361fe620-64f4-41b5-ba77-84f8e079b1f7
set "_key=NY48V%yh%PPYYH%yh%3F4PX%yh%XJRKJ%yh%W4423" &:: Visio Standard C2R-P
exit /b

:e914ea6e-a5fa-4439-a394-a9bb3293ca09
set "_key=DMTCJ%yh%KNRKX%yh%26982%yh%JYCKT%yh%P7KB6" &:: MondoR
exit /b

:9caabccb-61b1-4b4b-8bec-d10a3c3ac2ce
set "_key=HFTND%yh%W9MK4%yh%8B7MJ%yh%B6C4G%yh%XQBR2" &:: Mondo
exit /b

:d450596f-894d-49e0-966a-fd39ed4c4c64
set "_key=XQNVK%yh%8JYDB%yh%WJ9W3%yh%YJ8YR%yh%WFG99" &:: Professional Plus
exit /b

:dedfa23d-6ed1-45a6-85dc-63cae0546de6
set "_key=JNRGM%yh%WHDWX%yh%FJJG3%yh%K47QV%yh%DRTFM" &:: Standard
exit /b

:4f414197-0fc2-4c01-b68a-86cbb9ac254c
set "_key=YG9NW%yh%3K39V%yh%2T3HJ%yh%93F3Q%yh%G83KT" &:: Project Professional
exit /b

:da7ddabc-3fbe-4447-9e01-6ab7440b4cd4
set "_key=GNFHQ%yh%F6YQM%yh%KQDGJ%yh%327XX%yh%KQBVC" &:: Project Standard
exit /b

:6bf301c1-b94a-43e9-ba31-d494598c47fb
set "_key=PD3PC%yh%RHNGV%yh%FXJ29%yh%8JK7D%yh%RJRJK" &:: Visio Professional
exit /b

:aa2a7821-1827-4c2c-8f1d-4513a34dda97
set "_key=7WHWN%yh%4T7MP%yh%G96JF%yh%G33KR%yh%W8GF4" &:: Visio Standard
exit /b

:67c0fc0c-deba-401b-bf8b-9c8ad8395804
set "_key=GNH9Y%yh%D2J4T%yh%FJHGG%yh%QRVH7%yh%QPFDW" &:: Access
exit /b

:c3e65d36-141f-4d2f-a303-a842ee756a29
set "_key=9C2PK%yh%NWTVB%yh%JMPW8%yh%BFT28%yh%7FTBF" &:: Excel
exit /b

:d8cace59-33d2-4ac7-9b1b-9b72339c51c8
set "_key=DR92N%yh%9HTF2%yh%97XKM%yh%XW2WJ%yh%XW3J6" &:: OneNote
exit /b

:ec9d9265-9d1e-4ed0-838a-cdc20f2551a1
set "_key=R69KK%yh%NTPKF%yh%7M3Q4%yh%QYBHW%yh%6MT9B" &:: Outlook
exit /b

:d70b1bba-b893-4544-96e2-b7a318091c33
set "_key=J7MQP%yh%HNJ4Y%yh%WJ7YM%yh%PFYGF%yh%BY6C6" &:: Powerpoint
exit /b

:041a06cb-c5b8-4772-809f-416d03d16654
set "_key=F47MM%yh%N3XJP%yh%TQXJ9%yh%BP99D%yh%8K837" &:: Publisher
exit /b

:83e04ee1-fa8d-436d-8994-d31a862cab77
set "_key=869NQ%yh%FJ69K%yh%466HW%yh%QYCP2%yh%DDBV6" &:: Skype for Business
exit /b

:bb11badf-d8aa-470e-9311-20eaf80fe5cc
set "_key=WXY84%yh%JN2Q9%yh%RBCCQ%yh%3Q3J3%yh%3PFJ6" &:: Word
exit /b

:: Office 2013
:dc981c6b-fc8e-420f-aa43-f8f33e5c0923
set "_key=42QTK%yh%RN8M7%yh%J3C4G%yh%BBGYM%yh%88CYV" &:: Mondo
exit /b

:b322da9c-a2e2-4058-9e4e-f59a6970bd69
set "_key=YC7DK%yh%G2NP3%yh%2QQC3%yh%J6H88%yh%GVGXT" &:: Professional Plus
exit /b

:b13afb38-cd79-4ae5-9f7f-eed058d750ca
set "_key=KBKQT%yh%2NMXY%yh%JJWGP%yh%M62JB%yh%92CD4" &:: Standard
exit /b

:4a5d124a-e620-44ba-b6ff-658961b33b9a
set "_key=FN8TT%yh%7WMH6%yh%2D4X9%yh%M337T%yh%2342K" &:: Project Professional
exit /b

:427a28d1-d17c-4abf-b717-32c780ba6f07
set "_key=6NTH3%yh%CW976%yh%3G3Y2%yh%JK3TX%yh%8QHTT" &:: Project Standard
exit /b

:e13ac10e-75d0-4aff-a0cd-764982cf541c
set "_key=C2FG9%yh%N6J68%yh%H8BTJ%yh%BW3QX%yh%RM3B3" &:: Visio Professional
exit /b

:ac4efaf0-f81f-4f61-bdf7-ea32b02ab117
set "_key=J484Y%yh%4NKBF%yh%W2HMG%yh%DBMJC%yh%PGWR7" &:: Visio Standard
exit /b

:6ee7622c-18d8-4005-9fb7-92db644a279b
set "_key=NG2JY%yh%H4JBT%yh%HQXYP%yh%78QH9%yh%4JM2D" &:: Access
exit /b

:f7461d52-7c2b-43b2-8744-ea958e0bd09a
set "_key=VGPNG%yh%Y7HQW%yh%9RHP7%yh%TKPV3%yh%BG7GB" &:: Excel
exit /b

:fb4875ec-0c6b-450f-b82b-ab57d8d1677f
set "_key=H7R7V%yh%WPNXQ%yh%WCYYC%yh%76BGV%yh%VT7GH" &:: Groove
exit /b

:a30b8040-d68a-423f-b0b5-9ce292ea5a8f
set "_key=DKT8B%yh%N7VXH%yh%D963P%yh%Q4PHY%yh%F8894" &:: InfoPath
exit /b

:1b9f11e3-c85c-4e1b-bb29-879ad2c909e3
set "_key=2MG3G%yh%3BNTT%yh%3MFW9%yh%KDQW3%yh%TCK7R" &:: Lync
exit /b

:efe1f3e6-aea2-4144-a208-32aa872b6545
set "_key=TGN6P%yh%8MMBC%yh%37P2F%yh%XHXXK%yh%P34VW" &:: OneNote
exit /b

:771c3afa-50c5-443f-b151-ff2546d863a0
set "_key=QPN8Q%yh%BJBTJ%yh%334K3%yh%93TGY%yh%2PMBT" &:: Outlook
exit /b

:8c762649-97d1-4953-ad27-b7e2c25b972e
set "_key=4NT99%yh%8RJFH%yh%Q2VDH%yh%KYG2C%yh%4RD4F" &:: Powerpoint
exit /b

:00c79ff1-6850-443d-bf61-71cde0de305f
set "_key=PN2WF%yh%29XG2%yh%T9HJ7%yh%JQPJR%yh%FCXK4" &:: Publisher
exit /b

:d9f5b1c6-5386-495a-88f9-9ad6b41ac9b3
set "_key=6Q7VD%yh%NX8JD%yh%WJ2VH%yh%88V73%yh%4GBJ7" &:: Word
exit /b

:: Office 2010
:09ed9640-f020-400a-acd8-d7d867dfd9c2
set "_key=YBJTT%yh%JG6MD%yh%V9Q7P%yh%DBKXJ%yh%38W9R" &:: Mondo
exit /b

:ef3d4e49-a53d-4d81-a2b1-2ca6c2556b2c
set "_key=7TC2V%yh%WXF6P%yh%TD7RT%yh%BQRXR%yh%B8K32" &:: Mondo2
exit /b

:6f327760-8c5c-417c-9b61-836a98287e0c
set "_key=VYBBJ%yh%TRJPB%yh%QFQRF%yh%QFT4D%yh%H3GVB" &:: Professional Plus
exit /b

:9da2a678-fb6b-4e67-ab84-60dd6a9c819a
set "_key=V7QKV%yh%4XVVR%yh%XYV4D%yh%F7DFM%yh%8R6BM" &:: Standard
exit /b

:df133ff7-bf14-4f95-afe3-7b48e7e331ef
set "_key=YGX6F%yh%PGV49%yh%PGW3J%yh%9BTGG%yh%VHKC6" &:: Project Professional
exit /b

:5dc7bf61-5ec9-4996-9ccb-df806a2d0efe
set "_key=4HP3K%yh%88W3F%yh%W2K3D%yh%6677X%yh%F9PGB" &:: Project Standard
exit /b

:92236105-bb67-494f-94c7-7f7a607929bd
set "_key=D9DWC%yh%HPYVV%yh%JGF4P%yh%BTWQB%yh%WX8BJ" &:: Visio Premium
exit /b

:e558389c-83c3-4b29-adfe-5e4d7f46c358
set "_key=7MCW8%yh%VRQVK%yh%G677T%yh%PDJCM%yh%Q8TCP" &:: Visio Professional
exit /b

:9ed833ff-4f92-4f36-b370-8683a4f13275
set "_key=767HD%yh%QGMWX%yh%8QTDB%yh%9G3R2%yh%KHFGJ" &:: Visio Standard
exit /b

:8ce7e872-188c-4b98-9d90-f8f90b7aad02
set "_key=V7Y44%yh%9T38C%yh%R2VJK%yh%666HK%yh%T7DDX" &:: Access
exit /b

:cee5d470-6e3b-4fcc-8c2b-d17428568a9f
set "_key=H62QG%yh%HXVKF%yh%PP4HP%yh%66KMR%yh%CW9BM" &:: Excel
exit /b

:8947d0b8-c33b-43e1-8c56-9b674c052832
set "_key=QYYW6%yh%QP4CB%yh%MBV6G%yh%HYMCJ%yh%4T3J4" &:: Groove - SharePoint Workspace
exit /b

:ca6b6639-4ad6-40ae-a575-14dee07f6430
set "_key=K96W8%yh%67RPQ%yh%62T9Y%yh%J8FQJ%yh%BT37T" &:: InfoPath
exit /b

:ab586f5c-5256-4632-962f-fefd8b49e6f4
set "_key=Q4Y4M%yh%RHWJM%yh%PY37F%yh%MTKWH%yh%D3XHX" &:: OneNote
exit /b

:ecb7c192-73ab-4ded-acf4-2399b095d0cc
set "_key=7YDC2%yh%CWM8M%yh%RRTJC%yh%8MDVC%yh%X3DWQ" &:: Outlook
exit /b

:45593b1d-dfb1-4e91-bbfb-2d5d0ce2227a
set "_key=RC8FX%yh%88JRY%yh%3PF7C%yh%X8P67%yh%P4VTT" &:: Powerpoint
exit /b

:b50c4f75-599b-43e8-8dcd-1081a7967241
set "_key=BFK7F%yh%9MYHM%yh%V68C7%yh%DRQ66%yh%83YTP" &:: Publisher
exit /b

:2d0882e7-a4e7-423b-8ccc-70d91e0158b1
set "_key=HVHB3%yh%C6FV7%yh%KQX9W%yh%YQG79%yh%CRY7T" &:: Word
exit /b

:ea509e87-07a1-4a45-9edc-eba5a39f36af
set "_key=D6QFG%yh%VBYP2%yh%XQHM7%yh%J97RH%yh%VVRCK" &:: Small Business Basics
exit /b

:TheEnd

if %act_failed% EQU 1 (
echo ____________________________________________________________________
echo.
call :_errorinfo
)

if not defined _tskinstalled if not defined _oldtsk (
echo.
if %winbuild% GEQ 9200 (
call :leavenonexistentkms %nul%
echo Keeping the non-existent IP address 10.0.0.10 as KMS Server.
) else (
call :Clear-KMS-Cache
)
)

if not [%Act_OK%]==[1] (
echo.
echo In case of any issues, check https://massgrave.dev/troubleshoot
)

if defined _unattended exit /b

echo ____________________________________________________________________
echo.
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b

::========================================================================================================================================

:_errorinfo

call :CheckFR

set _intcon=
for %%a in (l.root-servers.net resolver1.opendns.com download.windowsupdate.com google.com) do if not defined _intcon (
for /f "delims=[] tokens=2" %%# in ('ping -n 1 %%a') do (if not [%%#]==[] set _intcon=1)
)

if not defined _intcon (
call :_color %_Red% "Internet is not connected."
exit /b
)

if [%ERRORCODE%]==[-1073418124] (
echo Checking Port 1688 connection, it may take a while...
echo.

set /a count=0
set _portcon=
for %%a in (%srvlist%) do if not defined _portcon if !count! LEQ 7 (
set /a count+=1
%psc% "$t = New-Object Net.Sockets.TcpClient;try{$t.Connect("""%%a""", 1688)}catch{};$t.Connected" | findstr /i true 1>nul && set _portcon=1
)

if not defined _portcon (
call :_color %Red% "Port 1688 is blocked in your Internet connection."
echo.
echo Reason:   Probably restricted Internet [Office/College] is connected,
echo           or Firewall is blocking the connection.
echo.
echo Solution: Either use another Internet connection or use offline KMS
echo           https://github.com/abbodi1406/KMS_VL_ALL_AIO
) else (
echo Port 1688 connection test is passed.
echo.
echo Make sure system files are not blocked by your firewall.
echo If the issue persists, try offline KMS
echo https://github.com/abbodi1406/KMS_VL_ALL_AIO
)
echo.
)

echo KMS server is not an issue in this case.
exit /b

::========================================================================================================================================

:setserv

::  Multi KMS servers integration and servers randomization

set srvlist=
set -=

set "srvlist=kms.zhu%-%xiaole.org kms-default.cangs%-%hui.net kms.six%-%yin.com kms.moe%-%club.org kms.cgt%-%soft.com"
set "srvlist=%srvlist% kms.id%-%ina.cn kms.moe%-%yuuko.com xinch%-%eng213618.cn kms.wl%-%rxy.cn kms.ca%-%tqu.com"
set "srvlist=%srvlist% kms.0%-%t.net.cn kms.its%-%jzx.com kms.wx%-%lost.com kms.moe%-%yuuko.top kms.gh%-%pym.com"

set n=1
for %%a in (%srvlist%) do (set %%a=&set server!n!=%%a&set /a n+=1)
set max_servers=15
set /a server_num=0
exit /b

:getserv

if %server_num% equ %max_servers% set /a server_num+=1&set KMS_IP=222.184.9.98&exit /b
set /a rand=%Random%%%(15+1-1)+1
if defined !server%rand%! goto :getserv
set KMS_IP=!server%rand%!
set !server%rand%!=1

::  Get IPv4 address of KMS server to use for the activation, works even if ICMP echo is disabled.
::  Microsoft and Antivirus's may flag the issue if public KMS server host name is directly used for the activation.

set /a server_num+=1
(for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %KMS_IP% 2^>nul') do set "KMS_IP=%%a"
if [%KMS_IP%]==[!KMS_IP!] for /f "delims=[] tokens=2" %%# in ('pathping -4 -h 1 -n -p 1 -q 1 -w 1 %KMS_IP% 2^>nul') do set "KMS_IP=%%#"
if not [%KMS_IP%]==[!KMS_IP!] exit /b
goto :getserv
)

:==========================================================================================================================================

:Clear-KMS-Cache

set OPPk=SOFTWARE\Microsoft\OfficeSoftwareProtectionPlatform
set SPPk=SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform

set _wApp=55c92734-d682-4d71-983e-d6ec3f16059f
set _oApp=0ff1ce15-a989-479d-af46-f275c6370663
set _oA14=59a52881-a989-479d-af46-f275c6370663

%nul% reg delete "HKLM\%SPPk%" /f /v KeyManagementServiceName
%nul% reg delete "HKLM\%SPPk%" /f /v KeyManagementServicePort
%nul% reg delete "HKLM\%SPPk%" /f /v DisableDnsPublishing
%nul% reg delete "HKLM\%SPPk%" /f /v DisableKeyManagementServiceHostCaching
%nul% reg delete "HKLM\%SPPk%\%_wApp%" /f
if %winbuild% GEQ 9200 (
if defined notx86 (
%nul% reg delete "HKLM\%SPPk%" /f /v KeyManagementServiceName /reg:32
%nul% reg delete "HKLM\%SPPk%" /f /v KeyManagementServicePort /reg:32
%nul% reg delete "HKLM\%SPPk%\%_oApp%" /f /reg:32
)
%nul% reg delete "HKLM\%SPPk%\%_oApp%" /f
)
if %winbuild% GEQ 9600 (
%nul% reg delete "HKU\S-1-5-20\%SPPk%\%_wApp%" /f
%nul% reg delete "HKU\S-1-5-20\%SPPk%\%_oApp%" /f
)
%nul% reg delete "HKLM\%OPPk%" /f /v KeyManagementServiceName
%nul% reg delete "HKLM\%OPPk%" /f /v KeyManagementServicePort
%nul% reg delete "HKLM\%OPPk%" /f /v DisableDnsPublishing
%nul% reg delete "HKLM\%OPPk%" /f /v DisableKeyManagementServiceHostCaching
%nul% reg delete "HKLM\%OPPk%\%_oA14%" /f
%nul% reg delete "HKLM\%OPPk%\%_oApp%" /f

:: check KMS38 lock

%nul% reg query "HKLM\%SPPk%\%_wApp%" && (
set error_=9
echo Failed to completely clear KMS Cache.
reg query "HKLM\%SPPk%\%_wApp%" /s 2>nul | findstr /i "127.0.0.2" >nul && echo KMS38 activation is locked.
) || (
echo Cleared KMS Cache successfully.
)
exit /b

:=========================================================================================================================================

:leavenonexistentkms

reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "10.0.0.10"
reg add "HKLM\%SPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "1688"
reg delete "HKLM\%SPPk%" /f /v DisableDnsPublishing
reg delete "HKLM\%SPPk%" /f /v DisableKeyManagementServiceHostCaching
if not defined _keepkms38 reg delete "HKLM\%SPPk%\%_wApp%" /f
if %winbuild% GEQ 9200 (
if not %xOS%==x86 (
reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "10.0.0.10" /reg:32
reg add "HKLM\%SPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "1688" /reg:32
reg delete "HKLM\%SPPk%\%_oApp%" /f /reg:32
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "10.0.0.10" /reg:32
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServicePort /t REG_SZ /d "1688" /reg:32
)
reg delete "HKLM\%SPPk%\%_oApp%" /f
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "10.0.0.10"
reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServicePort /t REG_SZ /d "1688"
)
if %winbuild% GEQ 9600 (
reg delete "HKU\S-1-5-20\%SPPk%\%_wApp%" /f
reg delete "HKU\S-1-5-20\%SPPk%\%_oApp%" /f
)
reg add "HKLM\%OPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "10.0.0.10"
reg delete "HKLM\%OPPk%" /f /v KeyManagementServicePort
reg delete "HKLM\%OPPk%" /f /v DisableDnsPublishing
reg delete "HKLM\%OPPk%" /f /v DisableKeyManagementServiceHostCaching
reg delete "HKLM\%OPPk%\%_oA14%" /f
reg delete "HKLM\%OPPk%\%_oApp%" /f
goto :eof

:=========================================================================================================================================

:_Complete_Uninstall

cls
mode con: cols=91 lines=30
title Online KMS Complete Uninstall

set "key=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\taskcache\tasks"

set "_C16R="
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" 2^>nul') do if exist "%%b\root\Licenses16\ProPlus*.xrm-ms" set "_C16R=1"
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath /reg:32" 2^>nul') do if exist "%%b\root\Licenses16\ProPlus*.xrm-ms" set "_C16R=1"
if %winbuild% GEQ 9200 if defined _C16R (
echo.
echo ## Notice ##
echo.
echo To make sure Office programs do not show a non-genuine banner,
echo please run the activation option once, and don't uninstall afterward.
echo __________________________________________________________________________________________
)

set error_=
echo.
call :Clear-KMS-Cache
call :clearstuff

if defined error_ (
if [%error_%]==[1] (
echo __________________________________________________________________________________________
%eline%
echo Try Again / Restart the System
echo __________________________________________________________________________________________
)
) else (
echo __________________________________________________________________________________________
echo.
call :_color %Green% "Online KMS Complete Uninstall was done successfully."
echo __________________________________________________________________________________________
)

if defined _unattended timeout /t 2 & exit /b

echo.
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b

:clearstuff

reg query "%key%" /f Path /s | find /i "\Activation-Renewal" >nul && (
echo Deleting [Task] Activation-Renewal
schtasks /delete /tn Activation-Renewal /f %nul%
)

reg query "%key%" /f Path /s | find /i "\Activation-Run_Once" >nul && (
echo Deleting [Task] Activation-Run_Once
schtasks /delete /tn Activation-Run_Once /f %nul%
)

reg query "%key%" /f Path /s | find /i "\Online_KMS_Activation_Script-Renewal" >nul && (
echo Deleting [Task] Online_KMS_Activation_Script-Renewal
schtasks /delete /tn Online_KMS_Activation_Script-Renewal /f %nul%
)

reg query "%key%" /f Path /s | find /i "\Online_KMS_Activation_Script-Run_Once" >nul && (
echo Deleting [Task] Online_KMS_Activation_Script-Run_Once
schtasks /delete /tn Online_KMS_Activation_Script-Run_Once /f %nul%
)

If exist "%windir%\Online_KMS_Activation_Script\" (
echo Deleting [Folder] %windir%\Online_KMS_Activation_Script\
rmdir /s /q "%windir%\Online_KMS_Activation_Script\" %nul%
)

if exist "%ProgramData%\Online_KMS_Activation.cmd" (
echo Deleting [File] %ProgramData%\Online_KMS_Activation.cmd
del /f /q "%ProgramData%\Online_KMS_Activation.cmd" %nul%
)

If exist "%ProgramData%\Online_KMS_Activation\" (
echo Deleting [Folder] %ProgramData%\Online_KMS_Activation\
rmdir /s /q "%ProgramData%\Online_KMS_Activation\" %nul%
)

If exist "%ProgramData%\Activation-Renewal\" (
echo Deleting [Folder] %ProgramData%\Activation-Renewal\
rmdir /s /q "%ProgramData%\Activation-Renewal\" %nul%
)

reg query "HKCR\DesktopBackground\shell\Activate Windows - Office" %nul% && (
echo Deleting [Registry] HKCR\DesktopBackground\shell\Activate Windows - Office
Reg delete "HKCR\DesktopBackground\shell\Activate Windows - Office" /f %nul%
)

reg query "%key%" /f Path /s | find /i "\Activation-Renewal" >nul && (set error_=1)
reg query "%key%" /f Path /s | find /i "\Activation-Run_Once" >nul && (set error_=1)
reg query "%key%" /f Path /s | find /i "\Online_KMS_Activation_Script-Run_Once" >nul && (set error_=1)
reg query "%key%" /f Path /s | find /i "\Online_KMS_Activation_Script-Run_Once" >nul && (set error_=1)
If exist "%windir%\Online_KMS_Activation_Script\" (set error_=1)
reg query "HKCR\DesktopBackground\shell\Activate Windows - Office" %nul% && (set error_=1)
if exist "%ProgramData%\Online_KMS_Activation.cmd" (set error_=1)
if exist "%ProgramData%\Online_KMS_Activation\" (set error_=1)
if exist "%ProgramData%\Activation-Renewal\" (set error_=1)
exit /b

:=========================================================================================================================================

:RenTask

cls
mode con cols=91 lines=30
title  Install Activation Auto-Renewal

set error_=
set "_dest=%ProgramData%\Activation-Renewal"
set "key=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\taskcache\tasks"

call :clearstuff %nul%

if defined error_ (
%eline%
echo Failed to completely clear KMS related folders/tasks.
echo Run the Uninstall option and then try again.
goto :RenDone
)

if not exist "%_dest%\" md "%_dest%\" %nul%
set "_temp=%SystemRoot%\Temp\_taskwork"

set nil=
if exist "%_temp%\.*" rmdir /s /q "%_temp%\" %nul%
md "%_temp%\" %nul%
call :RenExport renewal "%_temp%\Renewal.xml" Unicode
if defined ActTask (call :RenExport run_once "%_temp%\Run_Once.xml" Unicode)
s%nil%cht%nil%asks /cre%nil%ate /tn "Activation-Renewal" /ru "SYS%nil%TEM" /xml "%_temp%\Renewal.xml" %nul%
if defined ActTask (s%nil%cht%nil%asks /cre%nil%ate /tn "Activation-Run_Once" /ru "SYS%nil%TEM" /xml "%_temp%\Run_Once.xml" %nul%)
if exist "%_temp%\.*" rmdir /s /q "%_temp%\" %nul%

call :createInfo.txt
%nul% %psc% "$f=[io.file]::ReadAllText('!_batp!') -split \":_extracttask\:.*`r`n\"; [io.file]::WriteAllText('%_dest%\Activation_task.cmd', '@REM Dummy ' + '%random%' + [Environment]::NewLine + $f[1].Trim(), [System.Text.Encoding]::ASCII);"
title  Install Activation Auto-Renewal

::========================================================================================================================================

reg query "%key%" /f Path /s | find /i "\Activation-Renewal" >nul || (set error_=1)
if defined ActTask reg query "%key%" /f Path /s | find /i "\Activation-Run_Once" >nul || (set error_=1)

If not exist "%_dest%\Activation_task.cmd" (set error_=1)
If not exist "%_dest%\Info.txt" (set error_=1)

if defined error_ (

reg query "%key%" /f Path /s | find /i "\Activation-Renewal" >nul && (
schtasks /delete /tn Activation-Renewal /f %nul%
)
reg query "%key%" /f Path /s | find /i "\Activation-Run_Once" >nul && (
schtasks /delete /tn Activation-Run_Once /f %nul%
)

If exist "%_dest%\" (
rmdir /s /q "%_dest%\" %nul%
)

%eline%
echo Run the Uninstall option and then try again.
goto :RenDone
)

echo __________________________________________________________________________________________
echo.
echo Files created:
echo %_dest%\Activation_task.cmd
echo %_dest%\Info.txt
echo.
(if defined ActTask (echo Scheduled Tasks created:) else (echo Scheduled Task created:))
echo \Activation-Renewal [Weekly]
if defined ActTask (echo \Activation-Run_Once)
echo __________________________________________________________________________________________
echo.
echo Info:
echo Activation will be renewed every week if the Internet connection is found.
echo It'll only renew installed KMS licenses. It won't convert any license to KMS.
echo __________________________________________________________________________________________
echo.
if defined ActTask (
call :_color %Green% "Renewal and Activation Tasks were successfully created."
) else (
call :_color %Green% "Renewal Task was successfully created."
)
echo.
call :_color %Gray% "Make sure you have run the Activation option at least once."
echo __________________________________________________________________________________________
)

::========================================================================================================================================

:RenDone

if defined _unattended exit /b

echo.
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b

::========================================================================================================================================

:createInfo.txt

(
echo   The use of this script is to renew your Windows/Office KMS license using online KMS.
echo:
echo   If renewal/activation Scheduled tasks were created then following would exist,
echo:
echo   - Scheduled tasks
echo     Activation-Renewal    [Renewal / Weekly]
echo     Activation-Run_Once   [Activation Task - deletes itself once activated]
echo     The scheduled tasks runs only if the system is connected to the Internet.
echo:
echo   - Files
echo     C:\ProgramData\Activation-Renewal\Activation_task.cmd
echo     C:\ProgramData\Activation-Renewal\Info.txt
echo     C:\ProgramData\Activation-Renewal\Logs.txt
echo ______________________________________________________________________________________________
echo:
echo   Online KMS Activation Script is a part of 'Microsoft Activation Scripts' [MAS] project.
echo:   
echo   Homepage: massgrave.dev
echo      Email: windowsaddict@protonmail.com
)>"%_dest%\Info.txt"
exit /b

::========================================================================================================================================

:renewal:
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.3" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Source>Microsoft Corporation</Source>
    <Date>1999-01-01T12:00:00.34375</Date>
    <Author>WindowsAddict</Author>
    <Version>1.0</Version>
    <Description>Online K-M-S Activation-Renewal - Weekly Task</Description>
    <URI>\Activation-Renewal</URI>
    <SecurityDescriptor>D:P(A;;FA;;;SY)(A;;FA;;;BA)(A;;FRFX;;;LS)(A;;FRFW;;;S-1-5-80-123231216-2592883651-3715271367-3753151631-4175906628)(A;;FR;;;S-1-5-4)</SecurityDescriptor>
  </RegistrationInfo>
  <Triggers>
    <CalendarTrigger>
      <StartBoundary>1999-01-01T12:00:00</StartBoundary>
      <Enabled>true</Enabled>
      <ScheduleByWeek>
        <DaysOfWeek>
          <Sunday />
        </DaysOfWeek>
        <WeeksInterval>1</WeeksInterval>
      </ScheduleByWeek>
    </CalendarTrigger>
  </Triggers>
  <Principals>
    <Principal id="LocalSystem">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>true</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>true</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT10M</ExecutionTimeLimit>
    <Priority>7</Priority>
    <RestartOnFailure>
      <Interval>PT2M</Interval>
      <Count>3</Count>
    </RestartOnFailure>
  </Settings>
  <Actions Context="LocalSystem">
    <Exec>
      <Command>%ProgramData%\Activation-Renewal\Activation_task.cmd</Command>
    <Arguments>Task</Arguments>
    </Exec>
  </Actions>
</Task>
:renewal:

:run_once:
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.3" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Source>Microsoft Corporation</Source>
    <Date>1999-01-01T12:00:00.34375</Date>
    <Author>WindowsAddict</Author>
    <Version>1.0</Version>
    <Description>Online K-M-S Activation Run Once - Run and Delete itself on first Internet Contact</Description>
    <URI>\Activation-Run_Once</URI>
    <SecurityDescriptor>D:P(A;;FA;;;SY)(A;;FA;;;BA)(A;;FRFX;;;LS)(A;;FRFW;;;S-1-5-80-123231216-2592883651-3715271367-3753151631-4175906628)(A;;FR;;;S-1-5-4)</SecurityDescriptor>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="LocalSystem">
      <UserId>S-1-5-18</UserId>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>true</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>true</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>false</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>true</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <ExecutionTimeLimit>PT10M</ExecutionTimeLimit>
    <Priority>7</Priority>
    <RestartOnFailure>
      <Interval>PT2M</Interval>
      <Count>3</Count>
    </RestartOnFailure>
  </Settings>
  <Actions Context="LocalSystem">
    <Exec>
      <Command>%ProgramData%\Activation-Renewal\Activation_task.cmd</Command>
    <Arguments>Task</Arguments>
    </Exec>
  </Actions>
</Task>
:run_once:

::========================================================================================================================================

::  Extract the text from batch script without character and file encoding issue

:RenExport

%nul% %psc% "$f=[io.file]::ReadAllText('!_batp!') -split \":%~1\:.*`r`n\"; [io.file]::WriteAllText('%~2',$f[1].Trim(),[System.Text.Encoding]::%~3);"
exit /b

::========================================================================================================================================

:_extracttask:
@echo off

::   Renew K-M-S activation with Online servers via scheduled task

::============================================================================
::
::   This script is a part of 'Microsoft Activation Scripts' (MAS) project.
::
::   Homepage: massgrave.dev
::      Email: windowsaddict@protonmail.com
::
::============================================================================


if not "%~1"=="Task" (
echo.
echo ====== Error ======
echo.
echo This file is supposed to be run only by the scheduled task.
echo.
echo Press any key to exit
pause >nul
exit /b
)

::  Set Path variable, it helps if it is misconfigured in the system

set "PATH=%SystemRoot%\System32;%SystemRoot%\System32\wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "PATH=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%PATH%"
)

>nul fltmc || exit /b

::========================================================================================================================================

set _tserror=
set winbuild=1
set "nul=>nul 2>&1"
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G
set psc=powershell.exe

set run_once=
set t_name=Renewal Task
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\taskcache\tasks" /f Path /s | find /i "\Activation-Run_Once" >nul && (
set run_once=1
set t_name=Run Once Task
)

set _wmic=0
for %%# in (wmic.exe) do @if not "%%~$PATH:#"=="" (
wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul && set _wmic=1
)

setlocal EnableDelayedExpansion
if exist "%ProgramData%\Activation-Renewal\" call :_taskstart>>"%ProgramData%\Activation-Renewal\Logs.txt" & exit

::========================================================================================================================================

:_taskstart

echo.
echo %date%, %time%

set /a loop=1
set /a max_loop=4

call :_tasksetserv

:_intrepeat

::  Check Internet connection. Works even if ICMP echo is disabled.

for %%a in (%srvlist%) do (
for /f "delims=[] tokens=2" %%# in ('ping -n 1 %%a') do (
if not [%%#]==[] goto _taskIntConnected
)
)

nslookup dns.msftncsi.com 2>nul | find "131.107.255.255" 1>nul
if [%errorlevel%]==[0] goto _taskIntConnected

if %loop%==%max_loop% (
set _tserror=1
goto _taskend
)

echo.
echo Error: Internet is not connected
echo Waiting 30 seconds

timeout /t 30 >nul
set /a loop=%loop%+1
goto _intrepeat

:_taskIntConnected

::========================================================================================================================================

::  Check not x86 Windows

set notx86=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') do set arch=%%b
if /i not "%arch%"=="x86" set notx86=1

::========================================================================================================================================

set "OPPk=SOFTWARE\Microsoft\OfficeSoftwareProtectionPlatform"
set "SPPk=SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"

set "slp=SoftwareLicensingProduct"
set "ospp=OfficeSoftwareProtectionProduct"

set "_wApp=55c92734-d682-4d71-983e-d6ec3f16059f"
set "_oApp=0ff1ce15-a989-479d-af46-f275c6370663"
set "_oA14=59a52881-a989-479d-af46-f275c6370663"

::========================================================================================================================================

::  Clean existing KMS cache from the registry / Set port value to 1688

%nul% reg delete "HKLM\%SPPk%" /f /v KeyManagementServiceName
%nul% reg add "HKLM\%SPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "1688"
%nul% reg delete "HKLM\%SPPk%\%_wApp%" /f
if %winbuild% GEQ 9200 (
if defined notx86 (
%nul% reg add "HKLM\%SPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "1688" /reg:32
%nul% reg delete "HKLM\%SPPk%\%_oApp%" /f /reg:32
%nul% reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServicePort /t REG_SZ /d "1688" /reg:32
)
%nul% reg delete "HKLM\%SPPk%\%_oApp%" /f
%nul% reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServicePort /t REG_SZ /d "1688"
)
if %winbuild% GEQ 9600 (
%nul% reg delete "HKU\S-1-5-20\%SPPk%\%_wApp%" /f
%nul% reg delete "HKU\S-1-5-20\%SPPk%\%_oApp%" /f
)
%nul% reg add "HKLM\%OPPk%" /f /v KeyManagementServicePort /t REG_SZ /d "1688"
%nul% reg delete "HKLM\%OPPk%\%_oA14%" /f
%nul% reg delete "HKLM\%OPPk%\%_oApp%" /f

::========================================================================================================================================

::  Check WMI and sppsvc Errors

set applist=
net start sppsvc /y %nul%
if %_wmic% EQU 1 set "chkapp=for /f "tokens=2 delims==" %%a in ('"wmic path %slp% where (ApplicationID='%_wApp%') get ID /VALUE" 2^>nul')"
if %_wmic% EQU 0 set "chkapp=for /f "tokens=2 delims==" %%a in ('%psc% "(([WMISEARCHER]'SELECT ID FROM %slp% WHERE ApplicationID=''%_wApp%''').Get()).ID ^| %% {echo ('ID='+$_)}" 2^>nul')"
%chkapp% do (if defined applist (call set "applist=!applist! %%a") else (call set "applist=%%a"))

if not defined applist (
set _tserror=1
if %_wmic% EQU 1 wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul
if %_wmic% EQU 0 %psc% "Get-CIMInstance -Class Win32_ComputerSystem | Select-Object -Property CreationClassName" 2>nul | find /i "computersystem" 1>nul
if !errorlevel! NEQ 0 (set e_wmispp=WMI, SPP) else (set e_wmispp=SPP)
echo.
echo Error: Not Respoding- !e_wmispp!
echo.
)

::========================================================================================================================================

::  Check installed volume products activation ID's

call :_taskgetids sppwid %slp% windows
call :_taskgetids sppoid %slp% office
call :_taskgetids osppid %ospp% office

::========================================================================================================================================

echo.
echo Renewing KMS activation for all installed Volume products

if not defined sppwid if not defined sppoid if not defined osppid (
echo.
echo No installed Volume Windows / Office product found
echo.
echo Renewing KMS server
call :_taskgetserv
call :_taskregserv
goto :_skipact
)

::========================================================================================================================================

:: Check KMS38 activation

set gpr=0
set _kms38=0
if defined sppwid if %winbuild% GEQ 14393 (
set _path=%slp%
set _actid=%sppwid%
call :_taskgetgrace
)

if %gpr% NEQ 0 if %gpr% GTR 259200 (
set _kms38=1
call :_taskchkEnterpriseG _kms38
)

:: Set specific KMS host to Local Host so that global KMS IP can not replace KMS38 activation but can be used with Office and other Windows Editions.

if %_kms38% EQU 1 (
%nul% reg add "HKLM\%SPPk%\%_wApp%\%sppwid%" /f /v KeyManagementServiceName /t REG_SZ /d "127.0.0.2"
%nul% reg add "HKLM\%SPPk%\%_wApp%\%sppwid%" /f /v KeyManagementServicePort /t REG_SZ /d "1688"
)

::========================================================================================================================================

echo.
if defined sppwid (
set _path=%slp%
set _actid=%sppwid%
call :_actprod
call :_act act_win
call :_actinfo act_win
) else (
echo Checking: Volume version of Windows is not installed
)

if defined sppoid (
set _path=%slp%
for %%# in (%sppoid%) do (
echo.
set _actid=%%#
call :_actprod
call :_act
call :_actinfo
)
)

if defined osppid (
set _path=%ospp%
for %%# in (%osppid%) do (
echo.
set _actid=%%#
call :_actprod
call :_act
call :_actinfo
)
)

if not defined sppoid if not defined osppid (
echo.
echo Checking: Volume version of Office is not installed
)

:_skipact

::========================================================================================================================================

if defined run_once (
echo.
echo Deleting Scheduled Task Activation-Run_Once
schtasks /delete /tn Activation-Run_Once /f %nul%
)

::========================================================================================================================================

:_taskend

echo.
echo Exiting
echo ______________________________________________________________________

if defined _tserror (exit /b 123456789) else (exit /b 0)

::========================================================================================================================================

:_act

set errorcode=12345
set /a act_attempt=0

:_act2

if %act_attempt% GTR 4 exit /b

if not [%act_ok%]==[1] (
call :_taskgetserv
call :_taskregserv
)

if not !server_num! GTR %max_servers% (

if [%1]==[act_win] if %_kms38% EQU 1 (
set act_ok=1
exit /b
)

if %_wmic% EQU 1 wmic path !_path! where ID='!_actid!' call Activate %nul%
if %_wmic% EQU 0 %psc% "try {$null=(([WMISEARCHER]'SELECT ID FROM !_path! where ID=''!_actid!''').Get()).Activate(); exit 0} catch { exit $_.Exception.InnerException.HResult }"

call set errorcode=!errorlevel!

if !errorcode! EQU 0 (
set act_ok=1
exit /b
)
if [%1]==[act_win] if !errorcode! EQU -1073418187 if %winbuild% LSS 9200 (
set act_ok=1
exit /b
)

set act_ok=0
set /a act_attempt+=1
goto _act2
)
exit /b

:_actprod

if %_wmic% EQU 1 for /f "tokens=2 delims==" %%x in ('"wmic path !_path! where ID='!_actid!' get Name /VALUE" 2^>nul') do call echo Activating: %%x
if %_wmic% EQU 0 for /f "tokens=2 delims==" %%x in ('%psc% "(([WMISEARCHER]'SELECT Name FROM !_path! WHERE ID=''!_actid!''').Get()).Name | %% {echo ('Name='+$_)}" 2^>nul') do call echo Activating: %%x
exit /b

::========================================================================================================================================

:_actinfo

if [%1]==[act_win] if %_kms38% EQU 1 (
echo Windows is activated with KMS38
exit /b
)

if %errorcode% EQU 12345 (
echo Product Activation Failed
echo Unable to test KMS servers due to restricted or no Internet
set _tserror=1
exit /b
)

if %errorcode% EQU -1073418187 (
echo Product Activation Failed: 0xC004F035
if [%1]==[act_win] if %winbuild% LSS 9200 echo Windows 7 cannot be KMS-activated on this computer due to unqualified OEM BIOS
exit /b
)

if %errorcode% EQU -1073417728 (
echo Product Activation Failed: 0xC004F200
echo Windows needs to rebuild the activation-related files.
set _tserror=1
exit /b
)

set gpr=0
set gpr2=0
call :_taskgetgrace
set /a "gpr2=(%gpr%+1440-1)/1440"

if %errorcode% EQU 0 if %gpr% EQU 0 (
echo Product Activation succeeded, but Remaining Period failed to increase.
if [%1]==[act_win] if %winbuild% LSS 9200 echo This could be related to the error described in KB4487266
set _tserror=1
exit /b
)

set _actpass=1
if %gpr% EQU 43200  if [%1]==[act_win] if %winbuild% GEQ 9200 set _actpass=0
if %gpr% EQU 64800  set _actpass=0
if %gpr% GTR 259200 if [%1]==[act_win] call :_taskchkEnterpriseG _actpass
if %gpr% EQU 259200 set _actpass=0

if %errorcode% EQU 0 if %_actpass% EQU 0 (
echo Product Activation Successful
echo Remaining Period: %gpr2% days ^(%gpr% minutes^)
exit /b
)

cmd /c exit /b %errorcode%
if %errorcode% NEQ 0 (
echo Product Activation Failed: 0x!=ExitCode!
) else (
echo Product Activation Failed
)
echo Remaining Period: %gpr2% days ^(%gpr% minutes^)
set _tserror=1
exit /b

::========================================================================================================================================

:_taskgetids

set %1=
if %_wmic% EQU 1 set "chkapp=for /f "tokens=2 delims==" %%a in ('"wmic path %2 where (Name like '%%%3%%' and Description like '%%KMSCLIENT%%' and PartialProductKey is not NULL) get ID /VALUE" 2^>nul')"
if %_wmic% EQU 0 set "chkapp=for /f "tokens=2 delims==" %%a in ('%psc% "(([WMISEARCHER]'SELECT ID FROM %2 WHERE Name like ''%%%3%%'' and Description like ''%%KMSCLIENT%%'' and PartialProductKey is not NULL').Get()).ID ^| %% {echo ('ID='+$_)}" 2^>nul')"
%chkapp% do (if defined %1 (call set "%1=!%1! %%a") else (call set "%1=%%a"))
exit /b

:_taskgetgrace

set gpr=0
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%# in ('"wmic path !_path! where ID='!_actid!' get GracePeriodRemaining /VALUE" 2^>nul') do call set "gpr=%%#"
if %_wmic% EQU 0 for /f "tokens=2 delims==" %%# in ('%psc% "(([WMISEARCHER]'SELECT GracePeriodRemaining FROM !_path! where ID=''!_actid!''').Get()).GracePeriodRemaining | %% {echo ('GracePeriodRemaining='+$_)}" 2^>nul') do call set "gpr=%%#"
exit /b

:_taskchkEnterpriseG

for %%# in (e0b2d383-d112-413f-8a80-97f373a5820c e38454fb-41a4-4f59-a5dc-25080e354730) do (if %sppwid%==%%# set %1=0)
exit /b

::========================================================================================================================================

:_taskregserv

%nul% reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%"
%nul% reg add "HKLM\%OPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%"

if %winbuild% GEQ 9200 (
%nul% reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%"
if defined notx86 (
%nul% reg add "HKLM\%SPPk%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" /reg:32
%nul% reg add "HKLM\%SPPk%\%_oApp%" /f /v KeyManagementServiceName /t REG_SZ /d "%KMS_IP%" /reg:32
)
)
exit /b

::========================================================================================================================================

:_tasksetserv

::  Multi KMS servers integration and servers randomization

set srvlist=
set -=

set "srvlist=kms.zhu%-%xiaole.org kms-default.cangs%-%hui.net kms.six%-%yin.com kms.moe%-%club.org kms.cgt%-%soft.com"
set "srvlist=%srvlist% kms.id%-%ina.cn kms.moe%-%yuuko.com xinch%-%eng213618.cn kms.wl%-%rxy.cn kms.ca%-%tqu.com"
set "srvlist=%srvlist% kms.0%-%t.net.cn kms.its%-%jzx.com kms.wx%-%lost.com kms.moe%-%yuuko.top kms.gh%-%pym.com"

set n=1
for %%a in (%srvlist%) do (set %%a=&set server!n!=%%a&set /a n+=1)
set max_servers=15
set /a server_num=0
exit /b

:_taskgetserv

if %server_num% geq %max_servers% (set /a server_num+=1&set KMS_IP=222.184.9.98&exit /b)
set /a rand=%Random%%%(15+1-1)+1
if defined !server%rand%! goto :_taskgetserv
set KMS_IP=!server%rand%!
set !server%rand%!=1

::  Get IPv4 address of KMS server to use for the activation, works even if ICMP echo is disabled.
::  Microsoft and Antivirus's may flag the issue if public KMS server host name is directly used for the activation.

set /a server_num+=1
(for /f "delims=[] tokens=2" %%a in ('ping -4 -n 1 %KMS_IP% 2^>nul') do set "KMS_IP=%%a"
if [%KMS_IP%]==[!KMS_IP!] for /f "delims=[] tokens=2" %%# in ('pathping -4 -h 1 -n -p 1 -q 1 -w 1 %KMS_IP% 2^>nul') do set "KMS_IP=%%#"
if not [%KMS_IP%]==[!KMS_IP!] exit /b
goto :_taskgetserv
)

:: Ver:1.8
::========================================================================================================================================
:_extracttask:

:======================================================================================================================================================

:_color

if %_NCS% EQU 1 (
if defined _unattended (echo %~2) else (echo %esc%[%~1%~2%esc%[0m)
) else (
if defined _unattended (echo %~2) else (call :batcol %~1 "%~2")
)
exit /b

:_color2

if %_NCS% EQU 1 (
echo %esc%[%~1%~2%esc%[%~3%~4%esc%[0m
) else (
call :batcol %~1 "%~2" %~3 "%~4"
)
exit /b

::=======================================

:: Colored text with pure batch method
:: Thanks to @dbenham and @jeb
:: stackoverflow.com/a/10407642

:batcol

pushd %_coltemp%
if not exist "'" (<nul >"'" set /p "=.")
setlocal
set "s=%~2"
set "t=%~4"
call :_batcol %1 s %3 t
del /f /q "'"
del /f /q "`.txt"
popd
exit /b

:_batcol

setlocal EnableDelayedExpansion
set "s=!%~2!"
set "t=!%~4!"
for /f delims^=^ eol^= %%i in ("!s!") do (
  if "!" equ "" setlocal DisableDelayedExpansion
    >`.txt (echo %%i\..\')
    findstr /a:%~1 /f:`.txt "."
    <nul set /p "=%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%"
)
if "%~4"=="" echo(&exit /b
setlocal EnableDelayedExpansion
for /f delims^=^ eol^= %%i in ("!t!") do (
  if "!" equ "" setlocal DisableDelayedExpansion
    >`.txt (echo %%i\..\')
    findstr /a:%~3 /f:`.txt "."
    <nul set /p "=%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%"
)
echo(
exit /b

::=======================================

:_colorprep

if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"

set     "Red="41;97m""
set    "Gray="100;97m""
set   "Black="30m""
set   "Green="42;97m""
set    "Blue="44;97m""
set  "Yellow="43;97m""
set "Magenta="45;97m""

set    "_Red="40;91m""
set  "_Green="40;92m""
set   "_Blue="40;94m""
set  "_White="40;37m""
set "_Yellow="40;93m""

exit /b
)

for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "_BS=%%A %%A"
set "_coltemp=%SystemRoot%\Temp"

set     "Red="CF""
set    "Gray="8F""
set   "Black="00""
set   "Green="2F""
set    "Blue="1F""
set  "Yellow="6F""
set "Magenta="5F""

set    "_Red="0C""
set  "_Green="0A""
set   "_Blue="09""
set  "_White="07""
set "_Yellow="0E""

exit /b

::========================================================================================================================================

::  https://gist.github.com/ave9858/9fff6af726ba3ddc646285d1bbf37e71
::  This code is used to clean Office licenses

:cleanlicense:
function UninstallLicenses($DllPath) {
    $AssemblyBuilder = [AppDomain]::CurrentDomain.DefineDynamicAssembly(4, 1)
    $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule(2, $False)
    $TypeBuilder = $ModuleBuilder.DefineType(0)
    
    [void]$TypeBuilder.DefinePInvokeMethod('SLOpen', $DllPath, 'Public, Static', 1, [int], @([IntPtr].MakeByRefType()), 1, 3)
    [void]$TypeBuilder.DefinePInvokeMethod('SLGetSLIDList', $DllPath, 'Public, Static', 1, [int],
        @([IntPtr], [int], [Guid].MakeByRefType(), [int], [int].MakeByRefType(), [IntPtr].MakeByRefType()), 1, 3).SetImplementationFlags(128)
    [void]$TypeBuilder.DefinePInvokeMethod('SLUninstallLicense', $DllPath, 'Public, Static', 1, [int], @([IntPtr], [IntPtr]), 1, 3)

    $SPPC = $TypeBuilder.CreateType()
    $Handle = 0
    [void]$SPPC::SLOpen([ref]$Handle)
    $pnReturnIds = 0
    $ppReturnIds = 0

    if (!$SPPC::SLGetSLIDList($Handle, 0, [ref][Guid]"0ff1ce15-a989-479d-af46-f275c6370663", 6, [ref]$pnReturnIds, [ref]$ppReturnIds)) {
        foreach ($i in 0..($pnReturnIds - 1)) {
            [void]$SPPC::SLUninstallLicense($Handle, [Int64]$ppReturnIds + [Int64]16 * $i)
        }    
    }
}

$OSPP = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\OfficeSoftwareProtectionPlatform" -ErrorAction SilentlyContinue).Path
if ($OSPP) {
    Write-Output "Found Office Software Protection installed, cleaning"
    UninstallLicenses($OSPP + "osppc.dll")
}
UninstallLicenses("sppc.dll")
:cleanlicense:

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:_Check_Status_vbs
@setlocal DisableDelayedExpansion
@echo off
@cls
mode con cols=100 lines=32
>nul 2>&1 powershell "&{$W=$Host.UI.RawUI.WindowSize;$B=$Host.UI.RawUI.BufferSize;$W.Height=31;$B.Height=300;$Host.UI.RawUI.WindowSize=$W;$Host.UI.RawUI.BufferSize=$B;}"
color 07
title Check Activation Status [vbs]
set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "SysPath=%SystemRoot%\Sysnative"
set "Path=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)

set "_bit=64"
set "_wow=1"
if /i "%PROCESSOR_ARCHITECTURE%"=="x86" if "%PROCESSOR_ARCHITEW6432%"=="" set "_wow=0"&set "_bit=32"
set "_utemp=%TEMP%"
set "line2=************************************************************"
set "line3=____________________________________________________________"
set _sO16vbs=0
set _sO15vbs=0
if exist "%ProgramFiles%\Microsoft Office\Office15\ospp.vbs" (
  set _sO15vbs=1
) else if exist "%ProgramW6432%\Microsoft Office\Office15\ospp.vbs" (
  set _sO15vbs=1
) else if exist "%ProgramFiles(x86)%\Microsoft Office\Office15\ospp.vbs" (
  set _sO15vbs=1
)
setlocal EnableDelayedExpansion
echo %line2%
echo ***                   Windows Status                     ***
echo %line2%
pushd "!_utemp!"
copy /y %SystemRoot%\System32\slmgr.vbs . >nul 2>&1
net start sppsvc /y >nul 2>&1
cscript //nologo slmgr.vbs /dli || (echo Error executing slmgr.vbs&del /f /q slmgr.vbs&popd&goto :casVend)
cscript //nologo slmgr.vbs /xpr
del /f /q slmgr.vbs >nul 2>&1
popd
echo %line3%

:casVo16
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot /v Path" 2^>nul') do (set "office=%%b")
if exist "!office!\ospp.vbs" (
set _sO16vbs=1
echo.
echo %line2%
if %_sO15vbs% EQU 0 (
echo ***              Office 2016 %_bit%-bit Status               ***
) else (
echo ***               Office 2013/2016 Status                ***
)
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)
if %_wow%==0 goto :casVo13
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\InstallRoot /v Path" 2^>nul') do (set "office=%%b")
if exist "!office!\ospp.vbs" (
set _sO16vbs=1
echo.
echo %line2%
if %_sO15vbs% EQU 0 (
echo ***              Office 2016 32-bit Status               ***
) else (
echo ***               Office 2013/2016 Status                ***
)
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)

:casVo13
if %_sO16vbs% EQU 1 goto :casVo10
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\15.0\Common\InstallRoot /v Path" 2^>nul') do (set "office=%%b")
if exist "!office!\ospp.vbs" (
echo.
echo %line2%
echo ***              Office 2013 %_bit%-bit Status               ***
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)
if %_wow%==0 goto :casVo10
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\15.0\Common\InstallRoot /v Path" 2^>nul') do (set "office=%%b")
if exist "!office!\ospp.vbs" (
echo.
echo %line2%
echo ***              Office 2013 32-bit Status               ***
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)

:casVo10
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\14.0\Common\InstallRoot /v Path" 2^>nul') do (set "office=%%b")
if exist "!office!\ospp.vbs" (
echo.
echo %line2%
echo ***              Office 2010 %_bit%-bit Status               ***
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)
if %_wow%==0 goto :casVc16
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\Common\InstallRoot /v Path" 2^>nul') do (set "office=%%b")
if exist "!office!\ospp.vbs" (
echo.
echo %line2%
echo ***              Office 2010 32-bit Status               ***
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)

:casVc16
reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath >nul 2>&1 || (
reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath >nul 2>&1 || goto :casVc13
)
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\Microsoft\Office\ClickToRun /v InstallPath" 2^>nul') do (set "office=%%b\Office16")
if exist "!office!\ospp.vbs" (
set _sO16vbs=1
echo.
echo %line2%
if %_sO15vbs% EQU 0 (
echo ***              Office 2016-2021 C2R Status             ***
) else (
echo ***                Office 2013-2021 Status               ***
)
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)
if %_wow%==0 goto :casVc13
set office=
for /f "skip=2 tokens=2*" %%a in ('"reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun /v InstallPath" 2^>nul') do (set "office=%%b\Office16")
if exist "!office!\ospp.vbs" (
set _sO16vbs=1
echo.
echo %line2%
if %_sO15vbs% EQU 0 (
echo ***              Office 2016-2021 C2R Status             ***
) else (
echo ***                Office 2013-2021 Status               ***
)
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)

:casVc13
if %_sO16vbs% EQU 1 goto :casVc10
reg query HKLM\SOFTWARE\Microsoft\Office\15.0\ClickToRun /v InstallPath >nul 2>&1 || (
reg query HKLM\SOFTWARE\WOW6432Node\Microsoft\Office\15.0\ClickToRun /v InstallPath >nul 2>&1 || goto :casVc10
)
set office=
if exist "%ProgramFiles%\Microsoft Office\Office15\ospp.vbs" (
  set "office=%ProgramFiles%\Microsoft Office\Office15"
) else if exist "%ProgramW6432%\Microsoft Office\Office15\ospp.vbs" (
  set "office=%ProgramW6432%\Microsoft Office\Office15"
) else if exist "%ProgramFiles(x86)%\Microsoft Office\Office15\ospp.vbs" (
  set "office=%ProgramFiles(x86)%\Microsoft Office\Office15"
)
if exist "!office!\ospp.vbs" (
echo.
echo %line2%
echo ***                Office 2013 C2R Status                ***
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)

:casVc10
if %_wow%==0 reg query HKLM\SOFTWARE\Microsoft\Office\14.0\CVH /f Click2run /k >nul 2>&1 || goto :casVend
if %_wow%==1 reg query HKLM\SOFTWARE\Wow6432Node\Microsoft\Office\14.0\CVH /f Click2run /k >nul 2>&1 || goto :casVend
set office=
if exist "%ProgramFiles%\Microsoft Office\Office14\ospp.vbs" (
  set "office=%ProgramFiles%\Microsoft Office\Office14"
) else if exist "%ProgramW6432%\Microsoft Office\Office14\ospp.vbs" (
  set "office=%ProgramW6432%\Microsoft Office\Office14"
) else if exist "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" (
  set "office=%ProgramFiles(x86)%\Microsoft Office\Office14"
)
if exist "!office!\ospp.vbs" (
echo.
echo %line2%
echo ***                Office 2010 C2R Status                ***
echo %line2%
cscript //nologo "!office!\ospp.vbs" /dstatus
)

:casVend
echo.
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:_Check_Status_wmi

@setlocal DisableDelayedExpansion
@echo off
mode con cols=100 lines=32
>nul 2>&1 powershell "&{$W=$Host.UI.RawUI.WindowSize;$B=$Host.UI.RawUI.BufferSize;$W.Height=31;$B.Height=300;$Host.UI.RawUI.WindowSize=$W;$Host.UI.RawUI.BufferSize=$B;}"
color 07
title Check Activation Status [wmi]

set WMI_VBS=0
@cls
set "_cmdf=%~f0"
set wspp=SoftwareLicensingProduct
set wsps=SoftwareLicensingService
set ospp=OfficeSoftwareProtectionProduct
set osps=OfficeSoftwareProtectionService
set winApp=55c92734-d682-4d71-983e-d6ec3f16059f
set o14App=59a52881-a989-479d-af46-f275c6370663
set o15App=0ff1ce15-a989-479d-af46-f275c6370663
for %%# in (spp_get,ospp_get,cW1nd0ws,sppw,c0ff1ce15,sppo,osppsvc,ospp14,ospp15) do set "%%#="
for /f "tokens=6 delims=[]. " %%# in ('ver') do set winbuild=%%#
set "spp_get=Description, DiscoveredKeyManagementServiceMachineName, DiscoveredKeyManagementServiceMachinePort, EvaluationEndDate, GracePeriodRemaining, ID, KeyManagementServiceMachine, KeyManagementServicePort, KeyManagementServiceProductKeyID, LicenseStatus, LicenseStatusReason, Name, PartialProductKey, ProductKeyID, VLActivationInterval, VLRenewalInterval"
set "ospp_get=%spp_get%"
if %winbuild% GEQ 9200 set "spp_get=%spp_get%, KeyManagementServiceLookupDomain, VLActivationTypeEnabled"
if %winbuild% GEQ 9600 set "spp_get=%spp_get%, DiscoveredKeyManagementServiceMachineIpAddress, ProductKeyChannel"
set "_work=%~dp0"
set "_batf=%~f0"
set "_batp=%_batf:'=''%"
set "_Local=%LocalAppData%"
set _Identity=0
setlocal EnableDelayedExpansion
dir /b /s /a:-d "!_Local!\Microsoft\Office\Licenses\*1*" 1>nul 2>nul && set _Identity=1
dir /b /s /a:-d "!ProgramData!\Microsoft\Office\Licenses\*1*" 1>nul 2>nul && set _Identity=1
pushd "!_work!"
setlocal DisableDelayedExpansion
if %winbuild% LSS 9200 if not exist "%SystemRoot%\servicing\Packages\Microsoft-Windows-PowerShell-WTR-Package~*.mum" set _Identity=0

set "SysPath=%SystemRoot%\System32"
set "Path=%SystemRoot%\System32;%SystemRoot%\System32\Wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0\"
if exist "%SystemRoot%\Sysnative\reg.exe" (
set "SysPath=%SystemRoot%\Sysnative"
set "Path=%SystemRoot%\Sysnative;%SystemRoot%\Sysnative\Wbem;%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\;%Path%"
)

set _cwmi=0
for %%# in (wmic.exe) do @if not "%%~$PATH:#"=="" (
wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "ComputerSystem" 1>nul && set _cwmi=1
)

if %_cwmi% EQU 0 (
echo:
echo Error: WMI is not responding in the system.
echo:
echo In MAS, Goto Troubleshoot and run Fix WMI option.
echo:
echo Press any key to go back...
pause >nul
exit /b
)

set "line2=************************************************************"
set "line3=____________________________________________________________"
set "_psc=powershell"

set _prsh=1
for %%# in (powershell.exe) do @if "%%~$PATH:#"=="" set _prsh=0
set "_csg=cscript.exe //NoLogo //Job:WmiMulti "%~nx0?.wsf""
set "_csq=cscript.exe //NoLogo //Job:WmiQuery "%~nx0?.wsf""
set "_csx=cscript.exe //NoLogo //Job:XPDT "%~nx0?.wsf""
if %_cwmi% EQU 0 set WMI_VBS=1
if %WMI_VBS% EQU 0 (
set "_zz1=wmic path"
set "_zz2=where"
set "_zz3=get"
set "_zz4=/value"
set "_zz5=("
set "_zz6=)"
set "_zz7="wmic path"
set "_zz8=/value""
) else (
set "_zz1=%_csq%"
set "_zz2="
set "_zz3="
set "_zz4="
set "_zz5=""
set "_zz6=""
set "_zz7=%_csq%"
set "_zz8="
)
set _WSH=0
set OsppHook=1
sc query osppsvc >nul 2>&1
if %errorlevel% EQU 1060 set OsppHook=0

net start sppsvc /y >nul 2>&1
call :casWpkey %wspp% %winApp% cW1nd0ws sppw
if %winbuild% GEQ 9200 call :casWpkey %wspp% %o15App% c0ff1ce15 sppo
if %OsppHook% NEQ 0 (
net start osppsvc /y >nul 2>&1
call :casWpkey %ospp% %o14App% osppsvc ospp14
if %winbuild% LSS 9200 call :casWpkey %ospp% %o15App% osppsvc ospp15
)

echo %line2%
echo ***                   Windows Status                     ***
echo %line2%
if not defined cW1nd0ws (
echo.
echo Error: product key not found.
goto :casWcon
)
set winID=1
set "_qr=%_zz7% %wspp% %_zz2% %_zz5%ApplicationID='%winApp%' and PartialProductKey is not null%_zz6% %_zz3% ID %_zz8%"
for /f "tokens=2 delims==" %%# in ('%_qr%') do (
  set "chkID=%%#"
  call :casWdet "%wspp%" "%wsps%" "%spp_get%"
  call :casWout
  echo %line3%
  echo.
)

:casWcon
set winID=0
set verbose=1
if not defined c0ff1ce15 (
if defined osppsvc goto :casWospp
goto :casWend
)
echo %line2%
echo ***                   Office Status                      ***
echo %line2%
set "_qr=%_zz7% %wspp% %_zz2% %_zz5%ApplicationID='%o15App%' and PartialProductKey is not null%_zz6% %_zz3% ID %_zz8%"
for /f "tokens=2 delims==" %%# in ('%_qr%') do (
  set "chkID=%%#"
  call :casWdet "%wspp%" "%wsps%" "%spp_get%"
  call :casWout
  echo %line3%
  echo.
)
set verbose=0
if defined osppsvc goto :casWospp
goto :casWend

:casWospp
if %verbose% EQU 1 (
echo %line2%
echo ***                   Office Status                      ***
echo %line2%
)
set "_qr=%_zz7% %ospp% %_zz2% %_zz5%ApplicationID='%o15App%' and PartialProductKey is not null%_zz6% %_zz3% ID %_zz8%"
if defined ospp15 for /f "tokens=2 delims==" %%# in ('%_qr%') do (
  set "chkID=%%#"
  call :casWdet "%ospp%" "%osps%" "%ospp_get%"
  call :casWout
  echo %line3%
  echo.
)
set "_qr=%_zz7% %ospp% %_zz2% %_zz5%ApplicationID='%o14App%' and PartialProductKey is not null%_zz6% %_zz3% ID %_zz8%"
if defined ospp14 for /f "tokens=2 delims==" %%# in ('%_qr%') do (
  set "chkID=%%#"
  call :casWdet "%ospp%" "%osps%" "%ospp_get%"
  call :casWout
  echo %line3%
  echo.
)
goto :casWend

:casWpkey
set "_qr=%_zz1% %1 %_zz2% %_zz5%ApplicationID='%2' and PartialProductKey is not null%_zz6% %_zz3% ID %_zz4%"
%_qr% 2>nul | findstr /i ID 1>nul && (set %3=1&set %4=1)
exit /b

:casWdet
for %%# in (%~3) do set "%%#="
if /i %~1==%ospp% for %%# in (DiscoveredKeyManagementServiceMachineIpAddress, KeyManagementServiceLookupDomain, ProductKeyChannel, VLActivationTypeEnabled) do set "%%#="
set "cKmsClient="
set "cTblClient="
set "cAvmClient="
set "ExpireMsg="
set "_xpr="
set "_qr="wmic path %~1 where ID='%chkID%' get %~3 /value" ^| findstr ^="
if %WMI_VBS% NEQ 0 set "_qr=%_csg% %~1 "ID='%chkID%'" "%~3""
for /f "tokens=* delims=" %%# in ('%_qr%') do set "%%#"

set /a _gpr=(GracePeriodRemaining+1440-1)/1440
echo %Description%| findstr /i VOLUME_KMSCLIENT 1>nul && (set cKmsClient=1&set _mTag=Volume)
echo %Description%| findstr /i TIMEBASED_ 1>nul && (set cTblClient=1&set _mTag=Timebased)
echo %Description%| findstr /i VIRTUAL_MACHINE_ACTIVATION 1>nul && (set cAvmClient=1&set _mTag=Automatic VM)
cmd /c exit /b %LicenseStatusReason%
set "LicenseReason=%=ExitCode%"
set "LicenseMsg=Time remaining: %GracePeriodRemaining% minute(s) (%_gpr% day(s))"
if %_gpr% GEQ 1 if %_WSH% EQU 1 (
for /f "tokens=* delims=" %%# in ('%_csx% %GracePeriodRemaining%') do set "_xpr=%%#"
)
if %_gpr% GEQ 1 if %_prsh% EQU 1 if not defined _xpr (
for /f "tokens=* delims=" %%# in ('%_psc% "$([DateTime]::Now.addMinutes(%GracePeriodRemaining%)).ToString('yyyy-MM-dd HH:mm:ss')" 2^>nul') do set "_xpr=%%#"
title Check Activation Status [wmi]
)

if %LicenseStatus% EQU 0 (
set "License=Unlicensed"
set "LicenseMsg="
)
if %LicenseStatus% EQU 1 (
set "License=Licensed"
set "LicenseMsg="
if %GracePeriodRemaining% EQU 0 (
  if %winID% EQU 1 (set "ExpireMsg=The machine is permanently activated.") else (set "ExpireMsg=The product is permanently activated.")
  ) else (
  set "LicenseMsg=%_mTag% activation expiration: %GracePeriodRemaining% minute(s) (%_gpr% day(s))"
  if defined _xpr set "ExpireMsg=%_mTag% activation will expire %_xpr%"
  )
)
if %LicenseStatus% EQU 2 (
set "License=Initial grace period"
if defined _xpr set "ExpireMsg=Initial grace period ends %_xpr%"
)
if %LicenseStatus% EQU 3 (
set "License=Additional grace period (KMS license expired or hardware out of tolerance)"
if defined _xpr set "ExpireMsg=Additional grace period ends %_xpr%"
)
if %LicenseStatus% EQU 4 (
set "License=Non-genuine grace period."
if defined _xpr set "ExpireMsg=Non-genuine grace period ends %_xpr%"
)
if %LicenseStatus% EQU 6 (
set "License=Extended grace period"
if defined _xpr set "ExpireMsg=Extended grace period ends %_xpr%"
)
if %LicenseStatus% EQU 5 (
set "License=Notification"
  if "%LicenseReason%"=="C004F200" (set "LicenseMsg=Notification Reason: 0xC004F200 (non-genuine)."
  ) else if "%LicenseReason%"=="C004F009" (set "LicenseMsg=Notification Reason: 0xC004F009 (grace time expired)."
  ) else (set "LicenseMsg=Notification Reason: 0x%LicenseReason%"
  )
)
if %LicenseStatus% GTR 6 (
set "License=Unknown"
set "LicenseMsg="
)
if not defined cKmsClient exit /b

if %KeyManagementServicePort%==0 set KeyManagementServicePort=1688
set "KmsReg=Registered KMS machine name: %KeyManagementServiceMachine%:%KeyManagementServicePort%"
if "%KeyManagementServiceMachine%"=="" set "KmsReg=Registered KMS machine name: KMS name not available"

if %DiscoveredKeyManagementServiceMachinePort%==0 set DiscoveredKeyManagementServiceMachinePort=1688
set "KmsDns=KMS machine name from DNS: %DiscoveredKeyManagementServiceMachineName%:%DiscoveredKeyManagementServiceMachinePort%"
if "%DiscoveredKeyManagementServiceMachineName%"=="" set "KmsDns=DNS auto-discovery: KMS name not available"

set "_qr="wmic path %~2 get ClientMachineID, KeyManagementServiceHostCaching /value" ^| findstr ^="
if %WMI_VBS% NEQ 0 set "_qr=%_csg% %~2 "ClientMachineID, KeyManagementServiceHostCaching""
for /f "tokens=* delims=" %%# in ('%_qr%') do set "%%#"
if /i %KeyManagementServiceHostCaching%==True (set KeyManagementServiceHostCaching=Enabled) else (set KeyManagementServiceHostCaching=Disabled)

if %winbuild% LSS 9200 exit /b
if /i %~1==%ospp% exit /b

if "%KeyManagementServiceLookupDomain%"=="" set "KeyManagementServiceLookupDomain="

if %VLActivationTypeEnabled% EQU 3 (
set VLActivationType=Token
) else if %VLActivationTypeEnabled% EQU 2 (
set VLActivationType=KMS
) else if %VLActivationTypeEnabled% EQU 1 (
set VLActivationType=AD
) else (
set VLActivationType=All
)

if %winbuild% LSS 9600 exit /b
if "%DiscoveredKeyManagementServiceMachineIpAddress%"=="" set "DiscoveredKeyManagementServiceMachineIpAddress=not available"
exit /b

:casWout
echo.
echo Name: %Name%
echo Description: %Description%
echo Activation ID: %ID%
echo Extended PID: %ProductKeyID%
if defined ProductKeyChannel echo Product Key Channel: %ProductKeyChannel%
echo Partial Product Key: %PartialProductKey%
echo License Status: %License%
if defined LicenseMsg echo %LicenseMsg%
if not %LicenseStatus%==0 if not %EvaluationEndDate:~0,8%==16010101 echo Evaluation End Date: %EvaluationEndDate:~0,4%-%EvaluationEndDate:~4,2%-%EvaluationEndDate:~6,2% %EvaluationEndDate:~8,2%:%EvaluationEndDate:~10,2% UTC
if not defined cKmsClient (
if defined ExpireMsg echo.&echo.    %ExpireMsg%
exit /b
)
if defined VLActivationTypeEnabled echo Configured Activation Type: %VLActivationType%
echo.
if not %LicenseStatus%==1 (
echo Please activate the product in order to update KMS client information values.
exit /b
)
echo Most recent activation information:
echo Key Management Service client information
echo.    Client Machine ID (CMID): %ClientMachineID%
echo.    %KmsDns%
echo.    %KmsReg%
if defined DiscoveredKeyManagementServiceMachineIpAddress echo.    KMS machine IP address: %DiscoveredKeyManagementServiceMachineIpAddress%
echo.    KMS machine extended PID: %KeyManagementServiceProductKeyID%
echo.    Activation interval: %VLActivationInterval% minutes
echo.    Renewal interval: %VLRenewalInterval% minutes
echo.    KMS host caching: %KeyManagementServiceHostCaching%
if defined KeyManagementServiceLookupDomain echo.    KMS SRV record lookup domain: %KeyManagementServiceLookupDomain%
if defined ExpireMsg echo.&echo.    %ExpireMsg%
exit /b

:casWend
if %_Identity% EQU 1 if %_prsh% EQU 1 (
echo %line2%
echo ***                  Office vNext Status                 ***
echo %line2%
setlocal EnableDelayedExpansion
%_psc% "$f=[IO.File]::ReadAllText('!_batp!') -split ':vNextDiag\:.*';iex ($f[1])"
title Check Activation Status [wmi]
echo %line3%
echo.
)
echo.
call :_color %_Yellow% "Press any key to go back..."
pause >nul
exit /b

:vNextDiag:
function PrintModePerPridFromRegistry
{
	$vNextRegkey = "HKCU:\SOFTWARE\Microsoft\Office\16.0\Common\Licensing\LicensingNext"
	$vNextPrids = Get-Item -Path $vNextRegkey -ErrorAction Ignore | Select-Object -ExpandProperty 'property' | Where-Object -FilterScript {$_.ToLower() -like "*retail" -or $_.ToLower() -like "*volume"}
	If ($vNextPrids -Eq $null)
	{
		Write-Host "No registry keys found."
		Return
	}
	$vNextPrids | ForEach `
	{
		$mode = (Get-ItemProperty -Path $vNextRegkey -Name $_).$_
		Switch ($mode)
		{
			2 { $mode = "vNext"; Break }
			3 { $mode = "Device"; Break }
			Default { $mode = "Legacy"; Break }
		}
		Write-Host $_ = $mode
	}
}
function PrintSharedComputerLicensing
{
	$scaRegKey = "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
	$scaValue = Get-ItemProperty -Path $scaRegKey -ErrorAction Ignore | Select-Object -ExpandProperty "SharedComputerLicensing" -ErrorAction Ignore
	$scaRegKey2 = "HKLM:\SOFTWARE\Microsoft\Office\16.0\Common\Licensing"
	$scaValue2 = Get-ItemProperty -Path $scaRegKey2 -ErrorAction Ignore | Select-Object -ExpandProperty "SharedComputerLicensing" -ErrorAction Ignore
	$scaPolicyKey = "HKLM:\SOFTWARE\Policies\Microsoft\Office\16.0\Common\Licensing"
	$scaPolicyValue = Get-ItemProperty -Path $scaPolicyKey -ErrorAction Ignore | Select-Object -ExpandProperty "SharedComputerLicensing" -ErrorAction Ignore
	If ($scaValue -Eq $null -And $scaValue2 -Eq $null -And $scaPolicyValue -Eq $null)
	{
		Write-Host "No registry keys found."
		Return
	}
	$scaModeValue = $scaValue -Or $scaValue2 -Or $scaPolicyValue
	If ($scaModeValue -Eq 0)
	{
		$scaMode = "Disabled"
	}
	If ($scaModeValue -Eq 1)
	{
		$scaMode = "Enabled"
	}
	Write-Host "SharedComputerLicensing" = $scaMode
	Write-Host
	$tokenFiles = $null
	$tokenPath = "${env:LOCALAPPDATA}\Microsoft\Office\16.0\Licensing"
	If (Test-Path $tokenPath)
	{
		$tokenFiles = Get-ChildItem -Path $tokenPath -Recurse -File -Filter "*authString*"
	}
	If ($tokenFiles.length -Eq 0)
	{
		Write-Host "No tokens found."
		Return
	}
	$tokenFiles | ForEach `
	{
		$tokenParts = (Get-Content -Encoding Unicode -Path $_.FullName).Split('_')
		$output = [PSCustomObject] `
			@{
				ACID = $tokenParts[0];
				User = $tokenParts[3]
				NotBefore = $tokenParts[4];
				NotAfter = $tokenParts[5];
			} | ConvertTo-Json
		Write-Host $output
	}
}
function PrintLicensesInformation
{
	Param(
		[ValidateSet("NUL", "Device")]
		[String]$mode
	)
	If ($mode -Eq "NUL")
	{
		$licensePath = "${env:LOCALAPPDATA}\Microsoft\Office\Licenses"
	}
	ElseIf ($mode -Eq "Device")
	{
		$licensePath = "${env:PROGRAMDATA}\Microsoft\Office\Licenses"
	}
	$licenseFiles = $null
	If (Test-Path $licensePath)
	{
		$licenseFiles = Get-ChildItem -Path $licensePath -Recurse -File
	}
	If ($licenseFiles.length -Eq 0)
	{
		Write-Host "No licenses found."
		Return
	}
	$licenseFiles | ForEach `
	{
		$license = (Get-Content -Encoding Unicode $_.FullName | ConvertFrom-Json).License
		$decodedLicense = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($license)) | ConvertFrom-Json
		$licenseType = $decodedLicense.LicenseType
		If ($null -Ne $decodedLicense.ExpiresOn)
		{
			$expiry = [DateTime]::Parse($decodedLicense.ExpiresOn, $null, 48)
		}
		Else
		{
			$expiry = New-Object DateTime
		}
		$licenseState = $null
		If ((Get-Date) -Gt (Get-Date $decodedLicense.MetaData.NotAfter))
		{
			$licenseState = "RFM"
		}
		ElseIf ((Get-Date) -Lt (Get-Date $expiry))
		{
			$licenseState = "Licensed"
		}
		Else
		{
			$licenseState = "Grace"
		}
		if ($mode -Eq "NUL")
		{
			$output = [PSCustomObject] `
			@{
				Version = $_.Directory.Name
				Type = "User|${licenseType}";
				Product = $decodedLicense.ProductReleaseId;
				Acid = $decodedLicense.Acid;
				LicenseState = $licenseState;
				EntitlementStatus = $decodedLicense.Status;
				EntitlementExpiration = $decodedLicense.ExpiresOn;
				ReasonCode = $decodedLicense.ReasonCode;
				NotBefore = $decodedLicense.Metadata.NotBefore;
				NotAfter = $decodedLicense.Metadata.NotAfter;
				NextRenewal = $decodedLicense.Metadata.RenewAfter;
				TenantId = $decodedLicense.Metadata.TenantId;
			} | ConvertTo-Json
		}
		ElseIf ($mode -Eq "Device")
		{
			$output = [PSCustomObject] `
			@{
				Version = $_.Directory.Name
				Type = "Device|${licenseType}";
				Product = $decodedLicense.ProductReleaseId;
				Acid = $decodedLicense.Acid;
				DeviceId = $decodedLicense.Metadata.DeviceId;
				LicenseState = $licenseState;
				EntitlementStatus = $decodedLicense.Status;
				EntitlementExpiration = $decodedLicense.ExpiresOn;
				ReasonCode = $decodedLicense.ReasonCode;
				NotBefore = $decodedLicense.Metadata.NotBefore;
				NotAfter = $decodedLicense.Metadata.NotAfter;
				NextRenewal = $decodedLicense.Metadata.RenewAfter;
				TenantId = $decodedLicense.Metadata.TenantId;
			} | ConvertTo-Json
		}
		Write-Output $output
	}
}
	Write-Host
	Write-Host "========== Mode per ProductReleaseId =========="
	Write-Host
PrintModePerPridFromRegistry
	Write-Host
	Write-Host "========== Shared Computer Licensing =========="
	Write-Host
PrintSharedComputerLicensing
	Write-Host
	Write-Host "========== vNext licenses =========="
	Write-Host
PrintLicensesInformation -Mode "NUL"
	Write-Host
	Write-Host "========== Device licenses =========="
	Write-Host
PrintLicensesInformation -Mode "Device"
:vNextDiag:

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:troubleshoot
@setlocal DisableDelayedExpansion
@echo off

cls
color 07
title  Troubleshoot

set _elev=
if /i "%~1"=="-el" set _elev=1

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

call :_colorprep

set cbs_log=%SystemRoot%\logs\cbs\cbs.log
set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :_color %Red% "==== ERROR ====" &echo:"
set "line=_________________________________________________________________________________________________"
if %~z0 GEQ 200000 (set "_exitmsg=Go back") else (set "_exitmsg=Exit")

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"

::  Check desktop location

set desktop=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set "desktop=%%b"
if not defined desktop for /f "delims=" %%a in ('%psc% "& {write-host $([Environment]::GetFolderPath('Desktop'))}"') do call set "desktop=%%a"

if not defined desktop (
%eline%
echo Desktop location was not detected, aborting...
goto at_done
)

setlocal EnableDelayedExpansion

::========================================================================================================================================

:at_menu

cls
color 07
title  Troubleshoot
mode con cols=77 lines=30

echo:
echo:
echo:
echo:
echo:       _______________________________________________________________
echo:                                                   
call :_color2 %_White% "             [1] " %_Green% "Help"
echo:             ___________________________________________________
echo:                                                                      
echo:             [2] Dism RestoreHealth
echo:             [3] SFC Scannow
echo:                                                                      
echo:             [4] Fix WMI
echo:             [5] Fix Licensing
echo:             [6] Fix WPA Registry
echo:             ___________________________________________________
echo:
echo:             [0] %_exitmsg%
echo:       _______________________________________________________________
echo:          
call :_color2 %_White% "            " %_Green% "Enter a menu option in the Keyboard :"
choice /C:1234560 /N
set _erl=%errorlevel%

if %_erl%==7 exit /b
if %_erl%==6 start https://massgrave.dev/fix-wpa-registry.html &goto at_menu
if %_erl%==5 goto:retokens
if %_erl%==4 goto:fixwmi
if %_erl%==3 goto:sfcscan
if %_erl%==2 goto:dism_rest
if %_erl%==1 start https://massgrave.dev/troubleshoot.html &goto at_menu
goto :at_menu

::========================================================================================================================================

:dism_rest

cls
mode 98, 30
title  Dism /English /Online /Cleanup-Image /RestoreHealth

if %winbuild% LSS 9200 (
%eline%
echo Unsupported OS version Detected.
echo This command is supported only for Windows 8/8.1/10/11 and their Server equivalent.
goto :at_back
)

set _int=
for %%a in (l.root-servers.net resolver1.opendns.com download.windowsupdate.com google.com) do if not defined _int (
for /f "delims=[] tokens=2" %%# in ('ping -n 1 %%a') do (if not [%%#]==[] set _int=1)
)

echo:
if defined _int (
echo      Checking Internet Connection  [Connected]
) else (
call :_color2 %_White% "     " %Red% "Checking Internet Connection  [Not connected]"
)

echo %line%
echo:
echo      Dism uses Windows Update to provide the files required to fix corruption.
echo      This will take 5-15 minutes or more..
echo %line%
echo:
echo      Notes:
echo:
call :_color2 %_White% "     - " %Gray% "Make sure the Internet is connected."
call :_color2 %_White% "     - " %Gray% "Make sure the Windows update is properly working."
echo:
echo %line%
echo:
choice /C:09 /N /M ">    [9] Continue [0] Go back : "
if %errorlevel%==1 goto at_menu

cls
mode 110, 30
echo:

call :_stopservice TrustedInstaller
del /s /f /q "%SystemRoot%\logs\cbs\*.*"

set _time=
for /f %%a in ('%psc% "Get-Date -format HH_mm_ss"') do set _time=%%a
echo:
echo Applying the command,
echo dism /english /online /cleanup-image /restorehealth
echo:
dism /english /online /cleanup-image /restorehealth /Logpath:"%SystemRoot%\Temp\RHealth_DISM_%_time%.txt" /loglevel:4

if not exist "!desktop!\AT_Logs\" md "!desktop!\AT_Logs\" %nul%
copy /y /b "%SystemRoot%\Temp\RHealth_DISM_%_time%.txt" "!desktop!\AT_Logs\RHealth_DISM_%_time%.txt" %nul%
copy /y /b "%cbs_log%" "!desktop!\AT_Logs\RHealth_CBS_%_time%.txt" %nul%
del /f /q "%SystemRoot%\Temp\RHealth_DISM_%_time%.txt" %nul%

echo:
call :_color %Gray% "CBS and DISM logs are copied to the AT_Logs folder on the dekstop."
goto :at_back

::========================================================================================================================================

:sfcscan

cls
mode 98, 30
title  sfc /scannow

echo:
echo %line%
echo:    
echo      System File Checker will repair missing or corrupted system files.
echo      This will take 10-15 minutes or more..
echo:
echo      If SFC could not fix something, then run the command again to see if it may be able 
echo      to the next time. Sometimes it may take running the sfc /scannow command 3 times
echo      restarting the PC after each time to completely fix everything that it's able to.
echo:   
echo %line%
echo:
choice /C:09 /N /M ">    [9] Continue [0] Go back : "
if %errorlevel%==1 goto at_menu

cls
echo:

call :_stopservice TrustedInstaller
del /s /f /q "%SystemRoot%\logs\cbs\*.*"

set _time=
for /f %%a in ('%psc% "Get-Date -format HH_mm_ss"') do set _time=%%a
echo:
echo Applying the command,
echo sfc /scannow
echo:
sfc /scannow

if not exist "!desktop!\AT_Logs\" md "!desktop!\AT_Logs\" %nul%

copy /y /b "%cbs_log%" "!desktop!\AT_Logs\SFC_CBS_%_time%.txt" %nul%

echo:
call :_color %Gray% "CBS log is copied to the AT_Logs folder on the dekstop."
goto :at_back

::========================================================================================================================================

:retokens

cls
mode con cols=115 lines=32
%nul% %psc% "&{$W=$Host.UI.RawUI.WindowSize;$B=$Host.UI.RawUI.BufferSize;$W.Height=31;$B.Height=200;$Host.UI.RawUI.WindowSize=$W;$Host.UI.RawUI.BufferSize=$B;}"
title  Fix Licensing ^(ClipSVC ^+ Office vNext ^+ SPP ^+ OSPP^)

echo:
echo %line%
echo:   
echo      Notes:
echo:
echo       - It helps in troubleshooting activation issues.
echo:
echo       - This option will,
echo            - Deactivate Windows and Office, you may need to reactivate
echo            - Clear ClipSVC, Office vNext, SPP and OSPP licenses
echo            - Fix SPP permissions of tokens folder and registries
echo            - Trigger the repair option for Office.
echo:
call :_color2 %_White% "      - " %Red% "Apply it only when it is necessary."
echo:
echo %line%
echo:
choice /C:09 /N /M ">    [9] Continue [0] Go back : "
if %errorlevel%==1 goto at_menu

::========================================================================================================================================

::  Rebuild ClipSVC Licences

cls
:cleanlicensing

echo:
echo %line%
echo:
call :_color %Magenta% "Rebuilding ClipSVC Licences"
echo:

if %winbuild% LSS 10240 (
echo ClipSVC Licence rebuilding is supported only on Win 10/11 and Server equivalent.
echo Skipping...
goto :cleanvnext
)

%psc% "(([WMISEARCHER]'SELECT Name FROM SoftwareLicensingProduct WHERE LicenseStatus=1 AND GracePeriodRemaining=0 AND PartialProductKey IS NOT NULL').Get()).Name" 2>nul | findstr /i "Windows" 1>nul && (
echo Windows is permanently activated.
echo Skipping rebuilding ClipSVC licences...
goto :cleanvnext
)

echo Stopping ClipSVC service...
call :_stopservice ClipSVC
timeout /t 2 %nul%

echo:
echo Applying the command to Clean ClipSVC Licences...
echo rundll32 clipc.dll,ClipCleanUpState

rundll32 clipc.dll,ClipCleanUpState

if %winbuild% LEQ 10240 (
echo [Successful]
) else (
if exist "%ProgramData%\Microsoft\Windows\ClipSVC\tokens.dat" (
call :_color %Red% "[Failed]"
) else (
echo [Successful]
)
)

::  Below registry key (Volatile & Protected) gets created after the ClipSVC License cleanup command, and gets automatically deleted after 
::  system restart. It needs to be deleted to activate the system without restart.

set "RegKey=HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ClipSVC\Volatile\PersistedSystemState"
set "_ident=HKU\S-1-5-19\SOFTWARE\Microsoft\IdentityCRL"

reg query "%RegKey%" %nul% && %nul% call :regownstart
reg delete "%RegKey%" /f %nul% 

echo:
echo Deleting a Volatile ^& Protected Registry Key...
echo [%RegKey%]
reg query "%RegKey%" %nul% && (
call :_color %Red% "[Failed]"
echo Restart the system, that will delete this registry key automatically.
) || (
echo [Successful]
)

::   Clear HWID token related registry to fix activation incase if there is any corruption

echo:
echo Deleting a IdentityCRL Registry Key...
echo [%_ident%]
reg delete "%_ident%" /f %nul%
reg query "%_ident%" %nul% && (
call :_color %Red% "[Failed]"
) || (
echo [Successful]
)

call :_stopservice ClipSVC

::  Rebuild ClipSVC folder to fix permission issues

echo:
if %winbuild% GTR 10240 (
echo Deleting Folder %ProgramData%\Microsoft\Windows\ClipSVC\
rmdir /s /q "C:\ProgramData\Microsoft\Windows\ClipSvc" %nul%

if exist "%ProgramData%\Microsoft\Windows\ClipSVC\" (
call :_color %Red% "[Failed]"
) else (
echo [Successful]
)

echo:
echo Rebuilding Folder %ProgramData%\Microsoft\Windows\ClipSVC\
net start ClipSVC /y %nul%
timeout /t 3 %nul%
if not exist "%ProgramData%\Microsoft\Windows\ClipSVC\" timeout /t 5 %nul%
if not exist "%ProgramData%\Microsoft\Windows\ClipSVC\" (
call :_color %Red% "[Failed]"
) else (
echo [Successful]
)
)

echo:
echo Restarting [wlidsvc LicenseManager] services...
for %%# in (wlidsvc LicenseManager) do (net stop %%# /y %nul% & net start %%# /y %nul%)

::========================================================================================================================================

::  Clear Office vNext License

:cleanvnext

echo:
echo %line%
echo:
call :_color %Magenta% "Clearing Office vNext License"
echo:

setlocal DisableDelayedExpansion
set "_Local=%LocalAppData%"
setlocal EnableDelayedExpansion

attrib -R "!ProgramData!\Microsoft\Office\Licenses" %nul%
attrib -R "!_Local!\Microsoft\Office\Licenses" %nul%

if exist "!ProgramData!\Microsoft\Office\Licenses\" (
rd /s /q "!ProgramData!\Microsoft\Office\Licenses\" %nul%
if exist "!ProgramData!\Microsoft\Office\Licenses\" (
echo Failed To Delete - !ProgramData!\Microsoft\Office\Licenses\
) else (
echo Deleted Folder - !ProgramData!\Microsoft\Office\Licenses\
)
) else (
echo Not Found - !ProgramData!\Microsoft\Office\Licenses\
)

if exist "!_Local!\Microsoft\Office\Licenses\" (
rd /s /q "!_Local!\Microsoft\Office\Licenses\" %nul%
if exist "!_Local!\Microsoft\Office\Licenses\" (
echo Failed To Delete - !_Local!\Microsoft\Office\Licenses\
) else (
echo Deleted Folder - !_Local!\Microsoft\Office\Licenses\
)
) else (
echo Not Found - !_Local!\Microsoft\Office\Licenses\
)

echo:
for %%# in (
HKCU\Software\Microsoft\Office\16.0\Common\Licensing
HKCU\Software\Microsoft\Office\16.0\Registration
) do (
reg query %%# %nul% && (
reg delete %%# /f %nul% && (
echo Deleted Registry - %%#
) || (
echo Failed to Delete - %%#
)
) || (
echo Not Found Registry - %%#
)
)

::========================================================================================================================================

::  Rebuild SPP Tokens

echo:
echo %line%
echo:
call :_color %Magenta% "Rebuilding SPP Licensing Tokens"
echo:

call :scandat check

if not defined token (
call :_color %Red% "tokens.dat file not found."
) else (
echo tokens.dat file: [%token%]
)

if %winbuild% GEQ 14393 (
set wpaerror=
set /a count=0
for /f %%a in ('reg query "HKLM\SYSTEM\WPA" 2^>nul') do set /a count+=1
for /L %%# in (1,1,!count!) do (
reg query "HKLM\SYSTEM\WPA\8DEC0AF1-0341-4b93-85CD-72606C2DF94C-7P-%%#" /ve /t REG_BINARY %nul% || set wpaerror=1
)

if defined wpaerror (
echo:
echo Checking WPA Registry Keys...
call :_color %Red% "[Error Found] [Registry Count - !count!]"
)
)

set tokenstore=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v TokenStore 2^>nul') do call set "tokenstore=%%b"

::  Check sppsvc permissions and apply fixes

if %winbuild% GEQ 10240 (

echo:
echo Checking SPP permission related issues...
call :checkperms

if defined permerror (

mkdir "%tokenstore%" %nul%
set "d=$sddl = 'O:BAG:BAD:PAI(A;OICI;FA;;;SY)(A;OICI;FA;;;BA)(A;OICIIO;GR;;;BU)(A;;FR;;;BU)(A;OICI;FA;;;S-1-5-80-123231216-2592883651-3715271367-3753151631-4175906628)';"
set "d=!d! $AclObject = New-Object System.Security.AccessControl.DirectorySecurity;"
set "d=!d! $AclObject.SetSecurityDescriptorSddlForm($sddl);"
set "d=!d! Set-Acl -Path %tokenstore% -AclObject $AclObject;"
%psc% "!d!" %nul%

for %%# in (
"HKLM:\SYSTEM\WPA_QueryValues, EnumerateSubKeys, WriteKey"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform_SetValue"
) do for /f "tokens=1,2 delims=_" %%A in (%%#) do (
set "d=$acl = Get-Acl '%%A';"
set "d=!d! $rule = New-Object System.Security.AccessControl.RegistryAccessRule ('NT Service\sppsvc', '%%B', 'ContainerInherit, ObjectInherit','None','Allow');"
set "d=!d! $acl.ResetAccessRule($rule);"
set "d=!d! $acl.SetAccessRule($rule);"
set "d=!d! Set-Acl -Path '%%A' -AclObject $acl"
%psc% "!d!" %nul%
)

call :checkperms
if defined permerror (
call :_color %Red% "[Failed To Fix]"
) else (
echo [Successfully Fixed]
)
) else (
echo [Error Not Found]
)
)

echo:
echo Stopping sppsvc service...
call :_stopservice sppsvc

echo:
call :scandat delete
call :scandat check

if defined token (
echo:
call :_color %Red% "Failed to delete .dat files."
echo:
)

echo:
echo Reinstalling System Licenses [slmgr /rilc]...
cscript //nologo %windir%\system32\slmgr.vbs /rilc %nul%
if %errorlevel% NEQ 0 cscript //nologo %windir%\system32\slmgr.vbs /rilc %nul%
if %errorlevel% EQU 0 (
echo [Successful]
) else (
call :_color %Red% "[Failed]"
)

call :scandat check

echo:
if not defined token (
call :_color %Red% "Failed to rebuilt tokens.dat file."
) else (
echo tokens.dat file was rebuilt successfully.
)

::========================================================================================================================================

::  Rebuild OSPP Tokens

echo:
echo %line%
echo:
call :_color %Magenta% "Rebuilding OSPP Licensing Tokens"
echo:

sc qc osppsvc %nul% || (
echo OSPP based Office is not installed
echo Skipping rebuilding OSPP tokens...
goto :repairoffice
)

call :scandatospp check

if not defined token (
call :_color %Red% "tokens.dat file not found."
) else (
echo tokens.dat file: [%token%]
)

echo:
echo Stopping osppsvc service...
call :_stopservice osppsvc

echo:
call :scandatospp delete
call :scandatospp check

if defined token (
echo:
call :_color %Red% "Failed to delete .dat files."
echo:
)

echo:
echo Starting osppsvc service to generate tokens.dat
call :_startservice osppsvc
call :scandatospp check
if not defined token (
call :_stopservice osppsvc
call :_startservice osppsvc
timeout /t 3 %nul%
)

call :scandatospp check

echo:
if not defined token (
call :_color %Red% "Failed to rebuilt tokens.dat file."
) else (
echo tokens.dat file was rebuilt successfully.
)

::========================================================================================================================================

:repairoffice

echo:
echo %line%
echo:
call :_color %Magenta% "Repairing Office Licenses"
echo:

for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PROCESSOR_ARCHITECTURE') do set arch=%%b

if /i "%arch%"=="ARM64" (
echo:
echo ARM64 Windows Found.
echo You need to use repair option in Windows settings for Office.
echo:
start ms-settings:appsfeatures
goto :repairend
)

if /i "%arch%"=="x86" (
set arch=X86
) else (
set arch=X64
)

for %%# in (68 86) do (
for %%A in (msi14 msi15 msi16 c2r14 c2r15 c2r16) do (set %%A_%%#=&set %%Arepair%%#=)
)

set _68=HKLM\SOFTWARE\Microsoft\Office
set _86=HKLM\SOFTWARE\Wow6432Node\Microsoft\Office

%nul% reg query %_68%\14.0\Common\InstallRoot /v Path  && (set "msi14_68=Office 14.0 MSI x86/x64"  & set "msi14repair68=%systemdrive%\Program Files\Common Files\microsoft shared\OFFICE14\Office Setup Controller\Setup.exe")
%nul% reg query %_86%\14.0\Common\InstallRoot /v Path  && (set "msi14_86=Office 14.0 MSI x86"      & set "msi14repair86=%systemdrive%\Program Files (x86)\Common Files\Microsoft Shared\OFFICE14\Office Setup Controller\Setup.exe")
%nul% reg query %_68%\15.0\Common\InstallRoot /v Path  && (set "msi15_68=Office 15.0 MSI x86/x64"  & set "msi15repair68=%systemdrive%\Program Files\Common Files\microsoft shared\OFFICE15\Office Setup Controller\Setup.exe")
%nul% reg query %_86%\15.0\Common\InstallRoot /v Path  && (set "msi15_86=Office 15.0 MSI x86"      & set "msi15repair86=%systemdrive%\Program Files (x86)\Common Files\Microsoft Shared\OFFICE15\Office Setup Controller\Setup.exe")
%nul% reg query %_68%\16.0\Common\InstallRoot /v Path  && (set "msi16_68=Office 16.0 MSI x86/x64"  & set "msi16repair68=%systemdrive%\Program Files\Common Files\Microsoft Shared\OFFICE16\Office Setup Controller\Setup.exe")
%nul% reg query %_86%\16.0\Common\InstallRoot /v Path  && (set "msi16_86=Office 16.0 MSI x86"      & set "msi16repair86=%systemdrive%\Program Files (x86)\Common Files\Microsoft Shared\OFFICE16\Office Setup Controller\Setup.exe")
%nul% reg query %_68%\14.0\CVH /f Click2run /k         && (set "c2r14_68=Office 14.0 C2R x86/x64"  & set "c2r14repair68=")
%nul% reg query %_86%\14.0\CVH /f Click2run /k         && (set "c2r14_86=Office 14.0 C2R x86"      & set "c2r14repair86=")
%nul% reg query %_68%\15.0\ClickToRun /v InstallPath   && (set "c2r15_68=Office 15.0 C2R x86/x64"  & set "c2r15repair68=%systemdrive%\Program Files\Microsoft Office 15\Client%arch%\integratedoffice.exe")
%nul% reg query %_86%\15.0\ClickToRun /v InstallPath   && (set "c2r15_86=Office 15.0 C2R x86"      & set "c2r15repair86=%systemdrive%\Program Files\Microsoft Office 15\Client%arch%\integratedoffice.exe")
%nul% reg query %_68%\ClickToRun /v InstallPath        && (set "c2r16_68=Office 16.0 C2R x86/x64"  & set "c2r16repair68=%systemdrive%\Program Files\Microsoft Office 15\Client%arch%\OfficeClickToRun.exe")
%nul% reg query %_86%\ClickToRun /v InstallPath        && (set "c2r16_86=Office 16.0 C2R x86"      & set "c2r16repair86=%systemdrive%\Program Files\Microsoft Office 15\Client%arch%\OfficeClickToRun.exe")

set uwp16=
if %winbuild% GEQ 10240 (
dir /b "%ProgramFiles%\WindowsApps\Microsoft.Office.Desktop*" %nul% && set uwp16=Office 16.0 UWP
dir /b "%ProgramW6432%\WindowsApps\Microsoft.Office.Desktop*" %nul% && set uwp16=Office 16.0 UWP
dir /b "%ProgramFiles(x86)%\WindowsApps\Microsoft.Office.Desktop*" %nul% && set uwp16=Office 16.0 UWP
%psc% "Get-AppxPackage -name "Microsoft.Office.Desktop"" | find /i "Office" 1>nul && set uwp16=Office 16.0 UWP
)

set /a counter=0
echo Checking installed Office versions...
echo:

for %%# in (
"%msi14_68%"
"%msi14_86%"
"%msi15_68%"
"%msi15_86%"
"%msi16_68%"
"%msi16_86%"
"%c2r14_68%"
"%c2r14_86%"
"%c2r15_68%"
"%c2r15_86%"
"%c2r16_68%"
"%c2r16_86%"
"%uwp16%"
) do (
if not "%%#"=="""" (
set insoff=%%#
set insoff=!insoff:"=!
echo [!insoff!]
set /a counter+=1
)
)

if %counter% GTR 1 (
%eline%
echo Multiple office versions found.
echo It's recommended to install only one version of office.
echo ________________________________________________________________
echo:
)

if %counter% EQU 0 (
echo:
echo Installed Office is not found.
goto :repairend
echo:
) else (
echo:
call :_color %_Yellow% "A Window will popup, in that Window you need to select [Quick] Repair Option..."
call :_color %_Yellow% "Press any key to continue..."
echo:
pause >nul
)

if defined uwp16 (
echo:
echo Note: Skipping repair for Office 16.0 UWP. 
echo       You need to use reset option in Windows settings for it.
echo ________________________________________________________________
echo:
start ms-settings:appsfeatures
)

set c2r14=
if defined c2r14_68 set c2r14=1
if defined c2r14_86 set c2r14=1

if defined c2r14 (
echo:
echo Note: Skipping repair for Office 14.0 C2R 
echo       You need to use Repair option in Windows settings for it.
echo ________________________________________________________________
echo:
start appwiz.cpl
)

if defined msi14_68 if exist "%msi14repair68%" echo Running - "%msi14repair68%"                    & "%msi14repair68%"
if defined msi14_86 if exist "%msi14repair86%" echo Running - "%msi14repair86%"                    & "%msi14repair86%"
if defined msi15_68 if exist "%msi15repair68%" echo Running - "%msi15repair68%"                    & "%msi15repair68%"
if defined msi15_86 if exist "%msi15repair86%" echo Running - "%msi15repair86%"                    & "%msi15repair86%"
if defined msi16_68 if exist "%msi16repair68%" echo Running - "%msi16repair68%"                    & "%msi16repair68%"
if defined msi16_86 if exist "%msi16repair86%" echo Running - "%msi16repair86%"                    & "%msi16repair86%"
if defined c2r15_68 if exist "%c2r15repair68%" echo Running - "%c2r15repair68%" REPAIRUI RERUNMODE & "%c2r15repair68%" REPAIRUI RERUNMODE
if defined c2r15_86 if exist "%c2r15repair86%" echo Running - "%c2r15repair86%" REPAIRUI RERUNMODE & "%c2r15repair86%" REPAIRUI RERUNMODE
if defined c2r16_68 if exist "%c2r16repair68%" echo Running - "%c2r16repair68%" scenario=Repair    & "%c2r16repair68%" scenario=Repair
if defined c2r16_86 if exist "%c2r16repair86%" echo Running - "%c2r16repair86%" scenario=Repair    & "%c2r16repair86%" scenario=Repair

:repairend

echo:
echo %line%
echo:
echo:
call :_color %Green% "Finished"
goto :at_back

::========================================================================================================================================

:fixwmi

cls
mode 98, 34
title  Fix WMI

::  https://techcommunity.microsoft.com/t5/ask-the-performance-team/wmi-repository-corruption-or-not/ba-p/375484

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
%eline%
echo WMI rebuild is not recommended on Windows Server. Aborting...
goto :at_back
)

for %%# in (wmic.exe) do @if "%%~$PATH:#"=="" (
%eline%
echo wmic.exe file is not found in the system. Aborting...
goto :at_back
)

echo:
echo Checking WMI

set error=
wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul
if %errorlevel% NEQ 0 set error=1
winmgmt /verifyrepository %nul%
if %errorlevel% NEQ 0 set error=1

if not defined error (
echo [Working]
echo No need to apply this option. Aborting...
goto :at_back
)

call :_color %Red% "[Not Responding]"

echo:
sc query Winmgmt %nul% || (
%eline%
echo Winmgmt service is not installed. Aborting...
goto :at_back
)

echo Disabling Winmgmt service
sc config Winmgmt start= disabled %nul%
if %errorlevel% EQU 0 (
echo [Successful]
) else (
call :_color %Red% "[Failed] Aborting..."
sc config Winmgmt start= auto %nul%
goto :at_back
)

echo:
echo Stopping Winmgmt service
call :_stopservice Winmgmt
call :_stopservice Winmgmt
call :_stopservice Winmgmt
sc query Winmgmt | find /i "1  STOPPED" %nul% && (
echo [Successful]
) || (
call :_color %Red% "[Failed]"
echo:
call :_color %Magenta% "Its recommended to select [Restart] option and then apply Fix WMI option again."
echo %line%
echo:
choice /C:21 /N /M "> [1] Restart  [2] Revert Back Changes :"
if !errorlevel!==1 (sc config Winmgmt start= auto %nul%&goto :at_back)
echo:
echo Restarting...
shutdown -t 5 -r
exit
)

echo:
echo Deleting WMI repository
rmdir /s /q "%windir%\System32\wbem\repository\" %nul%
if exist "%windir%\System32\wbem\repository\" (
call :_color %Red% "[Failed]"
) else (
echo [Successful]
)

echo:
echo Enabling Winmgmt service
sc config Winmgmt start= auto %nul%
if %errorlevel% EQU 0 (
echo [Successful]
) else (
call :_color %Red% "[Failed]"
)

wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul
if %errorlevel% EQU 0 (
echo:
echo Checking WMI
call :_color %Green% "[Working]"
goto :at_back
)

echo:
echo Registering .dll's and Compiling .mof's, .mfl's
call :registerobj %nul%

echo:
echo Checking WMI
wmic path Win32_ComputerSystem get CreationClassName /value 2>nul | find /i "computersystem" 1>nul
if %errorlevel% NEQ 0 (
call :_color %Red% "[Not Responding]"
echo:
echo Run [Dism RestoreHealth] and [SFC Scannow] options and make sure there are no errors.
) else (
call :_color %Green% "[Working]"
)

goto :at_back

:registerobj

::  https://eskonr.com/2012/01/how-to-fix-wmi-issues-automatically/

call :_stopservice Winmgmt
cd /d %systemroot%\system32\wbem\
regsvr32 /s %systemroot%\system32\scecli.dll
regsvr32 /s %systemroot%\system32\userenv.dll
mofcomp cimwin32.mof
mofcomp cimwin32.mfl
mofcomp rsop.mof
mofcomp rsop.mfl
for /f %%s in ('dir /b /s *.dll') do regsvr32 /s %%s
for /f %%s in ('dir /b *.mof') do mofcomp %%s
for /f %%s in ('dir /b *.mfl') do mofcomp %%s

winmgmt /salvagerepository
winmgmt /resetrepository
exit /b

::========================================================================================================================================

:at_back

echo:
echo %line%
echo:
call :_color %_Yellow% "Press any key to go back..."
pause >nul
goto :at_menu

::========================================================================================================================================

:at_done

echo:
echo Press any key to %_exitmsg%...
pause >nul
exit /b

::========================================================================================================================================

:_stopservice

for %%# in (%1) do (
sc query %%# | find /i "STOPPED" %nul% || net stop %%# /y %nul%
sc query %%# | find /i "STOPPED" %nul% || sc stop %%# %nul%
)
exit /b

:_startservice

for %%# in (%1) do (
sc query %%# | find /i "RUNNING" %nul% || net start %%# /y %nul%
sc query %%# | find /i "RUNNING" %nul% || sc start %%# %nul%
)
exit /b

::========================================================================================================================================

:checkperms

set permerror=
if not exist "%tokenstore%\" set permerror=1

for %%# in (
"%tokenstore%"
"HKLM:\SYSTEM\WPA"
"HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
) do if not defined permerror (
%psc% "$acl = Get-Acl '%%#'; if ($acl.Access.Where{ $_.IdentityReference -eq 'NT SERVICE\sppsvc' -and $_.AccessControlType -eq 'Deny' -or $acl.Access.IdentityReference -notcontains 'NT SERVICE\sppsvc'}) {Exit 2}" %nul%
if !errorlevel!==2 set permerror=1
)
exit /b

::========================================================================================================================================

:scandat

set token=
for %%# in (
%Systemdrive%\Windows\System32\spp\store_test\2.0\
%Systemdrive%\Windows\System32\spp\store\
%Systemdrive%\Windows\System32\spp\store\2.0\
%Systemdrive%\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform\
) do (

if %1==check (
if exist %%#tokens.dat set token=%%#tokens.dat
)

if %1==delete (
if exist %%# (
%nul% dir /a-d /s "%%#*.dat" && (
attrib -r -s -h "%%#*.dat" /S
del /S /F /Q "%%#*.dat"
)
)
)
)
exit /b

:scandatospp

set token=
for %%# in (
%ProgramData%\Microsoft\OfficeSoftwareProtectionPlatform\
) do (

if %1==check (
if exist %%#tokens.dat set token=%%#tokens.dat
)

if %1==delete (
if exist %%# (
%nul% dir /a-d /s "%%#*.dat" && (
attrib -r -s -h "%%#*.dat" /S
del /S /F /Q "%%#*.dat"
)
)
)
)
exit /b

::========================================================================================================================================

:regownstart

%psc% "$f=[io.file]::ReadAllText('!_batp!') -split ':regown\:.*';iex ($f[1]);"
exit /b

::  Below code takes ownership of a volatile registry key and deletes it
::  HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ClipSVC\Volatile\PersistedSystemState

:regown:
$AssemblyBuilder = [AppDomain]::CurrentDomain.DefineDynamicAssembly(4, 1)
$ModuleBuilder = $AssemblyBuilder.DefineDynamicModule(2, $False)
$TypeBuilder = $ModuleBuilder.DefineType(0)

$TypeBuilder.DefinePInvokeMethod('RtlAdjustPrivilege', 'ntdll.dll', 'Public, Static', 1, [int], @([int], [bool], [bool], [bool].MakeByRefType()), 1, 3) | Out-Null
$TypeBuilder.CreateType()::RtlAdjustPrivilege(9, $true, $false, [ref]$false) | Out-Null

$SID = New-Object System.Security.Principal.SecurityIdentifier('S-1-5-32-544')
$IDN = ($SID.Translate([System.Security.Principal.NTAccount])).Value
$Admin = New-Object System.Security.Principal.NTAccount($IDN)

$path = 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\ClipSVC\Volatile\PersistedSystemState'
$key = [Microsoft.Win32.RegistryKey]::OpenBaseKey('LocalMachine', 'Registry64').OpenSubKey($path, 'ReadWriteSubTree', 'takeownership')

$acl = $key.GetAccessControl()
$acl.SetOwner($Admin)
$key.SetAccessControl($acl)

$rule = New-Object System.Security.AccessControl.RegistryAccessRule($Admin,"FullControl","Allow")
$acl.SetAccessRule($rule)
$key.SetAccessControl($acl)
:regown:

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:insert_hwidkey
@setlocal DisableDelayedExpansion
@echo off

cls
color 07
title  Install Windows HWID Key

set _args=
set _elev=
set _unattended=0

set _args=%*
if defined _args set _args=%_args:"=%
if defined _args (
for %%A in (%_args%) do (
if /i "%%A"=="-el" set _elev=1
if /i "%%A"=="/Insert-HWID-Key"  set _unattended=1
)
)

::========================================================================================================================================

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"
set     "Red="41;97m""
set   "Green="42;97m""
set  "_Green="40;92m""
set "_Yellow="40;93m""
) else (
set     "Red="Red" "white""
set   "Green="DarkGreen" "white""
set  "_Green="Black" "Green""
set "_Yellow="Black" "Yellow""
)

set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :dk_color %Red% "==== ERROR ====" &echo:"
set "line=echo ___________________________________________________________________________________________"
if %~z0 GEQ 200000 (set "_exitmsg=Go back") else (set "_exitmsg=Exit")

::========================================================================================================================================

if %winbuild% LSS 10240 (
%eline%
echo Unsupported OS version detected.
echo This option is supported only for Windows 10/11.
goto ins_done
)

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
%eline%
echo HWID Activation is not supported for Windows Server.
goto ins_done
)

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"

setlocal EnableDelayedExpansion

::========================================================================================================================================

cls
mode 98, 30
echo:
echo Initializing...
call :dk_product
call :dk_ckeckwmic
call :dk_actids

::========================================================================================================================================

::  Check SKU value / Check in multiple places to find Edition change corruption

set osSKU=
set regSKU=
set wmiSKU=

for /f "tokens=3 delims=." %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v OSProductPfn 2^>nul') do set "regSKU=%%a"
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%a in ('"wmic Path Win32_OperatingSystem Get OperatingSystemSKU /format:LIST" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"
if %_wmic% EQU 0 for /f "tokens=1" %%a in ('%psc% "([WMI]'Win32_OperatingSystem=@').OperatingSystemSKU" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"

set osSKU=%wmiSKU%
if not defined osSKU set osSKU=%regSKU%

if not defined osSKU (
%eline%
echo SKU value was not detected properly. Aborting...
goto ins_done
)

::========================================================================================================================================

::  Detect key

set key=
set _channel=
set actidnotfound=

for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildBranch 2^>nul') do set "branch=%%b"

if defined applist call :hwiddata key attempt1
if not defined key call :hwiddata key attempt2

if not defined key (
%eline%
echo [%winos% ^| %winbuild% ^| SKU:%osSKU%]
echo Unable to find this product in the HWID supported product list.
echo Make sure you are using updated version of the script.
echo https://massgrave.dev
goto ins_done
)

::========================================================================================================================================

if %_unattended%==1 goto insertkey

cls
%line%
echo:
echo Install [%winos% ^| SKU:%osSKU% ^| %winbuild%] %channel% Key
echo [%key%]
%line%
echo:
if not "%regSKU%"=="%wmiSKU%" (
echo Note: Difference Found In SKU Value- WMI:%wmiSKU% Reg:%regSKU%
echo:
)
call :dk_color %_Green% "Press [1] to Continue or [0] to %_exitmsg%"
choice /C:01 /N
if %errorlevel%==1 exit /b

::========================================================================================================================================

:insertkey

cls
%line%

if %_wmic% EQU 1 wmic path SoftwareLicensingService where __CLASS='SoftwareLicensingService' call InstallProductKey ProductKey="%key%" %nul%
if %_wmic% EQU 0 %psc% "(([WMISEARCHER]'SELECT Version FROM SoftwareLicensingService').Get()).InstallProductKey('%key%')" %nul%
if not %errorlevel%==0 cscript //nologo %windir%\system32\slmgr.vbs /ipk %key% %nul%

set error_code=%errorlevel%
cmd /c exit /b %error_code%
if %error_code% NEQ 0 set "error_code=[0x%=ExitCode%]"

echo:
echo [%winos% ^| SKU:%osSKU% ^| %winbuild%]


if %error_code% EQU 0 (
call :dk_refresh
call :dk_channel
call echo Installing %%_channel%% [%key%]
echo:
call :dk_color %Green% "[Successful]"
) else (
echo Installing [%key%]
echo:
call :dk_color %Red% "[Unsuccessful] %error_code%"
if defined actidnotfound call :dk_color %Red% "Activation ID not found for this key."
echo Check this page for help https://massgrave.dev/troubleshoot
)
%line%

::========================================================================================================================================

:ins_done

echo:
if %_unattended%==1 timeout /t 2 & exit /b
call :dk_color %_Yellow% "Press any key to %_exitmsg%..."
pause >nul
exit /b

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:change_edition
@setlocal DisableDelayedExpansion
@echo off

::  To stage current edition while changing edition with CBS Upgrade Method, change 0 to 1 in below line
set _stg=0

cls
color 07
title  Change Windows Edition

set _elev=
if /i "%~1"=="-el" set _elev=1

set winbuild=1
set "nul=>nul 2>&1"
set psc=powershell.exe
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"
set     "Red="41;97m""
set    "Gray="100;97m""
set   "Green="42;97m""
set "Magenta="45;97m""
set  "_White="40;37m""
set  "_Green="40;92m""
set "_Yellow="40;93m""
) else (
set     "Red="Red" "white""
set    "Gray="Darkgray" "white""
set   "Green="DarkGreen" "white""
set "Magenta="Darkmagenta" "white""
set  "_White="Black" "Gray""
set  "_Green="Black" "Green""
set "_Yellow="Black" "Yellow""
)

set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :dk_color %Red% "==== ERROR ====" &echo:"
set "line=echo ___________________________________________________________________________________________"
if %~z0 GEQ 200000 (set "_exitmsg=Go back") else (set "_exitmsg=Exit")

::========================================================================================================================================

::  Fix for the special characters limitation in path name

set "_work=%~dp0"
if "%_work:~-1%"=="\" set "_work=%_work:~0,-1%"

set "_batf=%~f0"
set "_batp=%_batf:'=''%"

set _PSarg="""%~f0""" -el %_args%

set "_ttemp=%temp%"

setlocal EnableDelayedExpansion

::========================================================================================================================================

cls
mode 98, 30

echo:
echo Initializing...
echo:
call :dk_product
call :dk_ckeckwmic

::  Show info for potential script stuck scenario

sc start sppsvc %nul%
if %errorlevel% NEQ 1056 if %errorlevel% NEQ 0 (
echo:
echo Error code: %errorlevel%
call :dk_color %Red% "Failed to start [sppsvc] service, rest of the process may take a long time..."
echo:
)

::========================================================================================================================================

::  Check Activation IDs

call :dk_actids

if not defined applist (
%eline%
echo Activation IDs not found. Aborting...
echo:
echo Check this page for help. https://massgrave.dev/troubleshoot
goto ced_done
)

::  Check Windows Edition

set osedition=
for /f "tokens=3 delims=: " %%a in ('DISM /English /Online /Get-CurrentEdition 2^>nul ^| find /i "Current Edition :"') do set "osedition=%%a"

if "%osedition%"=="" (
%eline%
DISM /English /Online /Get-CurrentEdition %nul%
cmd /c exit /b !errorlevel!
echo DISM command failed [Error Code - 0x!=ExitCode!]
echo OS Edition was not detected properly. Aborting...
echo:
echo Check this page for help. https://massgrave.dev/troubleshoot
goto ced_done
)

::  Check SKU value

set osSKU=
set regSKU=
set wmiSKU=

for /f "tokens=3 delims=." %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\ProductOptions" /v OSProductPfn 2^>nul') do set "regSKU=%%a"
if %_wmic% EQU 1 for /f "tokens=2 delims==" %%a in ('"wmic Path Win32_OperatingSystem Get OperatingSystemSKU /format:LIST" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"
if %_wmic% EQU 0 for /f "tokens=1" %%a in ('%psc% "([WMI]'Win32_OperatingSystem=@').OperatingSystemSKU" 2^>nul') do if not errorlevel 1 set "wmiSKU=%%a"

set osSKU=%wmiSKU%
if not defined osSKU set osSKU=%regSKU%

if not defined osSKU (
%eline%
echo SKU value was not detected properly. Aborting...
goto ced_done
)

set branch=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildBranch 2^>nul') do set "branch=%%b"

::  Check PowerShell

%psc% $ExecutionContext.SessionState.LanguageMode 2>nul | find /i "Full" 1>nul || (
%eline%
echo PowerShell is not responding properly. Aborting...
goto ced_done
)

::========================================================================================================================================

::  Get Target editions list

set _target=
set _dtarget=
set _ptarget=
set _ntarget=

if %winbuild% GEQ 10240 for /f "tokens=4" %%a in ('dism /online /english /Get-TargetEditions ^| findstr /i /c:"Target Edition : "') do (if defined _dtarget (set "_dtarget=!_dtarget! %%a") else (set "_dtarget=%%a"))
for /f "tokens=4" %%a in ('%psc% "$f=[io.file]::ReadAllText('!_batp!') -split ':cbsxml\:.*';& ([ScriptBlock]::Create($f[1])) -GetTargetEditions;" ^| findstr /i /c:"Target Edition : "') do (if defined _ptarget (set "_ptarget=!_ptarget! %%a") else (set "_ptarget=%%a"))

::========================================================================================================================================

::  Block the change to/from CountrySpecific and CloudEdition editions

for %%# in (99 139 202 203) do if %osSKU%==%%# (
%eline%
echo [%winos% ^| SKU:%osSKU% ^| %winbuild%]
echo It's not recommended to change this installed edition to any other.
echo Aborting...
goto ced_done
)

for %%# in ( %_dtarget% %_ptarget% ) do (
echo "!_target!" | find /i " %%# " 1>nul || set "_target=!_target! %%# "
)

if defined _target (
for %%# in (%_target%) do (
echo %%# | findstr /i "CountrySpecific CloudEdition" %nul% || (set "_ntarget=!_ntarget! %%#")
)
)

if not defined _ntarget (
%line%
echo:
call :dk_color %Gray% "Target Edition not found."
echo Current Edition [%osedition% ^| %winbuild%] can not be changed to any other Edition.
%line%
goto ced_done
)

::========================================================================================================================================

:cedmenu2

cls
mode 98, 30
set inpt=
set note=
set counter=0
set verified=0
set targetedition=

%line%
echo:
call :dk_color %Gray% "You can change the Edition [%osedition%] [%winbuild%] to one of the following."
%line%
echo:

for %%A in (%_ntarget%) do (
set /a counter+=1
if %winbuild% GEQ 10240 (
echo "%_ptarget%" | find /i "%%A" 1>nul && (
set note=1
call :dk_color2 %_White% "[!counter!]  " %Magenta% "%%A"
) || (
echo [!counter!]  %%A
)
) else (
echo [!counter!]  %%A
)
set targetedition!counter!=%%A
)

%line%
echo:
echo [0]  %_exitmsg%
echo:
if defined note (
echo Note: CBS Upgrade Method is available for Purple colored editions.
echo:
)
call :dk_color %_Green% "Enter option number in keyboard, and press "Enter":"
set /p inpt=
if "%inpt%"=="" goto cedmenu2
if "%inpt%"=="0" exit /b
for /l %%i in (1,1,%counter%) do (if "%inpt%"=="%%i" set verified=1)
set targetedition=!targetedition%inpt%!
if %verified%==0 goto cedmenu2

::========================================================================================================================================

cls
if %winbuild% GEQ 10240 (
echo "%_ptarget%" | find /i "%targetedition%" 1>nul && (
echo "%_dtarget%" | find /i "%targetedition%" 1>nul && (
echo:
%line%
echo:
if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
echo  [1] DISM Method             [Recommended]
) else (
echo  [1] Changepk Method         [Recommended]
)
echo:
echo  [2] CBS Upgrade Method      [Alternative]
echo:
echo  [0] Go back
%line%
echo:
echo  Enter a menu option in the Keyboard:
choice /C:120 /N
set _el=!errorlevel!
if !_el!==3 goto :cedmenu2
if !_el!==2 goto :cbsmethod
if !_el!==1 REM
)
)
) else (
goto :cbsmethod
)

echo "%_ptarget%" | find /i "%targetedition%" 1>nul && (
echo "%_dtarget%" | find /i "%targetedition%" 1>nul || (
goto :cbsmethod
)
)

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*Edition~*.mum" (
goto :ced_change_server
)

cls
set key=
set _chan=
set _changepk=0

::  Check if changepk.exe or slmgr.vbs is required for edition upgrade

if not exist "%SystemRoot%\System32\spp\tokens\skus\%targetedition%\" (
set _changepk=1
)

if /i "%osedition:~0,4%"=="Core" (
if /i not "%targetedition:~0,4%"=="Core" (
set _changepk=1
)
)

if %_changepk%==1 (
set "keyflow=Retail Volume:MAK Volume:GVLK OEM:NONSLP OEM:DM"
) else (
set "keyflow=Retail OEM:NONSLP OEM:DM Volume:MAK Volume:GVLK"
)

if not defined key call :ced_targetSKU %targetedition%
if not defined key if defined targetSKU call :ced_windowskey
if defined key if defined pkeychannel set _chan=%pkeychannel%
if not defined key call :changeeditiondata

if not defined key (
%eline%
echo [%targetedition% ^| %winbuild%]
echo Unable to get product key from pkeyhelper.dll
echo Make sure you are using updated version of the script.
echo https://massgrave.dev
goto ced_done
)

::========================================================================================================================================

%line%

::  Changing from Core to Non-Core & Changing editions in Windows build older than 17134 requires "changepk /productkey" method and restart
::  In other cases, editions can be changed instantly with "slmgr /ipk"

cls
if %_changepk%==1 (
echo "%_chan%" | find /i "OEM" >NUL && (
%eline%
echo [%osedition%] can not be changed to [%targetedition%] Edition due to lack of non OEM keys.
echo Non-OEM keys are required to change from Core to Non-Core Editions.
goto ced_done
)
)

:ced_loop

cls
if %_changepk%==1 (
for %%a in (l.root-servers.net resolver1.opendns.com download.windowsupdate.com google.com) do (
for /f "delims=[] tokens=2" %%# in ('ping -n 1 %%a') do (
if not [%%#]==[] (
%eline%
echo Internet needs to be disconnected to change edition [%osedition%] to [%targetedition%]
echo Disconnect the Internet and then press any key...
pause >nul
goto ced_loop
)
)
)
)

echo:
echo Changing the Current Edition [%osedition%] to [%targetedition%]
echo:

if %_changepk%==1 (
call :dk_color %Magenta% "Notes-"
echo:
echo  - You can safely ignore if error appears in the upgrade Window,
echo    but in that case you must manually reboot the system.
echo:
echo  - Save your work before continue, system will auto restart.
echo  - You can connect to Internet after the system restart.
echo:
echo  - You will need to activate with HWID option once the edition is changed.
echo:
choice /C:21 /N /M "[1] Continue [2] %_exitmsg% : "
if !errorlevel!==1 exit /b
)

::========================================================================================================================================

if %_changepk%==0 (
echo Installing %_chan% Key [%key%]
echo:
if %_wmic% EQU 1 wmic path SoftwareLicensingService where __CLASS='SoftwareLicensingService' call InstallProductKey ProductKey="%key%" %nul%
if %_wmic% EQU 0 %psc% "(([WMISEARCHER]'SELECT Version FROM SoftwareLicensingService').Get()).InstallProductKey('%key%')" %nul%
if not !errorlevel!==0 cscript //nologo %windir%\system32\slmgr.vbs /ipk %key% %nul%

set error_code=!errorlevel!
cmd /c exit /b !error_code!
if !error_code! NEQ 0 set "error_code=[0x!=ExitCode!]"

if !error_code! EQU 0 (
call :dk_refresh
call :dk_color %Green% "[Successful]"
echo:
call :dk_color %Gray% "Reboot is required to properly change the Edition."
) else (
call :dk_color %Red% "[Unsuccessful] [Error Code: 0x!=ExitCode!]"
)
)

if %_changepk%==1 (
echo:
echo Applying the command with %_chan% Key
echo start changepk.exe /ProductKey %key%
start changepk.exe /ProductKey %key%
)
%line%

goto ced_done

::========================================================================================================================================

:cbsmethod

cls
mode con cols=105 lines=32
%nul% %psc% "&{$W=$Host.UI.RawUI.WindowSize;$B=$Host.UI.RawUI.BufferSize;$W.Height=31;$B.Height=200;$Host.UI.RawUI.WindowSize=$W;$Host.UI.RawUI.BufferSize=$B;}"

echo:
echo Changing the Current Edition [%osedition%] to [%targetedition%]
echo:
call :dk_color %Magenta% "Important - Save your work before continue, system will auto reboot."
if %winbuild% GEQ 17034 if %targetedition%==Professional echo           - Enterprise Key will be installed instead of Pro, you can quickly change to Pro later. 
echo:
choice /C:01 /N /M "[1] Continue [0] %_exitmsg% : "
if %errorlevel%==1 exit /b

echo:
echo Initializing...
echo:

if %_stg%==0 (set stage=) else (set stage=-StageCurrent)
%psc% "$f=[io.file]::ReadAllText('!_batp!') -split ':cbsxml\:.*';& ([ScriptBlock]::Create($f[1])) -SetEdition %targetedition% %stage%;"

echo:
%line%
goto ced_done

::========================================================================================================================================

:ced_change_server

cls
mode con cols=105 lines=32
%nul% %psc% "&{$W=$Host.UI.RawUI.WindowSize;$B=$Host.UI.RawUI.BufferSize;$W.Height=31;$B.Height=200;$Host.UI.RawUI.WindowSize=$W;$Host.UI.RawUI.BufferSize=$B;}"

set key=
set pkeychannel=
set "keyflow=Volume:GVLK Retail Volume:MAK OEM:NONSLP OEM:DM"
call :changeeditionserverdata

if not defined key call :ced_targetSKU %targetedition%
if not defined key if defined targetSKU call :ced_windowskey
if defined key if not defined pkeychannel call :dk_pkeychannel %key%

if not defined key (
%eline%
echo [%targetedition% ^| %winbuild%]
echo Unable to get product key from pkeyhelper.dll
echo Make sure you are using updated version of the script.
echo https://massgrave.dev
goto ced_done
)

::========================================================================================================================================

cls
echo:
echo Changing the Current Edition [%osedition%] to [%targetedition%]
echo:
echo Applying the command with %pkeychannel% Key
echo DISM /online /Set-Edition:%targetedition% /ProductKey:%key% /AcceptEula
DISM /online /Set-Edition:%targetedition% /ProductKey:%key% /AcceptEula

call :dk_color %Magenta% "Make sure to restart the system."

::========================================================================================================================================

:ced_done

echo:
call :dk_color %_Yellow% "Press any key to %_exitmsg%..."
pause >nul
exit /b

::========================================================================================================================================

:ced_windowskey

for %%# in (pkeyhelper.dll) do @if "%%~$PATH:#"=="" exit /b
for %%# in (%keyflow%) do (
call :dk_pkey %targetSKU% '%%#'
if defined pkey call :dk_pkeychannel !pkey!
if /i [!pkeychannel!]==[%%#] (
set key=!pkey!
exit /b
)
)
exit /b

::========================================================================================================================================

:ced_targetSKU

set k=%1
set targetSKU=
for %%# in (pkeyhelper.dll) do @if "%%~$PATH:#"=="" exit /b

call :dk_reflection

set d1=%ref% [void]$TypeBuilder.DefinePInvokeMethod('GetEditionIdFromName', 'pkeyhelper.dll', 'Public, Static', 1, [int], @([String], [int].MakeByRefType()), 1, 3);
set d1=%d1% $out = 0; [void]$TypeBuilder.CreateType()::GetEditionIdFromName('%k%', [ref]$out); $out

for /f %%a in ('%psc% "%d1%"') do if not errorlevel 1 (set targetSKU=%%a)
if "%targetSKU%"=="0" set targetSKU=
exit /b

::========================================================================================================================================

::  https://github.com/Gamers-Against-Weed/Set-WindowsCbsEdition

:cbsxml:[
param (
    [Parameter()]
    [String]$SetEdition,

    [Parameter()]
    [Switch]$GetTargetEditions,

    [Parameter()]
    [Switch]$StageCurrent
)

function Get-AssemblyIdentity {
    param (
        [String]$PackageName
    )

    $PackageName = [String]$PackageName
    $packageData = ($PackageName -split '~')

    if($packageData[3] -eq '') {
        $packageData[3] = 'neutral'
    }

    return "<assemblyIdentity name=`"$($packageData[0])`" version=`"$($packageData[4])`" processorArchitecture=`"$($packageData[2])`" publicKeyToken=`"$($packageData[1])`" language=`"$($packageData[3])`" />"
}

function Get-SxsName {
    param (
        [String]$PackageName
    )

    $name = ($PackageName -replace '[^A-z0-9\-\._]', '')

    if($name.Length -gt 40) {
        $name = ($name[0..18] -join '') + '\.\.' + ($name[-19..-1] -join '')
    }

    return $name.ToLower()
}

function Find-EditionXmlInSxs {
    param (
        [String]$Edition
    )

    $candidates = @($Edition, 'Client', 'Server')
    $winSxs = $Env:SystemRoot + '\WinSxS'
    $allInSxs = Get-ChildItem -Path $winSxs | select Name

    foreach($candidate in $candidates) {
        $name = Get-SxsName -PackageName "Microsoft-Windows-Editions-$candidate"
        $packages = $allInSxs | where name -Match ('^.*_'+$name+'_31bf3856ad364e35')

        if($packages.Length -eq 0) {
            continue
        }

        $package = $packages[-1].Name
        $testPath = $winSxs + "\$package\" + $Edition + 'Edition.xml'

        if(Test-Path -Path $testPath -PathType Leaf) {
            return $testPath
        }
    }

    return $null
}

function Find-EditionXml {
    param (
        [String]$Edition
    )

    $servicingEditions = $Env:SystemRoot + '\servicing\Editions'
    $editionXml = $Edition + 'Edition.xml'

    $editionXmlInServicing = $servicingEditions + '\' + $editionXml

    if(Test-Path -Path $editionXmlInServicing -PathType Leaf) {
        return $editionXmlInServicing
    }

    return Find-EditionXmlInSxs -Edition $Edition
}

function Write-UpgradeCandidates {
    param (
        [HashTable]$InstallCandidates
    )

    $editionCount = 0
    Write-Host 'Editions that can be upgraded to:'
    foreach($candidate in $InstallCandidates.Keys) {
        Write-Host "Target Edition : $candidate"
        $editionCount++
    }

    if($editionCount -eq 0) {
        Write-Host '(no editions are available)'
    }
}

function Write-UpgradeXml {
    param (
        [Array]$RemovalCandidates,
        [Array]$InstallCandidates,
        [Boolean]$Stage
    )

    $removeAction = 'remove'
    if($Stage) {
        $removeAction = 'stage'
    }

    Write-Output '<?xml version="1.0"?>'
    Write-Output '<unattend xmlns="urn:schemas-microsoft-com:unattend">'
    Write-Output '<servicing>'

    foreach($package in $InstallCandidates) {
        Write-Output '<package action="install">'
        Write-Output (Get-AssemblyIdentity -PackageName $package)
        Write-Output '</package>'
    }

    foreach($package in $RemovalCandidates) {
        Write-Output "<package action=`"$removeAction`">"
        Write-Output (Get-AssemblyIdentity -PackageName $package)
        Write-Output '</package>'
    }

    Write-Output '</servicing>'
    Write-Output '</unattend>'
}

function Write-Usage {
    Get-Help $script:MyInvocation.MyCommand.Path -detailed
}

$version = '1.0'
$getTargetsParam = $GetTargetEditions.IsPresent
$stageCurrentParam = $StageCurrent.IsPresent

if($SetEdition -eq '' -and ($false -eq $getTargetsParam)) {
    Write-Usage
    Exit 1
}

$removalCandidates = @();
$installCandidates = @{};

$packages = Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages' | select Name | where { $_.name -match '^.*\\Microsoft-Windows-.*Edition~' }
foreach($package in $packages) {
    $state = (Get-ItemProperty -Path "Registry::$($package.Name)").CurrentState
    $packageName = ($package.Name -split '\\')[-1]
    $packageEdition = (($packageName -split 'Edition~')[0] -split 'Microsoft-Windows-')[-1]

    if($state -eq 0x40) {
        if($null -eq $installCandidates[$packageEdition]) {
            $installCandidates[$packageEdition] = @()
        }

        if($false -eq ($installCandidates[$packageEdition] -contains $packageName)) {
            $installCandidates[$packageEdition] = $installCandidates[$packageEdition] + @($packageName)
        }
    }

    if((($state -eq 0x50) -or ($state -eq 0x70)) -and ($false -eq ($removalCandidates -contains $packageName))) {
        $removalCandidates = $removalCandidates + @($packageName)
    }
}

if($getTargetsParam) {
    Write-UpgradeCandidates -InstallCandidates $installCandidates
    Exit
}

if($false -eq ($installCandidates.Keys -contains $SetEdition)) {
    Write-Error "The system cannot be upgraded to `"$SetEdition`""
    Exit 1
}

$xmlPath = $Env:SystemRoot + '\Temp' + '\CbsUpgrade.xml'

Write-UpgradeXml -RemovalCandidates $removalCandidates `
    -InstallCandidates $installCandidates[$SetEdition] `
    -Stage $stageCurrentParam >$xmlPath

$editionXml = Find-EditionXml -Edition $SetEdition
if($null -eq $editionXml) {
    Write-Warning 'Unable to find edition specific settings XML. Proceeding without it...'
}

Write-Host 'Starting the upgrade process. This may take a while...'

DISM.EXE /English /NoRestart /Online /Apply-Unattend:$xmlPath
$dismError = $LASTEXITCODE

Remove-Item -Path $xmlPath -Force

if(($dismError -ne 0) -and ($dismError -ne 3010)) {
    Write-Error 'Failed to upgrade to the target edition'
    Exit $dismError
}

if($null -ne $editionXml) {
    $destination = $Env:SystemRoot + '\' + $SetEdition + '.xml'
    Copy-Item -Path $editionXml -Destination $destination

    DISM.EXE /English /NoRestart /Online /Apply-Unattend:$editionXml
    $dismError = $LASTEXITCODE

    if(($dismError -ne 0) -and ($dismError -ne 3010)) {
        Write-Error 'Failed to apply edition specific settings'
        Exit $dismError
    }
}

Restart-Computer
:cbsxml:]

::========================================================================================================================================

::  1st column = Generic Retail/OEM/MAK/GVLK Key
::  2nd column = Key Type
::  3rd column = WMI Edition ID
::  4th column = Version name incase same Edition ID is used in different OS versions with different key
::  Separator  = _

::  Key preference is in the following order. Retail > Volume:MAK > Volume:GVLK > OEM:NONSLP > OEM:DM
::  OEM keys are in last because they can't be used in edition change if "changepk /productkey" method is needed instead of "slmgr /ipk"
::  OEM keys are listed here because we don't have other keys for that edition

:changeeditiondata

set h=
for %%# in (
44N%h%YX-TK%h%R9D-CCM2%h%D-V6%h%B8F-HQ%h%WWR__Volume:MAK_Enterprise
D6R%h%D9-D4%h%N8T-RT9Q%h%X-YW%h%6YT-FC%h%WWJ______Retail_Starter
3V6%h%Q6-NQ%h%XCX-V8YX%h%R-9Q%h%CYV-QP%h%FCT__Volume:MAK_EnterpriseN
3NF%h%XW-2T%h%27M-2BDW%h%6-4G%h%HRV-68%h%XRX______Retail_StarterN
VK7%h%JG-NP%h%HTM-C97J%h%M-9M%h%PGT-3V%h%66T______Retail_Professional
2B8%h%7N-8K%h%FHP-DKV6%h%R-Y2%h%C8J-PK%h%CKT______Retail_ProfessionalN
4CP%h%RK-NM%h%3K3-X6XX%h%Q-RX%h%X86-WX%h%CHW______Retail_CoreN
N24%h%34-X9%h%D7W-8PF6%h%X-8D%h%V9T-8T%h%YMD______Retail_CoreCountrySpecific
BT7%h%9Q-G7%h%N6G-PGBY%h%W-4Y%h%WX6-6F%h%4BT______Retail_CoreSingleLanguage
YTM%h%G3-N6%h%DKC-DKB7%h%7-7M%h%9GH-8H%h%VX7______Retail_Core
XKC%h%NC-J2%h%6Q9-KFHD%h%2-FK%h%THY-KD%h%72Y__OEM:NONSLP_PPIPro
YNM%h%GQ-8R%h%YV3-4PGQ%h%3-C8%h%XTP-7C%h%FBY______Retail_Education
84N%h%GF-MH%h%BT6-FXBX%h%8-QW%h%JK7-DR%h%R8H______Retail_EducationN
KCN%h%VH-YK%h%WX8-GJJB%h%9-H9%h%FDT-6F%h%7W2__Volume:MAK_EnterpriseS_VB
VBX%h%36-N7%h%DDY-M9H6%h%2-83%h%BMJ-CP%h%R42__Volume:MAK_EnterpriseS_RS5
PN3%h%KR-JX%h%M7T-46HM%h%4-MC%h%QGK-7X%h%PJQ__Volume:MAK_EnterpriseS_RS1
DVW%h%KN-3G%h%CMV-Q2XF%h%4-DD%h%PGM-VQ%h%WWY__Volume:MAK_EnterpriseS_TH
RQF%h%NW-9T%h%PM3-JQ73%h%T-QV%h%4VQ-DV%h%9PT__Volume:MAK_EnterpriseSN_VB
M33%h%WV-NH%h%Y3C-R7FP%h%M-BQ%h%GPT-23%h%9PG__Volume:MAK_EnterpriseSN_RS5
2DB%h%W3-N2%h%PJG-MVHW%h%3-G7%h%TDK-9H%h%KR4__Volume:MAK_EnterpriseSN_RS1
NTX%h%6B-BR%h%YC2-K678%h%6-F6%h%MVQ-M7%h%V2X__Volume:MAK_EnterpriseSN_TH
G3K%h%NM-CH%h%G6T-R36X%h%3-9Q%h%DG6-8M%h%8K9______Retail_ProfessionalSingleLanguage
HNG%h%CC-Y3%h%8KG-QVK8%h%D-WM%h%WRK-X8%h%6VK______Retail_ProfessionalCountrySpecific
DXG%h%7C-N3%h%6C4-C4HT%h%G-X4%h%T3X-2Y%h%V77______Retail_ProfessionalWorkstation
WYP%h%NQ-8C%h%467-V2W6%h%J-TX%h%4WX-WT%h%2RQ______Retail_ProfessionalWorkstationN
8PT%h%T6-RN%h%W4C-6V7J%h%2-C2%h%D3X-MH%h%BPB______Retail_ProfessionalEducation
GJT%h%YN-HD%h%MQY-FRR7%h%6-HV%h%GC7-QP%h%F8P______Retail_ProfessionalEducationN
C4N%h%TJ-CX%h%6Q2-VXDM%h%R-XV%h%KGM-F9%h%DJC__Volume:MAK_EnterpriseG
46P%h%N6-R9%h%BK9-CVHK%h%B-HW%h%Q9V-MB%h%JY8__Volume:MAK_EnterpriseGN
NJC%h%F7-PW%h%8QT-3324%h%D-68%h%8JX-2Y%h%V66______Retail_ServerRdsh
V3W%h%VW-N2%h%PV2-CGWC%h%3-34%h%QGF-VM%h%J2C______Retail_Cloud
NH9%h%J3-68%h%WK7-6FB9%h%3-4K%h%3DF-DJ%h%4F6______Retail_CloudN
2HN%h%6V-HG%h%TM8-6C97%h%C-RK%h%67V-JQ%h%PFD______Retail_CloudE
XQQ%h%YW-NF%h%FMW-XJPB%h%H-K8%h%732-CK%h%FFD______OEM:DM_IoTEnterprise
QPM%h%6N-7J%h%2WJ-P88H%h%H-P3%h%YRH-YY%h%74H__OEM:NONSLP_IoTEnterpriseS_VB
KBN%h%8V-HF%h%GQ4-MGXV%h%D-34%h%7P6-PD%h%QGT_Volume:GVLK_IoTEnterpriseS_NI
K9V%h%KN-3B%h%GWV-Y624%h%W-MC%h%RMQ-BH%h%DCD______Retail_CloudEditionN
KY7%h%PN-VR%h%6RX-83W6%h%Y-6D%h%DYQ-T6%h%R4W______Retail_CloudEdition
MPB%h%3G-XN%h%BR7-CC43%h%M-FG%h%64B-F9%h%GBK______Retail_IoTEnterpriseSK
) do (
for /f "tokens=1-4 delims=_" %%A in ("%%#") do if /i %targetedition%==%%C (

if not defined key (
set 4th=%%D
if not defined 4th (
set "key=%%A" & set "_chan=%%B"
) else (
echo "%branch%" | find "%%D" 1>nul && (set "key=%%A" & set "_chan=%%B")
)
)
)
)
exit /b

::========================================================================================================================================

:changeeditionserverdata

if exist "%SystemRoot%\Servicing\Packages\Microsoft-Windows-Server*CorEdition~*.mum" (set Cor=Cor) else (set Cor=)

::  Only RS3 and older version keys (GVLK/Generic Retail) are stored here, later ones are extracted from the system itself

set h=
for %%# in (
WC2%h%BQ-8N%h%RM3-FDD%h%YY-2B%h%FGV-KHK%h%QY_RS1_ServerStandard%Cor%
CB7%h%KF-BW%h%N84-R7R%h%2Y-79%h%3K2-8XD%h%DG_RS1_ServerDatacenter%Cor%
JCK%h%RF-N3%h%7P4-C2D%h%82-9Y%h%XRT-4M6%h%3B_RS1_ServerSolution
QN4%h%C6-GB%h%JD2-FB4%h%22-GH%h%WJK-GJG%h%2R_RS1_ServerCloudStorage
VP3%h%4G-4N%h%PPG-79J%h%TQ-86%h%4T4-R3M%h%QX_RS1_ServerAzureCor
9JQ%h%NQ-V8%h%HQ6-PKB%h%8H-GG%h%HRY-R62%h%H6_RS1_ServerAzureNano
VN8%h%D3-PR%h%82H-DB6%h%BJ-J9%h%P4M-92F%h%6J_RS1_ServerStorageStandard
48T%h%QX-NV%h%K3R-D8Q%h%R3-GT%h%HHM-8FH%h%XC_RS1_ServerStorageWorkgroup
2HX%h%DN-KR%h%XHB-GPY%h%C7-YC%h%KFJ-7FV%h%DG_RS3_ServerDatacenterACor
PTX%h%N8-JF%h%HJM-4WC%h%78-MP%h%CBR-9W4%h%KR_RS3_ServerStandardACor
) do (
for /f "tokens=1-3 delims=_" %%A in ("%%#") do if /i %targetedition%==%%C (
echo "%branch%" | find /i "%%B" 1>nul && (set "key=%%A")
)
)
exit /b

:+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:MASend
echo:
if defined _MASunattended timeout /t 2 & exit /b
echo Press any key to exit...
pause >nul
exit /b

::End::

rem 微软激活脚本 End

:allprocessrunning
echo 正在导出计算机所有正在运行的进程
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
tasklist /v /fi "STATUS eq running" >%userprofile%\desktop\MDT\AllProcess_Running.log
echo.
echo 导出完成，请查看桌面 MDT 文件夹中的 AllProcess_Running.log 文件
start %userprofile%\desktop\MDT\AllProcess_Running.log
echo 路径：%userprofile%\desktop\MDT\AllProcess_Running.log
pause
goto menu

:allprocess
echo 正在导出计算机所有进程
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
tasklist >%userprofile%\desktop\MDT\AllProcess.log
echo.
echo 导出完成，请查看桌面 MDT 文件夹中的 AllProcess.log 文件
start %userprofile%\desktop\MDT\AllProcess.log
echo 路径：%userprofile%\desktop\MDT\AllProcess.log
pause
goto menu

:killprocess
cls
echo     杀死特定进程
echo.
echo     请在下方输入要杀死的进程名，并用英文半角双引号将路径引用
echo     不引用会导致结束进程失败或程序崩溃退出
echo     例如："This is sample.exe"、"example.exe"
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在进程名处输入 0 并回车确认

set /p input=→  请输入进程名：

if %input% equ 0 goto menu
echo.
echo 程序识别到的进程名为：%input%
echo.
echo 尝试使用 taskkill 命令结束进程
taskkill /im %imput% /f
echo 操作执行完成
echo.
echo 使用 wmic 命令获取进程信息
wmic process where name=%input% get processid,executablepath,name
echo 操作执行完成
echo.
echo 尝试使用 wmic 命令结束进程
wmic process where name=%input% call terminate
wmic process where name=%input% delete
echo 操作执行完成
echo.
echo 使用 tasklist 查找目标进程是否存在
tasklist | findstr %input%
echo 操作执行完成
echo 所有操作已执行完成
goto finkill

:finkill
echo.
echo     已尝试结束目标进程
echo.
echo     1. 继续杀死其他特定进程
echo     2. 返回主菜单
set /p cinput=→  请输入选项：
if %cinput% equ 1 goto killprocess
if %cinput% equ 2 goto menu
echo →  输入异常，请检查输入选项
goto finkill

:eacuninstall
cls
echo.
echo     EAC小蓝熊卸载脚本
echo.
echo     此操作将卸载 EasyAntiCheat（小蓝熊）并清除所有数据
echo     包括但不限于 EpicGames、Steam 平台的小蓝熊数据
set /p eacinput=→  是否继续操作？（Y/n）
if %eacinput% equ Y goto deleacdata
if %eacinput% equ y goto deleacdata
if %eacinput% equ N goto menu
if %eacinput% equ n goto menu
goto menu

:deleacdata
echo 停止 EAC 相关服务
sc stop EasyAntiCheat_EOS
sc stop EasyAntiCheat
echo 删除 EAC 相关服务
sc delete EasyAntiCheat_EOS
sc delete EasyAntiCheat
echo 删除 EAC 相关文件
rd /s /q "C:\Program Files (x86)\EasyAntiCheat"
rd /s /q "C:\Program Files (x86)\EasyAntiCheat_EOS"
echo 操作执行完成
echo.
echo 清理注册表信息
reg delete "HKLM\SOFTWARE\WOW6432Node\EasyAntiCheat" /f >nul
reg delete "HKLM\SOFTWARE\WOW6432Node\EasyAntiCheat_EOS" /f >nul
reg delete "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat" /f >nul
reg delete "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat\Security" /f >nul
reg delete "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat_EOS" /f >nul
reg delete "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat_EOS\Security" /f >nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat" /f >nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat\Security" /f >nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat_EOS" /f >nul
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat_EOS\Security" /f >nul
echo 操作执行完成
echo.
echo 清理常见游戏的 EAC 注册表信息
reg delete "HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\1172470" /v "EasyAntiCheat" /f >nul
reg delete "HKLM\SOFTWARE\WOW6432Node\Valve\Steam\Apps\GGD_EAC" /v "easyanticheat" /f >nul
echo 操作执行完成
echo 请手动重新安装 EAC 或者校验游戏完整性重新运行游戏安装部署脚本安装EAC
pause
goto menu

:apexshopimgerr
cls
echo.
echo     Apex Legends 商店图片不显示出现禁用标志（ASSET FAILED TO LOAD）修复
echo     请先关闭游戏，修复过程会关闭游戏进程
echo     请保存好文件，按任意键继续修复
pause
echo.
echo 结束 Apex Legends 进程
taskkill /im r5apex.exe /F
taskkill /im r5apex_dx12.exe /F
echo.
echo 修改文件夹权限
takeown /f "%userprofile%\Saved Games\Respawn"
icacls "%userprofile%\Saved Games\Respawn" /grant Everyone:F
takeown /f "%userprofile%\Saved Games\Respawn\Apex"
icacls "%userprofile%\Saved Games\Respawn\Apex" /grant Everyone:F
takeown /f "%userprofile%\Saved Games\Respawn\Apex\assets"
icacls "%userprofile%\Saved Games\Respawn\Apex\assets" /grant Everyone:F
echo.
echo 权限修改完成，请重新验证游戏完整性（推荐全新安装）
echo 此问题多半是由加速器修复卡屏造成的，请慎用卡屏修复工具！
pause
goto menu

:cmdstart
cls
echo.
echo 正在启动 CMD.exe （以管理员身份运行）
start cmd.exe
echo 操作执行完成
pause
goto menu

:psstart
cls
echo.
echo 正在启动 Powershell.exe （以管理员身份运行）
start powershell.exe
echo 操作执行完成
pause
goto menu

:userlist
cls
echo.
echo     导出用户列表菜单
echo.
echo     0. 返回主菜单
echo     1. 导出用户列表（基础）
echo     2. 导出用户列表（详细）
echo.
set /p ulinput=→  请选择一个项目：
if %ulinput% equ 0 goto menu
if %ulinput% equ 1 goto ulbasic
if %ulinput% equ 2 goto uldetail
echo →  输入异常，请检查输入选项
pause
goto userlist

:ulbasic
echo 开始导出用户列表（基础）
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
echo.
powershell.exe Get-LocalUser >%userprofile%\desktop\MDT\Userlist_Basic.log
echo.
echo 导出用户列表（基础）完成，请查看桌面 MDT 文件夹中的 Userlist_Basic.log 文件
start %userprofile%\desktop\MDT\Userlist_Basic.log
echo 路径：%userprofile%\desktop\MDT\Userlist_Basic.log
pause
goto menu

:uldetail
echo 开始导出用户列表（详细）
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
echo.
powershell.exe "Get-LocalUser | Select *" >%userprofile%\desktop\MDT\Userlist_Detail.log
echo.
echo 导出用户列表（详细）完成，请查看桌面 MDT 文件夹中的 Userlist_Detail.log 文件
start %userprofile%\desktop\MDT\Userlist_Detail.log
echo 路径：%userprofile%\desktop\MDT\Userlist_Detail.log
pause
goto menu

:wureset
cls
echo.
echo     此操作将重置 Windows Update，是否继续操作？（y/N）
echo.
set /p wuinput=→  请确认您的操作：
if %wuinput% equ y goto wuresetstart
if %wuinput% equ Y goto wuresetstart
if %wuinput% equ n goto menu
if %wuinput% equ N goto menu
goto menu

:wuresetstart
echo 开始重置 Windows Update
echo.
	:: ----- Stopping the Windows Update services -----
echo 停止 Windows Update 相关服务
net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc
net stop WaaSMedicSvc
net stop UsoSvc

echo 取消正在进行的 Windows Update 操作
taskkill /im wuauclt.exe /f

	:: ----- Checking the services status -----
echo 检查 BITS 服务状态

	sc query bits | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 BITS 服务失败
		echo.
		echo 再次重试停止 BITS 服务
    net stop bits
	)

echo 检查 Windows Update 服务状态

	sc query wuauserv | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Windows Update 服务失败
		echo.
		echo 再次重试停止 Windows Update 服务
    net stop wuauserv
	)

echo 检查 Application Identity 服务状态

	sc query appidsvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		sc query appidsvc | findstr /I /C:"OpenService FAILED 1060"
		if %errorlevel% NEQ 0 (
			echo 停止 Application Identity 服务失败
			echo.
			echo 再次重试停止 Application Identity 服务
      net stop appidsvc
		)
	)

echo 检查 Cryptographic 服务状态

	sc query cryptsvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Cryptographic 服务失败
		echo.
		echo 再次重试停止 Cryptographic 服务
    net stop cryptsvc
	)

echo 检查 Windows Update Medic 服务状态

	sc query WaaSMedicSvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Windows Update Medic 服务失败
		echo.
		echo 再次重试停止 Windows Update Medic 服务
    net stop cryptsvc
	)

echo 检查 Update Orchestrator 服务状态

	sc query WaaSMedicSvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Update Orchestrator 服务失败
		echo.
		echo 再次重试停止 Update Orchestrator 服务
    net stop UsoSvc
	)

	:: ----- Delete the qmgr*.dat files -----
echo 清理 qmgr*.dat 文件
del /s /q /f "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"
del /s /q /f "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat"

	:: ----- Renaming the softare distribution folders backup copies -----
echo 删除旧的 SoftwareDistribution 备份文件

cd /d %SYSTEMROOT%

	if exist "%SYSTEMROOT%\winsxs\pending.xml.bak" (
		del /s /q /f "%SYSTEMROOT%\winsxs\pending.xml.bak"
	)
	if exist "%SYSTEMROOT%\SoftwareDistribution.bak" (
		rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution.bak"
	)
	if exist "%SYSTEMROOT%\system32\Catroot2.bak" (
		rmdir /s /q "%SYSTEMROOT%\system32\Catroot2.bak"
	)
	if exist "%SYSTEMROOT%\WindowsUpdate.log.bak" (
		del /s /q /f "%SYSTEMROOT%\WindowsUpdate.log.bak"
	)

echo 重命名 SoftwareDistribution 文件夹
	if exist "%SYSTEMROOT%\winsxs\pending.xml" (
		takeown /f "%SYSTEMROOT%\winsxs\pending.xml"
		attrib -r -s -h /s /d "%SYSTEMROOT%\winsxs\pending.xml"
		ren "%SYSTEMROOT%\winsxs\pending.xml" pending.xml.bak
	)
	if exist "%SYSTEMROOT%\SoftwareDistribution" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\SoftwareDistribution"
		ren "%SYSTEMROOT%\SoftwareDistribution" SoftwareDistribution.bak
		if exist "%SYSTEMROOT%\SoftwareDistribution" (
			echo.
			echo 未能成功重命名 SoftwareDistribution 文件夹
			echo.
			echo 操作失败，请检查文件夹权限和安全软件拦截情况
      echo 检查完毕后请重新运行此功能进行修复
			pause>nul
			goto menu
		)
	)
	if exist "%SYSTEMROOT%\system32\Catroot2" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\system32\Catroot2"
		ren "%SYSTEMROOT%\system32\Catroot2" Catroot2.bak
	)
	if exist "%SYSTEMROOT%\WindowsUpdate.log" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\WindowsUpdate.log"
		ren "%SYSTEMROOT%\WindowsUpdate.log" WindowsUpdate.log.bak
	)

echo 重置注册表信息
echo.
rem wuauserv
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "DependOnService" /t REG_MULTI_SZ /d "rpcss" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Description" /d "@%%systemroot%%\system32\wuauserv.dll,-106" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "DisplayName" /d "@%%systemroot%%\system32\wuauserv.dll,-105" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "ErrorControl" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "FailureActions" /t REG_BINARY /d "80510100000000000000000003000000140000000100000060ea000000000000000000000000000000000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "ImagePath" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\svchost.exe -k netsvcs -p" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "ObjectName" /d "LocalSystem" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "RequiredPrivileges" /t REG_MULTI_SZ /d "SeAuditPrivilege\0SeCreateGlobalPrivilege\0SeCreatePageFilePrivilege\0SeTcbPrivilege\0SeAssignPrimaryTokenPrivilege\0SeImpersonatePrivilege\0SeIncreaseQuotaPrivilege\0SeShutdownPrivilege\0SeDebugPrivilege\0SeBackupPrivilege\0SeRestorePrivilege\0SeSecurityPrivilege\0SeTakeOwnershipPrivilege\0SeLoadDriverPrivilege\0SeManageVolumePrivilege\0SeSystemEnvironmentPrivilege\0SeCreateSymbolicLinkPrivilege\0SeIncreaseBasePriorityPrivilege" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "ServiceSidType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Start" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "SvcMemHardLimitInMB" /t REG_DWORD /d 246 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "SvcMemMidLimitInMB" /t REG_DWORD /d 167 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "SvcMemSoftLimitInMB" /t REG_DWORD /d 88 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /v "Type" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\Parameters" /v "ServiceDll" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\wuauserv.dll" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\Parameters" /v "ServiceDllUnloadOnStop" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\Parameters" /v "ServiceMain" /d "WUServiceMain" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\Security" /v "Security" /t REG_BINARY /d "010014807800000084000000140000003000000002001c000100000002801400ff000f000101000000000001000000000200480003000000000014009d00020001010000000000050b00000000001800ff010f000102000000000005200000002002000000001400ff010f00010100000000000512000000010100000000000512000000010100000000000512000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo\0" /v "Type" /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo\0" /v "Action" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo\0" /v "Guid" /t REG_BINARY /d "e6ca9f65db5ba94db1ffca2a178d46e0" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo\1" /v "Type" /t REG_DWORD /d 5 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo\1" /v "Action" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv\TriggerInfo\1" /v "Guid" /t REG_BINARY /d "c846fb5489f04c46b1fd59d1b62c3b50" /f >nul
echo 操作执行完成

rem bits
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "DependOnService" /t REG_MULTI_SZ /d "RpcSs" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Description" /d "@%%SystemRoot%%\system32\qmgr.dll,-1001" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "DisplayName" /d "@%%SystemRoot%%\system32\qmgr.dll,-1000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "ErrorControl" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "FailureActions" /t REG_BINARY /d "80510100000000000000000003000000140000000100000060ea000001000000c0d401000000000000000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "ImagePath" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\svchost.exe -k netsvcs -p" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "ObjectName" /d "LocalSystem" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "RequiredPrivileges" /t REG_MULTI_SZ /d "SeCreateGlobalPrivilege\0SeImpersonatePrivilege\0SeTcbPrivilege\0SeAssignPrimaryTokenPrivilege\0SeIncreaseQuotaPrivilege\0SeDebugPrivilege" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "ServiceSidType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Start" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "Type" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /v "DelayedAutostart" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Parameters" /v "ServiceDll" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\qmgr.dll" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Parameters" /v "ServiceDllUnloadOnStop" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Close" /d "PerfMon_Close" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Collect" /d "PerfMon_Collect" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Library" /d "C:\Windows\System32\bitsperf.dll" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Open" /d "PerfMon_Open" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "InstallType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "PerfIniFile" /d "bitsctrs.ini" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "First Counter" /t REG_DWORD /d 8616 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Last Counter" /t REG_DWORD /d 8632 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "First Help" /t REG_DWORD /d 8617 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Last Help" /t REG_DWORD /d 8633 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Object List" /d "8616" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "1008" /t  /d  /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "1011" /t  /d  /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Performance" /v "Disable Performance Counters" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\BITS\Security" /v "Security" /t REG_BINARY /d "0100148090000000a00000001400000034000000020020000100000002c0180000000c000102000000000005200000002002000002005c000400000000021400ff010f0001010000000000051200000000001800ff010f0001020000000000052000000020020000000014008d010200010100000000000504000000000014008d0102000101000000000005060000000102000000000005200000002002000001020000000000052000000020020000" /f >nul
echo 操作执行完成

rem TrustedInstaller
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "BlockTime" /t REG_DWORD /d 10800 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "BlockTimeIncrement" /t REG_DWORD /d 900 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Description" /d "@%%SystemRoot%%\servicing\TrustedInstaller.exe,-101" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "DisplayName" /d "@%%SystemRoot%%\servicing\TrustedInstaller.exe,-100" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "ErrorControl" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "FailureActions" /t REG_BINARY /d "840300000000000000000000030000001400000001000000c0d4010001000000e09304000000000000000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Group" /d "ProfSvc_Group" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "ImagePath" /t REG_EXPAND_SZ /d "%%SystemRoot%%\servicing\TrustedInstaller.exe" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "ObjectName" /d "localSystem" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "PreshutdownTimeout" /t REG_DWORD /d 3600000 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "ServiceSidType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Start" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller" /v "Type" /t REG_DWORD /d 16 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\TrustedInstaller\Security" /v "Security" /t REG_BINARY /d "0100148090000000a00000001400000034000000020020000100000002c0180000000c000102000000000005200000002002000002005c000400000000021400ff010f0001010000000000051200000000001800ff01020001020000000000052000000020020000000014008d010200010100000000000504000000000014008d0102000101000000000005060000000102000000000005200000002002000001020000000000052000000020020000" /f >nul
echo 操作执行完成

rem CryptSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "DependOnService" /t REG_MULTI_SZ /d "RpcSs" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "Description" /d "@%%SystemRoot%%\system32\cryptsvc.dll,-1002" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "DisplayName" /d "@%%SystemRoot%%\system32\cryptsvc.dll,-1001" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "ErrorControl" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "FailureActions" /t REG_BINARY /d "80510100000000000000000003000000140000000100000060ea000000000000000000000000000000000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "ImagePath" /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\svchost.exe -k NetworkService -p" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "ObjectName" /d "NT Authority\NetworkService" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "RequiredPrivileges" /t REG_MULTI_SZ /d "SeChangeNotifyPrivilege\0SeCreateGlobalPrivilege\0SeImpersonatePrivilege" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "ServiceSidType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "Start" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc" /v "Type" /t REG_DWORD /d 16 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\Parameters" /v "ServiceDll" /t REG_EXPAND_SZ /d "%%SystemRoot%%\system32\cryptsvc.dll" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\Parameters" /v "ServiceDllUnloadOnStop" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\Parameters" /v "ServiceMain" /d "CryptServiceMain" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\Security" /v "Security" /t REG_BINARY /d "01000480d8000000e400000000000000140000000200c4000700000000001400fd01020001010000000000051200000000001800ff010f0001020000000000052000000020020000000014008d010200010100000000000504000000000014008d01020001010000000000050600000000001800fd01020001020000000000052000000025020000000018008d000200010200000000000f0200000001000000000038008d000200010a00000000000f03000000000400008543efbe8867637e4d7a39abdefa60729ff69fa85772dbfe9e1ca32d96ba04a4010100000000000512000000010100000000000512000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\TriggerInfo" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\TriggerInfo\0" /v "Action" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\TriggerInfo\0" /v "Data0" /t REG_BINARY /d "460035003000410041004300300030002d0043003700460033002d0034003200380065002d0041003000320032002d004100360042003700310042004600420039004400340033000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\TriggerInfo\0" /v "DataType0" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\TriggerInfo\0" /v "GUID" /t REG_BINARY /d "67d190bc70943941a9babe0bbbf5b74d" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\CryptSvc\TriggerInfo\0" /v "Type" /t REG_DWORD /d 6 /f >nul
echo 操作执行完成

rem UsoSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "DelayedAutoStart" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "DependOnService" /t REG_MULTI_SZ /d "rpcss" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Description" /d "@%%systemroot%%\system32\usosvc.dll,-102" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "DisplayName" /d "@%%systemroot%%\system32\usosvc.dll,-101" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "ErrorControl" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "FailureActions" /t REG_BINARY /d "805101000000000000000000030000001400000001000000c0d4010001000000e09304000000000000000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "ImagePath" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\svchost.exe -k netsvcs -p" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "ObjectName" /d "LocalSystem" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "PreshutdownTimeout" /t REG_DWORD /d 3600000 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "RequiredPrivileges" /t REG_MULTI_SZ /d "SeAuditPrivilege\0SeCreateGlobalPrivilege\0SeCreatePageFilePrivilege\0SeTcbPrivilege\0SeAssignPrimaryTokenPrivilege\0SeImpersonatePrivilege\0SeIncreaseQuotaPrivilege\0SeShutdownPrivilege\0SeDebugPrivilege\0SeBackupPrivilege\0SeRestorePrivilege\0SeSecurityPrivilege\0SeTakeOwnershipPrivilege\0SeLoadDriverPrivilege\0SeManageVolumePrivilege\0SeSystemEnvironmentPrivilege\0SeCreateSymbolicLinkPrivilege\0SeIncreaseBasePriorityPrivilege" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "ServiceSidType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Start" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /v "Type" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc\Parameters" /v "ServiceDll" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\usosvc.dll" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc\Parameters" /v "ServiceDllUnloadOnStop" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc\Parameters" /v "ServiceMain" /d "ServiceMain" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc\Security" /v "Security" /t REG_BINARY /d "010014807800000084000000140000003000000002001c000100000002801400ff000f000101000000000001000000000200480003000000000014009d00020001010000000000050b00000000001800ff010f000102000000000005200000002002000000001400ff010f00010100000000000512000000010100000000000512000000010100000000000512000000" /f >nul
echo 操作执行完成

rem WaaSMedicSvc
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "DependOnService" /t REG_MULTI_SZ /d "rpcss" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Description" /d "@WaaSMedicSvcImpl.dll,-101" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "DisplayName" /d "@WaaSMedicSvcImpl.dll,-100" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "ErrorControl" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "FailureActions" /t REG_BINARY /d "840300000000000000000000030000001400000001000000c0d4010001000000e09304000000000000000000" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "ImagePath" /t REG_EXPAND_SZ /d "%%systemroot%%\system32\svchost.exe -k wusvcs -p" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "LaunchProtected" /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "ObjectName" /d "LocalSystem" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "RequiredPrivileges" /t REG_MULTI_SZ /d "SeTcbPrivilege\0SeChangeNotifyPrivilege\0SeImpersonatePrivilege\0SeTakeOwnershipPrivilege\0SeSecurityPrivilege\0SeBackupPrivilege\0SeRestorePrivilege\0SeManageVolumePrivilege" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "ServiceSidType" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Start" /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /v "Type" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc\Parameters" /v "ServiceDll" /t REG_EXPAND_SZ /d "%%SystemRoot%%\System32\WaaSMedicSvc.dll" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc\Parameters" /v "ServiceDllUnloadOnStop" /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc\Parameters" /v "ServiceMain" /d "ServiceMain" /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc\Security" /v "Security" /t REG_BINARY /d "010014807800000084000000140000003000000002001c000100000002801400ff000f000101000000000001000000000200480003000000000014009d00020001010000000000050b00000000001800ff010f000102000000000005200000002002000000001400ff010f00010100000000000512000000010100000000000512000000010100000000000512000000" /f >nul
echo 操作执行完成

	:: ----- Reset the BITS service and the Windows Update service to the default security descriptor -----
echo 正在将 BITS 服务和 Windows Update 服务重置为默认安全描述符
	sc.exe sdset wuauserv D:(A;CI;CCLCSWRPLORC;;;AU)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)S:(AU;FA;CCDCLCSWRPWPDTLOSDRCWDWO;;;WD)
	sc.exe sdset bits D:(A;CI;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)S:(AU;SAFA;WDWO;;;BA)
	sc.exe sdset cryptsvc D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)(A;;CCLCSWRPWPDTLOCRRC;;;SO)(A;;CCLCSWLORC;;;AC)(A;;CCLCSWLORC;;;S-1-15-3-1024-3203351429-2120443784-2872670797-1918958302-2829055647-4275794519-765664414-2751773334)
	sc.exe sdset trustedinstaller D:(A;CI;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLOCRRC;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)S:(AU;SAFA;WDWO;;;BA)

	:: ----- Reregister the BITS files and the Windows Update files -----
echo 重新注册 BITS 文件和 Windows Update 文件.
	cd /d %SYSTEMROOT%\system32
	regsvr32.exe /s atl.dll
	regsvr32.exe /s urlmon.dll
	regsvr32.exe /s mshtml.dll
	regsvr32.exe /s shdocvw.dll
	regsvr32.exe /s browseui.dll
	regsvr32.exe /s jscript.dll
	regsvr32.exe /s vbscript.dll
	regsvr32.exe /s scrrun.dll
	regsvr32.exe /s msxml.dll
	regsvr32.exe /s msxml3.dll
	regsvr32.exe /s msxml6.dll
	regsvr32.exe /s actxprxy.dll
	regsvr32.exe /s softpub.dll
	regsvr32.exe /s wintrust.dll
	regsvr32.exe /s dssenh.dll
	regsvr32.exe /s rsaenh.dll
	regsvr32.exe /s gpkcsp.dll
	regsvr32.exe /s sccbase.dll
	regsvr32.exe /s slbcsp.dll
	regsvr32.exe /s cryptdlg.dll
	regsvr32.exe /s oleaut32.dll
	regsvr32.exe /s ole32.dll
	regsvr32.exe /s shell32.dll
	regsvr32.exe /s initpki.dll
	regsvr32.exe /s wuapi.dll
	regsvr32.exe /s wuaueng.dll
	regsvr32.exe /s wuaueng1.dll
	regsvr32.exe /s wucltui.dll
	regsvr32.exe /s wups.dll
	regsvr32.exe /s wups2.dll
	regsvr32.exe /s wuweb.dll
	regsvr32.exe /s qmgr.dll
	regsvr32.exe /s qmgrprxy.dll
	regsvr32.exe /s wucltux.dll
	regsvr32.exe /s muweb.dll
	regsvr32.exe /s wuwebv.dll
echo 文件重新注册操作执行完成
echo.
	:: ----- Resetting Winsock -----
echo 重置 Winsock
	netsh winsock reset

	:: ----- Resetting WinHTTP Proxy -----
echo 重置 WinHTTP 代理设置

	if %family% EQU 5 (
		proxycfg.exe -d
	) else (
		netsh winhttp reset proxy
	)

	:: ----- Set the startup type as automatic -----
echo 重置服务状态为自动启动
	sc.exe config wuauserv start= auto
	sc.exe config bits start= delayed-auto
	sc.exe config cryptsvc start= auto
	sc.exe config TrustedInstaller start= demand
	sc.exe config DcomLaunch start= auto
  sc.exe config WaaSMedicSvc start= auto

	:: ----- Starting the Windows Update services -----
echo 启动 Windows Update 相关服务
	net start bits
	net start wuauserv
	net start appidsvc
	net start cryptsvc
	net start DcomLaunch

	:: ----- End process -----
	echo 所有操作已执行完成

	echo 修复 Windows Update 完成
	pause
goto menu

:wudisable
cls
echo.
echo     二次确认：此操作将禁用 Windows Update
echo     若您不明白您在做什么，请输入 0 返回主菜单
echo     若已明确需求，继续操作请输入 Y
echo.
set /p wuinput=→  请输入选项：
if %wuinput% equ 0 goto menu
if %wuinput% equ Y goto wudisablestart
if %wuinput% equ y goto wudisablestart
goto menu

:wudisablestart

echo 取消正在进行的 Windows Update 操作
taskkill /im wuauclt.exe /f

echo 停止 Windows Update 相关服务

net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc
net stop WaaSMedicSvc
net stop UsoSvc

echo 检查 BITS 服务状态

	sc query bits | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 BITS 服务失败
		echo.
		echo 再次重试停止 BITS 服务
    net stop bits
	)

echo 检查 Windows Update 服务状态

	sc query wuauserv | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Windows Update 服务失败
		echo.
		echo 再次重试停止 Windows Update 服务
    net stop wuauserv
	)

echo 检查 Application Identity 服务状态

	sc query appidsvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		sc query appidsvc | findstr /I /C:"OpenService FAILED 1060"
		if %errorlevel% NEQ 0 (
			echo 停止 Application Identity 服务失败
			echo.
			echo 再次重试停止 Application Identity 服务
      net stop appidsvc
		)
	)

echo 检查 Cryptographic 服务状态

	sc query cryptsvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Cryptographic 服务失败
		echo.
		echo 再次重试停止 Cryptographic 服务
    net stop cryptsvc
	)

echo 检查 Windows Update Medic 服务状态

	sc query WaaSMedicSvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Windows Update Medic 服务失败
		echo.
		echo 再次重试停止 Windows Update Medic 服务
    net stop cryptsvc
	)

echo 检查 Update Orchestrator 服务状态

	sc query WaaSMedicSvc | findstr /I /C:"STOPPED"
	if %errorlevel% NEQ 0 (
		echo 停止 Update Orchestrator 服务失败
		echo.
		echo 再次重试停止 Update Orchestrator 服务
    net stop UsoSvc
	)


echo 禁用 Windows Update 相关服务

sc stop WaaSMedicSvc >nul
sc config WaaSMedicSvc start= disabled >nul

sc stop wuauserv >nul
sc config wuauserv start= disabled >nul

sc stop BITS >nul
sc config BITS start= disabled >nul

sc stop cryptsvc >nul
sc config cryptsvc start= disabled >nul
echo 操作执行完成
echo. 
echo 注册表信息更新
echo 清理 BITS 服务
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\BITS" /f >nul
echo 清理 UsoSvc 服务
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc" /f >nul
echo 清理 WaaSMedicSvc 服务
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc" /f >nul
echo 清理 wuauserv 服务
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\wuauserv" /f >nul
echo.
echo 操作执行完成


echo 清理 qmgr*.dat 文件
del /s /q /f "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"
del /s /q /f "%ALLUSERSPROFILE%\Microsoft\Network\Downloader\qmgr*.dat"
echo.
echo 删除旧的 SoftwareDistribution 备份文件

cd /d %SYSTEMROOT%

	if exist "%SYSTEMROOT%\winsxs\pending.xml.bak" (
		del /s /q /f "%SYSTEMROOT%\winsxs\pending.xml.bak"
	)
	if exist "%SYSTEMROOT%\SoftwareDistribution.bak" (
		rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution.bak"
	)
	if exist "%SYSTEMROOT%\system32\Catroot2.bak" (
		rmdir /s /q "%SYSTEMROOT%\system32\Catroot2.bak"
	)
	if exist "%SYSTEMROOT%\WindowsUpdate.log.bak" (
		del /s /q /f "%SYSTEMROOT%\WindowsUpdate.log.bak"
	)
echo.
echo 清理 SoftwareDistribution 文件夹

	if exist "%SYSTEMROOT%\winsxs\pending.xml" (
		takeown /f "%SYSTEMROOT%\winsxs\pending.xml"
		attrib -r -s -h /s /d "%SYSTEMROOT%\winsxs\pending.xml"
		del /s /q /f "%SYSTEMROOT%\winsxs\pending.xml"
	)
	if exist "%SYSTEMROOT%\SoftwareDistribution" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\SoftwareDistribution"
		rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution"
		if exist "%SYSTEMROOT%\SoftwareDistribution" (
			echo.
			echo 未能成功删除 SoftwareDistribution 文件夹
			echo.
			echo 操作失败，请检查文件夹权限和安全软件拦截情况
      echo 检查完毕后请重新运行此功能进行修复
			pause>nul
			goto menu
		)
	)
	if exist "%SYSTEMROOT%\system32\Catroot2" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\system32\Catroot2"
		rmdir /s /q "%SYSTEMROOT%\system32\Catroot2"
	)
	if exist "%SYSTEMROOT%\WindowsUpdate.log" (
		attrib -r -s -h /s /d "%SYSTEMROOT%\WindowsUpdate.log"
		del /s /q /f "%SYSTEMROOT%\WindowsUpdate.log"
	)
echo.
echo 所有操作已执行完成
echo 已禁用 Windows Update
pause
goto menu

:gpeditmsc
cls
echo.
echo 正在启动本地组策略编辑器
start gpedit.msc
echo 操作执行完成
pause
goto menu

:servicesmsc
cls
echo.
echo 正在启动服务管理单元
start services.msc
echo 操作执行完成
pause
goto menu

:regeditexe
cls
echo.
echo 正在启动注册表编辑器
start regedit.exe
echo 操作执行完成
pause
goto menu

:compmgmtmsc
cls
echo.
echo 正在启动计算机管理
start compmgmt.msc
echo 操作执行完成
pause
goto menu

:eventvwrmsc
cls
echo.
echo 正在启动事件管理器
start eventvwr.msc
echo 操作执行完成
pause
goto menu

:ctrlpanel
cls
echo.
echo 正在启动控制面板
rem start control
rundll32.exe shell32.dll,Control_RunDLL
echo 操作执行完成
pause
goto menu

:winversion
cls
echo.
echo 执行 Winver 命令
winver
echo 操作执行完成
pause
goto menu

:startmssetting
cls
echo.
echo 正在打开设置
start ms-settings:wheel
echo 操作执行完成
pause
goto menu

:starttaskmgr
cls
echo.
echo 正在启动任务管理器
start taskmgr.exe
echo 操作执行完成
pause
goto menu

:startdiskmgr
cls
echo.
echo 正在启动磁盘管理
start diskmgmt.msc
echo 操作执行完成
pause
goto menu

:sharemanage
cls
echo.
echo 正在启动共享文件夹管理
start fsmgmt.msc
echo 操作执行完成
pause
goto menu

:startperfmon
cls
echo.
echo 正在启动性能监视器
start perfmon.msc
echo 操作执行完成
pause
goto menu

:securemgr
cls
echo.
echo 正在启动本地安全组策略
start secpol.msc
echo 操作执行完成
pause
goto menu

:dxcheck
cls
echo.
echo 正在启动 DirectX 检测工具
start dxdiag
echo 操作执行完成
pause
goto menu

:rdapp
cls
echo.
echo 正在启动远程桌面连接
start mstsc
echo 操作执行完成
pause
goto menu

:optionalfunc
cls
echo.
echo 正在启动 Windows 功能管理（启用或关闭 Windows 功能）
rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl,,2
rem start OptionalFeatures
echo 操作执行完成
pause
goto menu

:ms_config
cls
echo.
echo 正在启动系统配置（启动、引导管理）
start msconfig
echo 操作执行完成
pause
goto menu

:startsysinfo
cls
echo.
echo 正在启动系统信息
start msinfo32
echo 操作执行完成
pause
goto menu

:memcheckprogram
cls
echo.
echo 正在启动 Windows 内存诊断
start mdsched
echo 操作执行完成
pause
goto menu

:componentmgr
cls
echo.
echo 正在启动组件服务管理
start dcomcnfg
echo 操作执行完成
pause
goto menu

:ipconfigsys
cls
echo.
echo 查看本机网络连接信息
echo 执行命令
rem 如果路径不存在则创建路径
if not exist "%userprofile%\desktop\MDT" md "%userprofile%\desktop\MDT"
ipconfig /all >%userprofile%\desktop\MDT\Sys_ipconfig_Detail.log
ipconfig >%userprofile%\desktop\MDT\Sys_ipconfig_Basic.log
type %userprofile%\desktop\MDT\Sys_ipconfig_Basic.log
echo 操作执行完成
echo 本机网络连接信息导出完成
echo 请查看桌面 MDT 文件夹中的 Sys_ipconfig_Basic.log 和 Sys_ipconfig_Detail.log 文件
rem start %userprofile%\desktop\MDT\sys_ipconfig.log
echo 路径：%userprofile%\desktop\MDT\Sys_ipconfig_Basic.log
echo 路径：%userprofile%\desktop\MDT\Sys_ipconfig_Detail.log
pause
goto menu

:setbatteryoption
cls
echo.
echo     请选择你要设置的电源选项：
echo.
echo     0. 返回主菜单
echo     1. 节能模式
echo     2. 平衡模式
echo     3. 高性能模式
echo     4. 卓越性能模式（仅限于Win10/11专业版以上）
set /p binput=→  请输入：
if %binput% equ 0 goto menu
if %binput% equ 1 goto setlowbattery
if %binput% equ 2 goto setmedbattery
if %binput% equ 3 goto sethighperfbattery
if %binput% equ 4 goto setextremeperfbattery
echo →  输入异常，请检查输入选项
goto setbatteryoption
:setlowbattery
echo 正在设置电源选项（部分机型可能无效，例如Surface）
echo.
echo 设置节能模式
powercfg /s a1841308-3541-4fab-bc81-f71556f20b4a
echo.
goto setbatteryfin

:setmedbattery
echo 正在设置电源选项（部分机型可能无效，例如Surface）
echo.
echo 设置平衡模式
powercfg /s 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
goto setbatteryfin

:sethighperfbattery
echo 正在设置电源选项（部分机型可能无效，例如Surface）
echo.
echo 设置高性能模式
powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo.
goto setbatteryfin

:setextremeperfbattery
echo 正在设置电源选项（部分机型可能无效，例如Surface）
echo.
echo 设置卓越性能模式（仅限于Win10/11专业版以上）
powercfg /s e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
goto setbatteryfin

:setbatteryfin
echo.
echo     电源选项设置完成
echo.
echo     请选择你要继续的操作：
echo     0. 返回主菜单
echo     1. 重新设置计算机使用的电源选项
echo     2. 恢复其他电源选项
set /p bfinput=→  请输入：
if %bfinput% equ 0 goto menu
if %bfinput% equ 1 goto setbatteryoption
if %bfinput% equ 2 goto borecmenu
echo →  输入异常，请检查输入选项
goto setbatteryfin

rem 网络彻底重置，网络完全重置，整合代码开始
:NetworkAllReset
cls
rem proxydiag
echo 代理环境诊断开始
echo.
call:securitysoft
call:minidump
call:ieproxy
call:ipv6state
rem call:systemfirewalloff
call:dnsserver 本地DNS服务器: 
call:dnseventlog
call:systemtime
echo.
echo 代理环境诊断完成
echo.
rem networkreset
echo 网络重置开始
echo.
echo 正在结束加速器进程...
echo.
rem 结束VeryKuai加速器
taskkill /F /IM VeryKuai.exe >nul 2>nul
rem 结束雷神加速器
taskkill /F /IM Leigod.exe >nul 2>nul
rem 结束uu加速器
taskkill /F /IM uu.exe >nul 2>nul
rem 结束zz加速器（AK旗下，征云网络科技）
taskkill /F /im ZZ.exe >nul 2>nul
rem 结束迅游加速器
taskkill /F /im xunyou.exe >nul 2>nul
rem 结束鲜牛加速器
taskkill /F /im XianNiu.exe >nul 2>nul
rem 结束奇游加速器
taskkill /F /im QiYou.exe >nul 2>nul
rem 结束小黑盒加速器
taskkill /F /im heyboxacc.exe >nul 2>nul
taskkill /f /im heyboxbrowser.exe >nul 2>nul
rem 结束nn加速器(雷神旗下)
taskkill /F /im nn.exe >nul 2>nul
rem 结束AK加速器（征云网络科技）
taskkill /F /im AK.exe>nul 2>nul
echo 结束代理程序
taskkill /im v2rayN.exe /F >nul 2>nul
taskkill /im "Clash for Windows.exe" /F >nul 2>nul
taskkill /im proxy.exe /F >nul 2>nul
taskkill /im v2ray.exe /F >nul 2>nul
taskkill /im wv2ray.exe /F >nul 2>nul
taskkill /im v2ray_privoxy.exe /F >nul 2>nul
taskkill /im sysproxy.exe /F >nul 2>nul
echo.
echo 操作执行完成
echo.
echo 请关闭加速器以获得最佳修复效果
echo.
echo 前置修复：重置 LSP
netsh winsock reset >nul 2>nul
echo.
echo.
echo 重置 TCP/IP 协议
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

echo 禁用 Killer 服务
sc config "Killer Network Service x64" start= disabled >nul 2>nul
sc config "Killer Network Service" start= disabled >nul 2>nul
sc config "Killer Bandwidth Service" start= disabled >nul 2>nul
sc config "Rivet Bandwidth Service" start= disabled >nul 2>nul

echo.
echo 重置 LSP
netsh winsock reset >nul 2>nul
netsh winsock reset >nul 2>nul
echo.

echo 重置 hosts 文件权限并清空
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
call:host1fix

echo 停止并删除驱动服务
set drivername=vkdpi xunyoufilter xunyounpf QeeYouPacket npf uuwfp uupacket networktunnel10_x64 ylwfp TP2CNNetFilter lgdcatcher lgdcatchertdi xfilter savitar netrtp
for %%i in (%drivername%) do (
sc stop %%i >nul 2>nul
sc config %%i start= DISABLED >nul 2>nul
sc delete %%i >nul 2>nul
)
echo.

call:ieproxy

echo 刷新 DNS/ARP 缓存
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

echo 清理系统临时文件
rd /s /q %windir%\temp & md %windir%\temp >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*" >nul 2>nul
del /f /s /q "%userprofile%\Local Settings\Temp\*.*" >nul 2>nul
echo.

echo 清理 Cookies
del /f /q %userprofile%\cookies\*.* >nul 2>nul

echo 清理最近使用文件和跳转列表
del /f /q %userprofile%\recent\*.* >nul 2>nul
del /f /s /q "%userprofile%\recent\*.*" >nul 2>nul
del /f /s /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*.*" >nul 2>nul
echo.

echo 清理临时 Internet 文件
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Temporary Internet Files\*.*" >nul 2>nul
echo.

echo 清理字体缓存
del /f /s /q "%windir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" >nul 2>nul
echo.

echo 清理 CryptoAPI 证书缓存
del /f /s /q "%userprofile%\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*" >nul 2>nul
echo.

echo 清理预加载文件
del /f /s /q "%windir%\Prefetch\*.pf" >nul 2>nul
echo.
echo 清理 Microsoft Edge 缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Extension State\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Session Storage\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\JumpListIconsRecentClosed\*.tmp" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*" >nul 2>nul
echo.

echo 清理 Internet Explorer 缓存
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Internet Explorer\DOMStore\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\container.dat" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\deprecated.cookie" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*" >nul 2>nul
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\WebCache\*.*" >nul 2>nul
echo.

echo 修复 SSL 3.0 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "CheckedValue" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "DefaultValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "HelpID" /d "iexplore.hlp#50129" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "Mask" /t REG_DWORD /d 32 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-4753" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "Text" /d "SSL 3.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\SSL3.0" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.0 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "CheckedValue" /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "DefaultValue" /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "Mask" /t REG_DWORD /d 128 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-4754" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "Text" /d "TLS 1.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.0" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.1 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "CheckedValue" /t REG_DWORD /d 512 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "DefaultValue" /t REG_DWORD /d 512 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "Mask" /t REG_DWORD /d 512 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "OSVersion" /d "3.6.1.0.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-6800" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "Text" /d "TLS 1.1" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.1" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.2 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "CheckedValue" /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "DefaultValue" /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "Mask" /t REG_DWORD /d 2048 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "OSVersion" /d "3.6.1.0.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-6801" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "Text" /d "TLS 1.2" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.2" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo 修复 TLS 1.3 选项
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "CheckedValue" /t REG_DWORD /d 8192 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "DefaultValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "HelpID" /d "iexplore.hlp#50511" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "HKeyRoot" /t REG_DWORD /d 2147483649 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "Mask" /t REG_DWORD /d 8192 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "OSVersion" /d "3.6.1.0.0" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "PlugUIText" /d "@C:\Windows\System32\inetcpl.cpl,-6802" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "RegPath" /d "SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "RegPoliciesPath" /d "SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "Text" /d "TLS 1.3" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "Type" /d "checkbox" /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "UncheckedValue" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Microsoft\Internet Explorer\AdvancedOptions\CRYPTO\TLS1.3" /v "ValueName" /d "SecureProtocols" /f >nul
echo 操作执行完成
echo.

echo IE 组件修复
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo.
set var=0
for /l %%i in (15,-1,1) do echo 正在停止驱动服务: %var%%%i && ping -n 2 127.1 >nul

echo 再次重置 IE
echo.
del /f /q "%temp%\mb" >nul 2>nul
echo Miniblink 缓存清理成功
Rundll32 InetCpl.cpl,ClearMyTracksByProcess 255
echo IE 缓存清理成功
echo 请在弹出窗口里勾选“删除个人设置“，再点击重置，最后点击关闭
echo 程序将在完成操作后继续进行
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
echo IE 已重置
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo 清空 IE 代理设置
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
echo.
echo 开始修复 IE 主页
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:start" /f >nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "https://www.msn.cn/zh-cn" /f >nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /d "http://go.microsoft.com/fwlink/?LinkId=54896" /f >nul
reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "http://go.microsoft.com/fwlink/?LinkId=625115" /f >nul
echo 修复完成

echo IE 组件已修复
echo.

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

echo.
echo LSP 修复
netsh winsock reset
netsh winsock reset
netsh winsock reset
echo.
echo 已修复
echo.
echo 更换 DNS
call:dnssetting 223.5.5.5 8.8.8.8
echo.
echo 尝试设置电源选项为卓越性能/高性能
echo 正在设置电源选项...
echo.
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
echo 设置电源选项完成
echo 如遇设置异常，可在系统诊断修复菜单中，选择电源选项恢复进行修复
echo.
echo     提醒：如果帧率仍然比预想的要低或者不正常，请检查系统问题
echo     包括但不限于软件层面：OEM定制驱动软件限制功耗影响帧率（节能模式、办公模式等）
echo     NVIDIA Experience、AMD等控制面板限制功耗影响帧率
echo     系统虚拟内存设置异常、各种系统小问题堆积导致大异常
echo     某些软件环境后台（不一定显示）占用大量系统资源进行运算（模型训练、挖矿软件、木马病毒等）
echo     硬件层面：电池电压不稳，计算机供电异常，运行内存过小、内存条接触异常识别异常
echo     固态硬盘损坏，机械硬盘老化（推荐除了文件存储需求外，软件均安装至固态硬盘内）
echo     请自行排查重试，若均难以解决，请联系专业用户。
echo.
echo 修复 Xbox 多人游戏
echo.
echo 临时禁用 Teredo 隧道
netsh int teredo set state disable > NUL

echo 禁用华硕 GameFirst (建议卸载！)
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

echo 重置 Windows 防火墙策略
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

echo 重置系统 IPv6 设置
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

echo 操作执行完成
echo.

echo 启动系统服务
sc start IKEEXT > NUL
sc start FDResPub > NUL
sc start SSDPSRV > NUL
sc start upnphost > NUL

echo 设置 IPv6 前缀优先级
netsh int ipv6 set prefix ::1/128 50 0 > NUL
netsh int ipv6 set prefix ::/0 40 1 > NUL
netsh int ipv6 set prefix 2002::/16 30 2 > NUL
netsh int ipv6 set prefix ::/96 20 3 > NUL
netsh int ipv6 set prefix ::ffff:0:0/96 100 4 > NUL

echo 启动 IP Helper 服务
sc start iphlpsvc > NUL

echo 配置 Teredo 隧道参数
route delete ::/0 > NUL
netsh int teredo set state type=default > NUL
netsh int teredo set state enterpriseclient teredo.remlab.net 20 0 > NUL
netsh int ipv6 add route ::/0 "Teredo Tunneling Pseudo-Interface" > NUL

echo 启动 Xbox 网络服务
sc start XboxNetApiSvc > NUL
sc start XblAuthManager > NUL

echo 修复工具运行结束！
echo Teredo 配置状态：
netsh int teredo show state
echo.
echo 已修复 Xbox 多人游戏

echo 开始修复 Steam
echo.
echo 正在检测 Steam 是否开启......
tasklist | find /I "Steam.exe"
if errorlevel 1 goto steamchina
if not errorlevel 1 goto startvacfix

:steamchina
echo 正在检测国服启动器是否开启......
tasklist | find /I "steamchina.exe"
if errorlevel 1 goto stopsteam
if not errorlevel 1 goto startvacfix

:stopsteam
echo Steam 和国服启动器均未开启
goto startvacfix

:killsteam
echo Steam 已开启
echo 正在强制关闭
taskkill /F /IM Steam.exe
echo 已强制关闭
goto startvacfix

:killsteamchina
echo Steam 已开启
echo 正在强制关闭
taskkill /F /IM steamchina.exe
echo 已强制关闭
goto startvacfix

:startvacfix
echo 开始解决 VAC 屏蔽

echo 开启 Network Connections
sc config Netman start= AUTO
sc start Netman

echo 开启 Remote Access Connection Manager
sc config RasMan start= AUTO
sc start RasMan

echo 开启 Telephony
sc config TapiSrv start= AUTO
sc start TapiSrv

echo 开启 Windows Firewall
sc config MpsSvc start= AUTO
sc start MpsSvc
netsh advfirewall set allprofiles state on

echo 恢复 Data Execution Prevention 启动设置为默认值
bcdedit /deletevalue nointegritychecks
bcdedit /deletevalue loadoptions
bcdedit /debug off
bcdedit /deletevalue nx

echo 正在获取你的 Steam 或国服启动器目录
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\SOFTWARE\Valve\Steam" ^| find /i "SteamPath"') do set "SteamPath=%%k" 
if "%SteamPath%" NEQ "0x1" (goto Autosteampath) else (goto Manualerr)

:Autosteampath
echo Steam 或国服启动器目录为%SteamPath% 

echo 开始安装 Steam Services
cd /d "%SteamPath%\bin"
steamservice  /install
ping -n 3 127.0.0.1>nul
echo 开始修复 Steam Services
steamservice  /repair
ping -n 3 127.0.0.1>nul
echo .
echo 修复 Steam Services 完毕
echo 出现"Steam client service installation complete"且无任何"Fail"字样
echo (如"Add firewall exception failed for steamservice.exe"出现)才可以结束，
echo 否则请检查您的防火墙设置(关闭“不允许例外”选项)

echo 启动Steam Services服务
sc config "Steam Client Service" start= AUTO
sc start "Steam Client Service"

echo 修复完成，请重启Steam
echo.
echo 开始清理 Flash Player 播放器缓存
reg delete "HKCU\Software\Macromedia\FlashPlayer" /f >nul
echo 清理完成

echo 重启 EAC 相关服务
sc stop EasyAntiCheat_EOS >nul 2>nul
sc stop EasyAntiCheat >nul 2>nul
sc start EasyAntiCheat_EOS >nul 2>nul
sc start EasyAntiCheat >nul 2>nul
echo 操作执行完成
echo.
echo LSP 修复及 DNS 缓存清理
netsh winsock reset
ipconfig /flushdns
echo 操作执行完成
echo.
echo 所有操作已执行完成
echo 请重新启动计算机以完成修复
set /p choice=你想要现在重启计算机吗？ (y/N) 
if /I "%choice%"=="y" shutdown -r -t 0
if /I "%choice%"=="Y" shutdown -r -t 0
goto :EOF

rem 网络整合重置代码结束

:sysuserbackup
cls
echo     即将开始用户数据备份工作，请指定备份路径（请用引号引用路径）
echo     请确保目标备份路径空间充足，避免出现备份失败的问题！
echo     若不想备份请在备份路径中输入 0 返回主菜单
set /p bakpath=→  备份路径：
echo.
if %bakpath% equ 0 goto menu
echo.
echo 识别到的用户路径为%bakpath%
if not exist %bakpath% md %bakpath%

if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	echo 无法创建指定目录，请检查是否存在此路径或是否限制程序权限！
  pause
  goto sysuserbackup
)

echo 开始系统盘（C盘）用户资料备份
echo.
echo 读取用户数据，导出文件目录结构
tree %userprofile% >%bakpath%\UserProfile_Data_Tree.log
echo 导出完成文件目录结构完成，路径为：%bakpath%\UserProfile_Data_Tree.log
echo.
echo 数据备份未屏蔽用户输出，方便查看定位备份进度
echo.
echo 开始备份用户数据
echo 数据较多，请耐心等待...
echo.
echo 用户文档备份...
echo 数据较多，请耐心等待...
echo D| xcopy /v /s /e /y /i /c "%userprofile%\Documents" "%bakpath%\UserProfile_Data\Documents"
echo 用户文档备份完成
echo.
echo 用户图片备份...
echo 数据较多，请耐心等待...
echo D| xcopy /v /s /e /y /i /c "%userprofile%\Pictures" "%bakpath%\UserProfile_Data\Pictures"
echo 用户图片备份完成
echo.
echo 用户下载文件备份...
echo 数据较多，请耐心等待...
echo D| xcopy /v /s /e /y /i /c "%userprofile%\Downloads" "%bakpath%\UserProfile_Data\Downloads"
echo 用户下载文件备份完成
echo.
echo 用户视频备份...
echo 数据较多，请耐心等待...
echo D| xcopy /v /s /e /y /i /c "%userprofile%\Videos" "%bakpath%\UserProfile_Data\Videos"
echo 用户视频备份完成
echo.
echo 用户音乐备份...
echo 数据较多，请耐心等待...
echo D| xcopy /v /s /e /y /i /c "%userprofile%\Music" "%bakpath%\UserProfile_Data\Music"
echo 用户音乐备份完成
echo.
echo 用户桌面数据备份...
echo 数据较多，请耐心等待...
echo D| xcopy /v /s /e /y /i /c "%userprofile%\Desktop" "%bakpath%\UserProfile_Data\Desktop"
echo 用户桌面数据备份完成
echo.
echo 即将开始备份 AppData 数据
echo.
echo AppData 数据较大，多为软件数据游戏存档等，推荐手动备份
echo.
echo 请确保目标备份路径空间充足，避免出现备份失败的问题！
echo set /p appbak=是否要备份 AppData 数据？（y/N）
if %appbak% equ y goto appdatabak
if %appbak% equ Y goto appdatabak
if %appbak% equ n goto passappdata
if %appbak% equ N goto passappdata

:appdatabak
echo 开始备份 AppData 数据...
echo AppData 数据较大，耗时较久，请耐心等待
echo D| xcopy /v /s /e /y /i /c "%userprofile%\AppData" "%bakpath%\UserProfile_Data\AppData"
echo 备份 AppData 数据完成
goto OEMBAK

:passappdata
echo 已跳过 AppData 数据备份
echo 正在打开 AppData 路径，请自行选择数据备份！
start %userprofile%\AppData
echo 操作执行完成
echo.
goto OEMBAK

:OEMBAK
echo 备份 OEM 定制文件
echo D| xcopy /v /s /e /y /i /c "C:\Recovery" "%bakpath%\C_Driver_Data\Recovery"
echo OEM 定制文件备份完成
echo.
if exist "C:\FLiNGTrainers" (
	echo 开始备份风灵月影修改器数据
	echo D| xcopy /v /s /e /y /i /c "C:\FLiNGTrainers" "%bakpath%\C_Driver_Data\FLiNGTrainers"
	echo 备份风灵月影修改器数据完成
)
echo 请自行备份其余C盘根目录数据
start C:\
echo.
echo 操作执行完成
echo.
echo 所有操作已执行完成
echo.
echo 用户数据备份完成，备份存储路径为：%bakpath%
start %bakpath%
echo.
echo     部分数据请自行备份，确保备份完全
echo     备份过程中已增加文件校验环节，保险起见请二次检查备份文件是否完整！
echo     如果因磁盘空间不足而导致备份失败，请务必重新备份数据！
echo     重装系统等敏感操作前请仔细检查备份工作是否到位！
pause
goto menu

:desktopiconset
cls
echo.
echo 正在打开桌面图标设置
rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0
echo 操作执行完成
pause
goto menu

:useraccset
cls
echo.
echo 正在打开用户账户设置
rundll32.exe shell32.dll,Control_RunDLL nusrmgr.cpl
echo 操作执行完成
pause
goto menu

:firewallset
cls
echo.
echo 正在打开 Windows Defender 防火墙设置
rundll32.exe shell32.dll,Control_RunDLL firewall.cpl
echo 操作执行完成
pause
goto menu

:applistset
cls
echo.
echo 正在打开程序和功能（卸载或更改程序）
rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl
echo 操作执行完成
pause
goto menu

:computerpropset
cls
echo.
echo 正在打开系统属性设置
rundll32.exe shell32.dll,Control_RunDLL sysdm.cpl
echo 操作执行完成
pause
goto menu

:timezoneset
cls
echo.
echo 正在打开时间和区域设置
rundll32.exe shell32.dll,Control_RunDLL intl.cpl,,0
echo 操作执行完成
pause
goto menu

:easyuseset
cls
echo.
echo 正在打开轻松使用设置中心
rundll32.exe shell32.dll,Control_RunDLL access.cpl
echo 操作执行完成
pause
goto menu

:scrpropset
cls
echo.
echo 正在打开显示属性（屏幕设置）
rundll32.exe shell32.dll,Control_RunDLL desk.cpl
echo 操作执行完成
pause
goto menu

:securitycenter
cls
echo.
echo 正在打开安全和维护（Windows 安全中心）
rundll32.exe shell32.dll,Control_RunDLL wscui.cpl
echo 操作执行完成
pause
goto menu

:netconnectcenter
cls
echo.
echo 打开网络连接设置（传统设置）
rundll32.exe shell32.dll,Control_RunDLL ncpa.cpl
echo 操作执行完成
pause
goto menu
