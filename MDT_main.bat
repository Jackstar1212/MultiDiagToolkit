@echo off
REM Copyright (c) 2025 Jackstar1212. MIT License.
setlocal enabledelayedexpansion
title MultiDiagToolKit
rem check active code page flag
set check_done=0
rem set target active code page
set targetACP=936

:: Check whether a code page check has been performed
if "%~1" == "check_done" (
    set check_done=1
	goto normalload
)

if %check_done% equ 0 (
    echo.
    echo     Checking requirements...
    echo.
    rem for /f "tokens=2 delims=: " %%i in ('chcp') do set "activecp=%%i"
	for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v ACP 2^>nul') do set "activecp=%%i"
    if "!activecp!" equ "%targetACP%" (
        echo     检查通过，当前活动代码页为：!activecp! 符合运行要求。
        set check_done=1
        goto normalload
    ) else (
        echo     Incompatibility has been detected.
        echo     The current active code page is !activecp!, which fails to meet the minimum requirements of the program running.
        echo     Please visit https://www.nekomoe.fun/ or contact administrator for further support.
        echo.
        echo     Although we will try to temporarily modify the active code page, We strongly recommend you quit the program to avoid damage to your computer.
        echo.    If you continue to run the program, garbled Chinese characters may appear, leading to unknown errors. 
        echo.
        echo     Here are some Chinese characters for test: 你好，世界。Hello, world.
        echo.
        set /p checkoption="→   Do you want to continue? (y/N): "
        if "!checkoption!" equ "" goto endprogram
        if "!checkoption!" equ "y" set check_done=1 & goto forceload
        if "!checkoption!" equ "Y" set check_done=1 & goto forceload
        if "!checkoption!" equ "n" goto endprogram
        if "!checkoption!" equ "N" goto endprogram
        echo     Input error, please check again. A force exit is being executed.
        goto endprogram
    )
)

:forceload
echo.
cls
echo     A force load is being executed.
echo.
goto normalload

:endprogram
echo.
echo     Sorry for inconvenience. Thanks for using.
timeout /t 2 /nobreak >nul
exit

:normalload
chcp 936 >nul 2>nul
rem 临时修改活动代码页为 GB2312 确保中文被正确识别

rem HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage
rem OEMCP ACP 两个 REG_SZ 改成 936 永久修正 CMD 活动代码页 为 GB2312(ANSI)
rem 部分系统被修改为 65001 即 UTF-8 可能会有兼容性问题，推荐修正

rem 取得管理员权限
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
	chcp %targetACP% >nul
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

    timeout /t 3 /nobreak > NUL
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "check_done", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    cls
    Exit /b
)

:: If running as an administrator and are not checking the code page, check code page
if %check_done% equ 0 (
    echo.
    echo     Checking requirements...
    echo.
    rem for /f "tokens=2 delims=: " %%i in ('chcp') do set "activecp=%%i"
	for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v ACP 2^>nul') do set "activecp=%%i"
    if "!activecp!" equ "%targetACP%" (
        echo     检查通过，当前活动代码页为：!activecp! 符合运行要求。
        set check_done=1
    ) else (
        echo     Incompatibility has been detected.
        echo     The current active code page is !activecp!, which fails to meet the minimum requirements of the program running.
        echo     Please visit https://www.nekomoe.fun/ or contact administrator for further support.
        echo.
        echo     Although we will try to temporarily modify the active code page, We strongly recommend you quit the program to avoid damage to your computer.
        echo.    If you continue to run the program, garbled Chinese characters may appear, leading to unknown errors. 
        echo.
        echo     Here are some Chinese characters for test: 你好，世界。Hello, world.
        echo.
        set /p checkoption="→   Do you want to continue? (y/N): "
        if "!checkoption!" equ "" goto endprogram
        if "!checkoption!" equ "y" set check_done=1 & goto forceload
        if "!checkoption!" equ "Y" set check_done=1 & goto forceload
        if "!checkoption!" equ "n" goto endprogram
        if "!checkoption!" equ "N" goto endprogram
        echo     Input error, please check again. A force exit is being executed.
        goto endprogram
    )
)

chcp 936 >nul 2>nul

rem 临时修改活动代码页为 GB2312 确保中文被正确识别
rem 系统诊断修复工具
rem 设置窗口大小及颜色
rem color 2f
color 70
mode con cols=92 lines=54
rem cols 设置宽度；lines 设置长度
rem 颜色属性由两个十六进制数字指定 -- 第一个对应于背景，第二个对应于前景。每个数字可以为以下任何值:
rem 0 = 黑色 1 = 蓝色 2 = 绿色 3= 浅绿色 4 = 红色 5 = 紫色 6 = 黄色 7 = 白色 8 = 灰色 9 = 淡蓝色 A = 淡绿色 B = 淡浅绿色 C = 淡红色 D = 淡紫色 E = 淡黄色 F = 亮白色
rem 检查系统环境变量

rem 快速初始化开关，默认0，为1时跳过生成系统信息初始化
rem 方便调试优化，测试时可以设置fastlaunch为1
set fastlaunch=0
rem 若需要菜单，请删除L76的goto InitializeCheck
rem goto InitializeCheck

set BypassSecuritySoftwareCheck=0
rem 此选项为是否允许安全软件检查，设置为1时跳过安全检查，默认值0
rem 开启此选项以禁用本程序的安全软件检查

rem 设置程序版本、作者信息
set "progver=5.2"
set "Author=LonelyFish"

title 系统诊断修复工具 v%progver% by %Author%

rem 启动菜单
cls
echo.
echo ---------------------------------------
echo     多合一系统诊断修复工具 启动菜单
echo ---------------------------------------
echo.
echo     请选择启动模式：
echo.
echo     0. 退出程序
echo     1. 常规启动
echo     2. 快速启动
echo     3. 常规启动 禁用安全检查（不推荐）
echo     4. 快速启动 禁用安全检查（不推荐）
echo.
echo     （常规启动异常时可尝试快速启动）
echo.
set /p bootmode=→  请选择启动模式：
if "%bootmode%"=="" (
	set fastlaunch=0
	set BypassSecuritySoftwareCheck=0
	goto InitializeCheck
)
if %bootmode% equ 0 goto exitprogram
if %bootmode% equ 1 (
	set fastlaunch=0
	set BypassSecuritySoftwareCheck=0
	goto InitializeCheck
)
if %bootmode% equ 2 (
	set fastlaunch=1
	set BypassSecuritySoftwareCheck=0
	goto InitializeCheck
)
if %bootmode% equ 3 (
	set fastlaunch=0
	set BypassSecuritySoftwareCheck=1
	goto InitializeCheck
)
if %bootmode% equ 4 (
	set fastlaunch=1
	set BypassSecuritySoftwareCheck=1
	goto InitializeCheck
)


rem 启动模式菜单
rem cls
rem echo.
rem echo ---------------------------------------
rem echo     多合一系统诊断修复工具 启动菜单
rem echo ---------------------------------------
rem echo.
rem echo     请选择启动模式：
rem echo.
rem echo     0. 退出程序
rem echo     1. 常规启动
rem echo     2. 快速启动（常规启动异常时可以选我）
rem echo.
rem set /p bootmode1=→  请选择启动模式：
rem if "%bootmode1%"=="" set bootmode1=1
rem if %bootmode1% equ 0 goto exitprogram
rem if %bootmode1% equ 1 set fastlaunch=0
rem if %bootmode1% equ 2 set fastlaunch=1
rem goto SSCMenu

rem :SSCMenu
rem rem 安全软件检查菜单
rem cls
rem echo.
rem echo ---------------------------------------
rem echo     多合一系统诊断修复工具 启动菜单
rem echo ---------------------------------------
rem echo.
rem echo     是否禁用安全软件检查？
rem echo.
rem echo     0. 退出程序
rem echo     1. 不禁用安全检查（默认）
rem echo     2. 禁用安全检查（不推荐）
rem echo.
rem set /p bootmode2=→  请选择启动模式：
rem if "%bootmode2%"=="" set bootmode2=1
rem if %bootmode2% equ 0 goto exitprogram
rem if %bootmode2% equ 1 set BypassSecuritySoftwareCheck=0
rem if %bootmode2% equ 2 set BypassSecuritySoftwareCheck=1
rem goto InitializeCheck
rem 启动菜单 End

:InitializeCheck
cls
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
	echo     未检测到 WMIC，可能已弃用
	echo     诊断工具功能可能受限，请手动修复 C:\Windows\System32\Wbem 环境变量
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

rem 此处开始检查安全软件，避免后续操作遭到拦截导致修复失败或异常
if %BypassSecuritySoftwareCheck% equ 1 (
  echo.
  echo     安全软件检查已被禁用，跳过安全检查环节，请注意修复时放行！
  echo.
  goto FinishSecuritySoftCheck
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq 360tray.exe" |findstr /i 360tray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出 360 安全卫士, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出 360 安全卫士, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
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
	echo     请退出 Norton 杀毒, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出 Norton 杀毒, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
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
	echo     请退出 360 杀毒, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出 360 杀毒, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
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

%systemroot%\system32\tasklist /fi "IMAGENAME eq LenovoPcManager.exe" |findstr /i QQPCSoftMgr.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo     请退出联想电脑管家, 以免操作过程中出现错误！
	mshta vbscript:msgbox("请退出联想电脑管家, 以免操作过程中出现错误！",64,"消息"^)(window.close^)
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

:FinishSecuritySoftCheck

powershell -executionpolicy bypass -command "&{$H=get-host;$W=$H.ui.rawui;$B=$W.buffersize;$B.width=128;$B.height=300;$W.buffersize=$B;$W.windowtitle='系统诊断修复工具'}"
rem 再次确认编码正确
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

rem 获取用户桌面路径，确保 MDT 文件夹生成正确
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| find /i "Desktop"') do set "UserDesktopPath=%%k" 
echo 识别到当前用户的桌面路径为："%UserDesktopPath%" >nul 2>nul

rem 获取其余常见用户文件夹路径并设置变量
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| find /i "SendTo"') do set "UserSendToPath=%%k" 
echo 识别到当前用户的发送到...文件夹路径为："%UserSendToPath%" >nul 2>nul

for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| find /i "StartMenu"') do set "UserStartMenuPath=%%k" 
echo 识别到当前用户的开始菜单路径为："%UserStartMenuPath%" >nul 2>nul

for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| find /i "Startup"') do set "UserStartupPath=%%k" 
echo 识别到当前用户的启动文件夹路径为："%UserStartupPath%" >nul 2>nul

:preGetOSinfo
rem 提前读取，避免重复读取加快目录加载速度
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
rem 如果目录存在，则确保所有权
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
rem 生成文件夹说明文件
echo.>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo 此文件夹为 MultiDiagToolkit（MDT）程序的日志及缓存输出文件夹>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo MDT 生成的所有日志均会保存在此文件夹内>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo 如不再需要日志及缓存信息，可以在 MDT 程序退出后删除此文件夹>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo 以下为日志及缓存文件夹名称说明：>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo 此文件夹是干什么的？_ReadMe.txt  说明文件                      由 MDT 主程序初始化生成，用于告知用户此文件夹的作用与用途>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo AllProcess.log                  系统所有进程列表日志          由查看系统当前所有进程功能生成>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo AllProcess_Running.log          系统所有正在运行的进程列表日志 由查看系统当前所有正在运行的进程功能生成>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo Battery_Report.html             电池健康度报告                由查看电池健康度功能生成，可以查看电池健康度相关信息>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo GET_HASH.log                    HASH 值日志                  由查看文件 HASH 值功能生成，可查看生成的文件 HASH 值记录>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo NetDiag.txt                     内网信息日志                  由系统环境诊断功能生成，可以查看内网情况信息>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo OS_Info.txt                     系统信息转储文件              由 MDT 主程序初始化生成，可以查看系统相关信息>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo ProgramList.log                 此设备安装的程序列表日志       由导出程序列表功能生成，可以查看此设备安装的程序>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo SFC_Details.txt                 系统修复无法修复的文件列表     由系统修复功能中的 SFC 修复功能生成，可以查看此设备使用系统修复无法修复的文件列表>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo System_Info.txt                 此设备的详细系统信息文件       由系统环境诊断功能、生成详细系统信息报告功能生成，可以查看系统详细信息>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo Sys_ipconfig_Basic.log          系统网络 IP 配置信息基础日志   由查看本机网络连接信息功能生成，可以查看系统网络连接基础情况>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo Sys_ipconfig_Detail.log         系统网络 IP 配置信息详细日志   由查看本机网络连接信息功能生成，可以查看系统网络连接详细情况>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo Userlist_Basic.log              用户列表基础信息日志           由列出此计算机的所有用户功能生成，可以查看此设备用户的基础信息>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo Userlist_Detail.log             用户列表详细信息日志           由列出此计算机的所有用户功能生成，可以查看此设备用户的详细信息>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo WindowsFocusBG                  Windows 聚焦壁纸保存文件夹     由获取缓存的 Windows 聚焦壁纸功能生成，可以查看缓存的 Windows 聚焦壁纸>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo 如果没有以上部分文件，是因为用户没有调用相关功能，因此不会生成相关日志文件>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo.>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt
echo 生成此文件的 MDT 程序版本：%progver%>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt 
echo 作者：%Author%>>%UserDesktopPath%\MDT\此文件夹是干什么的？_ReadMe.txt

echo.
echo     正在生成系统信息转储文件
rem 调用生成系统信息方法
rem 快速启动检查
if %fastlaunch% equ 1 (
    echo.
    echo     快速启动模式下，已禁用系统信息生成
    echo.
    goto InitializeFinish
)
call :generatesysinfo

echo.
rem 存储首次生成系统信息文件MD5值，作为校验标准
for /f %%i in ('certutil -hashfile %UserDesktopPath%\MDT\OS_Info.txt MD5 ^|findstr /v "[^0-9a-z]"') do set osinfoMD5=%%i
echo osinfoMD5 = %osinfoMD5% >nul
echo     已保存系统信息校验值
echo     已保存系统信息，路径：%UserDesktopPath%\MDT\OS_Info.txt
echo.
:InitializeFinish
echo     程序初始化完成
timeout /t 1 /nobreak > NUL


rem 主目录 ——————————————————————————————————————————————————————————————————
:menu
for /f "tokens=4" %%i in ('powercfg /LIST ^|findstr /v "Active" ^|findstr "*"') do set powerstate=%%i
set powerstate=!powerstate:(=! 2>nul
set powerstate=!powerstate:)=! 2>nul

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

:mainmenubaseinfo
cls
echo.
rem 跳过安全软件检查
if %BypassSecuritySoftwareCheck% equ 1 (
    echo     警告：已禁用安全软件检查，请注意放行！
    echo.
)
rem for /f "tokens=2 delims=: " %%i in ('chcp') do set "activecp=%%i"
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage" /v ACP 2^>nul') do set "activecp=%%i"
if !activecp! neq %targetACP% (
	echo     警告：活动代码页不满足要求，修复存在风险！
	echo.
)
echo     基本系统信息: 
echo.
rem 快速启动检查
if %fastlaunch% equ 1 (
    echo.
    echo     快速启动模式下，已禁用系统信息生成
    echo.
    goto mainmenuenter
)

rem 此处不再执行systeminfo命令，直接读取预加载的文件，但是做MD5校验，与最开始生成的文件不同则重新生成文件
rem 文件不存在则重新生成
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
if not exist "%UserDesktopPath%\MDT\OS_Info.txt" (
  echo     系统信息转储文件丢失，重新读取系统信息
  call :generatesysinfo
  echo     已重新保存系统信息
)

rem 校验屏幕分辨率和虚拟内存更改情况
rem 虚拟内存信息校验
FOR /F "usebackq delims=" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_PageFileUsage).AllocatedBaseSize"`) DO SET virtualramcheck=%%i
rem 旧版虚拟内存信息校验
::for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualramcheck=%%i/1024

rem 屏幕分辨率信息校验
FOR /F "usebackq tokens=1,2 delims=," %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_DesktopMonitor).ScreenWidth,ScreenHeight"`) DO (
    IF NOT "%%i" == "" IF NOT "%%j" == "" (
        SET scrresolutioncheck=%%j*%%i
    ) ELSE (
        SET scrresolutioncheck=未能成功获取屏幕分辨率
    )
)
rem 旧版屏幕分辨率信息校验方式
::for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do set scrresolutioncheck=%%j*%%i
rem 部分系统存在屏幕分辨率获取异常问题，填补缺省值
::if "%scrresolutioncheck%" == "" (
::    set scrresolutioncheck=未能成功获取屏幕分辨率
::)

if %virtualramcheck% neq %virtualram% (
  echo     系统环境发生变化，重新读取系统信息
  call :generatesysinfo
  echo     已重新保存系统信息
)

rem 此校验可能无效，可能导致部分设备闪退（暂时恢复，有问题再删）
if %scrresolutioncheck% neq %scrresolution% (
echo     系统环境发生变化，重新读取系统信息
call :generatesysinfo
echo     已重新保存系统信息
)

rem 开始MD5校验，不通过则重新生成
for /f %%i in ('certutil -hashfile %UserDesktopPath%\MDT\OS_Info.txt MD5 ^|findstr /v "[^0-9a-z]"') do set osinfoMD5New=%%i
if %osinfoMD5% neq %osinfoMD5New% (
  echo     系统信息校验值不匹配，重新读取系统信息
  call :generatesysinfo
  echo     已重新保存系统信息
)

rem 进入菜单，输出记录
type %UserDesktopPath%\MDT\OS_Info.txt
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
:mainmenuenter
echo.
rem 主菜单：多合一系统诊断修复工具

rem 校验标题
title 系统诊断修复工具 v%progver% by %Author%

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
echo.
echo     6. 退出程序
echo ------------------------------------------------------------------------------------------
echo.
echo     脚本作者：%Author%
echo     脚本版本：v%progver% 2025 LUV.
echo.
echo     声明：脚本修复功能不一定适用于您的问题，作者对使用脚本后果概不负责，请自行斟酌使用
echo     声明：继续使用代表您同意免除脚本作者对您电脑进行修改缩造成后果的责任，自行承担后果
echo     声明：如果不同意，请点击右上角关闭按钮关闭脚本并删除脚本文件
echo     首次使用建议阅读关于脚本的疑难解答
echo.
echo ------------------------------------------------------------------------------------------
set /p maininput=→  请选择项目：
if "%maininput%"=="" set maininput=null
if %maininput% equ 0 goto QA
if %maininput% equ 1 goto menusysrepairP1
if %maininput% equ 2 goto menunetfix
if %maininput% equ 3 goto menusysoptimizeP1
if %maininput% equ 4 goto menusoft
if %maininput% equ 5 goto menuotherP1
if %maininput% equ 6 goto exitprogramstart
if %maininput% equ 2024 goto easteregg1
if %maininput% equ 2025 goto easteregg1
if %maininput% equ 1975 goto easteregg2
if %maininput% equ 0504 goto easteregg2
if %maininput% equ 1212 goto easteregg3
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
echo     9. Windows Update 更新安装问题修复（其他故障请使用系统修复）
echo.
echo    10. taskmgr.exe 没有与之关联的程序运行（任务管理器定位程序进程路径出问题，选我）
echo.
echo    11. 多种 exe 没有与之关联的程序运行（打开软件报这个错选我）
echo.
echo    12. 取消 Windows 激活状态并重置评估期（慎用！会使 Windows 变为未激活状态！）（小白别点）
echo.
echo    13. 组策略添加、修复（适用于家庭版添加组策略或者升级专业版后组策略丢失异常等问题）
echo.
echo    14. 修复桌面图标间距异常、窗口右上角关闭最大化最小化按钮异常
echo        （桌面图标间距好大，怪怪的，右上角关闭图标也怪怪的，选我）
echo.
echo    15. 修复微软商店打不开、转圈、白屏等问题（微软商店打不开选我）
echo.
echo    16. IE 主页劫持修复（主页被乱改了）
echo.
echo    17. 修复由于远程连接导致的剪贴板复制粘贴失效问题
echo.
echo    18. 停用 vmmem ，解决 vmmem 占用过高问题
echo.
echo    19. 查看电池健康度（看看电脑电池损耗如何）
echo.
echo    20. 查看下一页（当前页面为：P1）
echo ------------------------------------------------------------------------------------------
set /p sysdiaginput1=→  请选择项目：
if "%sysdiaginput1%"=="" set sysdiaginput1=null
if %sysdiaginput1% equ 0 goto menu
if %sysdiaginput1% equ 1 goto envdiag
if %sysdiaginput1% equ 2 goto systemrepair
if %sysdiaginput1% equ 3 goto programlist
if %sysdiaginput1% equ 4 goto iereset
if %sysdiaginput1% equ 5 goto xboxfix
if %sysdiaginput1% equ 6 goto IconRepair
if %sysdiaginput1% equ 7 goto WinFocus
if %sysdiaginput1% equ 8 goto borecmenu
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
echo     2. 加入 Windows 预览体验计划（Windows Insider Channel）
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
echo.
echo     8. 启动系统配置（启动、引导管理）
echo.
echo     9. 启动系统信息
echo.
echo    10. 启动 Windows 内存诊断
echo.
echo    11. 启动优化驱动器（碎片整理）
echo.
echo    12. 禁用 Windows Defender（文件一直被系统拦截选我）
echo.
echo    13. 启用 Windows Defender（恢复Defender功能选我）
echo.
echo    14. 禁用 Windows Update
echo.
echo    15. 启用、重置、修复 Windows Update
echo.
echo    16. 恢复 UAC（我后悔禁用了，还是想要权限在自己手里控制舒服）
echo.
echo    17. 禁用 UAC（关了 UAC，打开软件不会再申请管理员权限，省的选是选否不知道）
echo.
echo    18. 生成详细系统信息报告
echo.
echo    19. 修复 Windows 安全中心本地安全机构保护已关闭，开启后反复要求重启生效问题
echo.
echo    20. 查看下一页（当前页面为：P2）
echo ------------------------------------------------------------------------------------------
set /p sysdiaginput2=→  请选择项目：
if "%sysdiaginput2%"=="" set sysdiaginput2=null
if %sysdiaginput2% equ 0 goto menu
if %sysdiaginput2% equ 1 goto menusysrepairP1
if %sysdiaginput2% equ 2 goto insiderchannel
if %sysdiaginput2% equ 3 goto diskcleanmgr
if %sysdiaginput2% equ 4 goto MAS_ACTIVATOR
if %sysdiaginput2% equ 5 goto allprocessrunning
if %sysdiaginput2% equ 6 goto allprocess
if %sysdiaginput2% equ 7 goto userlist
if %sysdiaginput2% equ 8 goto ms_config
if %sysdiaginput2% equ 9 goto startsysinfo
if %sysdiaginput2% equ 10 goto memcheckprogram
if %sysdiaginput2% equ 11 goto startdefrag
if %sysdiaginput2% equ 12 goto defenderoff
if %sysdiaginput2% equ 13 goto defenderon
if %sysdiaginput2% equ 14 goto wudisable
if %sysdiaginput2% equ 15 goto wureset
if %sysdiaginput2% equ 16 goto enableuac
if %sysdiaginput2% equ 17 goto disableuac
if %sysdiaginput2% equ 18 goto getsysteminfo
if %sysdiaginput2% equ 19 goto wsclsafix
if %sysdiaginput2% equ 20 goto menusysrepairP3
echo →  输入异常，请检查输入选项
pause
goto menusysrepairP2

:menusysrepairP3
cls
echo ------------------------------------------------------------------------------------------
echo                                       系统诊断修复菜单
echo ------------------------------------------------------------------------------------------
echo     0. 返回主菜单
echo.
echo     1. 返回上一页（当前页面为：P3）
echo.
echo     2. 修复桌面创建文件时只能创建文件夹，且需要管理员权限的问题
echo.
echo     3. 鼠标右键菜单“发送到...”选项出现异常，有重复选项修复（可支持自定义快捷方式）
echo.
echo     4. 鼠标右键菜单-新建 里面没有“文本文档”
echo.
echo     5. 修复系统托盘安全中心图标丢失问题（HealthTray.exe）
echo	    即修复系统托盘安全中心图标不开机自启动问题
echo.
echo     6. 设置-应用-安装的应用 存在已卸载的程序名称残留清理
echo.
echo     7. 关闭火绒应用商店打开方式劫持（HrASOpen） 
echo.
echo     8. 设置-系统-屏幕-显示卡-应用程序的自定义设置 存在已卸载的程序名称残留清理
rem echo    20. 查看下一页（当前页面为：P3）
echo ------------------------------------------------------------------------------------------
set /p sysdiaginput3=→  请选择项目：
if "%sysdiaginput3%"=="" set sysdiaginput3=null
if %sysdiaginput3% equ 0 goto menu
if %sysdiaginput3% equ 1 goto menusysrepairP2
if %sysdiaginput3% equ 2 goto desktopmkfileerr
if %sysdiaginput3% equ 3 goto sendtoduplicate
if %sysdiaginput3% equ 4 goto Newtxtfix
if %sysdiaginput3% equ 5 goto healthtrayfix
if %sysdiaginput3% equ 6 goto delappnamecache
if %sysdiaginput3% equ 7 goto hrasopenrestore
if %sysdiaginput3% equ 8 goto GPUcustomset
rem if %sysdiaginput3% equ 20 goto menusysrepairP4
echo →  输入异常，请检查输入选项
pause
goto menusysrepairP3

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
echo    10. 查看本机网络连接信息详情
echo.
echo    11. 网络完全重置（我不知道哪里出问题了，帮我全部重置一遍，含 Steam、Xbox 修复）
echo.
echo    12. 打开网络连接设置（传统设置）
echo.
echo    13. 刷新 DNS 缓存（上网 DNS 解析错误，试试我或者换个 DNS）
echo.
echo    14. 本机当前设置的 DNS 服务器查询
echo.
echo    15. 网络 Ping 工具（连通性测试）
echo.
echo    16. IPv4/IPv6 开启/关闭详细设置菜单
echo ------------------------------------------------------------------------------------------
set /p netdiaginput=→  请选择项目：
if "%netdiaginput%"=="" set netdiaginput=null
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
if %netdiaginput% equ 13 goto flushdnscache
if %netdiaginput% equ 14 goto dnsquery
if %netdiaginput% equ 15 goto pingtoolmenu
if %netdiaginput% equ 16 goto ipv46setmenu
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
echo     1. 关闭 Windows 防火墙（碍手碍脚总弹窗问联网权限？选我关掉，当然不是那么推荐）
echo.
echo     2. 开启 Windows 防火墙（我后悔了，或者遇到问题了，重新打开选我）
echo.
echo     3. 设置计算机使用的电源选项（切换电源选项）
echo.
echo     4. 卓越性能模式（解锁电脑系统层面的一些功耗限制，让电脑尽可能满功耗运行）
echo.
echo     5. 恢复 UAC（我后悔禁用了，还是想要权限在自己手里控制舒服）
echo.
echo     6. 禁用 UAC（关了UAC，打开软件不会再申请管理员权限，省得选是选否不知道）
echo.
echo     7. 自定义开机选择系统启动项等待时间（高级操作：不想开机等 30 秒选择系统，选我输入自定义秒数）
echo.
echo     8. 打开可移动磁盘自动运行（想一插u盘自动播放选我，可能会让病毒也自动启动嗷）
echo.
echo     9. 关闭可移动磁盘自动运行（不要自动播放选我）
echo.
echo    10. 开启系统休眠（想要一盖电脑就冻结，打开电脑就恢复之前样子，选我，默认开）
echo.
echo    11. 关闭系统休眠（极致性能，我就一个臭打游戏的，台式机巴拉巴拉，选我）
echo.
echo    12. C盘/系统盘缓存垃圾清理（使用有风险，会清理日志文件等，请做好备份）（删个垃圾选我）
echo.
echo    13. （WIN7 限定）在较老的电脑上开启 Aero 透明毛玻璃效果
echo.
echo    14. 清除快捷方式小箭头（美化类：不要桌面上快捷方式左下角的小箭头）
echo.
echo    15. 恢复快捷方式小箭头（美化类：恢复桌面上快捷方式左下角的小箭头）
echo.
echo    16. 停用 vmmem，解决 vmmem 占用过高问题
echo.
echo    17. 停用 TabletPC 功能
echo.
echo    18. 记事本默认保存编码修改（高版本 Windows 不一定适用）
echo.
echo    19. 加入 Windows 预览体验计划（Windows Insider Channel）
echo.
echo    20. 查看下一页（当前页面为：P1）
echo ------------------------------------------------------------------------------------------
set /p sysopt1=→  请选择项目：
if "%sysopt1%"=="" set sysopt1=null
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
echo.
echo     9. 启动优化驱动器（碎片整理）
echo.
echo    10. 鼠标右键菜单“发送到...”选项出现异常，有重复选项修复（可支持自定义快捷方式）
echo.
echo    11. 禁用 ZIP 压缩包文件索引与预览，降低资源管理器占用
echo.
echo    12. 还原 ZIP 压缩包文件索引与预览，恢复默认值
echo.
echo    13. 系统托盘时间显示星期设置
echo.
echo    14. Windows 广告、提示、建议、推广关闭/开启
echo.
echo    15. 设备安全性-内核隔离（Hyper-V 功能）开启/关闭
echo.
echo    16. C盘 WinSxS 清理（系统存储组件清理）
echo.
echo    17. 解除 Windows 文件路径长度上限
echo.
echo    18. 恢复 Windows 文件路径长度上限
echo.
echo    19. Windows 系统日志清理
echo ------------------------------------------------------------------------------------------
set /p sysopt2=→  请选择项目：
if "%sysopt2%"=="" set sysopt2=null
if %sysopt2% equ 0 goto menu
if %sysopt2% equ 1 goto menusysoptimizeP1
if %sysopt2% equ 2 goto diskcleanmgr
if %sysopt2% equ 3 goto PrivCtrloff
if %sysopt2% equ 4 goto PrivCtrlon
if %sysopt2% equ 5 goto defenderoff
if %sysopt2% equ 6 goto defenderon
if %sysopt2% equ 7 goto wudisable
if %sysopt2% equ 8 goto wureset
if %sysopt2% equ 9 goto startdefrag
if %sysopt2% equ 10 goto sendtoduplicate
if %sysopt2% equ 11 goto zipPreviewOff
if %sysopt2% equ 12 goto zipPreviewOn
if %sysopt2% equ 13 goto weeksetmenu
if %sysopt2% equ 14 goto adsetmenu
if %sysopt2% equ 15 goto hypervmenu
if %sysopt2% equ 16 goto winsxsclean
if %sysopt2% equ 17 goto longpathenable
if %sysopt2% equ 18 goto longpathdisable
if %sysopt2% equ 19 goto wevcl
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
echo     2. Xbox 平台修复（打游戏用到 Xbox 了，这玩意出问题选我）
echo.
echo     3. Steam VAC 屏蔽修复与闪退问题修复工具（玩 CSGO 等报 VAC 验证错误断开连接之类的选我）
echo.
echo     4. 清理本地 FlashPlayer 播放器记录（单文件 FlashPlayer 播放器的记录清理）
echo.
echo     5. 记事本默认保存编码修改
echo.
echo     6. 获取文件 HASH 值
echo.
echo     7. 杀死特定进程
echo.
echo     8. EasyAntiCheat 异常、启动失败、卸载（EAC 小蓝熊删除重装）
echo.
echo     9. Apex Legends 商店图片不显示出现禁用标志（ASSET FAILED TO LOAD）
echo.
echo    10. QQ 音乐歌曲专辑图片无法正常显示
echo.
echo    11. KOOK（原开黑啦）语音异常连接不上修复（一直卡连接中可以试试我）
echo.
echo    12. Steam 无法连接至 Steam 网络、连接超时、无网络连接修复（Steam 连不上选我试试）
echo.
echo    13. 百度贴吧等网站访问不了，其他网站正常（IPv6 设置冲突）
echo.
echo    14. 鲁大师等软件劫持浏览器主页修复（主页变成 hao360）
echo.
echo    15. 获取缓存的 Windows 聚焦壁纸
echo ------------------------------------------------------------------------------------------
set /p softinput=→  请选择项目：
if "%softinput%"=="" set softinput=null
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
if %softinput% equ 10 goto qqmusicimgfix
if %softinput% equ 11 goto kookfix
if %softinput% equ 12 goto steamconnectfix
if %softinput% equ 13 goto tiebaerror
if %softinput% equ 14 goto ludashihpfix
if %softinput% equ 15 goto WinFocusbg
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
echo    10. 启动本地组策略编辑器（gpedit.msc）
echo.
echo    11. 启动服务管理单元（services.msc）
echo.
echo    12. 启动注册表编辑器（regedit.exe）
echo.
echo    13. 启动计算机管理（compmgmt.msc）
echo.
echo    14. 启动事件查看器（eventvwr.msc）
echo.
echo    15. 启动控制面板
echo.
echo    16. 查看系统版本信息（关于“Windows”）
echo.
echo    17. 打开系统设置页面（老版本 Windows 不适用）
echo.
echo    18. 启动磁盘管理（diskmgmt.msc）
echo.
echo    19. 启动任务管理器（taskmgr.exe）
echo.
echo    20. 查看下一页（当前页面为：P1）
echo ------------------------------------------------------------------------------------------
set /p otherinput1=→  请选择项目：
if "%otherinput1%"=="" set otherinput1=null
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
echo     7. 启动性能监视器（perfmon.msc）
echo.
echo     8. 启动本地安全组策略（secpol.msc）
echo.
echo     9. 启动 DirectX 检测工具（dxdiag）
echo.
echo    10. 启动远程桌面连接
echo.
echo    11. 用户资料数据备份（便捷备份用户数据，重装电脑前选我备份数据）
echo.
echo    12. 打开桌面图标设置（计算机、此电脑我的文档不见了，只有回收站，选我）
echo.
echo    13. 打开用户账户设置
echo.
echo    14. 打开 Windows Defender 防火墙设置
echo.
echo    15. 打开程序和功能（卸载或更改程序）
echo.
echo    16. 打开系统属性设置（虚拟内存、分页文件等高级系统设置）
echo.
echo    17. 打开时间和区域设置（时间格式调整、时区调整）
echo.
echo    18. 打开时间和日期设置（时间和日期的经典设置）
echo.
echo    19. 打开网络连接设置（传统设置）
echo.
echo    20. 查看下一页（当前页面为：P2）
echo ------------------------------------------------------------------------------------------
set /p otherinput2=→  请选择项目：
if "%otherinput2%"=="" set otherinput2=null
if %otherinput2% equ 0 goto menu
if %otherinput2% equ 1 goto menuotherP1
if %otherinput2% equ 2 goto optionalfunc
if %otherinput2% equ 3 goto ms_config
if %otherinput2% equ 4 goto startsysinfo
if %otherinput2% equ 5 goto memcheckprogram
if %otherinput2% equ 6 goto componentmgr
if %otherinput2% equ 7 goto startperfmon
if %otherinput2% equ 8 goto securemgr
if %otherinput2% equ 9 goto dxcheck
if %otherinput2% equ 10 goto rdapp
if %otherinput2% equ 11 goto sysuserbackup
if %otherinput2% equ 12 goto desktopiconset
if %otherinput2% equ 13 goto useraccset
if %otherinput2% equ 14 goto firewallset
if %otherinput2% equ 15 goto applistset
if %otherinput2% equ 16 goto computerpropset
if %otherinput2% equ 17 goto timezoneset
if %otherinput2% equ 18 goto timedateset
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
echo.
echo     5. 启动优化驱动器（碎片整理）
echo.
echo     6. 生成详细系统信息报告
echo.
echo     7. 启动鼠标属性
echo.
echo     8. 启动共享文件夹管理（fsmgmt.msc）
echo.
echo     9. 打开启动文件夹（开机时会自动运行此文件夹内的文件/快捷方式）
echo.
echo    10. 以 SYSTEM 权限运行程序/脚本（顶级权限，谨慎授予）
echo.
echo    11. 获取缓存的 Windows 聚焦壁纸
echo.
echo    12. 获取设备启动时间与运行时间
echo.
echo    13. 打开可靠性监视程序
echo.
echo    14. 打开性能监视器
echo.
echo    15. 打开资源监视器
rem echo.
rem echo 20. 查看下一页（当前页面为：P3）
echo ------------------------------------------------------------------------------------------
set /p otherinput3=→  请选择项目：
if "%otherinput3%"=="" set otherinput3=null
if %otherinput3% equ 0 goto menu
if %otherinput3% equ 1 goto menuotherP2
if %otherinput3% equ 2 goto easyuseset
if %otherinput3% equ 3 goto scrpropset
if %otherinput3% equ 4 goto securitycenter
if %otherinput3% equ 5 goto startdefrag
if %otherinput3% equ 6 goto getsysteminfo
if %otherinput3% equ 7 goto mousesetup
if %otherinput3% equ 8 goto sharemanage
if %otherinput3% equ 9 goto openstartup
if %otherinput3% equ 10 goto runassystem
if %otherinput3% equ 11 goto WinFocusbg
if %otherinput3% equ 12 goto boot_run_time
if %otherinput3% equ 13 goto perfmon_page
if %otherinput3% equ 14 goto perfmon_program
if %otherinput3% equ 15 goto resmon_program
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
echo     导出的日志报告路径： %UserDesktopPath%\MDT 
echo     即用户桌面上的 MDT 文件夹。
echo     软件所有的日志都保存在此文件夹内，如不需要可以在程序运行完毕后删除。如果不知道哪个
echo     日志对应哪个功能，可以查看文件夹内的 此文件夹是干什么的？_ReadMe.txt 文件。
echo.
echo     常见问题：主菜单系统显卡信息有误，独立显卡、屏幕分辨率没有正确显示。
echo.
echo     电脑存在多个显卡如同时存在集显和独显时，查询到的显卡信息顺序可能会变化。而此命令行
echo     查询只会返回的查询到的最后一个显卡信息，并不能显示所有显卡信息。在绝大多数情况下，
echo     独显会是最后查询到的显卡。但是也有极个别情况集显排序在独显之前，因此返回的结果就是
echo     集显的相关信息。综上所述，主界面的显卡信息不一定准确，主界面布局空间有限，若要详细
echo     查看显卡信息，请使用系统环境诊断功能检测显卡信息。
echo     部分设备的系统可能存在 OEM 定制策略等问题导致无法查询到屏幕分辨率，请谅解。
echo.
echo     当前程序版本：%progver%
echo     作者：%Author%
echo.
echo     特别感谢：JiangYou01 等人对我的帮助与支持。（程序含彩蛋！输入特殊数字即可触发！）
echo     还有那帮看着没心没肺，但是关键时刻很给力的林间暖苑水友群的水友们！
echo.
echo ------------------------------------------------------------------------------------------
timeout /t 3 /nobreak > NUL
echo →  按任意键即可返回菜单
pause
goto menu

:generatesysinfo
rem 生成系统信息，读取信息
rem 先清除文件属性，再删除文件重建，避免权限问题
rem 取得所有权
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
takeown /f %UserDesktopPath%\MDT\OS_Info.txt >nul 2>nul
icacls %UserDesktopPath%\MDT\OS_Info.txt /remove:d administrators >nul 2>nul
icacls %UserDesktopPath%\MDT\OS_Info.txt /grant administrators:F >nul 2>nul
echo y| cacls.exe %UserDesktopPath%\MDT\OS_Info.txt /t /p /c Everyone:F >nul 2>nul
echo y| cacls.exe %UserDesktopPath%\MDT\OS_Info.txt /t /g /c Everyone:F >nul 2>nul
rem 清理属性
attrib -r -h -s -a %UserDesktopPath%\MDT\OS_Info.txt >nul 2>nul
rem 重建文件
if exist %UserDesktopPath%\MDT\OS_Info.txt del /q /f %UserDesktopPath%\MDT\OS_Info.txt
type nul>%UserDesktopPath%\MDT\OS_Info.txt
rem 开始生成系统信息
rem 操作系统名称（旧方案）
rem for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"OS 名称"') do set osnametmp=%%i
rem for /f "tokens=2 delims=:" %%i in ('echo %osnametmp%') do set osname=%%i
rem 操作系统名称（新方案），加快载入
::for /f "usebackq skip=1 delims=" %%i in (`wmic os get Caption`) do (
::    set "osname=%%i"
::    goto breakosnamefor
::)
:::breakosnamefor
rem echo %osname%

rem 操作系统名称（新方案2.0）
FOR /F "usebackq delims=" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_OperatingSystem).Caption"`) DO SET osname=%%i

rem 系统版本
for /f "tokens=*" %%i in ('ver') do set sysv=%%i

rem CPU信息
FOR /F "usebackq delims=" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_Processor).Name"`) DO SET cpuinfo=%%i
rem 旧版获取CPU信息
::for /f "tokens=*" %%i in ('wmic cpu get name ^|findstr /v "Name" ^|findstr "[^\S]"') do set cpuinfo=%%i

rem 内存信息
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty TotalVisibleMemorySize"`) DO (
    set /a ram=%%i/1024
)
::FOR /F "usebackq delims=" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory / 1MB"`) DO SET ram=%%i
rem 取内存为整数
::for /f "tokens=1 delims=." %%i in ('echo %ram%') do set ram_int=%%i
rem 旧版获取内存信息
::for /f %%i in ('wmic os get TotalVisibleMemorySize ^|findstr [0-9]') do set /a ram=%%i/1024

rem 虚拟内存信息
FOR /F "usebackq delims=" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_PageFileUsage).AllocatedBaseSize"`) DO SET virtualram=%%i
rem 旧版获取虚拟内存信息
::for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualram=%%i/1024

rem 显卡信息
FOR /F "usebackq tokens=1,2 delims==" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_VideoController).Name"`) DO SET vganame=%%i
rem 旧版获取显卡信息
::for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get AdapterRAM^,Name /value ^|findstr Name') do set vganame=%%i

rem 屏幕分辨率信息

FOR /F "usebackq tokens=1,2 delims=," %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_DesktopMonitor).ScreenWidth,ScreenHeight"`) DO (
    IF NOT "%%i" == "" IF NOT "%%j" == "" (
        SET scrresolution=%%j*%%i
    ) ELSE (
        SET scrresolution=未能成功获取屏幕分辨率
    )
)

rem 旧版获取屏幕分辨率信息方式
::for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do set scrresolution=%%j*%%i
::rem 部分系统存在屏幕分辨率获取异常问题，填补缺省值
::if "%scrresolution%" == "" (
::    set scrresolution=未能成功获取屏幕分辨率
::)

rem 主板信息
rem for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"BIOS"') do set biosinfotmp=%%i
rem for /f "tokens=2 delims=:" %%i in ('echo %biosinfotmp%') do set biosinfo=%%i

rem 获取主板信息
for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"BIOS"') do set biosinfotmp=%%i

rem 从获取的信息中提取BIOS版本号
for /f "tokens=2 delims=:" %%a in ("%biosinfotmp%") do set biosinfo=%%a

rem 去除前导空格
for /f "tokens=* delims= " %%b in ("%biosinfo%") do set biosinfo=%%b

rem 应用程序错误信息
if "%systemver%"=="10" (
for /f "tokens=1,2,4* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName Application -EntryType Error -Newest 2 -After %year%-%month%-%day% -Source 'Application Error' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo    %%i %%j 错误: %%k %%l
) else (
echo. >nul 2>nul
)
rem 统一输出信息
echo     操作系统名称:                 %osname%>%UserDesktopPath%\MDT\OS_Info.txt
echo     系统版本:                     %sysv%>>%UserDesktopPath%\MDT\OS_Info.txt
echo     中央处理器 CPU:               %cpuinfo%>>%UserDesktopPath%\MDT\OS_Info.txt
echo     图形处理器 GPU:               %vganame%>>%UserDesktopPath%\MDT\OS_Info.txt
echo     屏幕分辨率:                   %scrresolution%>>%UserDesktopPath%\MDT\OS_Info.txt
echo     运行内存:                     %ram% MB>>%UserDesktopPath%\MDT\OS_Info.txt
echo     当前分配虚拟内存:             %VirtualRAM% MB>>%UserDesktopPath%\MDT\OS_Info.txt
echo     主板信息:                     %biosinfo%>>%UserDesktopPath%\MDT\OS_Info.txt
rem 存储重新生成系统信息文件 MD5 值，作为校验标准（因为用户可能会更改分辨率之类的，所以需要同步更新正确文件的 MD5）
for /f %%i in ('certutil -hashfile %UserDesktopPath%\MDT\OS_Info.txt MD5 ^|findstr /v "[^0-9a-z]"') do set osinfoMD5=%%i
echo osinfoMD5 = %osinfoMD5% >nul
goto :eof

:getvgainfo
echo     显卡 GPU 详细信息:
FOR /F "usebackq delims=" %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_VideoController).Name"`) DO (
    echo     %%i
)
goto:eof

:getdiskinfo
echo     磁盘信息:
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_DiskDrive | Select-Object -ExpandProperty Model"`) DO (
    echo     %%i
)
goto:eof

rem 老版本:getvgainfo
::echo     显卡 GPU 详细信息:
rem set vgatrimstr="Name="
rem set vganame=!vganame:%vgatrimstr%=!
::wmic path Win32_VideoController get AdapterRAM^,Name /value |findstr Name >%temp%\vgainfo.txt
rem for /f "tokens=*" %%i in (%temp%\vgainfo.txt) do echo %%i

rem 设置延迟环境变量扩展
rem setlocal enabledelayedexpansion

::set fn=%temp%\vgainfo.txt
rem for循环读取文本，使用usebackq可以使文本文件名包含空格等字符
::(for /f "usebackq delims=" %%i in ("%fn%")do (
::	rem 输出读取到的单行字符串到控制台（con）
::	echo %%i>con  >nul
::	set h=%%i
::	
::	rem 输出单行字符串去除前5个字符的数据，并在前面加4个空格调整格式
::	echo     !h:~5!
::	rem 结束延迟环境变量扩展
::	rem endlocal
::))>%temp%\vgainfo_trim.txt

::del /s /q %temp%\vgainfo.txt >nul
::type %temp%\vgainfo_trim.txt
::rem del /s /q %temp%\vgainfo_trim.txt >nul
::goto:eof

rem 旧版:getdiskinfo
::echo     磁盘信息:
::wmic DISKDRIVE get model /value |findstr Model >%temp%\diskinfo.txt

::set fn=%temp%\diskinfo.txt
::rem for循环读取文本，使用usebackq可以使文本文件名包含空格等字符
::(for /f "usebackq delims=" %%i in ("%fn%")do (
::	rem 输出读取到的单行字符串到控制台（con）
::	echo %%i>con  >nul
::	set h=%%i
::	
::	rem 输出单行字符串去除前6个字符的数据，并在前面加4个空格调整格式
::	echo     !h:~6!
::	rem 结束延迟环境变量扩展
::	rem endlocal
::))>%temp%\diskinfo_trim.txt

::del /s /q %temp%\diskinfo.txt >nul
::type %temp%\diskinfo_trim.txt
::rem del /s /q %temp%\diskinfo_trim.txt >nul
::goto:eof

:getbiosinfo
echo     BIOS 主板信息:
rem for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"BIOS"') do set biosinfotmp=%%i
rem for /f "tokens=2 delims=:" %%i in ('echo %biosinfotmp%') do set biosinfo=%%i

rem 获取主板信息
for /f "tokens=*" %%i in ('systeminfo ^| findstr /C:"BIOS"') do set biosinfotmp=%%i

rem 从获取的信息中提取BIOS版本号
for /f "tokens=2 delims=:" %%a in ("%biosinfotmp%") do set biosinfo=%%a

rem 去除前导空格
for /f "tokens=* delims= " %%b in ("%biosinfo%") do set biosinfo=%%b

echo     %biosinfo%
goto:eof

:envdiag
cls
call:systemver
call:get_boot_time
rem 旧版主板序列号及BIOS序列号
::echo 主板序列号
::wmic baseboard get serialnumber
::echo BIOS 序列号
::wmic bios get serialnumber
echo 主板序列号:
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_BaseBoard | Select-Object -ExpandProperty SerialNumber"`) DO (
    echo     %%i
)
echo BIOS 序列号:
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_BIOS | Select-Object -ExpandProperty SerialNumber"`) DO (
    echo     %%i
)
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
echo 生成详细系统信息报告
echo.
systeminfo >%UserDesktopPath%\MDT\System_Info.txt
call:getvgainfosilent
call:getdiskinfosilent
echo 显卡详细信息: >>%UserDesktopPath%\MDT\System_Info.txt
type %temp%\vgainfo_trim.txt >>%UserDesktopPath%\MDT\System_Info.txt
echo 磁盘信息: >>%UserDesktopPath%\MDT\System_Info.txt
type %temp%\diskinfo_trim.txt >>%UserDesktopPath%\MDT\System_Info.txt
del /s /q %temp%\vgainfo_trim.txt >nul
del /s /q %temp%\diskinfo_trim.txt >nul

echo 已保存系统详细信息，路径：%UserDesktopPath%\MDT\System_Info.txt
echo →  请按任意键回到主菜单
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
call:acceleratorCheck
call:proxyCheck
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
if "%a%"=="" set a=null
if %a% equ 1 goto regularreset
if %a% equ 2 goto brutereset
echo →  输入异常，请检查输入选项
pause
goto modeselect

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
echo.
set /p user_input=→  请选择一个项目：
if "%user_input%"=="" set user_input=null
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
echo 前置修复: 修改 DNS 服务器地址为微软 DNS 服务器
call:dnssetting 4.2.2.1 223.5.5.5
echo 前置服务修复完成
goto systemrepair

:SFCFIX
echo 即将使用 SFC 工具进行修复，如遇服务异常请先运行前置服务修复
echo 如遇进度条卡死超过 10 分钟，请退出程序重新运行并选择 DISM 工具修复
timeout /t 3 /nobreak > NUL
echo 运行 SCANNOW 命令修复系统
sfc /scannow
echo SFC 基础修复操作完成
if exist %windir%\Logs\CBS\CBS.log (
    echo 正在读取 CBS.log 并导出 SFC 工具不能修复的文件
    echo.
    echo Windows 资源保护无法修复的损坏文件列表：>"%UserDesktopPath%\MDT\SFC_Details.txt"
    findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log >>"%UserDesktopPath%\MDT\SFC_Details.txt"
    start %UserDesktopPath%\MDT\SFC_Details.txt
    echo 导出完成，路径为：%UserDesktopPath%\MDT\SFC_Details.txt
)
echo 操作执行完成
echo.
echo 若出现“Windows 资源保护找到了损坏文件但无法修复”的情况
echo 请检查 SFC_Details.txt 并尝试手动修复，或者使用 DISM 工具进行系统修复
echo 如果 SFC_Details.txt 内文件列表为空，那说明 SFC 功能没有检测到系统文件损坏
goto menu

:DISMFIX
echo.
echo 即将使用 DISM 工具进行修复，如遇服务异常请先运行前置服务修复
echo 如遇进度条卡死超过 10 分钟，请退出程序重新运行 DISM 工具修复
echo 若出现 DISM 工具异常或者仍然卡死，请考虑使用原版系统镜像覆盖安装系统修复文件
echo （上述情况大概率为系统文件遭到 DISM 工具不可修复的破坏）
timeout /t 3 /nobreak > NUL
echo.
echo 使用 DISM 工具校验系统文件
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /CheckHealth
echo DISM 扫描完成

:dismbreak
echo     DISM 工具扫描完成，请检查结果并选择：
echo.
echo     1. 可以修复组件存储
echo     2. 未检测到组件存储损坏
echo     3. 其他问题（找不到映像源等）
echo.
set /p host=→  请根据情况选择项目：
if "%host%"=="" set host=null
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
echo.
echo     2. 找不到映像源，找不到源文件，先检查网络是否通畅，重新运行
echo     若仍存在问题，请找原版镜像里的 install.wim 文件用 Source 参数指定源修复
echo     最推荐的方法是下载原版镜像覆盖安装系统修复
echo.
echo     3. 诊断策略服务未运行，请先运行前置修复
echo     如果仍存在问题，建议下载原版镜像文件覆盖安装系统修复
echo     普通用户推荐使用微软官方的 MediaCreationTool 无损覆盖、安装、升级系统
echo     专业用户可自行寻找镜像文件通过多种方式修复系统，不多赘述
echo.
echo     4. 系统更新安装出现 0x800f081f 错误：
echo     请打开组策略（快捷键：Win + R，输入 gpedit.msc 回车）
echo     在打开的组策略编辑器窗口中，定位到“计算机配置-管理模板-系统”
echo     在右侧设置菜单中下拉找到“指定可选组件安装和组件修复的设置”，双击打开
echo     在打开的配置页面中，选择“已启用(E)”，点击确定，然后重试 DISM 修复功能
echo     若反复出现安装更新失败，请尝试覆盖安装系统修复
echo.
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
if "%host%"=="" set host=null
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
if "%choice%"=="" set choice=y
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
if "%files%"=="" goto menu
cacls.exe "%files%" /e /t /p Administrators:N
echo 设置指定路径文件拒绝访问
echo.
pause
goto menu

:host7
echo.
set /p files=→  请输入文件完整路径: 
if "%files%"=="" goto menu
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
echo.
echo     IPv4 DNS 设置：
echo     1. 手动筛选设置 IPv4 DNS 服务器（专业用户）
echo     2. 优选组合 IPv4 DNS 服务器（新手小白用户）
echo     3. 手动输入设置 IPv4 DNS 服务器（专业用户）
echo.
echo     IPv6 DNS 设置：
echo     4. 手动筛选设置 IPv6 DNS 服务器（专业用户）
echo     5. 优选组合 IPv6 DNS 服务器（新手小白用户）
echo     6. 手动输入设置 IPv6 DNS 服务器（专业用户）
echo.
echo     DNS 清除设置：
echo     7. 清除 IPv4 DNS
echo     8. 清除 IPv6 DNS（可解决部分上网异常）
echo.
set /p dns=→  请选择: 
if "%dns%"=="" set dns=null
if %dns% equ 0 goto menu
if %dns% equ 1 goto dnssetup1
if %dns% equ 2 goto dnssetup2
if %dns% equ 3 goto dnssetup3
if %dns% equ 4 goto dnssetup4
if %dns% equ 5 goto dnssetup5
if %dns% equ 6 goto dnssetup6
if %dns% equ 7 goto ipv4dnsdel
if %dns% equ 8 goto ipv6dnsdel
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnsfix

:dnssetup1
cls
:dnssetupmenu1
cls
echo.
echo     请选择 IPv4 首选 DNS 服务器：
echo.
echo     0. 返回设置菜单
echo.
echo     1. 服务器：119.29.29.29        （腾讯 Public DNS+）
echo     2. 服务器：182.254.116.116     （腾讯 Public DNS+ 备用）
echo.
echo     3. 服务器：223.5.5.5           （阿里 DNS）
echo     4. 服务器：223.6.6.6           （阿里 DNS 备用）
echo.
echo     5. 服务器：8.8.8.8             （谷歌 DNS）
echo     6. 服务器：8.8.4.4             （谷歌 DNS 备用）
echo.
echo     7. 服务器：119.29.29.29        （百度公共 DNS）
echo.
echo     8. 服务器：1.1.1.1             （CloudFlare DNS）
echo     9. 服务器：1.0.0.1             （CloudFlare DNS 备用）
echo.
echo    10. 服务器：114.114.114.114     （114 DNS）
echo    11. 服务器：114.114.115.115     （114 DNS 备用）
echo.
echo    12. 服务器：80.80.80.80         （Freenom DNS）
echo    13. 服务器：80.80.81.81         （Freenom DNS 备用）
echo.
echo    14. 服务器：156.154.70.25       （Comodo DNS）
echo    15. 服务器：156.154.71.25       （Comodo DNS 备用）
echo.
echo    16. 服务器：208.67.222.222      （Open DNS）
echo    17. 服务器：208.67.220.220      （Open DNS 备用）
echo.
echo    18. 服务器：101.226.4.6         （360 电信、移动、铁通 DNS）
echo    19. 服务器：123.125.81.6        （360 联通 DNS）
echo.
echo    20. 服务器：4.2.2.1             （微软推荐：Verizon DNS）
echo    21. 服务器：4.2.2.2             （微软推荐：Verizon DNS 备用）
echo.
set /p manualdns=→  请输入选项：
if "%manualdns%"=="" set manualdns=null
if %manualdns% equ 0 goto dnsfix
if %manualdns% equ 1 goto m1setdns1
if %manualdns% equ 2 goto m1setdns2
if %manualdns% equ 3 goto m1setdns3
if %manualdns% equ 4 goto m1setdns4
if %manualdns% equ 5 goto m1setdns5
if %manualdns% equ 6 goto m1setdns6
if %manualdns% equ 7 goto m1setdns7
if %manualdns% equ 8 goto m1setdns8
if %manualdns% equ 9 goto m1setdns9
if %manualdns% equ 10 goto m1setdns10
if %manualdns% equ 11 goto m1setdns11
if %manualdns% equ 12 goto m1setdns12
if %manualdns% equ 13 goto m1setdns13
if %manualdns% equ 14 goto m1setdns14
if %manualdns% equ 15 goto m1setdns15
if %manualdns% equ 16 goto m1setdns16
if %manualdns% equ 17 goto m1setdns17
if %manualdns% equ 18 goto m1setdns18
if %manualdns% equ 19 goto m1setdns19
if %manualdns% equ 20 goto m1setdns20
if %manualdns% equ 21 goto m1setdns21
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnssetupmenu1

:dnsjump1
echo.
echo 保存 IPv4 首选 DNS 设置成功
echo 即将转到备选 DNS 设置页面
timeout /t 2 /nobreak > NUL
goto dnssetupmenu2

:m1setdns1 
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=119.29.29.29"
call:dnsjump1

:m1setdns2
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=182.254.116.116"
call:dnsjump1

:m1setdns3
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=223.5.5.5"
call:dnsjump1

:m1setdns4
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=223.6.6.6"
call:dnsjump1

:m1setdns5
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=8.8.8.8"
call:dnsjump1

:m1setdns6
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=4.4.4.4"
call:dnsjump1

:m1setdns7
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=119.29.29.29"
call:dnsjump1

:m1setdns8
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=1.1.1.1"
call:dnsjump1

:m1setdns9
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=1.0.0.1"
call:dnsjump1

:m1setdns10
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=114.114.114.114"
call:dnsjump1

:m1setdns11
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=114.114.115.115"
call:dnsjump1

:m1setdns12
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=80.80.80.80"
call:dnsjump1

:m1setdns13
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=80.80.81.81"
call:dnsjump1

:m1setdns14
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=156.154.70.25"
call:dnsjump1

:m1setdns15
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=156.154.71.25"
call:dnsjump1

:m1setdns16
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=208.67.222.222"
call:dnsjump1

:m1setdns17
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=208.67.220.220"
call:dnsjump1

:m1setdns18
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=101.226.4.6"
call:dnsjump1

:m1setdns19
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=123.125.81.6"
call:dnsjump1

:m1setdns20
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=4.2.2.1"
call:dnsjump1

:m1setdns21
echo.
echo 正在保存首选 IPv4 DNS 设置
set "m1dns=4.2.2.2"
call:dnsjump1

:dnssetupmenu2
cls
echo.
echo     请选择 IPv4 备选 DNS 服务器：
echo.
echo     0. 返回设置菜单
echo.
echo     1. 服务器：119.29.29.29        （腾讯 Public DNS+）
echo     2. 服务器：182.254.116.116     （腾讯 Public DNS+ 备用）
echo.
echo     3. 服务器：223.5.5.5           （阿里 DNS）
echo     4. 服务器：223.6.6.6           （阿里 DNS 备用）
echo.
echo     5. 服务器：8.8.8.8             （谷歌 DNS）
echo     6. 服务器：8.8.4.4             （谷歌 DNS 备用）
echo.
echo     7. 服务器：119.29.29.29        （百度公共 DNS）
echo.
echo     8. 服务器：1.1.1.1             （CloudFlare DNS）
echo     9. 服务器：1.0.0.1             （CloudFlare DNS 备用）
echo.
echo    10. 服务器：114.114.114.114     （114 DNS）
echo    11. 服务器：114.114.115.115     （114 DNS 备用）
echo.
echo    12. 服务器：80.80.80.80         （Freenom DNS）
echo    13. 服务器：80.80.81.81         （Freenom DNS 备用）
echo.
echo    14. 服务器：156.154.70.25       （Comodo DNS）
echo    15. 服务器：156.154.71.25       （Comodo DNS 备用）
echo.
echo    16. 服务器：208.67.222.222      （Open DNS）
echo    17. 服务器：208.67.220.220      （Open DNS 备用）
echo.
echo    18. 服务器：101.226.4.6         （360 电信、移动、铁通 DNS）
echo    19. 服务器：123.125.81.6        （360 联通 DNS）
echo.
echo    20. 服务器：4.2.2.1             （微软推荐：Verizon DNS）
echo    21. 服务器：4.2.2.2             （微软推荐：Verizon DNS 备用）
echo.
set /p manualdns=→  请输入选项：
if "%manualdns%"=="" set manualdns=null
if %manualdns% equ 0 goto dnsfix
if %manualdns% equ 1 goto m2setdns1
if %manualdns% equ 2 goto m2setdns2
if %manualdns% equ 3 goto m2setdns3
if %manualdns% equ 4 goto m2setdns4
if %manualdns% equ 5 goto m2setdns5
if %manualdns% equ 6 goto m2setdns6
if %manualdns% equ 7 goto m2setdns7
if %manualdns% equ 8 goto m2setdns8
if %manualdns% equ 9 goto m2setdns9
if %manualdns% equ 10 goto m2setdns10
if %manualdns% equ 11 goto m2setdns11
if %manualdns% equ 12 goto m2setdns12
if %manualdns% equ 13 goto m2setdns13
if %manualdns% equ 14 goto m2setdns14
if %manualdns% equ 15 goto m2setdns15
if %manualdns% equ 16 goto m2setdns16
if %manualdns% equ 17 goto m2setdns17
if %manualdns% equ 18 goto m2setdns18
if %manualdns% equ 19 goto m2setdns19
if %manualdns% equ 20 goto m2setdns20
if %manualdns% equ 21 goto m2setdns21
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnssetupmenu2

:m2setdns1 
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=119.29.29.29"
call:dnsjump2

:m2setdns2
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=182.254.116.116"
call:dnsjump2

:m2setdns3
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=223.5.5.5"
call:dnsjump2

:m2setdns4
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=223.6.6.6"
call:dnsjump2

:m2setdns5
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=8.8.8.8"
call:dnsjump2

:m2setdns6
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=4.4.4.4"
call:dnsjump2

:m2setdns7
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=119.29.29.29"
call:dnsjump2

:m2setdns8
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=1.1.1.1"
call:dnsjump2

:m2setdns9
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=1.0.0.1"
call:dnsjump2

:m2setdns10
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=114.114.114.114"
call:dnsjump2

:m2setdns11
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=114.114.115.115"
call:dnsjump2

:m2setdns12
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=80.80.80.80"
call:dnsjump2

:m2setdns13
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=80.80.81.81"
call:dnsjump2

:m2setdns14
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=156.154.70.25"
call:dnsjump2

:m2setdns15
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=156.154.71.25"
call:dnsjump2

:m2setdns16
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=208.67.222.222"
call:dnsjump2

:m2setdns17
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=208.67.220.220"
call:dnsjump2

:m2setdns18
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=101.226.4.6"
call:dnsjump2

:m2setdns19
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=123.125.81.6"
call:dnsjump2

:m2setdns20
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=4.2.2.1"
call:dnsjump2

:m2setdns21
echo.
echo 正在保存备选 IPv4 DNS 设置
set "m2dns=4.2.2.2"
call:dnsjump2

:dnsjump2
echo.
echo 保存 IPv4 备选 DNS 设置成功
echo 开始设置 IPv4 DNS 服务器

:manualdnssetup
echo 正在为 %networkname1% 设置 DNS 服务器
echo 首选 IPv4 DNS 服务器：%m1dns%
echo 备选 IPv4 DNS 服务器：%m2dns%
netsh interface ip set dnsservers %networkname1% static %m1dns%
netsh interface ip add dnsservers %networkname1% %m2dns%
echo.
call:dnsserver DNS已设置成功: 
ipconfig /flushdns >nul 2>nul
echo DNS 缓存已刷新
pause
goto menu

:dnssetup2
cls
echo.
echo     IPv4 DNS 优选设置菜单
echo.
echo     0. 返回主菜单
echo     1. 首选: 119.29.29.29（腾讯 Public DNS+）    备用: 8.8.8.8（谷歌 DNS）
echo     2. 首选: 223.5.5.5（阿里 DNS）               备用: 8.8.8.8（谷歌 DNS）
echo     3. 首选: 114.114.114.114（114 DNS）          备用: 8.8.8.8（谷歌 DNS）
echo     4. 首选: 180.76.76.76（百度公共 DNS）         备用: 8.8.8.8（谷歌 DNS）
echo     5. 首选: 8.8.8.8（谷歌 DNS）                 备用: 223.5.5.5（阿里 DNS）
echo     6. 首选: 9.9.9.9（IBM Quad9 DNS）            备用: 223.5.5.5(防运营商劫持^)（阿里 DNS）
echo     7. 首选: 4.2.2.1（微软 DNS）                  备用: 223.5.5.5（阿里 DNS）
echo     8. 移动: 101.226.4.6（电信 DNS）              备用: 223.5.5.5（阿里 DNS）
echo     9. 首选: 80.80.80.80（Freenom DNS）          备用: 223.5.5.5(防运营商劫持^)（阿里 DNS）
echo    10. 首选: 223.5.5.5（阿里 DNS）                备用: 4.2.2.1（微软 DNS）
echo    11. 首选：119.29.29.29（腾讯 Public DNS+）    备用：223.5.5.5（阿里 DNS）
echo    12. 首选：119.29.29.29（腾讯 Public DNS+）    备用：114.114.114.114（114 DNS）
echo.
set /p dns=→  请选择: 
if "%dns%"=="" set dns=null
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
if %dns% equ 10 goto dnsip10
if %dns% equ 11 goto dnsip11
if %dns% equ 12 goto dnsip12
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnssetup2

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
echo    警告: ISP 劫持了 114 DNS
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
call:dnssetting 4.2.2.1 223.5.5.5
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

:dnsip10
call:dnssetting 223.5.5.5 4.2.2.1
pause
goto menu

:dnsip11
call:dnssetting 119.29.29.29 223.5.5.5
pause
goto menu

:dnsip12
call:dnssetting 119.29.29.29 114.114.114.114
pause
goto menu


:dnssetup3
rem set m1dns=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^>
rem set m2dns=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^>
echo.
echo 请输入 IPv4 首选 DNS 服务器地址
echo 范围：0.0.0.0 至 255.255.255.255
echo 格式错误会导致 DNS 服务器设置失败或 DNS 服务异常
echo.
set /p m1dns=→  请输入首选 DNS 服务器地址（注意格式）：
echo.
echo 识别到的首选 DNS 服务器地址为：%m1dns%
echo.
echo 请输入 IPv4 备选 DNS 服务器地址
echo 范围：0.0.0.0 至 255.255.255.255
echo 格式错误会导致 DNS 服务器设置失败或 DNS 服务异常
echo.
set /p m2dns=→  请输入备选 DNS 服务器地址（注意格式）：
echo.
echo 识别到的备选 DNS 服务器地址为：%m2dns%
echo.
echo 开始设置 DNS 服务器
call:manualdnssetup

:dnssetting
echo 正在为 %networkname1% 设置 DNS 服务器
netsh interface ip set dnsservers %networkname1% static %1 >nul 2>nul
netsh interface ip add dnsservers %networkname1% %2 >nul 2>nul
echo.
call:dnsserver DNS已设置成功: 
ipconfig /flushdns >nul 2>nul
echo DNS 缓存已刷新
echo.
goto:eof

:dnssetup4
cls
:dnssetupv6menu1
cls
echo.
echo     请选择 IPv6 首选 DNS 服务器：
echo.
echo     0. 返回设置菜单
echo.
echo     1. 服务器：240c::6666          （下一代互联网北京研究中心 DNS）
echo     2. 服务器：240c::6644          （下一代互联网北京研究中心 DNS 备用）
echo.
echo     3. 服务器：2409:8088::a        （中国移动 IPv6 DNS）
echo     4. 服务器：2409:8088::b        （中国移动 IPv6 DNS 备用）
echo.
echo     5. 服务器：240e:4c:4008::1     （中国电信 IPv6 DNS）
echo     6. 服务器：240e:4c:4808::1     （中国电信 IPv6 DNS 备用）
echo.
echo     7. 服务器：2408:8899::8        （中国联通 IPv6 DNS）
echo     8. 服务器：2408:8888::8        （中国联通 IPv6 DNS 备用）
echo.
echo     9. 服务器：2001:dc7:1000::1    （中国互联网信息中心 CNNIC IPv6 DNS）
echo.
echo    10. 服务器：2001:de4::101       （TWNIC IPv6 DNS Quad 101）
echo    11. 服务器：2001:de4::102       （TWNIC IPv6 DNS Quad 101 备用）
echo.
echo    12. 服务器：2400:3200::1        （阿里 IPv6 DNS）
echo    13. 服务器：2400:3200:baba::1   （阿里 IPv6 DNS 备用）
echo.
echo    14. 服务器：2402:4e00::         （腾讯 DNSPod IPv6 DNS）
echo.
echo    15. 服务器：2400:da00::6666     （百度 IPv6 DNS 备用）
echo.
echo    16. 服务器：2001:4860:4860::8888（谷歌公共 IPv6 DNS）
echo    17. 服务器：2001:4860:4860::8844（谷歌公共 IPv6 DNS 备用）
echo.
echo    18. 服务器：2606:4700:4700::1111（Cloudflare IPv6 DNS）
echo    19. 服务器：2606:4700:4700::1001（Cloudflare IPv6 DNS 备用）
echo.
echo    20. 服务器：2620:0:ccc::2       （OpenDNS IPv6 DNS）
echo    21. 服务器：2620:0:ccd::2       （OpenDNS IPv6 DNS 备用）
echo.
echo    22. 服务器：2620:fe::fe         （Quad9 IPv6 DNS）
echo    23. 服务器：2620:fe::9          （Quad9 IPv6 DNS 备用）
echo.
set /p manualdns=→  请输入选项：
if "%manualdns%"=="" set manualdns=null
if %manualdns% equ 0 goto dnsfix
if %manualdns% equ 1 goto m1setv6dns1
if %manualdns% equ 2 goto m1setv6dns2
if %manualdns% equ 3 goto m1setv6dns3
if %manualdns% equ 4 goto m1setv6dns4
if %manualdns% equ 5 goto m1setv6dns5
if %manualdns% equ 6 goto m1setv6dns6
if %manualdns% equ 7 goto m1setv6dns7
if %manualdns% equ 8 goto m1setv6dns8
if %manualdns% equ 9 goto m1setv6dns9
if %manualdns% equ 10 goto m1setv6dns10
if %manualdns% equ 11 goto m1setv6dns11
if %manualdns% equ 12 goto m1setv6dns12
if %manualdns% equ 13 goto m1setv6dns13
if %manualdns% equ 14 goto m1setv6dns14
if %manualdns% equ 15 goto m1setv6dns15
if %manualdns% equ 16 goto m1setv6dns16
if %manualdns% equ 17 goto m1setv6dns17
if %manualdns% equ 18 goto m1setv6dns18
if %manualdns% equ 19 goto m1setv6dns19
if %manualdns% equ 20 goto m1setv6dns20
if %manualdns% equ 21 goto m1setv6dns21
if %manualdns% equ 22 goto m1setv6dns22
if %manualdns% equ 23 goto m1setv6dns23
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnssetupv6menu1

:dnsv6jump1
echo.
echo 保存 IPv6 首选 DNS 设置成功
echo 即将转到备选 DNS 设置页面
timeout /t 2 /nobreak > NUL
goto dnssetupv6menu2

:m1setv6dns1 
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=240c::6666"
call:dnsv6jump1

:m1setv6dns2
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=240c::6644"
call:dnsv6jump1

:m1setv6dns3
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2409:8088::a"
call:dnsv6jump1

:m1setv6dns4
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2409:8088::b"
call:dnsv6jump1

:m1setv6dns5
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=240e:4c:4008::1"
call:dnsv6jump1

:m1setv6dns6
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=240e:4c:4808::1"
call:dnsv6jump1

:m1setv6dns7
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2408:8899::8"
call:dnsv6jump1

:m1setv6dns8
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2408:8888::8"
call:dnsv6jump1

:m1setv6dns9
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2001:dc7:1000::1"
call:dnsv6jump1

:m1setv6dns10
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2001:de4::101"
call:dnsv6jump1

:m1setv6dns11
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2001:de4::102"
call:dnsv6jump1

:m1setv6dns12
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2400:3200::1"
call:dnsv6jump1

:m1setv6dns13
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2400:3200:baba::1"
call:dnsv6jump1

:m1setv6dns14
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2402:4e00::"
call:dnsv6jump1

:m1setv6dns15
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2400:da00::6666"
call:dnsv6jump1

:m1setv6dns16
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2001:4860:4860::8888"
call:dnsv6jump1

:m1setv6dns17
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2001:4860:4860::8844"
call:dnsv6jump1

:m1setv6dns18
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2606:4700:4700::1111"
call:dnsv6jump1

:m1setv6dns19
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2606:4700:4700::1001"
call:dnsv6jump1

:m1setv6dns20
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2620:0:ccc::2"
call:dnsv6jump1

:m1setv6dns21
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2620:0:ccd::2"
call:dnsv6jump1

:m1setv6dns22
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2620:fe::fe"
call:dnsv6jump1

:m1setv6dns23
echo.
echo 正在保存首选 IPv6 DNS 设置
set "m1dnsv6=2620:fe::9"
call:dnsv6jump1

:dnssetupv6menu2
cls
echo.
echo     请选择 IPv6 备选 DNS 服务器：
echo.
echo     0. 返回设置菜单
echo.
echo     1. 服务器：240c::6666          （下一代互联网北京研究中心 DNS）
echo     2. 服务器：240c::6644          （下一代互联网北京研究中心 DNS 备用）
echo.
echo     3. 服务器：2409:8088::a        （中国移动 IPv6 DNS）
echo     4. 服务器：2409:8088::b        （中国移动 IPv6 DNS 备用）
echo.
echo     5. 服务器：240e:4c:4008::1     （中国电信 IPv6 DNS）
echo     6. 服务器：240e:4c:4808::1     （中国电信 IPv6 DNS 备用）
echo.
echo     7. 服务器：2408:8899::8        （中国联通 IPv6 DNS）
echo     8. 服务器：2408:8888::8        （中国联通 IPv6 DNS 备用）
echo.
echo     9. 服务器：2001:dc7:1000::1    （中国互联网信息中心 CNNIC IPv6 DNS）
echo.
echo    10. 服务器：2001:de4::101       （TWNIC IPv6 DNS Quad 101）
echo    11. 服务器：2001:de4::102       （TWNIC IPv6 DNS Quad 101 备用）
echo.
echo    12. 服务器：2400:3200::1        （阿里 IPv6 DNS）
echo    13. 服务器：2400:3200:baba::1   （阿里 IPv6 DNS 备用）
echo.
echo    14. 服务器：2402:4e00::         （腾讯 DNSPod IPv6 DNS）
echo.
echo    15. 服务器：2400:da00::6666     （百度 IPv6 DNS 备用）
echo.
echo    16. 服务器：2001:4860:4860::8888（谷歌公共 IPv6 DNS）
echo    17. 服务器：2001:4860:4860::8844（谷歌公共 IPv6 DNS 备用）
echo.
echo    18. 服务器：2606:4700:4700::1111（Cloudflare IPv6 DNS）
echo    19. 服务器：2606:4700:4700::1001（Cloudflare IPv6 DNS 备用）
echo.
echo    20. 服务器：2620:0:ccc::2       （OpenDNS IPv6 DNS）
echo    21. 服务器：2620:0:ccd::2       （OpenDNS IPv6 DNS 备用）
echo.
echo    22. 服务器：2620:fe::fe         （Quad9 IPv6 DNS）
echo    23. 服务器：2620:fe::9          （Quad9 IPv6 DNS 备用）
echo.
set /p manualdns=→  请输入选项：
if "%manualdns%"=="" set manualdns=null
if %manualdns% equ 0 goto dnsfix
if %manualdns% equ 1 goto m2setv6dns1
if %manualdns% equ 2 goto m2setv6dns2
if %manualdns% equ 3 goto m2setv6dns3
if %manualdns% equ 4 goto m2setv6dns4
if %manualdns% equ 5 goto m2setv6dns5
if %manualdns% equ 6 goto m2setv6dns6
if %manualdns% equ 7 goto m2setv6dns7
if %manualdns% equ 8 goto m2setv6dns8
if %manualdns% equ 9 goto m2setv6dns9
if %manualdns% equ 10 goto m2setv6dns10
if %manualdns% equ 11 goto m2setv6dns11
if %manualdns% equ 12 goto m2setv6dns12
if %manualdns% equ 13 goto m2setv6dns13
if %manualdns% equ 14 goto m2setv6dns14
if %manualdns% equ 15 goto m2setv6dns15
if %manualdns% equ 16 goto m2setv6dns16
if %manualdns% equ 17 goto m2setv6dns17
if %manualdns% equ 18 goto m2setv6dns18
if %manualdns% equ 19 goto m2setv6dns19
if %manualdns% equ 20 goto m2setv6dns20
if %manualdns% equ 21 goto m2setv6dns21
if %manualdns% equ 22 goto m2setv6dns22
if %manualdns% equ 23 goto m2setv6dns23
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnssetupv6menu2

:m2setv6dns1 
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=240c::6666"
call:dnsv6jump2

:m2setv6dns2
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=240c::6644"
call:dnsv6jump2

:m2setv6dns3
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2409:8088::a"
call:dnsv6jump2

:m2setv6dns4
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2409:8088::b"
call:dnsv6jump2

:m2setv6dns5
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=240e:4c:4008::1"
call:dnsv6jump2

:m2setv6dns6
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=240e:4c:4808::1"
call:dnsv6jump2

:m2setv6dns7
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2408:8899::8"
call:dnsv6jump2

:m2setv6dns8
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2408:8888::8"
call:dnsv6jump2

:m2setv6dns9
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2001:dc7:1000::1"
call:dnsv6jump2

:m2setv6dns10
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2001:de4::101"
call:dnsv6jump2

:m2setv6dns11
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2001:de4::102"
call:dnsv6jump2

:m2setv6dns12
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2400:3200::1"
call:dnsv6jump2

:m2setv6dns13
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2400:3200:baba::1"
call:dnsv6jump2

:m2setv6dns14
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2402:4e00::"
call:dnsv6jump2

:m2setv6dns15
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2400:da00::6666"
call:dnsv6jump2

:m2setv6dns16
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2001:4860:4860::8888"
call:dnsv6jump2

:m2setv6dns17
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2001:4860:4860::8844"
call:dnsv6jump2

:m2setv6dns18
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2606:4700:4700::1111"
call:dnsv6jump2

:m2setv6dns19
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2606:4700:4700::1001"
call:dnsv6jump2

:m2setv6dns20
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2620:0:ccc::2"
call:dnsv6jump2

:m2setv6dns21
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2620:0:ccd::2"
call:dnsv6jump2

:m2setv6dns22
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2620:fe::fe"
call:dnsv6jump2

:m2setv6dns23
echo.
echo 正在保存备选 IPv6 DNS 设置
set "m2dnsv6=2620:fe::9"
call:dnsv6jump2

:dnsv6jump2
echo.
echo 保存 IPv6 备选 DNS 设置成功
echo 开始设置 IPv6 DNS 服务器
:manualdnsv6setup
echo 首选 IPv6 DNS 服务器：%m1dnsv6%
echo 备选 IPv6 DNS 服务器：%m2dnsv6%
netsh interface ipv6 set dnsservers %networkname1% static %m1dnsv6%
netsh interface ipv6 add dnsservers %networkname1% %m2dnsv6%
echo.
echo IPv6 DNS已设置成功
ipconfig /flushdns >nul 2>nul
echo DNS 缓存已刷新
pause
goto menu

:dnssetup5
cls
echo.
echo     IPv6 DNS 优选设置菜单
echo.
echo     0. 返回主菜单
echo.
echo     1. 首选: 240c::6666（下一代互联网北京研究中心 DNS）
echo        备用: 2400:3200::1（阿里 IPv6 DNS）
echo.
echo     2. 首选: 2400:3200::1（阿里 IPv6 DNS）
echo        备用: 2001:4860:4860::8888（谷歌公共 IPv6 DNS）
echo.
echo     3. 首选: 2001:dc7:1000::1（CNNIC IPv6 DNS）
echo        备用: 2400:3200::1（阿里 IPv6 DNS）
echo.
echo     4. 首选: 2402:4e00::（腾讯 DNSPod IPv6 DNS）
echo        备用: 240c::6666（下一代互联网北京研究中心 DNS）
echo.
echo     5. 首选: 2620:0:ccc::2（OpenDNS IPv6 DNS）
echo        备用: 240c::6666（阿里 DNS）
echo.
echo     6. 首选: 240e:4c:4008::1（中国电信 IPv6 DNS）
echo        备用: 2620:fe::fe（Quad9 IPv6 DNS）
echo.
echo     7. 首选: 2400:da00::6666（百度 IPv6 DNS 备用）
echo        备用: 2001:dc7:1000::1（CNNIC IPv6 DNS）
echo.
set /p dns=→  请选择: 
if "%dns%"=="" set dns=null
if %dns% equ 0 goto dnsv6ip0
if %dns% equ 1 goto dnsv6ip1
if %dns% equ 2 goto dnsv6ip2
if %dns% equ 3 goto dnsv6ip3
if %dns% equ 4 goto dnsv6ip4
if %dns% equ 5 goto dnsv6ip5
if %dns% equ 6 goto dnsv6ip6
if %dns% equ 7 goto dnsv6ip7
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto dnssetup5

:dnsv6ip0
goto menu

:dnsv6ip1
call:dnssettingv6 240c::6666 2400:3200::1
pause
goto menu

:dnsv6ip2
call:dnssettingv6 2400:3200::1 2001:4860:4860::8888
pause
goto menu

:dnsv6ip3
call:dnssettingv6 2001:dc7:1000::1 2400:3200::1
pause
goto menu

:dnsv6ip4
call:dnssettingv6 2402:4e00:: 240c::6666
pause
goto menu

:dnsv6ip5
call:dnssettingv6 2620:0:ccc::2 240c::6666
pause
goto menu

:dnsv6ip6
call:dnssettingv6 240e:4c:4008::1 2620:fe::fe
pause
goto menu

:dnsv6ip7
call:dnssettingv6 2400:da00::6666 2001:dc7:1000::1
pause
goto menu

:dnssetup6
rem set m1dnsv6=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^>
rem set m2dnsv6=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^>
echo.
echo 请输入 IPv6 首选 DNS 服务器地址
echo 范围：:::: 至 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF
echo 格式错误会导致 DNS 服务器设置失败或 DNS 服务异常
echo.
set /p m1dnsv6=→  请输入首选 DNS 服务器地址（注意格式）：
echo.
echo 识别到的首选 DNS 服务器地址为：%m1dnsv6%
echo.
echo 请输入 IPv6 备选 DNS 服务器地址
echo 范围：:::: 至 FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF:FFFF
echo 格式错误会导致 DNS 服务器设置失败或 DNS 服务异常
echo.
set /p m2dnsv6=→  请输入备选 DNS 服务器地址（注意格式）：
echo.
echo 识别到的备选 DNS 服务器地址为：%m2dnsv6%
echo.
echo 开始设置 DNS 服务器
call:manualdnsv6setup

:dnssettingv6
echo 正在为 %networkname1% 设置 DNS 服务器
netsh interface ipv6 set dnsservers %networkname1% static %1 >nul 2>nul
netsh interface ipv6 add dnsservers %networkname1% %2 >nul 2>nul
echo.
echo DNS已设置成功
ipconfig /flushdns >nul 2>nul
echo DNS 缓存已刷新
echo.
goto:eof

:programlist
cls
echo.
echo 开始导出用户程序列表
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
echo.
(for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k) >%UserDesktopPath%\MDT\ProgramList.log
(for /f "tokens=3,4*" %%i in ('reg query HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k) >%UserDesktopPath%\MDT\ProgramList.log
(for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<微软 \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k) >%UserDesktopPath%\MDT\ProgramList.log

echo 导出用户程序列表完成，请查看桌面 MDT 文件夹中的 ProgramList.log 文件
start %UserDesktopPath%\MDT\ProgramList.log
echo 路径：%UserDesktopPath%\MDT\ProgramList.log
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
set "ipv6Enabled=false"
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter 'IPEnabled=True' | Select-Object -ExpandProperty IPAddress"`) DO (
    echo %%i | find ":" | findstr /i "[0-9][a-f]*: [a-f][0-9]*:" > nul
    if "%errorlevel%" == "0" (
        if "!ipv6Enabled!" == "false" (
            echo IPv6协议: 开启中 (已设置IPv4优先^)
            set "ipv6Enabled=true"
        )
        for /f "tokens=1,2,3" %%j in ('netsh interface ipv6 show prefixpolicies ^| findstr [0-9]') do netsh interface ipv6 set prefixpolicy %%m %%j %%k > nul 2>nul
        netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 100 4 > nul 2>nul
    ) else (
        if "!ipv6Enabled!" == "false" (
            echo IPv6协议: 已关闭
        )
    )
)
echo.
goto:eof
rem 旧版:ipv6state
::wmic nicConfig where "IPEnabled='True'" get IPAddress |find ":" |findstr /i "[0-9][a-f]*: [a-f][0-9]*:" >nul
::if "%errorlevel%"=="0" (
::echo IPv6协议: 开启中 (已设置IPv4优先^)
::for /f "tokens=1,2,3" %%i in ('netsh interface ipv6 show prefixpolicies ^|findstr [0-9]') do netsh interface ipv6 set prefixpolicy %%k %%i %%j >nul 2>nul
::netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 100 4 >nul 2>nul
::) else (
::echo IPv6协议: 已关闭
::)
::echo.
::goto:eof

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
echo 正在关闭 Windows 系统防火墙...
netsh advfirewall set allprofiles state off >nul 2>nul
echo Windows系统防火墙: 已关闭
echo.
goto menu

:systemfirewallon
cls
echo.
echo 正在开启 Windows 系统防火墙...
netsh advfirewall set allprofiles state on >nul 2>nul
echo Windows系统防火墙: 已开启
echo.
goto menu

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

FOR /F "usebackq tokens=3" %%i IN (`powershell -Command "(Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseId).ReleaseId"`) DO SET systemversion=%%i

FOR /F "usebackq tokens=1 delims=." %%i IN (`powershell -Command "(Get-Item -Path 'C:\Program Files\Internet Explorer\IEXPLORE.EXE').VersionInfo.FileVersion"`) DO SET ieversion=%%i

echo.
for /f "tokens=1,*" %%i in ('ver') do echo %%i %%j %systemversion%
echo 计算机名: %COMPUTERNAME%
echo IE 浏览器: %ieversion%
echo 网卡 MTU: %mtuvalue%
if not "!mturesult!" == "" (
	echo %mturesult%
)

rem 旧版:systemver
::ping -n 1 /f -l 1372 www.baidu.com |findstr DF >nul
::if "%errorlevel%"=="0" (
::set mturesult=警告: 上层设备 MTU 小于 1400
::) else (
::set mturesult=
::)
::for /f "tokens=3" %%i in ('netsh int ip show interfaces ^|findstr /r "\<connected" ^|findstr /r "以太网 本地连接"') do set mtuvalue=%%i
::for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ReleaseId 2^>nul') do set systemversion=%%i
::for /f "delims=." %%i in ('wmic datafile where name^="C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE" get Version 2^>nul ^|findstr /i /c:"."') do set ieversion=%%i

::echo.
::for /f "tokens=1,*" %%i in ('ver') do echo %%i %%j %systemversion%
::echo 计算机名: %COMPUTERNAME%
::echo IE 浏览器: %ieversion%
::echo 网卡 MTU: %mtuvalue%
::if not "!mturesult!" == "" (
::	echo %mturesult%
::)

rem 数据诊断

if DEFINED systemversion (
	if "%systemversion%" GTR "1809" (
		echo. >nul 2>nul
	) else (
		set systemversionresult=Windows 10 系统版本 %systemversion% 过低, 建议升级
		echo !systemversionresult!
	)
) else (
echo. >nul 2>nul
)
echo.
goto:eof

:tracerttable
rem 检查mtee是否存在
if not exist %appdata%\mtee.exe (
  echo.
  echo 路由统计等功能需要 mtee.exe 辅助
  echo MDT 程序运行时会释放 mtee.exe 至 AppData 路径下
  echo 请确保 %appdata% 路径下存在 mtee.exe 文件
  echo 若不存在可尝试重新运行 MDT 主程序，并检查是否存在安全软件拦截和误删的情况
  echo.
  echo 未检测到 mtee.exe，跳过相关功能...
  goto:eof
)
rem IPv4路由行数统计
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
echo     IPv4路由表统计: %routeall%(行)
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
echo  %%i   %%j ms   %%k ms   %%l ms    %%m !IPquyu! |%appdata%\mtee /a /+ %temp%\traceroute.txt
)
)
) else (
for /f "tokens=*" %%i in ('tracert -w 100 -d -h 5 114.114.114.114 ^|findstr ^[1-9] ^|findstr /v "114.114.114.114" ^|findstr /i "%ipv4ipv6%"') do echo     %%i |%appdata%\mtee /a /+ %temp%\traceroute.txt
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
if not exist %appdata%\mtee.exe (
  echo.
  echo 网卡信息功能需要 mtee.exe 辅助
  echo MDT 程序运行时会释放 mtee.exe 至 AppData 路径下
  echo 请确保 %appdata% 路径下存在 mtee.exe 文件
  echo 若不存在可尝试重新运行 MDT 主程序，并检查是否存在安全软件拦截和误删的情况
  echo.
  echo 未检测到 mtee.exe，跳过相关功能...
  goto:eof
)
echo 网卡: 
rem 网卡列表
  for /f "tokens=1,2,4 delims=," %%i in ('Getmac /v /nh /fo csv') do (
    set networkstatus=%%k
    echo     %%i %%j  !networkstatus:~1,7! |%appdata%\mtee /a /+ %temp%\networkadapter.txt
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
rem 旧版获取硬件信息
::for /f "tokens=*" %%i in ('wmic cpu get name ^|findstr /v "Name" ^|findstr "[^\S]"') do echo     CPU:  %%i
::for /f %%i in ('wmic os get TotalVisibleMemorySize ^|findstr [0-9]') do set /a ram=%%i/1024
::for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualram=%%i/1024
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_Processor | Select-Object -ExpandProperty Name"`) DO (
    echo     CPU: %%i
)
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty TotalVisibleMemorySize"`) DO (
    set /a ram=%%i/1024
)
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty SizeStoredInPagingFiles"`) DO (
    set /a virtualram=%%i/1024
)

echo     运行内存:  %ram% MB; 当前分配虚拟内存:  %VirtualRAM% MB
rem for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get AdapterRAM^,Name /value ^|findstr Name') do set vganame=%%i
rem echo     显卡 GPU:  %vganame%
echo.
echo     运行内存硬件信息：
powershell -Command ^
    "Get-WmiObject Win32_PhysicalMemory | ForEach-Object { '    {0} {1} GB' -f $_.Manufacturer, ($_.Capacity / 1GB) }"
echo.
rem 显卡详细信息:
call:getvgainfo
::for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do echo     分辨率:  %%j*%%i
FOR /F "usebackq tokens=1,2 delims=," %%i IN (`powershell -Command "(Get-CimInstance -ClassName Win32_DesktopMonitor).ScreenWidth,ScreenHeight"`) DO (
    IF NOT "%%i" == "" IF NOT "%%j" == "" (
        set vgascr=    分辨率:  %%j*%%i
    ) ELSE (
        set vgascr=    未能成功获取屏幕分辨率
    )
)
echo %vgascr%
echo.
call:getdiskinfo
echo.
call:getbiosinfo
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

FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration -Filter 'IPEnabled=True' | Select-Object -ExpandProperty DNSServerSearchOrder"`) DO (
    set "dnsserverip=%%i"
    set "dnsserverip=!dnsserverip:{=!"
    set "dnsserverip=!dnsserverip:}=!"
    set "dnsserverip=!dnsserverip:"=!"
)

::for /f "tokens=1-2" %%i in ('wmic nicConfig where "IPEnabled='True'" get DNSServerSearchOrder ^|findstr "{"') do set dnsserverip=%%i %%j
::set dnsserverip=%dnsserverip:"=%
::set dnsserverip=%dnsserverip:{=%
::set dnsserverip=%dnsserverip:}=%

nslookup whether.114dns.com 114.114.114.114 2>nul |findstr 127.0.0 >nul
If %ERRORLEVEL% equ 0 (
set dnsresult=运营商可能 DNS 劫持
echo.
) else (
echo. >nul 2>nul
)
echo IPv4 DNS 服务器：
echo     %dnsserverip% %dnsresult%
echo.
echo IPv6 DNS 服务器：
netsh int ipv6 show dns %networkname1% |findstr /i "%ipv6only%"
echo.
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
    takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
		echo F| xcopy "%temp%\infocollect.txt" "%UserDesktopPath%\MDT\NetDiag.txt" /s /c /y /i >nul 2>nul
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
echo 若不想修改设置请直接按回车或者关闭程序
set /p usertime=设定开机启动项选择的等待时间（秒）：
if "%usertime%"=="" goto menu
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
echo 修复完成，请重启电脑，保持网络通畅，耐心等待 10 分钟。（建议白天修复，夜间聚焦推送不稳定）
pause
goto menu

:borecmenu
cls
echo.
echo     请选择你要恢复的电源选项：
echo.
echo     0. 返回主菜单
echo     1. 恢复节能模式
echo     2. 恢复平衡模式
echo     3. 恢复高性能模式
echo     4. 恢复卓越性能模式（仅限于 Win10/11 专业版以上）
echo     5. 自定义设置（打开系统电源选项设置页面）
echo.
set /p binput=→  请输入选项：
if "%binput%"=="" set binput=null
if %binput% equ 0 goto menu
if %binput% equ 1 goto lowbatteryrec
if %binput% equ 2 goto medbatteryrec
if %binput% equ 3 goto highperfbatteryrec
if %binput% equ 4 goto extremeperfbatteryrec
if %binput% equ 5 goto setcustombattery
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto borecmenu

:lowbatteryrec
echo.
echo 开始恢复电源选项设置（部分机型可能无效，例如 Surface）
echo.
echo 恢复节能模式
powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
echo.
goto batteryrecfin

:medbatteryrec
echo.
echo 开始恢复电源选项设置（部分机型可能无效，例如 Surface）
echo.
echo 恢复平衡模式
powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
goto batteryrecfin

:highperfbatteryrec
echo.
echo 开始恢复电源选项设置（部分机型可能无效，例如 Surface）
echo.
echo 恢复高性能模式
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo.
goto batteryrecfin

:extremeperfbatteryrec
echo.
echo 开始恢复电源选项设置（部分机型可能无效，例如 Surface）
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
echo     3. 未能设置成功电源选项修复（尝试写入不受支持的设置）
echo.
set /p bfinput=→  请输入选项：
if "%bfinput%"=="" set bfinput=null
if %bfinput% equ 0 goto menu
if %bfinput% equ 1 goto borecmenu
if %bfinput% equ 2 goto setbatteryoption
if %bfinput% equ 3 goto bosetfail
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
cls
goto batteryrecfin

:wu0205
cls
echo.
echo 开始修复 Windows Update 异常问题
echo 此修复功能对下载错误、下载异常、下载失败及部分安装失败等问题有修复作用
echo 如 0x80070002 0x80070003 0x80070005
echo 其他问题请使用系统修复功能或重置 Windows Update 功能
echo.
echo 配置系统服务
SC config wuauserv start= auto >nul 2>nul
SC config bits start= auto >nul 2>nul
SC config cryptsvc start= auto >nul 2>nul
SC config trustedinstaller start= auto >nul 2>nul
SC config wuauserv type=share >nul 2>nul
echo 临时停止系统服务
net stop wuauserv >nul 2>nul
net stop cryptSvc >nul 2>nul
net stop bits >nul 2>nul
net stop msiserver >nul 2>nul
echo 备份系统补丁路径并删除旧的备份
rd /s /q C:\Windows\SoftwareDistribution.old
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
echo 重启系统服务
net start wuauserv >nul 2>nul
net start cryptSvc >nul 2>nul
net start bits >nul 2>nul
net start msiserver >nul 2>nul
echo 修复完成，请重启电脑重试更新
echo 若仍存在问题，请使用系统修复功能或重置 Windows Update 功能进行修复
echo.
echo 注意：若系统更新安装出现 0x800f081f 错误
echo 请打开组策略（快捷键：Win + R，输入 gpedit.msc 回车）
echo 在打开的组策略编辑器窗口中，定位到“计算机配置-管理模板-系统”路径
echo 在右侧设置菜单中下拉找到“指定可选组件安装和组件修复的设置”，双击打开
echo 在打开的配置页面中，选择“已启用(E)”，点击确定，然后重试 DISM 修复功能或更新操作
echo 若反复出现安装更新失败，请尝试覆盖安装系统修复
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
if "%input%"=="" set input=null
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
echo 注意：使用垃圾清理功能会清理 MDT 程序临时文件
echo 执行后 MDT 程序会自动退出，如有需要请重新运行 MDT 程序
echo 如不需要清理，请输入 0 返回主菜单
echo 如需继续操作请按回车键
echo.
set /p input=→  请输入：
if "%input%"=="" goto junkcleanstart
if %input% equ 0 goto menu
:junkcleanstart
echo 开始生成垃圾清理批处理脚本
echo.

echo @echo off >%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat
echo echo 开始垃圾清理进程 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat
echo echo 系统盘扫描 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理自动更新补丁缓存与日志 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\SoftwareDistribution\DataStore\Logs\*.log" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\SoftwareDistribution\DataStore\Logs\*.jrs" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\SoftwareDistribution\Download\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理错误报告 >>%appdata%\junkclean.bat
rem echo del /f /s /q "%%ProgramData%%\Microsoft\Windows\WER\ReportArchive\*.wer" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%ProgramData%%\Microsoft\Windows\WER\ReportArchive\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 Windows Search 日志文件 >>%appdata%\junkclean.bat
echo del /f /s /q "%%systemdrive%%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jcp" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%systemdrive%%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jtx" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%systemdrive%%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jr" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 IIS 日志文件 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\System32\LogFiles\Fax\Incoming\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\System32\LogFiles\Fax\outcoming\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\System32\LogFiles\setupcln\setupact.log" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\System32\LogFiles\setupcln\setuperr.log" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 Windows 设置日志文件 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\setupact.log" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\setuperr.log" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 .Net Framework 日志 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\Microsoft.NET\Framework\*.log" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 Windows 日志 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\*.log" ^>nul 2^>nul >>%appdata%\junkclean.bat

rem 独立该日志清理功能
rem echo for /F "tokens=*" %%1 in ('wevtutil.exe el') DO wevtutil cl "%%1" ^>nul 2^>nul >>%appdata%\junkclean_log.bat

echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理系统临时文件 >>%appdata%\junkclean.bat
echo rd /s /q %%windir%%\temp ^& md %%windir%%\temp ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Temp\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\Local Settings\Temp\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理程序崩溃转储文件 >>%appdata%\junkclean.bat
echo del /f /s /q %%userprofile%%\AppData\Local\CrashDumps\*.* ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理程序崩溃报告 >>%appdata%\junkclean.bat
echo del /f /s /q %%userprofile%%\AppData\Local\CrashRpt\UnsentCrashReports\*.* ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 Cookies >>%appdata%\junkclean.bat
echo del /f /q %%userprofile%%\cookies\*.* ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理传递优化缓存文件 >>%appdata%\junkclean.bat
echo del /f /s /q "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理最近使用文件和跳转列表 >>%appdata%\junkclean.bat
echo rem 老版本最近使用文件 Windows 路径 >>%appdata%\junkclean.bat
echo del /f /s /q %%userprofile%%\recent\*.* ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\recent\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo rem 新版本最近使用文件 Windows 路径 >>%appdata%\junkclean.bat
echo del /f /s /q "%%AppData%%\Microsoft\Windows\Recent\CustomDestinations\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%AppData%%\Microsoft\Windows\Recent\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo rem 删除 RecentDocs 下的所有子键（即各文件类型的最近使用文件记录） >>%appdata%\junkclean.bat
echo rem 最近使用文件注册表清理 >>%appdata%\junkclean.bat
echo rem for /f "delims=" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /s^| findstr /v "HKEY_"') do ( >>%appdata%\junkclean.bat
echo rem    echo Deleting: %%a >>%appdata%\junkclean.bat
echo rem    reg delete "%%a" /f >>%appdata%\junkclean.bat
echo rem ) >>%appdata%\junkclean.bat
echo :: 建议重启资源管理器或重启计算机以确保更改生效 >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理临时 Internet 文件 >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\Local Settings\Temporary Internet Files\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Temporary Internet Files\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理字体缓存 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 CryptoAPI 证书缓存 >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理预加载文件 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\Prefetch\*.pf" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理自动更新补丁文件 >>%appdata%\junkclean.bat
echo del /f /s /q "%%windir%%\SoftwareDistribution\Download\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理缩略图缓存 >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Windows\Explorer\*.db" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Windows\Explorer\IconCacheToDelete\*.tmp" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 Microsoft Edge 缓存 >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Edge\User Data\Default\Extension State\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Edge\User Data\Default\Session Storage\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Edge\User Data\Default\JumpListIconsRecentClosed\*.tmp" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 清理 Internet Explorer 缓存 >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Internet Explorer\DOMStore\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Windows\INetCookies\container.dat" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Windows\INetCookies\deprecated.cookie" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q "%%userprofile%%\AppData\Local\Microsoft\Windows\WebCache\*.*" ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 系统盘整体清理 >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*.tmp ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*._mp ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*.log ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*.gid ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*.chk ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*.old ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\*.dmp ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%systemdrive%%\recycled\*.* ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%windir%%\*.bak ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%windir%%\prefetch\*.* ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 注册表缓存清理 ^>nul 2^>nul >>%appdata%\junkclean.bat
echo reg delete "HKEY_CLASSES_ROOT\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /va /f ^>nul 2^>nul >>%appdata%\junkclean.bat
echo reg delete "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /va /f ^>nul 2^>nul >>%appdata%\junkclean.bat
echo reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /va /f ^>nul 2^>nul >>%appdata%\junkclean.bat
echo reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location\Nonpackaged" /va /f ^>nul 2^>nul >>%appdata%\junkclean.bat
echo echo 操作执行完成 >>%appdata%\junkclean.bat
echo echo. >>%appdata%\junkclean.bat

echo echo 所有操作已执行完成 >>%appdata%\junkclean.bat
echo echo 操作执行完成，如有需要请重新运行 MDT 程序 >>%appdata%\junkclean.bat
echo echo 清理完成，请按任意键退出程序 >>%appdata%\junkclean.bat
echo pause >>%appdata%\junkclean.bat
echo rem 清理自身及缓存 >>%appdata%\junkclean.bat
echo del /f /s /q %%appdata%%\cdb.exe ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%appdata%%\ntsd.exe ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%appdata%%\mtee.exe ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%appdata%%\PsExec.exe ^>nul 2^>nul >>%appdata%\junkclean.bat
echo del /f /s /q %%appdata%%\junkclean.bat ^>nul 2^>nul >>%appdata%\junkclean.bat
::其实bat此时已被删除，无所谓exit，直接退出
echo exit >>%appdata%\junkclean.bat
echo 已生成垃圾清理批处理脚本
echo 执行垃圾清理批处理脚本
%appdata%\junkclean.bat
::其实MDT主程序文件此时已被清理，此处的pause和goto menu已无意义，使用的是junkclean.bat中的pause，直接exit
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
echo 修改 DNS 服务器地址为微软 DNS 服务器
call:dnssetting 4.2.2.1 223.5.5.5
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

echo.
echo 开始修复 Steam VAC 屏蔽问题
echo.
call:SteamRunningCheck

:startvacfix
echo 开始解决 VAC 屏蔽问题

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
if "%encode%"=="" set encode=null
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
title 离线 Windows 预览体验计划强制报名脚本 v%scriptver% 汉化版
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
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
powercfg /batteryreport /output "%UserDesktopPath%\MDT\Battery_Report.html"
echo.
echo 定位报告路径...
start %UserDesktopPath%\MDT
echo.
echo 正在打开报告...
start %UserDesktopPath%\MDT\Battery_Report.html
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
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
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
if "%input%"=="" goto menu
if %input% equ 0 goto menu

echo 程序识别到的文件路径为：%input%
echo 文件路径：%input%  >>%UserDesktopPath%\MDT\GET_HASH.log
echo.
echo. >>%UserDesktopPath%\MDT\GET_HASH.log
echo 开始计算 HASH 值
echo 提示：文件越大计算时间越久，请耐心等待...
echo 文件 MD2 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% MD2 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log

echo 文件 MD4 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% MD4 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log

echo 文件 MD5 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% MD5 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log

echo 文件 SHA1 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% SHA1 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log

echo 文件 SHA256 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% SHA256 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log

echo 文件 SHA384 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% SHA384 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log

echo 文件 SHA512 值： >>%UserDesktopPath%\MDT\GET_HASH.log
certutil -hashfile %input% SHA512 | findstr /v "[^0-9a-z]" >>%UserDesktopPath%\MDT\GET_HASH.log
echo.
echo ------------------------------------------------------------------------------------------ >>%UserDesktopPath%\MDT\GET_HASH.log

:finhash
echo HASH 值获取完成
echo 结果导出路径为： %UserDesktopPath%\MDT\GET_HASH.log
start %UserDesktopPath%\MDT\GET_HASH.log
echo.
echo     请选择你要继续的操作：
echo.
echo     1. 继续获取其他文件的 HASH 值
echo     2. 返回主菜单
echo.
set /p cinput=→  请输入选项：
if "%cinput%"=="" set cinput=null
if %cinput% equ 1 goto GETHASH
if %cinput% equ 2 goto menu
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto finhash

rem 以下功能输出较多信息为正常情况，可用 sc query 		 二次查询服务状态检验
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
cls
echo.
echo     声明：工具箱现不再整合 Microsoft-Activation-Scripts（以下简称 MAS） 
echo     请转到此页面：
echo     https://github.com/massgravel/Microsoft-Activation-Scripts
echo     来手动获取最新 MAS 脚本
echo.
echo     免责声明：Microsoft-Activation-Scripts 由 GitHub 作者 Massgravel 开发
echo     本脚本仅提供 MAS 获取方案，用户使用此外源脚本造成的一切后果由用户自行承担
echo     请您确保充分了解自己接下来的操作，并做好数据备份
echo.
echo     作者反对任何形式的软件破解侵权行为，请确保激活仅用于学习研究之目的！
echo. 
echo     要继续操作，请选择一个选项：
echo.
echo     0. 返回主菜单
echo     1. 手动转到 MAS Github 开源页面下载最新的 Release 版本
echo     2. 使用备用方案在线获取 MAS 激活脚本并尝试运行
echo.
echo     注意：使用备用方案请确保网络环境通畅
echo.
set /p masoption=→  请选择:
if "%masoption%"=="" set masoption=null
if %masoption% equ 0 goto menu
if %masoption% equ 1 goto manualgetmas
if %masoption% equ 2 goto altgetmas
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto MAS_ACTIVATOR

:manualgetmas
cls
echo.
echo https://github.com/massgravel/Microsoft-Activation-Scripts |clip
echo 已复制 MAS 激活脚本 GitHub 开源地址至剪贴板
echo 调用默认浏览器打开 GitHub 页面
echo 请转到 Release 页面下载最新版本 MAS 激活脚本并运行
echo 以便执行后续激活操作
echo.
start https://github.com/massgravel/Microsoft-Activation-Scripts
echo 操作执行完成
pause
goto menu

:altgetmas
cls
echo.
echo 尝试使用备用方案获取 MAS 激活脚本并尝试运行
echo 请确保网络通畅，并在后续使用管理员权限运行申请弹窗中选择“是”
echo 请在新的脚本窗口中完成后续激活操作
echo.
echo 调用 Powershell 执行命令 irm https://get.activated.win ^| iex
powershell -Command "irm https://get.activated.win | iex"
echo.
echo 部分旧版本 Windows 可能会出现调用异常
echo 如果未能成功调用出现红字提示或者其他错误
echo 请检查 Windows 更新，或者尝试直接以管理员身份运行 Powershell 
echo 然后执行 irm https://get.activated.win ^| iex 命令
echo 亦可尝试前往 GitHub 页面下载最新的 Release 版本
echo.
echo irm https://get.activated.win ^| iex>%temp%\MAS.txt
rem 不需要添加 -ExecutionPolicy Bypass 参数
rem powershell.exe -File "%temp%\MAS.txt"
rem echo 操作执行完成
rem echo.
clip <%temp%\MAS.txt
del /s /q /f %temp%\MAS.txt >nul 2>nul
echo 已自动复制 Powershell 命令备用
echo.
echo 操作执行完成
pause
goto menu

rem 微软激活脚本 End

:allprocessrunning
cls
echo.
echo 正在导出计算机所有正在运行的进程
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
tasklist /v /fi "STATUS eq running" >%UserDesktopPath%\MDT\AllProcess_Running.log
echo.
echo 导出完成，请查看桌面 MDT 文件夹中的 AllProcess_Running.log 文件
start %UserDesktopPath%\MDT\AllProcess_Running.log
echo 路径：%UserDesktopPath%\MDT\AllProcess_Running.log
pause
goto menu

:allprocess
cls
echo.
echo 正在导出计算机所有进程
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
tasklist >%UserDesktopPath%\MDT\AllProcess.log
echo.
echo 导出完成，请查看桌面 MDT 文件夹中的 AllProcess.log 文件
start %UserDesktopPath%\MDT\AllProcess.log
echo 路径：%UserDesktopPath%\MDT\AllProcess.log
pause
goto menu

:killprocess
cls
echo.
echo     杀死特定进程功能菜单
echo.
echo     请选择一个选项：
echo.
echo     0. 返回主菜单
echo     1. 使用 TASKKILL 命令结束进程
echo.    2. 使用 NTSD 命令结束进程（内核级）
echo     3. 使用 WMIC 命令结束进程（24H2 之前适用）
echo     4. 使用 CDB 命令结束进程（内核级）
echo.
echo     推荐先使用 TASKKILL / WMIC 命令结束进程
echo     如果不能正常结束，再使用 NTSD / CDB 命令结束进程
echo.
echo     部分进程存在保护机制，可能以上方式均无法结束
echo     建议使用专业分析工具解决
echo.
set /p kpinput=→  请输入选项：
if "%kpinput%"=="" set kpinput=null
if %kpinput% equ 0 goto menu
if %kpinput% equ 1 goto taskkillmenu
if %kpinput% equ 2 goto ntsdmenu
if %kpinput% equ 3 goto wmickillmenu
if %kpinput% equ 4 goto cdbkillmenu
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto killprocess

:taskkillmenu
cls
echo.
echo     使用 TASKKILL 命令结束进程
echo.
echo     请在下方输入要杀死的进程名，并用英文半角双引号将路径引用
echo     不引用会导致结束进程失败或程序崩溃退出
echo     例如："This is sample.exe"、"example.exe"
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在进程名处输入 0 并回车确认
echo.
set /p input=→  请输入进程名：
if "%input%"=="" goto menu
if %input% equ 0 goto menu
echo.
echo 程序识别到的进程名为：%input%
echo.
set PROC_NAME=%input%
REM 获取进程 ID
for /f "tokens=2 delims=," %%P in ('tasklist /NH /FI "IMAGENAME eq %PROC_NAME%" /FO CSV') do set PROC_ID=%%P
REM 检查进程是否存在
if "%PROC_ID%"=="" (
    echo 未找到进程 "%PROC_NAME%"
    goto:finkill
)
echo 尝试使用 TASKKILL 命令结束进程
taskkill /im %input% /f
echo 操作执行完成
echo.
goto:verifyprocess

:ntsdmenu
cls
echo.
echo     使用 NTSD 命令结束进程
echo.
echo     请在下方输入要杀死的进程名，并用英文半角双引号将路径引用
echo     不引用会导致结束进程失败或程序崩溃退出
echo     例如："This is sample.exe"、"example.exe"
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在进程名处输入 0 并回车确认
echo.
set /p input=→  请输入进程名：
if "%input%"=="" goto menu
if %input% equ 0 goto menu
echo.
echo 程序识别到的进程名为：%input%
rem 检查ntsd.exe是否被正确释放到appdata路径下
if not exist %appdata%\ntsd.exe (
  echo.
  echo 内核级结束进程功能需要 ntsd.exe 辅助
  echo MDT 程序运行时会释放 ntsd.exe 至 AppData 路径下
  echo 请确保 %appdata% 路径下存在 ntsd.exe 文件
  echo 若不存在可尝试重新运行 MDT 主程序，并检查是否存在安全软件拦截和误删的情况
  echo.
  echo 未检测到 ntsd.exe，跳过相关功能...
  goto:verifyprocess
)
set PROC_NAME=%input%
REM 获取所有同名进程 ID
set PROC_IDS=
for /f "tokens=2 delims=," %%P in ('tasklist /NH /FI "IMAGENAME eq %PROC_NAME%" /FO CSV') do (
    set PROC_IDS=!PROC_IDS! %%P
)
REM 检查是否找到进程
if "%PROC_IDS%" == "" (
    echo 未找到进程 "%PROC_NAME%"
    goto :finkill
)
echo.
echo 尝试使用 NTSD 命令结束进程（内核级）
echo 正在结束所有同名进程 "%PROC_NAME%"...

REM 创建临时批处理文件
set TEMP_BATCH_FILE=%TEMP%\temp_ntsd_kill.bat
echo @echo off > %TEMP_BATCH_FILE%

REM 将每个进程的 ntsd 命令写入临时批处理文件
for %%I in (%PROC_IDS%) do (
    echo %appdata%\ntsd.exe -c q -p %%I >> %TEMP_BATCH_FILE%
)

REM 异步运行临时批处理文件
start /B cmd /C %TEMP_BATCH_FILE%

echo.
echo 操作执行完成
echo.
echo 若提示：终止批处理操作吗(Y/N)?
echo 请直接按回车即可
echo.
echo 在外置命令提示符运行完成后，关闭外置命令提示符窗口
echo 随后请按任意键清理 NTSD 临时文件以进行下一步
pause
REM 删除临时批处理文件
del %TEMP_BATCH_FILE% >nul 2>nul
echo NTSD 临时文件清理完成
goto :verifyprocess

:wmickillmenu
cls
echo.
echo     使用 WMIC 命令结束进程（Windows 11 24H2 之前适用）
echo.
echo     请在下方输入要杀死的进程名，并用英文半角双引号将路径引用
echo     不引用会导致结束进程失败或程序崩溃退出
echo     例如："This is sample.exe"、"example.exe"
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在进程名处输入 0 并回车确认
echo.
set /p input=→  请输入进程名：
if "%input%"=="" goto menu
if %input% equ 0 goto menu
set PROC_NAME=%input%
echo.
echo     程序识别到的进程名为：%input%
echo.
echo     检测 WMIC 是否存在
wmic /? >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	echo     未检测到 WMIC，可能已弃用，操作已取消
	goto:wmickillfinal
)
echo 使用 wmic 命令获取进程信息（WMIC 已于 24H2 弃用，可能执行出错）
wmic process where name='%input%' get processid,executablepath,name
echo 操作执行完成
echo.
echo 尝试使用 wmic 命令结束进程（WMIC 已于 24H2 弃用，可能执行出错）
wmic process where name='%input%' call terminate
wmic process where name='%input%' delete
echo.
:wmickillfinal
echo 操作执行完成
goto:verifyprocess

:cdbkillmenu
cls
echo.
echo     使用 CDB 命令结束进程（内核级）
echo.
echo     请在下方输入要杀死的进程名，并用英文半角双引号将路径引用
echo     不引用会导致结束进程失败或程序崩溃退出
echo     例如："This is sample.exe"、"example.exe"
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在进程名处输入 0 并回车确认
echo.
set /p input=→  请输入进程名：
if "%input%"=="" goto menu
if %input% equ 0 goto menu
echo.
echo 程序识别到的进程名为：%input%
echo.
rem 检查cdb.exe是否被正确释放到appdata路径下
if not exist %appdata%\cdb.exe (
  echo.
  echo 内核级结束进程功能需要 cdb.exe 辅助
  echo MDT 程序运行时会释放 cdb.exe 至 AppData 路径下
  echo 请确保 %appdata% 路径下存在 cdb.exe 文件
  echo 若不存在可尝试重新运行 MDT 主程序，并检查是否存在安全软件拦截和误删的情况
  echo.
  echo 未检测到 cdb.exe，跳过相关功能...
  goto:verifyprocess
)
set PROC_NAME=%input%
REM 获取所有同名进程 ID
set PROC_IDS=
for /f "tokens=2 delims=," %%P in ('tasklist /NH /FI "IMAGENAME eq %PROC_NAME%" /FO CSV') do (
    set PROC_IDS=!PROC_IDS! %%P
)
REM 检查是否找到进程
if "%PROC_IDS%" == "" (
    echo 未找到进程 "%PROC_NAME%"
    goto :finkill
)
echo.
echo 尝试使用 CDB 命令结束进程（内核级）
echo 正在结束所有同名进程 "%PROC_NAME%"...

REM 创建临时批处理文件
set TEMP_BATCH_FILE=%TEMP%\temp_cdb_kill.bat
echo @echo off > %TEMP_BATCH_FILE%

REM 将每个进程的 cdb 命令写入临时批处理文件
for %%I in (%PROC_IDS%) do (
    echo %appdata%\cdb.exe -p %%I -c ".kill;q" >> %TEMP_BATCH_FILE%
)

REM 运行临时批处理文件
call %TEMP_BATCH_FILE%

REM 删除临时批处理文件
del %TEMP_BATCH_FILE%

echo.
echo 操作执行完成
goto :verifyprocess

:verifyprocess
echo.
REM 检查进程是否已结束
rem 设置冷却时间，部分进程存在延迟退出问题
timeout /t 2 /nobreak > NUL

echo 使用 TASKLIST 命令查找目标进程是否结束
tasklist /NH /FI "IMAGENAME eq %PROC_NAME%" | find /I "%PROC_NAME%" > nul
if %errorlevel% equ 0 (
    echo 无法结束进程 "%PROC_NAME%"
) else (
    echo 成功结束进程 "%PROC_NAME%"
)
echo 操作执行完成
echo.
echo 所有操作已执行完成
goto finkill

:finkill
echo.
echo     已尝试结束目标进程
echo.
echo     1. 继续杀死其他特定进程
echo     2. 返回主菜单
echo.
echo     如果未能成功结束目标进程，可更换方式再次尝试
echo.
set /p cinput=→  请输入选项：
if "%cinput%"=="" set cinput=null
if %cinput% equ 1 goto killprocess
if %cinput% equ 2 goto menu
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
cls
goto finkill

:eacuninstall
cls
echo.
echo     EAC 小蓝熊卸载脚本
echo.
echo     此操作将卸载 EasyAntiCheat（小蓝熊）并清除所有数据
echo     包括但不限于 EpicGames、Steam 平台的小蓝熊数据
echo.
set /p eacinput=→  是否继续操作？（Y/n）
if "%eacinput%"=="" goto menu
if %eacinput% equ Y goto deleacdata
if %eacinput% equ y goto deleacdata
if %eacinput% equ N goto menu
if %eacinput% equ n goto menu
echo.
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
echo 权限修改完成，请重新验证游戏完整性（推荐卸载后全新安装）
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
if "%ulinput%"=="" set ulinput=null
if %ulinput% equ 0 goto menu
if %ulinput% equ 1 goto ulbasic
if %ulinput% equ 2 goto uldetail
echo →  输入异常，请检查输入选项
pause
goto userlist

:ulbasic
echo 开始导出用户列表（基础）
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
echo.
powershell.exe Get-LocalUser >%UserDesktopPath%\MDT\Userlist_Basic.log
echo.
echo 导出用户列表（基础）完成，请查看桌面 MDT 文件夹中的 Userlist_Basic.log 文件
start %UserDesktopPath%\MDT\Userlist_Basic.log
echo 路径：%UserDesktopPath%\MDT\Userlist_Basic.log
pause
goto menu

:uldetail
echo 开始导出用户列表（详细）
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
echo.
powershell.exe "Get-LocalUser | Select *" >%UserDesktopPath%\MDT\Userlist_Detail.log
echo.
echo 导出用户列表（详细）完成，请查看桌面 MDT 文件夹中的 Userlist_Detail.log 文件
start %UserDesktopPath%\MDT\Userlist_Detail.log
echo 路径：%UserDesktopPath%\MDT\Userlist_Detail.log
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
if "%wuinput%"=="" goto menu
if %wuinput% equ 0 goto menu
if %wuinput% equ Y goto wudisablestart
if %wuinput% equ y goto wudisablestart
echo.
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
if not exist "%UserDesktopPath%\MDT" md "%UserDesktopPath%\MDT"
takeown /f %UserDesktopPath%\MDT /r /d Y >nul 2>nul
ipconfig /all >%UserDesktopPath%\MDT\Sys_ipconfig_Detail.log
ipconfig >%UserDesktopPath%\MDT\Sys_ipconfig_Basic.log
type %UserDesktopPath%\MDT\Sys_ipconfig_Basic.log
echo 操作执行完成
echo 本机网络连接信息导出完成
echo 请查看桌面 MDT 文件夹中的 Sys_ipconfig_Basic.log 和 Sys_ipconfig_Detail.log 文件
rem start %UserDesktopPath%\MDT\sys_ipconfig.log
echo 路径：%UserDesktopPath%\MDT\Sys_ipconfig_Basic.log
echo 路径：%UserDesktopPath%\MDT\Sys_ipconfig_Detail.log
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
echo     5. 自定义设置（打开系统电源选项设置页面）
echo.
set /p binput=→  请输入选项：
if "%binput%"=="" set binput=null
if %binput% equ 0 goto menu
if %binput% equ 1 goto setlowbattery
if %binput% equ 2 goto setmedbattery
if %binput% equ 3 goto sethighperfbattery
if %binput% equ 4 goto setextremeperfbattery
if %binput% equ 5 goto setcustombattery
echo →  输入异常，请检查输入选项
goto setbatteryoption
:setlowbattery
echo.
echo 正在设置电源选项（部分机型可能无效，例如 Surface）
echo.
echo 设置节能模式
powercfg -setactive a1841308-3541-4fab-bc81-f71556f20b4a
echo.
goto setbatteryfin

:setmedbattery
echo.
echo 正在设置电源选项（部分机型可能无效，例如 Surface）
echo.
echo 设置平衡模式
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
goto setbatteryfin

:sethighperfbattery
echo.
echo 正在设置电源选项（部分机型可能无效，例如 Surface）
echo.
echo 设置高性能模式
powercfg -setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo.
goto setbatteryfin

:setextremeperfbattery
echo.
echo 正在设置电源选项（部分机型可能无效，例如 Surface）
echo.
echo 设置卓越性能模式（仅限于Win10/11专业版以上）
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
goto setbatteryfin

:setcustombattery
echo.
echo 正在打开电源选项设置页面
rundll32.exe shell32.dll,Control_RunDLL powercfg.cpl
echo 操作执行完成
pause
goto setbatteryfin

:setbatteryfin
echo.
echo     电源选项设置完成
echo.
echo     请选择你要继续的操作：
echo     0. 返回主菜单
echo     1. 重新设置计算机使用的电源选项
echo     2. 恢复其他电源选项
echo     3. 未能设置成功电源选项修复（尝试写入不受支持的设置）
echo.
set /p bfinput=→  请输入选项：
if "%bfinput%"=="" set bfinput=null
if %bfinput% equ 0 goto menu
if %bfinput% equ 1 goto setbatteryoption
if %bfinput% equ 2 goto borecmenu
if %bfinput% equ 3 goto bosetfail
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
cls
goto setbatteryfin

:bosetfail
cls
echo.
echo 尝试修复电源选项设置
echo.
reg add HKLM\System\CurrentControlSet\Control\Power /v PlatformAoAcOverride /t REG_DWORD /d 0
echo.
echo 操作执行完成，请重新启动计算机后再次尝试设置电源选项
echo.
set /p choice=你想要现在重启计算机吗？ (y/N) 
if /I "%choice%"=="y" shutdown -r -t 0
if /I "%choice%"=="Y" shutdown -r -t 0
goto menu


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
call:acceleratorCheck
echo 结束代理程序
call:proxyCheck
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
netsh interface ip set dns %networkname1% static 4.2.2.1 primary >nul 2>nul
netsh interface ip add dns %networkname1% 223.5.5.5 >nul 2>nul
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
w32tm /resync /force > NUL
echo.

rem 清理注册表信息
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vkdpi" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ylwfp" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\networktunnel10_x64" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XunYouFilter" /f >nul 2>nul

rem echo 清理系统临时文件（不可清理，会清理自身影响后续功能，建议配合垃圾清理功能）
rem rd /s /q %windir%\temp & md %windir%\temp >nul 2>nul
rem del /f /s /q "%userprofile%\AppData\Local\Temp\*.*" >nul 2>nul
rem del /f /s /q "%userprofile%\Local Settings\Temp\*.*" >nul 2>nul
rem echo.

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
echo 操作执行完成
echo.
echo 设置 IPv4 优先级高于 IPv6
netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 60 4
echo 操作执行完成
echo.
echo 关闭 IPv6 DNS
netsh interface ipv6 delete dnsservers %networkname1% all >nul 2>nul
echo 操作执行完成
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
call:SteamRunningCheck

:startvacfix
echo 开始解决 VAC 屏蔽问题

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
if "%bakpath%"=="" goto menu
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
echo D| xcopy /v /s /e /y /i /c "%UserDesktopPath%" "%bakpath%\UserProfile_Data\Desktop"
echo 用户桌面数据备份完成
echo.
echo 即将开始备份 AppData 数据
echo.
echo AppData 数据较大，多为软件数据游戏存档等，推荐手动备份
echo.
echo 请确保目标备份路径空间充足，避免出现备份失败的问题！
set /p appbak=是否要备份 AppData 数据？（y/N）
if "%appbak%"=="" set appbak=y
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

:timedateset
cls
echo.
echo 正在打开时间和日期设置（经典设置）
rundll32.exe shell32.dll,Control_RunDLL timedate.cpl
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

:flushdnscache
cls
echo.
echo 开始刷新 DNS 缓存
echo.
ipconfig /flushdns
echo.
pause
goto menu

:dnsquery
cls
echo.
echo 开始查询本机设置的 DNS 服务器
echo.
call:dnsserver
echo.
echo 操作执行完成
pause
goto menu

:startdefrag
cls
echo.
echo 正在启动优化驱动器
start dfrgui
echo 操作执行完成
pause
goto menu

:pingtoolmenu
cls
echo.
echo     网络 Ping 工具菜单
echo.
echo     0. 返回主菜单
echo     1. 进入基础 Ping 工具
echo     2. 进入高级自定义 Ping 工具
echo.
set /p netinput=→  请选择项目：
if "%netinput%"=="" set netinput=null
if %netinput% equ 0 goto menu
if %netinput% equ 1 goto pingtool1
if %netinput% equ 2 goto pingtool2
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto pingtoolmenu

:pingtool1
cls
echo.
echo     基础 Ping 工具
echo.
echo     请输入你要测试的域名或者 IP 地址
echo     若想返回主菜单，请输入 0 并回车确认
echo.
set /p userping=→  请输入域名或 IP：
if "%userping%"=="" goto pingtoolmenu
if %userping% equ 0 goto pingtoolmenu
echo.
echo 识别到的域名或 IP 为：%userping%
echo.
echo 即将向 %userping% 发送 32 字节的 Ping 包，共计 4 次：
echo.
ping %userping%
echo.
echo 操作执行完成
pause
goto pingtoolmenu

:pingtool2
cls
echo.
echo     高级自定义 Ping 工具
echo.
echo     请输入你要测试的域名或者 IP 地址
echo     若想返回主菜单，请在“请输入域名或 IP”处输入 0 并回车确认
echo     若想无限次 Ping 请在“请设置你要 Ping 的次数“处输入 0 并回车确认
echo.
set /p userping=→  请输入域名或 IP：
if "%userping%"=="" goto pingtoolmenu
if %userping% equ 0 goto pingtoolmenu
set /p pingcount=→  请设置你要 Ping 的次数：
if "%pingcount%"=="" goto pinginfinite
if %pingcount% equ 0 goto pinginfinite
set /p pingpack=→  请输入包大小（单位：字节，默认大小为 32 字节）：
if "%pingpack%"=="" set pingpack=32
echo.
echo 识别到的域名或 IP 为：%userping%
echo 识别到的 Ping 次数为：%pingcount% 次
echo 识别到的包大小为：%pingpack% Byte
echo.
echo 即将向 %userping% 发送 %pingpack% 字节的 Ping 包，共计 %pingcount% 次：
echo.
ping %userping% -n %pingcount% -l %pingpack%
echo.
echo 操作执行完成
pause
goto pingtoolmenu

:pinginfinite
set /p pingpack=→  请输入包大小（单位：字节，默认大小为 32 字节）：
if "%pingpack%"=="" set pingpack=32
echo.
echo 识别到的域名或 IP 为：%userping%
echo 识别到的包大小为：%pingpack% Byte
echo.
echo 即将向 %userping% 发送 %pingpack% 字节的 Ping 包
echo 若要取消 Ping 的过程，请手动按键盘上的“Ctrl + C”
echo.
ping %userping% -l %pingpack% -t
echo.
echo 操作执行完成
pause
goto pingtoolmenu

:getsysteminfo
cls
echo.
echo 生成详细系统信息报告
echo.
systeminfo >%UserDesktopPath%\MDT\System_Info.txt
call:getvgainfosilent
call:getdiskinfosilent
echo 显卡详细信息: >>%UserDesktopPath%\MDT\System_Info.txt
type %temp%\vgainfo_trim.txt >>%UserDesktopPath%\MDT\System_Info.txt
echo 磁盘信息: >>%UserDesktopPath%\MDT\System_Info.txt
type %temp%\diskinfo_trim.txt >>%UserDesktopPath%\MDT\System_Info.txt
del /s /q %temp%\vgainfo_trim.txt >nul
del /s /q %temp%\diskinfo_trim.txt >nul
echo 已保存系统详细信息，路径：%UserDesktopPath%\MDT\System_Info.txt
echo →  请按任意键回到主菜单
pause
goto menu

:getvgainfosilent
rem 显卡 GPU 详细信息:
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_VideoController | Select-Object -ExpandProperty Name"`) DO (
    echo     %%i
) > "%temp%\vgainfo_trim.txt"
goto:eof

:getdiskinfosilent
rem 磁盘信息:
FOR /F "usebackq delims=" %%i IN (`powershell -Command "Get-CimInstance -ClassName Win32_DiskDrive | Select-Object -Property Model"`) DO (
    echo     %%i
) > "%temp%\diskinfo_trim.txt"
goto:eof

rem 旧版:getvgainfosilent
::rem 显卡 GPU 详细信息:
::wmic path Win32_VideoController get AdapterRAM^,Name /value |findstr Name >%temp%\vgainfo.txt

::set fn=%temp%\vgainfo.txt
::(for /f "usebackq delims=" %%i in ("%fn%")do (
::	rem 输出读取到的单行字符串到控制台（con）
::	echo %%i>con  >nul
::	set h=%%i
	
::	rem 输出单行字符串去除前5个字符的数据，并在前面加4个空格调整格式
::	echo     !h:~5!
::	rem 结束延迟环境变量扩展
::	rem endlocal
::))>%temp%\vgainfo_trim.txt

::del /s /q %temp%\vgainfo.txt >nul
::rem del /s /q %temp%\vgainfo_trim.txt >nul
::goto:eof

rem 旧版:getdiskinfosilent
::rem 磁盘信息:
::wmic DISKDRIVE get model /value |findstr Model >%temp%\diskinfo.txt

::set fn=%temp%\diskinfo.txt
::rem for循环读取文本，使用usebackq可以使文本文件名包含空格等字符
::(for /f "usebackq delims=" %%i in ("%fn%")do (
::	rem 输出读取到的单行字符串到控制台（con）
::	echo %%i>con  >nul
::	set h=%%i
	
::	rem 输出单行字符串去除前6个字符的数据，并在前面加4个空格调整格式
::	echo     !h:~6!
::	rem 结束延迟环境变量扩展
::	rem endlocal
::))>%temp%\diskinfo_trim.txt

::del /s /q %temp%\diskinfo.txt >nul
rem del /s /q %temp%\diskinfo_trim.txt >nul
::goto:eof



:qqmusicimgfix
cls
echo.
echo 开始修复 QQ 音乐歌曲专辑图片无法正常显示问题
echo.
%systemroot%\system32\tasklist /fi "IMAGENAME eq qqmusic.exe" |findstr /i qqmusic.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
  echo 已找到 QQ 音乐进程
  taskkill /im qqmusic.exe /f >nul 2>nul
  echo 已结束 QQ 音乐进程
) else (
	echo. >nul >nul
)
:startfixqqmusic
echo.
echo 定位 QQ 音乐临时缓存路径
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_USERS\.DEFAULT\Software\Tencent\QQMusic\LogConfig" ^| find /i "CACHEPATH"') do set "QQMusicCachePath=%%k" 
echo 识别到 QQ 音乐临时缓存路径为："%QQMusicCachePath%"
echo.
echo 清理 QQ 音乐缓存
rd /s /q "%QQMusicCachePath%" >nul 2>nul
if not exist "%QQMusicCachePath%" md "%QQMusicCachePath%" >nul 2>nul
echo 清理缓存完成
echo.
echo 清空 IE 代理设置
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f
echo.
echo 修复 DNS 设置
echo.
echo 设置新的 DNS 地址
call:dnssetting 119.29.29.29 223.5.5.5
echo.
echo 关闭 IPv6 DNS
netsh interface ipv6 delete dnsservers %networkname1% all >nul 2>nul
echo.
echo 已修复 DNS 设置
echo.
echo 操作执行完成，请重新打开 QQ 音乐
echo 若仍存在异常，建议重新安装 QQ 音乐或更换网络环境后重试
pause
goto menu

:mousesetup
cls
echo.
echo 正在打开鼠标属性
start control main.cpl
echo 操作执行完成
pause
goto menu

rem MDT 程序退出
:exitprogramstart
cls
echo.
set /p dellog=→  在离开之前，是否要删除 MDT 程序生成的所有日志文件？（y/N）
if "%dellog%"=="" goto exitprogram
if %dellog% equ y goto mdtlogdel
if %dellog% equ Y goto mdtlogdel
echo.
goto exitprogram

:mdtlogdel
echo.
echo     正在删除 MDT 程序生成的日志文件
rd /s /q %UserDesktopPath%\MDT
echo     已删除所有 MDT 程序生成的日志文件
timeout /t 1 /nobreak > NUL
:exitprogram
cls
del /s /q %appdata%\cdb.exe >nul 2>nul
del /s /q %appdata%\ntsd.exe >nul 2>nul
del /s /q %appdata%\mtee.exe >nul 2>nul
del /s /q %appdata%\PsExec.exe >nul 2>nul
echo.
echo     感谢使用多合一系统诊断修复工具，希望它能帮到你！
echo.
timeout /t 1 /nobreak > NUL
exit

:kookfix
cls
echo.
echo 开始修复 KOOK 语音异常问题
echo.
%systemroot%\system32\tasklist /fi "IMAGENAME eq kook.exe" |findstr /i kook.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
  echo 已找到 KOOK 进程
  taskkill /im kook.exe /f >nul 2>nul
  echo 已结束 KOOK 进程
) else (
	echo. >nul >nul
)
call:dnssetting 119.29.29.29 223.5.5.5
echo.
call:brutereset
echo.
netsh winsock reset
echo.
echo 操作执行完成，请重新打开 KOOK 语音
pause
goto menu

:steamconnectfix
cls
echo.
echo 开始修复 Steam 无法连接至 Steam 网络、连接超时、无网络连接问题
echo.
echo     请选择一个修复选项：
echo.
echo     1. 快速修复：适用于大多数情况
echo     2. 完全修复：常规状态下解决不了，或者专业用户使用
echo.
set /p fixinput=→  请输入选项：
if "%fixinput%"=="" set fixinput=null
if %fixinput% equ 1 goto steamconnectfastfix
if %fixinput% equ 2 goto steamconnectall
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto steamconnectfix

:steamconnectall
call:SteamRunningCheck
echo.
call:acceleratorCheck
call:proxyCheck
echo.
echo 前置修复：重置 LSP
netsh winsock reset >nul 2>nul
echo.
echo 更换 DNS 设置
echo.
call:dnssetting 119.29.29.29 223.5.5.5
echo 操作执行完成
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

echo 重置 Hosts 文件权限并清空
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
call:host1fix
echo 操作执行完成
echo.
rem 停止并删除驱动服务
set drivername=vkdpi xunyoufilter xunyounpf QeeYouPacket npf uuwfp uupacket networktunnel10_x64 ylwfp TP2CNNetFilter lgdcatcher lgdcatchertdi xfilter savitar netrtp
for %%i in (%drivername%) do (
sc stop %%i >nul 2>nul
sc config %%i start= DISABLED >nul 2>nul
sc delete %%i >nul 2>nul
)
echo.
:steamfirewallfixmenu
echo 即将进行 Windows 防火墙修复
echo.
echo     请选择一个修复选项
echo.
echo     1. 关闭 Windows 防火墙（如果你真的啥都不懂，那就关了算了）
echo     2. 重置 Windows 防火墙（普通用户选这个重置一下，重新允许 Steam 通过防火墙）
echo     3. 跳过修复（根据环境判断当前不需要修防火墙就选我）
echo.
set /p userfirewall=→  请输入选项：
if "%userfirewall%"=="" set userfirewall=null
if %userfirewall% equ 1 goto steamfirewalloff
if %userfirewall% equ 2 goto steamfirewallreset
if %userfirewall% equ 3 goto steamfirewallskip
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
goto steamfirewallfixmenu

:steamfirewalloff
echo.
netsh advfirewall reset >NUL 2>nul
netsh advfirewall set allprofiles state off >nul 2>nul
echo 已关闭 Windows 防火墙
goto steamportfixmenu

:steamfirewallreset
echo.
netsh advfirewall reset >NUL 2>nul
netsh advfirewall set allprofiles state off >nul 2>nul
netsh advfirewall reset >NUL 2>nul
netsh advfirewall set allprofiles state on >nul 2>nul
echo 已重置 Windows 防火墙
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\SOFTWARE\Valve\Steam" ^| find /i "SteamPath"') do set "SteamPath=%%k" 
echo 识别到 Steam 的安装路径为 %SteamPath%
echo.
echo 允许 Steam 通过防火墙
netsh advfirewall firewall add rule name="Steam" dir=in action=allow program="%SteamPath%\Steam.exe" enable=yes
echo 操作执行完成
echo.
goto steamportfixmenu

:steamfirewallskip
echo.
echo 已跳过 Windows 防火墙修复
echo.
goto steamportfixmenu

:steamportfixmenu
echo 即将开始 Steam 端口修复
echo.
echo     请选择一个修复选项
echo.
echo     1. 不修复 Steam 端口（对于大多数情况，无需修复 Steam 端口）
echo     2. 修复 Steam 端口（推荐先重装 Steam，不到万不得已不使用此选项）
echo     修复 Steam 端口也许可以解决部分端口冲突问题，但是可能会造成部分软件异常！
echo     建议手动排查端口问题，请谨慎使用此修复功能。（无法保障修复效果）
echo.
set /p portfix=→  请输入选项：
if "%portfix%"=="" set portfix=null
if %portfix% equ 1 goto steamportskip
if %portfix% equ 2 goto steamportfix
echo →  输入异常，请检查输入选项
timeout /t 2 /nobreak > NUL
cls
goto steamportfixmenu

:steamportskip
echo.
echo 已跳过 Steam 端口修复
echo.
goto steamfixcontinue

:steamportfix
echo 开通 Steam 登录和下载内容所需端口
netsh advfirewall firewall add rule name="Port 443 HTTPS" protocol=TCP dir=in localport=443 action=allow
netsh advfirewall firewall add rule name="Port 80 HTTP" protocol=TCP dir=in localport=80 action=allow
netsh advfirewall firewall add rule name="Steam Remote UDP" dir=in action=allow protocol=UDP localport=27015-27050
netsh advfirewall firewall add rule name="Steam Remote TCP" dir=in action=allow protocol=TCP localport=27015-27050
echo 操作执行完成
echo.
echo 开通 Steam 客户端所需端口
netsh advfirewall firewall add rule name="Steam Game Data Traffic Port" protocol=UDP dir=in localport=27000-27100 action=allow
netsh advfirewall firewall add rule name="Steam Link Remote Play UDP" protocol=UDP dir=in localport=27031-27036 action=allow
netsh advfirewall firewall add rule name="Steam Link Remote Play TCP" dir=in action=allow protocol=UDP localport=27036
netsh advfirewall firewall add rule name="Steam Client Remote UDP" dir=in action=allow protocol=UDP localport=4380
echo 操作执行完成
echo.
echo 开通 Steam 专用或侦听服务器所需端口
netsh advfirewall firewall add rule name="Steam SRCDS Rcon Port" dir=in action=allow protocol=TCP localport=27015
netsh advfirewall firewall add rule name="Steam Game Data Traffic Listening Port" dir=in action=allow protocol=UDP localport=27015
echo 操作执行完成
echo.
echo 开通 Steamworks 对等网络及 Steam 语音聊天所需端口
netsh advfirewall firewall add rule name="Steamworks UDP 1" dir=in action=allow protocol=UDP localport=3478
netsh advfirewall firewall add rule name="Steamworks UDP 2" dir=in action=allow protocol=UDP localport=4379
netsh advfirewall firewall add rule name="Steamworks UDP 3" dir=in action=allow protocol=UDP localport=4380
netsh advfirewall firewall add rule name="Steamworks UDP 4" dir=in action=allow protocol=UDP localport=27014-27030
echo 操作执行完成
echo.
echo Steam 端口修复完成
goto steamfixcontinue

:steamfixcontinue
echo.
echo 本地代理修复
call:ieproxy
echo.
echo 刷新 DNS/ARP 缓存
ipconfig /flushdns >nul 2>nul
arp -d >nul 2>nul
echo.

echo 正在同步网络时间...
call:systemtimereset
echo.
echo 操作执行完成
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
echo LSP 修复
netsh winsock reset
netsh winsock reset
netsh winsock reset
echo.
echo 操作执行完成
echo.
echo 清理 Steam 崩溃日志
del /f /q %SteamPath%\dumps\*.dmp >nul 2>nul
echo 操作执行完成
echo.
echo 是否删除 Steam 目录下的 Package 文件夹？
echo 此操作会导致 Steam 重新下载更新文件，但是可以解决因为更新异常导致的 Steam 连接失败问题
echo 有时删除此文件夹重新下载更新可以解决问题
echo.
set /p delpack=→  是否删除 Package 文件夹？（y/N）
if "%delpack%"=="" set delpack=y
if %delpack% equ y goto steamdelpack
if %delpack% equ Y goto steamdelpack
if %delpack% equ n goto steamconnectfinal
if %delpack% equ N goto steamconnectfinal
goto steamconnectfinal

:steamdelpack
echo.
echo 开始删除 Package 文件夹
rd /s /q %SteamPath%\package >nul 2>nul
echo 已删除 Package 文件夹，Steam 在下次启动时会要求更新，请保持网络畅通！
echo.
goto steamconnectfinal

:steamconnectfinal
echo 创建 Steam TCP 方式启动快捷方式
set "SrcFile=%SteamPath%\Steam.exe"
set "Args=-TCP"
set "LnkFile=Steam_TCP.LNK"
call :CreateShort "%SrcFile%" "%Args%" "%LnkFile%"
echo.
echo 已于用户桌面创建 Steam TCP 方式启动快捷方式（Steam_TCP.lnk）
echo 登录异常可以尝试使用此快捷方式登录 Steam
echo.
echo 所有操作已执行完成，请重新打开 Steam 尝试连接
echo.
echo 如果仍然存在异常，可能存在地区/特殊网络限制，请自行寻找加速器或特殊网络工具
echo 可以尝试其他不同选项进行修复（端口修复除外，不到万不得已不使用）
echo 也可尝试使用手机热点等方式登录 Steam
echo.
echo 推荐重新启动计算机以完成修复
echo.
pause
goto menu



::创建exe文件的lnk快捷方式

rem 此处为创建快捷方式的方法代码，随时调用
rem set "SrcFile=%SteamPath%\Steam.exe"
rem set "Args=-TCP"
rem set "LnkFile=Steam_TCP.LNK"
rem call :CreateShort "%SrcFile%" "%Args%" "%LnkFile%"
rem echo 创建快捷方式完成
rem goto :eof

::Arguments              目标程序参数
::Description            快捷方式备注
::FullName               返回快捷方式完整路径
::Hotkey                 快捷方式快捷键
::IconLocation           快捷方式图标，不设则使用默认图标
::TargetPath             目标
::WindowStyle            窗口启动状态
::WorkingDirectory       起始位置

:CreateShort
mshta VBScript:Execute("Set a=CreateObject(""WScript.Shell""):Set b=a.CreateShortcut(a.SpecialFolders(""DeskTop"") & ""\%~3""):b.TargetPath=""%~1"":b.WorkingDirectory=""%~dp1"":b.Arguments=""%~2"":b.Save:close")
:eof

:SteamRunningCheck
echo 正在检测 Steam 是否开启......
%systemroot%\system32\tasklist /fi "IMAGENAME eq Steam.exe" |findstr /i Steam.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
  echo.
  echo 已找到 Steam 进程
  echo.
  taskkill /im Steam.exe /f >nul 2>nul
  echo.
  echo 已结束 Steam 进程
  echo.
) else (
  echo.
	echo Steam 未开启
  echo.
)

echo 正在检测 Steam 国服启动器是否开启......
%systemroot%\system32\tasklist /fi "IMAGENAME eq Steamchina.exe" |findstr /i Steamchina.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
  echo.
  echo 已找到 Steam 国服启动器进程
  echo.
  taskkill /im Steamchina.exe /f >nul 2>nul
  echo.
  echo 已结束 Steam 国服启动器进程
  echo.
) else (
  echo.
	echo Steam 国服启动器未开启
  echo.
)
goto :eof

:acceleratorCheck
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
goto :eof

:proxyCheck
taskkill /im v2rayN.exe /F >nul 2>nul
taskkill /im "Clash for Windows.exe" /F >nul 2>nul
taskkill /im proxy.exe /F >nul 2>nul
taskkill /im v2ray.exe /F >nul 2>nul
taskkill /im wv2ray.exe /F >nul 2>nul
taskkill /im v2ray_privoxy.exe /F >nul 2>nul
taskkill /im sysproxy.exe /F >nul 2>nul
goto :eof

rem Steam 网络异常快速修复
:steamconnectfastfix
echo.
call:SteamRunningCheck
echo.
call:acceleratorCheck
call:proxyCheck
echo.
echo 前置修复：重置 LSP
netsh winsock reset >nul 2>nul
echo.
echo 更换 DNS 设置
echo.
call:dnssetting 119.29.29.29 223.5.5.5
echo 操作执行完成
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

echo 重置 Hosts 文件权限并清空
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
call:host1fix
echo 操作执行完成
echo.
rem 停止并删除驱动服务
set drivername=vkdpi xunyoufilter xunyounpf QeeYouPacket npf uuwfp uupacket networktunnel10_x64 ylwfp TP2CNNetFilter lgdcatcher lgdcatchertdi xfilter savitar netrtp
for %%i in (%drivername%) do (
sc stop %%i >nul 2>nul
sc config %%i start= DISABLED >nul 2>nul
sc delete %%i >nul 2>nul
)
echo.
echo.
echo 本地代理修复
call:ieproxy
echo.
echo 刷新 DNS/ARP 缓存
ipconfig /flushdns >nul 2>nul
arp -d >nul 2>nul
echo.

echo 正在同步网络时间...
call:systemtimereset
echo.
echo 操作执行完成
rem 清理注册表信息
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vkdpi" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ylwfp" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\networktunnel10_x64" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XunYouFilter" /f >nul 2>nul
echo.
echo LSP 修复
netsh winsock reset
netsh winsock reset
netsh winsock reset
echo.
echo 操作执行完成
echo.
echo 清理 Steam 崩溃日志
del /f /q %SteamPath%\dumps\*.dmp >nul 2>nul
echo 操作执行完成
echo.
goto steamconnectfinal

:wsclsafix
cls
echo.
echo 开始修复 Windows 安全中心本地安全机构保护设置异常问题
echo.
echo 更新注册表信息
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPL" /t REG_DWORD /d 2 /f >nul 2>nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v "RunAsPPLBoot" /t REG_DWORD /d 2 /f >nul 2>nul
echo.
echo 操作执行完成
echo.
echo 所有操作已执行完成，请重启计算机完成修复
pause
goto menu

:desktopmkfileerr
cls
echo.
echo 即将开始修复桌面创建文件权限不足问题
echo.
echo 请按任意键开始修复
pause
echo 获取用户桌面路径
echo.
echo 执行注册表查询操作
echo.
rem 程序运行之初已做查询，可省略，为保证成功，再次做查询
for /f "tokens=1,2,* " %%i in ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" ^| find /i "Desktop"') do set "UserDesktopPath=%%k" 
echo 识别到当前用户的桌面路径为：
echo "%UserDesktopPath%"
echo 操作执行完成
echo.
echo 更新文件夹权限信息
icacls "%UserDesktopPath%" /grant Everyone:F
takeown /f "%UserDesktopPath%"
echo y| cacls.exe "%UserDesktopPath%" /t /p /c Everyone:F >nul 2>nul
echo 操作执行完成
echo.
echo 重启资源管理器
taskkill /im explorer.exe /F
start explorer.exe
echo 操作执行完成
echo.
echo 所有操作已执行完成
echo 请重新尝试新建文件操作，观察是否存在权限不足问题
echo.
echo 修复完成
pause
goto menu

:sendtoduplicate
cls
echo.
echo 识别到当前用户的发送到...文件夹路径为：
echo "%UserSendToPath%"
echo.
echo 即将打开“发送到...”文件夹，请在打开的文件夹内删除多余的项目
echo 支持自定义快捷方式放入此文件夹，后续可在右键菜单“发送到...”项目中快捷操作
timeout /t 1 /nobreak > NUL
explorer.exe "%UserSendToPath%"
echo.
echo 操作执行完成
echo 修复完成
pause
goto menu

:openstartup
cls
echo.
echo 识别到当前用户的启动文件夹路径为：
echo "%UserStartupPath%"
echo 正在打开启动文件夹（开机时会自动运行此文件夹内的文件/快捷方式）
explorer.exe "%UserStartupPath%"
echo.
echo 操作执行完成
pause
goto menu

:zipPreviewOff
cls
echo.
echo 禁用 ZIP 压缩包文件索引与预览，降低资源管理器占用
echo.
echo 方法如下：
echo.
echo 第一步：
echo 在开启的注册表编辑器的地址栏输入并定位以下路径：（已自动复制到剪贴板直接粘贴即可）
echo.
echo HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder
echo HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder| clip
echo.
echo 第二步：
echo 右键左边侧边栏定位的 ShellFolder 文件夹，点击“权限”，再点击“高级”
echo 顶部所有者处右侧点击“更改”，在弹出的“选择用户和组”弹窗中点击“高级”
echo 点击“立即查找”，在底部找到自己当前的用户并双击，然后点击“确定”
echo 勾选“替换子容器和对象所有者”，完成所有者更改
echo.
echo 第三步：
echo 点击“添加”按钮
echo 点击“选择主体”，在弹出的“选择用户和组”弹窗中点击“高级”
echo 点击“立即查找”，在底部找到自己当前的用户并双击，然后点击“确定”
echo 勾选“完全控制”，点击确定，后续均点击确定关闭所有对话框
echo.
echo 第四步：
echo 在注册表编辑器的右边找到“Attributes”键值，右键修改
echo 将数值数据修改为 0 ，点击确定（默认值：200001a0）
echo.
echo 第五步：
echo （若要恢复权限，使用相同方法将所有者改为 SYSTEM 并删除当前用户权限即可）
echo （恢复权限务必同样勾选“替换子容器和对象所有者”）
echo 关闭注册表编辑器，重启计算机，完成更改
echo.
regedit.exe
echo 操作执行完成


rem echo @echo off >%temp%\zipPreviewOn.bat
rem echo echo.>>%temp%\zipPreviewOn.bat
rem echo reg add "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder" /v "Attributes" /t REG_DWORD /d 0 /f >>%temp%\zipPreviewOn.bat
rem echo reg add "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder" /v "DisableContextualTabset" /d "" /f >>%temp%\zipPreviewOn.bat
rem echo reg add "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder" /v "UseDropHandler" /d "" /f >>%temp%\zipPreviewOn.bat
rem echo echo.>>%temp%\zipPreviewOn.bat
rem %appdata%\psexec.exe -i -s %temp%\zipPreviewOn.bat
rem echo.
rem echo 操作执行完成
rem echo 已成功禁用 ZIP 压缩包文件索引与预览

pause
goto menu

:zipPreviewOn
cls
echo.
echo 恢复 ZIP 压缩包文件索引与预览，恢复默认值
echo.
echo 方法如下：
echo.
echo 第一步：
echo 在开启的注册表编辑器的地址栏输入并定位以下路径：（已自动复制到剪贴板直接粘贴即可）
echo.
echo HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder
echo HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder| clip
echo.
echo 第二步：
echo 右键左边侧边栏定位的 ShellFolder 文件夹，点击“权限”，再点击“高级”
echo 顶部所有者处右侧点击“更改”，在弹出的“选择用户和组”弹窗中点击“高级”
echo 点击“立即查找”，在底部找到自己当前的用户并双击，然后点击“确定”
echo 勾选“替换子容器和对象所有者”，完成所有者更改
echo.
echo 第三步：
echo 点击“添加”按钮
echo 点击“选择主体”，在弹出的“选择用户和组”弹窗中点击“高级”
echo 点击“立即查找”，在底部找到自己当前的用户并双击，然后点击“确定”
echo 勾选“完全控制”，点击确定，后续均点击确定关闭所有对话框
echo.
echo 第四步：
echo 在注册表编辑器的右边找到“Attributes”键值，右键修改
echo 将数值数据修改为 200001a0 ，点击确定（默认值：200001a0）
echo.
echo 第五步：
echo （若要恢复权限，使用相同方法将所有者改为 SYSTEM 并删除当前用户权限即可）
echo （恢复权限务必同样勾选“替换子容器和对象所有者”）
echo 关闭注册表编辑器，重启计算机，完成更改
echo.
regedit.exe
echo 操作执行完成
rem echo 还原 ZIP 压缩包文件索引与预览，恢复默认值
rem echo.
rem echo @echo off >%temp%\zipPreviewOn.bat
rem echo echo.>>%temp%\zipPreviewOn.bat
rem echo reg add "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder" /v "Attributes" /t REG_DWORD /d 536871328 /f >>%temp%\zipPreviewOn.bat
rem echo reg add "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder" /v "DisableContextualTabset" /d "" /f >>%temp%\zipPreviewOn.bat
rem echo reg add "HKCR\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}\ShellFolder" /v "UseDropHandler" /d "" /f >>%temp%\zipPreviewOn.bat
rem echo echo.>>%temp%\zipPreviewOn.bat
rem %appdata%\psexec.exe -i -s %temp%\zipPreviewOn.bat
rem echo.
rem echo 操作执行完成
rem echo 已成功恢复 ZIP 压缩包文件索引与预览

pause
goto menu

:tiebaerror
cls
echo 修复百度贴吧等网站访问不了，其他网站正常的问题
echo.
echo 此操作将关闭 IPv6 网络，请确认操作
pause
echo 开始修复
netsh interface ipv6 set interface %networkname1% state=disable
netsh interface ipv6 set privacy state=disable
netsh int ipv4 reset >nul 2>nul
netsh int ipv6 reset >nul 2>nul
netsh winsock reset
ipconfig /flushdns
echo 操作执行完成
echo 完成修复，请重启计算机
pause
goto menu

:ipv46setmenu
cls
echo.
echo     IPv4/IPv6 设置菜单
echo.
echo     0. 返回主菜单
echo     1. 安装 IPv4 协议
echo     2. 卸载 IPv4 协议
echo     3. 开启 IPv6 设置
echo     4. 关闭 IPv6 设置
echo     5. 设置 IPv4 优先级高于 IPv6（推荐）
echo     6. 设置 IPv6 优先级高于 IPv4（默认）
echo     7. 清除 IPv4 DNS
echo     8. 清除 IPv6 DNS（可解决部分上网异常）
echo.
set /p ipv46input=→  请选择项目：
if "%ipv46input%"=="" set ipv46input=null
if %ipv46input% equ 0 goto menu
if %ipv46input% equ 1 goto ipv4on
if %ipv46input% equ 2 goto ipv4off
if %ipv46input% equ 3 goto ipv6on
if %ipv46input% equ 4 goto ipv6off
if %ipv46input% equ 5 goto ipv4prior
if %ipv46input% equ 6 goto ipv6prior
if %ipv46input% equ 7 goto ipv4dnsdel
if %ipv46input% equ 8 goto ipv6dnsdel
echo →  输入异常，请检查输入选项
pause
goto ipv46setmenu


:ipv4on
cls
echo 安装 IPv4 协议
echo.
echo 请勾选对应网络的 IPv4 协议
netsh int ipv4 install >nul 2>nul
netsh int ipv4 reset >nul 2>nul
netsh winsock reset
ipconfig /flushdns
control netconnections
echo 所有操作已执行完成
pause
goto menu

:ipv4off
cls
echo 卸载 IPv4 协议
echo.
echo 此操作会导致不能上网！请确认需求后继续操作！
echo 如误触请关闭程序
pause
echo 请取消勾选对应网络的 IPv4 协议
echo.
netsh int IPv4 uninstall >nul 2>nul
netsh int ipv4 reset >nul 2>nul
netsh winsock reset
ipconfig /flushdns
control netconnections
echo 所有操作已执行完成
pause
goto menu

:ipv6on
cls
echo 开启 IPv6 设置
echo.
echo 请勾选对应网络的 IPv6 协议
echo.
echo 安装 IPv6 协议
netsh int ipv6 install >nul 2>nul
echo.
echo 重置系统 IPv6 设置
netsh int ipv6 reset >nul 2>nul
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

netsh int 6to4 set state default >nul 2>nul
netsh int isatap set state default >nul 2>nul
netsh int teredo set state server=teredo.remlab.net >nul 2>nul
netsh int ipv6 set teredo enterpriseclient >nul 2>nul
netsh int ipv6 set prefix 2002::/16 30 1 >nul 2>nul
netsh int ipv6 set prefix 2001::/32 5 1 >nul 2>nul
Reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Dnscache\Parameters /v AddrConfigControl /t REG_DWORD /d 0 /f >nul 2>nul
ipconfig /flushdns
rem netsh int ipv6 show teredo
rem netsh int ipv6 show route
rem netsh int ipv6 show int
rem netsh int ipv6 show prefix
rem netsh int ipv6 show address
rem route print

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

netsh int ipv6 reset >nul 2>nul
netsh winsock reset
ipconfig /flushdns
control netconnections
echo 所有操作已执行完成
pause
goto menu


:ipv6off
cls
echo 关闭 IPv6 设置
echo 请取消勾选对应网络的 IPv6 协议
echo.
netsh int ipv6 reset >nul 2>nul
echo.
echo 关闭 IPv6 通道
netsh interface teredo set state disable >nul 2>nul
netsh interface 6to4 set state disabled >nul 2>nul
netsh interface isatap set state disabled >nul 2>nul
echo.
echo 卸载 IPv6 协议
netsh int ipv6 uninstall >nul 2>nul
rem netsh interface IPV6 set global randomizeidentifier=disable
rem netsh interface IPV6 set privacy state=disable
rem netsh interface ipv6 6to4 set state state=disable
rem netsh interface ipv6 isatap set state state=disable
rem netsh interface ipv6 set teredo=disable
netsh winsock reset
ipconfig /flushdns

control netconnections

echo 所有操作已执行完成
pause
goto menu

:ipv4prior
cls
echo.
echo 设置 IPv4 优先级高于 IPv6
netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 60 4
echo 操作执行完成
echo.
pause
goto menu

:ipv6prior
cls
echo.
echo 设置 IPv6 优先级高于 IPv4
netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 35 4
echo 操作执行完成
echo.
pause
goto menu

:ipv4dnsdel
cls
echo.
echo 清除 IPv4 DNS
netsh interface ipv4 delete dnsservers %networkname1% all >nul 2>nul
echo 已清除 IPv4 DNS，请按需重新设置 DNS
echo.
echo 操作执行完成
pause
goto menu

:ipv6dnsdel
cls
echo.
echo 清除 IPv6 DNS
netsh interface ipv6 delete dnsservers %networkname1% all >nul 2>nul
echo 已清除 IPv6 DNS，请按需重新设置 DNS
echo.
echo 操作执行完成
pause
goto menu


:runassystem
cls
echo.
echo     以 SYSTEM 身份运行程序/脚本（管理员权限）
echo.
echo     请在下方输入要运行的文件路径
echo.
echo     首次使用此功能请点击弹窗的“Agree”
echo     若路径含空格，请用英文半角双引号将路径引用
echo     不引用会导致程序崩溃退出
echo     例如："C:\Test Path\example.exe"
echo     可以右键文件或文件夹，选择“复制文件地址”，再在此处粘贴
echo     或者选中文件或文件夹，按下“Ctrl + Shift + C”快捷键获取地址，再在此处粘贴
echo     不兼容环境变量输入，可能会导致空输出
echo.
echo     若要返回主菜单请在文件路径处输入 0 并回车确认

set /p input=→  请输入文件路径：
if "%input%"=="" goto menu
if %input% equ 0 goto menu

echo 程序识别到的文件路径为：%input%
%appdata%\psexec -i -d -s %input%
echo 操作执行完成
pause
goto menu

:ludashihpfix
echo.
echo 正在检测鲁大师是否开启......
%systemroot%\system32\tasklist /fi "IMAGENAME eq ludashi.exe" |findstr /i ludashi.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
  echo.
  echo 找到鲁大师进程，请关闭鲁大师以继续进行主页修复！
  timeout /t 1 /nobreak > NUL
  pause
  goto menu
  echo.
) else (
  echo.
	echo 鲁大师未启动，继续修复
  reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "about:start" /f
  reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Default_Page_URL" /d "https://www.msn.cn/zh-cn" /f
  reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Search Page" /d "http://go.microsoft.com/fwlink/?LinkId=54896" /f
  reg add "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /d "http://go.microsoft.com/fwlink/?LinkId=625115" /f
  rem reg delete "HKCU\Software\Microsoft\Internet Explorer\EUPP" /f >nul 2>nul
  echo.
  echo 修复完成
  pause
  goto menu
  echo.
)

:WinFocusbg
echo.
echo %USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets |clip
echo Windows 聚焦壁纸缓存路径已复制到剪贴板
echo.
echo 开始获取缓存的 Windows 聚焦壁纸
echo D| xcopy /v /s /e /y /i /c "%USERPROFILE%\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets" "%UserDesktopPath%\MDT\WindowsFocusBG"
ren "%UserDesktopPath%\MDT\WindowsFocusBG\*.*" *.jpg
echo.
echo 已获取缓存的 Windows 聚焦壁纸
echo 保存路径为：%UserDesktopPath%\MDT\WindowsFocusBG
start %UserDesktopPath%\MDT\WindowsFocusBG
echo.
echo 操作执行完成
pause
goto menu

:Newtxtfix
echo.
echo 开始修复鼠标右键-新建 里面没有“文本文档”的问题
echo.
echo 此项目需要手动操作，方法如下：
echo 系统设置页面，点击应用，点击可选功能。
echo 在已安装功能列表里找到“记事本（系统）”，点击卸载。
echo 拉回本页面顶部，点击添加可选功能的查看功能按钮。
echo 在弹出的添加可选功能里面，搜索“记事本（系统）”。
echo 安装，完成后重启计算机，完成修复。
echo.
echo 正在打开设置...
timeout /t 3 /nobreak > NUL
ms-settings:about
echo.
echo 操作执行完成
echo.
pause
goto menu

:healthtrayfix
cls
echo.
echo 开始修复系统托盘安全中心图标问题
echo 修复注册表项目
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /t REG_EXPAND_SZ /d "%%windir%%\system32\SecurityHealthSystray.exe" /f
echo 操作执行完成
echo.
echo 启动托盘程序
echo.
%windir%\System32\SecurityHealthSystray.exe

echo 操作执行完成
echo.
echo 所有操作均已执行完成
pause
goto menu

:weeksetmenu
cls
echo.
echo     系统托盘时间显示星期设置菜单
echo.
echo     0. 返回主菜单
echo     1. 设置显示星期
echo     2. 还原默认设置
echo.
set /p user_input=→  请选择一个项目：
if "%user_input%"=="" set user_input=null
if %user_input% equ 0 goto menu
if %user_input% equ 1 goto showweek
if %user_input% equ 2 goto defaultweek
echo.
echo →  输入异常，请检查输入选项
timeout /t 3 /nobreak > NUL
goto weeksetmenu

:showweek
cls
echo.
echo 正在更改系统日期时间格式以显示星期...
echo.
reg add "HKEY_CURRENT_USER\Control Panel\International" /v sShortDate /t REG_SZ /d "ddd yyyy/MM/dd" /f
echo.
echo 设置完成，为了使更改生效，建议重启资源管理器或重新启动计算机
echo.
pause
goto menu

:defaultweek
cls
echo.
echo 正在更改系统日期时间格式以恢复默认设置...
echo.
reg add "HKEY_CURRENT_USER\Control Panel\International" /v sShortDate /t REG_SZ /d "yyyy/MM/dd" /f
echo.
echo 已还原默认设置，为了使更改生效，建议重启资源管理器或重新启动计算机
echo.
pause
goto menu

:easteregg1
cls
echo.
echo     ★ ★ ★ ★ ★ ★ ★
echo     ☆   Easter Egg   ☆
echo     ★ ★ ★ ★ ★ ★ ★
echo.
echo     恭喜你找到了彩蛋一枚！
echo       祝你玩机永远顺利！
echo.
echo     /^^ · ω · ^^\ -- Nya~!
echo         /^^= ω =^^\ Meow--zZ
echo.
set /p user_input=→  那么你有没有神秘代码呢？有的话请输入：
if %user_input% equ nekomoe goto fastdebug
echo     0x00000000 Invalid code!
timeout /t 3 /nobreak > NUL
goto menu

:fastdebug
cls
echo.
echo     0x00000001 Verification passed.
echo.
echo     Authorized users.
echo     Welcome to MDT developer mode.
echo.
echo     Warning:
echo     In this mode, you have the highest privileges for this software, 
echo     and performing improper operations may cause damage to the system!
echo     If you do not understand what you are doing, type 0 to back menu.
echo     If you insist, type 1 to continue.
echo.
set /p user_input=→  Input code:
if %user_input% equ 0 goto menu
if %user_input% equ 1 goto developmode
echo     0x00000000 Invalid code!
timeout /t 3 /nobreak > NUL
goto menu

:developmode
rem 设置窗口大小及颜色
color 07
rem mode con cols=92 lines=54
rem cols 设置宽度；lines 设置长度
rem 颜色属性由两个十六进制数字指定 -- 第一个对应于背景，第二个对应于前景。每个数字可以为以下任何值:
rem 0 = 黑色 1 = 蓝色 2 = 绿色 3= 浅绿色 4 = 红色 5 = 紫色 6 = 黄色 7 = 白色 8 = 灰色 9 = 淡蓝色 A = 淡绿色 B = 淡浅绿色 C = 淡红色 D = 淡紫色 E = 淡黄色 F = 亮白色
rem 意义不明の循环——屎山代码
for /L %%i in (1,1,100) do (
  set /A decValue=%%i
  set /A hexValue=decValue
  set "hexValue=00000000!hexValue!"
  echo 0x!hexValue:~-8! Initializing...
)
echo.
echo Initialization complete.
cls

for /L %%i in (0,1,10000) do (
    set /A "percentage_main=%%i / 100"
    set /A "percentage_dot=%%i %% 100"
    
    rem 格式化小数部分，确保始终为两位数
    if !percentage_dot! LSS 10 (
        set "percentage_dot=0!percentage_dot!"
    )

    set "formatted=!percentage_main!.!percentage_dot!%%"
    echo Loading variables... !formatted! Complete.
)

echo.
echo Variables loaded.
cls
rem @echo off
rem setlocal ENABLEDELAYEDEXPANSION

set code=0123456789ABCDEF

for /l %%i in (0,1,100) do (
    set /a dec=%%i
    call:dec2hex !dec!
    rem 在这里进行格式化输出
    set "hexstr=00000000!hexstr!"
    echo 0x!hexstr:~-8!
)

echo.
echo All operations completed.
echo.
goto mdtdevmode

:dec2hex
set /a num=%1
set var=%num%
set str=

:calchex
set /a tra=%var%%%16
call,set tra=%%code:~%tra%,1%%
set /a var/=16
set str=%tra%%str%
if %var% gtr 0 goto calchex
set hexstr=%str%
goto:eof

:mdtdevmode
set "help_var1=支持所有系统环境变量输入，例如：%%USERNAME%%（用户名）、%%COMPUTERNAME%%（计算机名）、%%time:~0,8%%（时间）、%%date:~0,10%%（日期）"
set "help_var2=软件自带变量如下（部分变量需要执行相应功能才会赋值）：%%progver%%（软件版本）、%%Author%%（作者）、%%fastlaunch%%（快速启动标识，0常规启动，1快速启动）、%%BypassSecuritySoftwareCheck%%（安全软件检查，0默认不禁用，1禁用）、%%systemver%%（系统版本）、%%mydocdir%%（我的文档路径）、%%networkname1%%（最优先的网络的名称）、%%UserDesktopPath%%（用户桌面路径）、%%UserSendToPath%%（用户发送到...路径）、%%UserStartMenuPath%%（用户的开始菜单路径）、%%UserStartupPath%%（用户的启动文件夹路径）、%%gamebar%%（游戏模式状态）、%%scrresolution%%（屏幕分辨率）、%%scrresolutioncheck%%（屏幕分辨率检验，后获取）、%%virtualram%%（虚拟内存大小）、%%virtualramcheck%%（虚拟内存大小检验，后获取）、%%osinfoMD5%%（系统信息MD5）、%%osinfoMD5New%%（系统信息MD5校验，后获取）、%%timezone%%（时区）、%%Languages%%（语言代码）、%%SystemLanguages%%（系统语言）、%%powerstate%%（电源模式）、%%biosinfo%%（bios主板信息）、%%sumavg%%（DNS解析成功率）、%%autoconfigurl%%（代理配置信息）、%%autoconfigurlresult%%（代理配置信息结果）、%%proxyenable%%（代理状态）、%%proxyserver%%（代理地址/端口）、%%ieversion%%（ie版本）、%%ram%%（内存MB）、%%dnsresult%%（运营商DNS劫持情况）、%%dnsserverip%%（DNS服务器IP）"
cls
echo     MDT developer mode is activated.
timeout /t 1 /nobreak > NUL
cls
echo.
echo     Welcome to MDT developer mode.
echo.
echo     Home:       https://www.nekomoe.fun/
echo     Docs:       https://www.nekomoe.fun/?p=69
echo     Community:  https://github.com/Jackstar1212
echo.
echo     This is a debugging window based on the Windows Command Prompt (CMD).
echo     Developer mode for advanced operations and software debugging.
echo     Support for returning environment variables using the command line.
echo.
echo     Type "exit" and press enter to exit.
echo     Type "echo %%help_var1%%" or "echo %%help_var2%%" to get variables help.
echo.
echo     Report issues at https://www.nekomoe.fun/?p=69
echo.
cd %windir%\System32
cmd /k
@echo on
goto:eof

:boot_run_time
cls
echo.
echo 正在获取设备启动时间与运行时间...
echo.
call:get_boot_time
echo 获取设备启动时间与运行时间完成
echo.
pause
goto menu

:get_boot_time
:: 创建临时PowerShell脚本
echo $bootTime = (Get-WmiObject -Class Win32_OperatingSystem).LastBootUpTime > "%temp%\get_boot_time.ps1"
echo $bootTime = [Management.ManagementDateTimeConverter]::ToDateTime($bootTime) >> "%temp%\get_boot_time.ps1"
echo $currentTime = Get-Date >> "%temp%\get_boot_time.ps1"
echo $runTime = New-TimeSpan -Start $bootTime -End $currentTime >> "%temp%\get_boot_time.ps1"
echo Write-Host "系统启动时间：" >> "%temp%\get_boot_time.ps1"
echo $bootTime.ToString("yyyy年MM月dd日 HH时mm分ss秒") >> "%temp%\get_boot_time.ps1"
echo Write-Host "" >> "%temp%\get_boot_time.ps1"
echo Write-Host "系统已持续运行：" >> "%temp%\get_boot_time.ps1"
echo "$($runTime.Days)天 $($runTime.Hours)时 $($runTime.Minutes)分 $($runTime.Seconds)秒" >> "%temp%\get_boot_time.ps1"
rem echo Pause >> "%temp%\get_boot_time.ps1"

:: 执行临时PowerShell脚本
powershell -ExecutionPolicy Bypass -File "%temp%\get_boot_time.ps1"

:: 删除临时PowerShell脚本
del "%temp%\get_boot_time.ps1"
echo.
goto:eof

:easteregg2
cls
echo.
echo     Sonnet 18: Shall I compare thee to a summer's day?
echo.
echo     BY WILLIAM SHAKESPEARE
echo.
echo     Shall I compare thee to a summer's day?
echo     Thou art more lovely and more temperate:
echo     Rough winds do shake the darling buds of May,
echo     And summer's lease hath all too short a date;
echo     Sometime too hot the eye of heaven shines,
echo     And often is his gold complexion dimm'd;
echo     And every fair from fair sometime declines,
echo     By chance or nature's changing course untrimm'd;
echo     But thy eternal summer shall not fade,
echo     Nor lose possession of that fair thou ow'st;
echo     Nor shall death brag thou wander'st in his shade,
echo     When in eternal lines to time thou grow'st:
echo       So long as men can breathe or eyes can see,
echo       So long lives this, and this gives life to thee.
echo.
echo     ^>^>^> To eternal love.
echo.
pause
goto menu

:easteregg3
cls
echo.
echo     Bingo!
echo.
echo     这是作者的生日！
echo     是不是很巧？双十二！
echo.
echo     平时可以去我的博客转转哦~
echo     这是我的博客：https://www.nekomoe.fun/
echo.
echo     谢谢你用我写的小东西！能帮到你就再好不过了~
echo.
echo             LOVE_CAN_           HEAL_EVER
echo         YTHING.LOVE_CAN_H   EAL_EVERYTHING.LO
echo        VE_CAN_HEAL_EVERYTHING.LOVE_CAN_HEAL_EV
echo      ERYTHING.LOVE_CAN_HEAL_EVERYTHING.LOVE_CAN 
echo     HEAL_EVERYTHING.LOVE_CAN_HEAL_EVERYTHING.LOVE
echo     CAN_HEAL_EVERYTHING.LOVE_CAN_HEAL_EVERYTHING.
echo     LOVE_CAN_HEAL_EVERYTHING.LOVE_CAN_HEAL_EVERYT
echo     HING.LOVE_CAN_HEAL_EVERYTHING.LOVE_CAN_HEAL_E
echo     YERYTHING.LOVE_CAN_HEAL_EVERYTHING.LOVE_CAN_H
echo      EAL_EVERYTHING.LOVE_CAN_HEAL_EVERYTHING.LOV
echo       E_CAN_HEAL_EVERYTHING.LOVE_CAN_HEAL_EVERY
echo         THING.LOVE_CAN_HEAL_EVERYTHING.LOVE_C
echo           AN_HEAL_EVERYTHING.LOVE_CAN_HEAL_
echo             EVERYTHING.LOVE_CAN_HEAL_EVER
echo               YTHING.LOVE_CAN_HEAL_EVER
echo                  YTHING.LOVE_CAN_HEA
echo                     L_EVERYTHING.
echo                        LOVE_CA
echo                           N
echo.
pause
goto menu

:: 爱心代码备份
::echo.
::echo             *********           *********
::echo         *****************   *****************
::echo        ***************************************
::echo      *******************************************
::echo     *********************************************
::echo     *********************************************
::echo     *********************************************
::echo     *********************************************
::echo     *********************************************
::echo      *******************************************
::echo       *****************************************
::echo         *************************************
::echo           *********************************
::echo             *****************************
::echo               *************************
::echo                  *******************
::echo                     *************
::echo                        *******
::echo                           *
::echo.

:adsetmenu
cls
echo.
echo     Windows 广告、提示、建议、推广关闭/还原菜单
echo.
echo     请选择进一步操作：
echo.
echo     0. 返回主菜单
echo     1. 关闭广告设置
echo     2. 还原广告设置
echo.
echo     此功能会尽可能关闭/还原 Windows 广告、提示、建议、推广
echo     可能存在部分未能关闭/还原，需要手动操作
echo.
set /p user_input=→  请选择一个项目：
if "%user_input%"=="" set user_input=null
if %user_input% equ 0 goto menu
if %user_input% equ 1 goto closeadmenu
if %user_input% equ 2 goto restoreadmenu
echo.
echo →  输入异常，请检查输入选项
timeout /t 3 /nobreak > NUL
goto adsetmenu

:closeadmenu
cls
echo.
echo     Windows 广告、提示、建议、推广关闭菜单
echo.
echo     0. 返回主菜单
echo     1. 返回上一级菜单
echo     2. 关闭资源管理器广告
echo     3. 关闭锁屏、桌面上的提示和 Spotlight
echo     4. 关闭设置里的建议内容
echo     5. 关闭 Windows 提示和技巧
echo     6. 关闭完成设备设置广告（Win 10 存在，Win 11 不存在）
echo     7. 关闭欢迎体验广告
echo     8. 关闭个性化广告
echo     9. 关闭诊断数据定制体验
echo    10. 禁止开始菜单的建议内容
echo    11. 禁用 Windows 10 任务栏的“人脉”按钮和提示
echo    12. 关闭通知中心的提示和广告
echo    13. 禁用 Windows 小部件中的个性化广告
echo    14. 关闭基于位置的广告
echo    15. 关闭任务栏的“新闻和兴趣”
echo    16. （推荐）一键关闭所有广告、提示、建议、推广
echo.
set /p user_input=→  请选择一个项目：
if "%user_input%"=="" set user_input=null
if %user_input% equ 0 goto menu
if %user_input% equ 1 goto adsetmenu
if %user_input% equ 2 goto closeexplorerad
if %user_input% equ 3 goto closelockscrtip
if %user_input% equ 4 goto closesettingssuggestions
if %user_input% equ 5 goto closetip
if %user_input% equ 6 goto closefinishupad
if %user_input% equ 7 goto closeexpad
if %user_input% equ 8 goto closecustomad
if %user_input% equ 9 goto closediagexp
if %user_input% equ 10 goto closestartmenusuggestions
if %user_input% equ 11 goto closepeopletip
if %user_input% equ 12 goto closenotificationad
if %user_input% equ 13 goto closegadgetad
if %user_input% equ 14 goto closelocationad
if %user_input% equ 15 goto closenewsad
if %user_input% equ 16 goto closeallad
echo.
echo →  输入异常，请检查输入选项
timeout /t 3 /nobreak > NUL
goto adsetmenu

:closeexplorerad
cls
call:f_closeexplorerad
pause
goto adsetmenu

:closelockscrtip
cls
call:f_closelockscrtip
pause
goto adsetmenu

:closesettingssuggestions
cls
call:f_closesettingssuggestions
pause
goto adsetmenu

:closetip
cls
call:f_closetip
pause
goto adsetmenu

:closefinishupad
cls
call:f_closefinishupad
pause
goto adsetmenu

:closeexpad
cls
call:f_closeexpad
pause
goto adsetmenu

:closecustomad
cls
call:f_closecustomad
pause
goto adsetmenu

:closediagexp
cls
call:f_closediagexp
pause
goto adsetmenu

:closestartmenusuggestions
cls
call:f_closestartmenusuggestions
pause
goto adsetmenu

:closepeopletip
cls
call:f_closepeopletip
pause
goto adsetmenu

:closenotificationad
cls
call:f_closenotificationad
pause
goto adsetmenu

:closegadgetad
cls
call:f_closegadgetad
pause
goto adsetmenu

:closelocationad
cls
call:f_closelocationad
pause
goto adsetmenu

:closenewsad
cls
call:f_closenewsad
pause
goto adsetmenu

:closeallad
cls
call:f_closeexplorerad
call:f_closelockscrtip
call:f_closesettingssuggestions
call:f_closetip
call:f_closefinishupad
call:f_closeexpad
call:f_closecustomad
call:f_closediagexp
call:f_closestartmenusuggestions
call:f_closepeopletip
call:f_closenotificationad
echo.
echo 所有操作已执行完成
echo.
echo 提示：部分广告需要手动关闭，例如：
echo 锁屏界面新闻广告：请打开“设置”并转到“个性化 - 锁屏界面”
echo 将锁屏界面状态改为“无”
echo.
pause
goto menu


:restoreadmenu
cls
echo.
echo     Windows 广告、提示、建议、推广还原菜单
echo.
echo     0. 返回主菜单
echo     1. 返回上一级菜单
echo     2. 还原资源管理器广告
echo     3. 还原锁屏、桌面上的提示和 Spotlight
echo     4. 还原设置里的建议内容
echo     5. 还原 Windows 提示和技巧
echo     6. 还原完成设备设置广告（Win 10 存在，Win 11 不存在）
echo     7. 还原欢迎体验广告
echo     8. 还原个性化广告
echo     9. 还原诊断数据定制体验
echo    10. 禁止开始菜单的建议内容
echo    11. 禁用 Windows 10 任务栏的“人脉”按钮和提示
echo    12. 还原通知中心的提示和广告
echo    13. 禁用 Windows 小部件中的个性化广告
echo    14. 还原基于位置的广告
echo    15. 还原任务栏的“新闻和兴趣”
echo    16. 一键还原所有广告、提示、建议、推广
echo.
set /p user_input=→  请选择一个项目：
if "%user_input%"=="" set user_input=null
if %user_input% equ 0 goto menu
if %user_input% equ 1 goto adsetmenu
if %user_input% equ 2 goto restoreexplorerad
if %user_input% equ 3 goto restorelockscrtip
if %user_input% equ 4 goto restoresettingssuggestions
if %user_input% equ 5 goto restoretip
if %user_input% equ 6 goto restorefinishupad
if %user_input% equ 7 goto restoreexpad
if %user_input% equ 8 goto restorecustomad
if %user_input% equ 9 goto restorediagexp
if %user_input% equ 10 goto restorestartmenusuggestions
if %user_input% equ 11 goto restorepeopletip
if %user_input% equ 12 goto restorenotificationad
if %user_input% equ 13 goto restoregadgetad
if %user_input% equ 14 goto restorelocationad
if %user_input% equ 15 goto restorenewsad
if %user_input% equ 16 goto restoreallad
echo.
echo →  输入异常，请检查输入选项
timeout /t 3 /nobreak > NUL
goto adsetmenu

:restoreexplorerad
cls
call:f_restoreexplorerad
pause
goto adsetmenu

:restorelockscrtip
cls
call:f_restorelockscrtip
pause
goto adsetmenu

:restoresettingssuggestions
cls
call:f_restoresettingssuggestions
pause
goto adsetmenu

:restoretip
cls
call:f_restoretip
pause
goto adsetmenu

:restorefinishupad
cls
call:f_restorefinishupad
pause
goto adsetmenu

:restoreexpad
cls
call:f_restoreexpad
pause
goto adsetmenu

:restorecustomad
cls
call:f_restorecustomad
pause
goto adsetmenu

:restorediagexp
cls
call:f_restorediagexp
pause
goto adsetmenu

:restorestartmenusuggestions
cls
call:f_restorestartmenusuggestions
pause
goto adsetmenu

:restorepeopletip
cls
call:f_restorepeopletip
pause
goto adsetmenu

:restorenotificationad
cls
call:f_restorenotificationad
pause
goto adsetmenu

:restoregadgetad
cls
call:f_restoregadgetad
pause
goto adsetmenu

:restorelocationad
cls
call:f_restorelocationad
pause
goto adsetmenu

:restorenewsad
cls
call:f_restorenewsad
pause
goto adsetmenu

:restoreallad
cls
call:f_restoreexplorerad
call:f_restorelockscrtip
call:f_restoresettingssuggestions
call:f_restoretip
call:f_restorefinishupad
call:f_restoreexpad
call:f_restorecustomad
call:f_restorediagexp
call:f_restorestartmenusuggestions
call:f_restorepeopletip
call:f_restorenotificationad
echo.
echo 所有操作已执行完成
pause
goto menu


rem 菜单调用功能区

:f_closeexplorerad
:: 关闭资源管理器广告
echo.
echo 正在关闭资源管理器广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭资源管理器广告
goto:eof

:f_restoreexplorerad
echo.
:: 还原资源管理器广告
echo 正在还原资源管理器广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原资源管理器广告
goto:eof

:f_closelockscrtip
echo.
:: 关闭锁屏上的提示和 Spotlight
echo 正在关闭锁屏、桌面上的提示和 Spotlight
reg add "HKCU\Software\Policies\Microsoft\Windows\Personalization" /v NoLockScreenTips /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DesktopSpotlight\Settings" /v EnabledState /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭锁屏、桌面上的提示和 Spotlight
echo.
echo 如需要 Windows 聚焦功能（锁屏界面自动更换微软每日壁纸）
echo 请重新到“设置 - 个性化 - 锁屏界面 - 个性化锁屏界面”中开启
goto:eof

:f_restorelockscrtip
echo.
:: 还原锁屏上的提示和 Spotlight
echo 正在还原锁屏、桌面上的提示和 Spotlight
reg add "HKCU\Software\Policies\Microsoft\Windows\Personalization" /v NoLockScreenTips /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v RotatingLockScreenOverlayEnabled /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\DesktopSpotlight\Settings" /v EnabledState /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原锁屏、桌面上的提示和 Spotlight
goto:eof

:f_closesettingssuggestions
echo.
:: 关闭设置里的建议内容
echo 正在关闭设置里的建议内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭设置里的建议内容
goto:eof

:f_restoresettingssuggestions
echo.
:: 还原设置里的建议内容
echo 正在还原设置里的建议内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原设置里的建议内容
goto:eof

:f_closetip
echo.
:: 关闭 Windows 提示和技巧
echo 正在关闭 Windows 提示和技巧
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭 Windows 提示和技巧
goto:eof

:f_restoretip
echo.
:: 还原 Windows 提示和技巧
echo 正在还原 Windows 提示和技巧
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原 Windows 提示和技巧
goto:eof

:f_closefinishupad
echo.
:: 关闭完成设备设置广告（Win 10 存在，Win 11 不存在）
echo 正在关闭完成设备设置广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭完成设备设置广告
goto:eof

:f_restorefinishupad
echo.
:: 还原完成设备设置广告（Win 10 存在，Win 11 不存在）
echo 正在还原完成设备设置广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" /v ScoobeSystemSettingEnabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原完成设备设置广告
goto:eof

:f_closeexpad
echo.
:: 关闭欢迎体验广告
echo 正在关闭欢迎体验广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭欢迎体验广告
goto:eof

:f_restoreexpad
echo.
:: 还原欢迎体验广告
echo 正在还原欢迎体验广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-310093Enabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原欢迎体验广告
goto:eof

:f_closecustomad
echo.
:: 关闭个性化广告
echo 正在关闭个性化广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭个性化广告
goto:eof

:f_restorecustomad
echo.
:: 还原个性化广告
echo 正在还原个性化广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原个性化广告
goto:eof

:f_closediagexp
echo.
:: 关闭诊断数据定制体验
echo 正在关闭诊断数据定制体验
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭诊断数据定制体验
goto:eof

:f_restorediagexp
echo.
:: 还原诊断数据定制体验
echo 正在还原诊断数据定制体验
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原诊断数据定制体验
goto:eof

:f_closestartmenusuggestions
echo.
:: 禁止开始菜单的建议内容
echo 正在禁止开始菜单的建议内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f >nul 2>nul
echo 已禁止开始菜单的建议内容
goto:eof

:f_restorestartmenusuggestions
echo.
:: 还原开始菜单的建议内容
echo 正在还原开始菜单的建议内容
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原开始菜单的建议内容
goto:eof

:f_closepeopletip
echo.
:: 禁用 Windows 10 任务栏的“人脉”按钮和提示
echo 正在禁用 Windows 10 任务栏的“人脉”按钮和提示
if not exist "HKCU\Software\Policies\Microsoft\Windows\Explorer" mkdir "HKCU\Software\Policies\Microsoft\Windows\Explorer" >nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v ShowPeopleOnTaskbar /t REG_DWORD /d 0 /f >nul 2>nul
echo 已禁用 Windows 10 任务栏的“人脉”按钮和提示
goto:eof

:f_restorepeopletip
echo.
:: 还原 Windows 10 任务栏的“人脉”按钮和提示
echo 正在还原 Windows 10 任务栏的“人脉”按钮和提示
if not exist "HKCU\Software\Policies\Microsoft\Windows\Explorer" mkdir "HKCU\Software\Policies\Microsoft\Windows\Explorer" >nul 2>nul
reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v ShowPeopleOnTaskbar /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原 Windows 10 任务栏的“人脉”按钮和提示
goto:eof

:f_closenotificationad
echo.
:: 关闭通知中心的提示和广告
echo 正在关闭通知中心的提示和广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v NoTileApplicationNotification /t REG_DWORD /d 1 /f >nul 2>nul
echo 已关闭通知中心的提示和广告
goto:eof

:f_restorenotificationad
echo.
:: 还原通知中心的提示和广告
echo 正在还原通知中心的提示和广告
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v NoTileApplicationNotification /t REG_DWORD /d 0 /f >nul 2>nul
echo 已还原通知中心的提示和广告
goto:eof

:f_closegadgetad
echo.
:: 禁用 Windows 小部件中的个性化广告
echo 正在禁用 Windows 小部件中的个性化广告
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
echo 已禁用 Windows 小部件中的个性化广告
goto:eof

:f_restoregadgetad
echo.
:: 还原 Windows 小部件中的个性化广告
echo 正在还原 Windows 小部件中的个性化广告
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原 Windows 小部件中的个性化广告
goto:eof

:f_closelocationad
echo.
:: 关闭基于位置的广告
echo 正在关闭基于位置的广告
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v DisabledByUser /t REG_DWORD /d 1 /f >nul 2>nul
echo 已关闭基于位置的广告
goto:eof

:f_restorelocationad
echo.
:: 还原基于位置的广告
echo 正在还原基于位置的广告
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v DisabledByUser /t REG_DWORD /d 0 /f >nul 2>nul
echo 已还原基于位置的广告
goto:eof

:f_closenewsad
echo.
:: 关闭任务栏的“新闻和兴趣”
echo 正在关闭任务栏的“新闻和兴趣”
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsEnabled /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableNewsFeed /t REG_DWORD /d 0 /f >nul 2>nul
echo 已关闭任务栏的“新闻和兴趣”
goto:eof

:f_restorenewsad
echo.
:: 还原任务栏的“新闻和兴趣”
echo 正在还原任务栏的“新闻和兴趣”
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsEnabled /t REG_DWORD /d 1 /f >nul 2>nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v EnableNewsFeed /t REG_DWORD /d 1 /f >nul 2>nul
echo 已还原任务栏的“新闻和兴趣”
goto:eof

:hypervmenu
cls
echo     设备安全性-内核隔离（Hyper-V 功能）调整菜单
echo.
echo     0. 返回主菜单
echo     1. 开启设备安全性-内核隔离（Hyper-V 功能）
echo     2. 关闭设备安全性-内核隔离（Hyper-V 功能）
echo.
set /p user_input=→  请选择一个项目：
if "%user_input%"=="" set user_input=null
if %user_input% equ 0 goto menu
if %user_input% equ 1 goto hypervon
if %user_input% equ 2 goto hypervoff
echo.
echo →  输入异常，请检查输入选项
timeout /t 3 /nobreak > NUL
goto hypervmenu

:hypervon
cls
echo.
echo 开启设备安全性-内核隔离（Hyper-V 功能）
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 1 /f >nul 2>nul
echo.
echo 操作执行完成，请重新启动计算机以使更改生效
echo.
set /p choice=你想要现在重启计算机吗？ (y/N) 
if /I "%choice%"=="y" shutdown -r -t 0
if /I "%choice%"=="Y" shutdown -r -t 0
goto menu

:hypervoff
cls
echo.
echo 关闭设备安全性-内核隔离（Hyper-V 功能）
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >nul 2>nul
echo.
echo 操作执行完成，请重新启动计算机以使更改生效
echo.
set /p choice=你想要现在重启计算机吗？ (y/N) 
if /I "%choice%"=="y" shutdown -r -t 0
if /I "%choice%"=="Y" shutdown -r -t 0
goto menu

:delappnamecache
cls
echo.
echo 设置-应用-安装的应用 里面存在已卸载的程序名称残留清理方法
echo.
echo 打开注册表并定位到以下几个路径：
echo.
echo 计算机\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall
echo 计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\
echo 计算机\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\
echo.
echo 利用 Ctrl + F（查找）和 F3（查找下一项）功能
echo 在上述路径里面找到已卸载的残留程序名称，删掉对应键值即可
start regedit.exe >nul 2>nul
echo.
echo 操作执行完成
echo.
pause
goto menu


:hrasopenrestore
cls
echo.
echo 开始修复火绒应用商店打开方式劫持问题
echo.
echo 正在还原注册表设置...
:: 删除指定的注册表项
reg delete "HKEY_CLASSES_ROOT\HrASOpen.zip" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\HrASOpen.pdf" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\HrASOpen" /f >nul 2>nul

:: 设置 Unknown\shell 的默认值为 "openas"
reg add "HKEY_CLASSES_ROOT\Unknown\shell" /ve /t REG_SZ /d "openas" /f >nul 2>nul

:: 删除 Unknown\shell\HrASOpen 注册表项
reg delete "HKEY_CLASSES_ROOT\Unknown\shell\HrASOpen" /f >nul 2>nul

:: 设置 HKEY_CURRENT_USER\Software\Huorong\AppStore 下的 UnknowOpenWith 值为空字符串
reg add "HKEY_CURRENT_USER\Software\Huorong\AppStore" /v "UnknowOpenWith" /t REG_SZ /d "" /f >nul 2>nul

echo 所有操作已执行完成
pause
goto menu

:GPUcustomset
cls
echo.
echo 设置-系统-屏幕-显示卡-应用程序的自定义设置 存在已卸载的程序名称残留清理
echo.
echo 方法如下：
echo.
echo 第一步：
echo 在开启的注册表编辑器的地址栏输入并定位以下路径：（已自动复制到剪贴板直接粘贴即可）
echo.
echo HKEY_CURRENT_USER\Software\Microsoft\DirectX\UserGpuPreferences
echo HKEY_CURRENT_USER\Software\Microsoft\DirectX\UserGpuPreferences| clip
echo.
echo 第二步：
echo 在右侧列表中找到已卸载的程序路径项目删除
echo.
echo 关闭注册表编辑器，完成更改
echo.
regedit.exe
echo 操作执行完成
pause
goto menu

:winsxsclean
cls
echo.
echo 开始扫描系统组件存储占用空间大小
echo.
Dism /Online /Cleanup-Image /AnalyzeComponentStore
echo.
echo     0. 返回主菜单
echo     1. 清理系统组件存储
echo.
set /p choice=→  请选择一个项目：
if "%choice%"=="" set user_input=null
if %choice% equ 0 goto menu
if %choice% equ 1 goto compclean
echo.
echo →  输入异常，请检查输入选项
timeout /t 3 /nobreak > NUL
goto winsxsclean
:compclean
echo.
echo 开始清理系统组件存储
echo.
Dism /online /Cleanup-Image /StartComponentCleanup
echo.
echo 操作执行完成
pause
goto menu

:longpathenable
cls
echo.
echo 解除 Windows 文件路径长度上限
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f >nul 2>nul
echo.
echo 操作执行完成
pause
goto menu

:longpathdisable
cls
echo.
echo 恢复 Windows 文件路径长度上限
reg add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /v "LongPathsEnabled" /t REG_DWORD /d 0 /f >nul 2>nul
echo.
echo 操作执行完成
pause
goto menu

:perfmon_page
cls
echo 正在打开可靠性监视程序...
perfmon /rel
echo.
echo 操作执行完成
pause
goto menu

:perfmon_program
cls
echo 正在打开性能监视器...
perfmon.exe
echo.
echo 操作执行完成
pause
goto menu

:resmon_program
cls
echo 正在打开资源监视器...
resmon.exe
echo.
echo 操作执行完成
pause
goto menu

:wevcl
cls
echo 开始清理 Windows 系统日志
echo title 正在清理 Windows 系统日志，请稍等 >%appdata%\junkclean_log.bat
echo for /F "tokens=*" %%%%1 in ('wevtutil.exe el') DO wevtutil cl "%%%%1" >>%appdata%\junkclean_log.bat
echo echo Windows 系统日志清理完毕 >>%appdata%\junkclean_log.bat
echo timeout /t 2 /nobreak >nul >>%appdata%\junkclean_log.bat
echo exit >>%appdata%\junkclean_log.bat
start %appdata%\junkclean_log.bat
echo.
echo 操作执行完成
pause
goto menu
