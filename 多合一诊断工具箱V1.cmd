@echo off

rem ȡ�ù���ԱȨ��
>NUL 2>&1 REG.exe query "HKU\S-1-5-19" || (
    ECHO SET UAC = CreateObject^("Shell.Application"^) > "%TEMP%\Getadmin.vbs"
    ECHO UAC.ShellExecute "%~f0", "%1", "", "runas", 1 >> "%TEMP%\Getadmin.vbs"
    "%TEMP%\Getadmin.vbs"
    DEL /f /q "%TEMP%\Getadmin.vbs" 2>NUL
    Exit /b
)

rem ϵͳ����޸�����

rem ���ϵͳ��������

wmic /? >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	rem call:systempath %%SystemRoot%%\system32\Wbem
	echo ��Ϲ��߹��ܿ������ޣ����ֶ��޸�C:\Windows\system32\Wbem��������
)

netsh winsock show >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	call:systempath %%SystemRoot%%\system32
)

rem ����û�temp����Ŀ¼��������
echo %temp% |%systemroot%\system32\findstr "Local\Temp" >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo. >nul 2>nul
) else (
	%systemroot%\system32\reg add "HKEY_CURRENT_USER\Environment" /v Temp /t REG_EXPAND_SZ /d "%USERPROFILE%\AppData\Local\Temp" /f >nul 2>nul
	set temp=%USERPROFILE%\AppData\Local\Temp
	echo ���޸��û���������, �����´򿪼�鹤��
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq 360tray.exe" |findstr /i 360tray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo ���˳�360��ȫ��ʿ, ������������г��ִ���
	mshta vbscript:msgbox("���˳�360��ȫ��ʿ, ������������г��ִ���",64,"��Ϣ"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq QQPCSoftMgr.exe" |findstr /i QQPCSoftMgr.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo ���˳���Ѷ���Թܼ�, ������������г��ִ���
	mshta vbscript:msgbox("���˳���Ѷ���Թܼ�, ������������г��ִ���",64,"��Ϣ"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

%systemroot%\system32\tasklist /fi "IMAGENAME eq HipsTray.exe" |findstr /i HipsTray.exe >nul 2>nul
if %ERRORLEVEL% equ 0 (
	echo ���˳����ް�ȫ���, ������������г��ִ���
	mshta vbscript:msgbox("���˳����ް�ȫ���, ������������г��ִ���",64,"��Ϣ"^)(window.close^)
	exit
) else (
	echo. >nul >nul
)

title ��������޸�����
rem color 2f
mode con cols=128 lines=40
setlocal enabledelayedexpansion
powershell -executionpolicy bypass -command "&{$H=get-host;$W=$H.ui.rawui;$B=$W.buffersize;$B.width=128;$B.height=300;$W.buffersize=$B;$W.windowtitle='ϵͳ����޸�����'}"
chcp 936 2>nul >nul

rem ��ȡϵͳ�汾��Ϣ
ver /? >nul 2>nul
if !ERRORLEVEL! equ 0 (
	for /f "tokens=4 " %%i in ('ver') do (
		for /f "tokens=1 delims=." %%a in ('echo %%i 2^>nul') do set systemver=%%a
	)
) else (
	set systemver=9
)

rem ��ȡpowershell�汾��Ϣ
for /f %%i in ('powershell -executionpolicy bypass $PSVersionTable.PSVersion 2^>nul ^|findstr [0-9]') do set powershellver=%%i

set ipv4ipv6=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^> [0-9][a-f][0-9]*: [a-f][a-f][a-f]*: [a-f][a-f][a-f][0-9]: [0-9][0-9][0-9]*::
set ipv4only=^\^<[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*\^>
set ipv6only=[0-9][a-f][0-9]*: [a-f][a-f][a-f]*: [a-f][a-f][a-f][0-9]: [0-9][0-9][0-9]*::
rem ��ȡ�������ļ���
set mybatname=%~n0
)

rem ������ȫ/����/����/ģ����/�����������
set securitysoftwareprocess=Avast adguard 2345 V2RayN V3Medic V3LSvc Ldshelper LenovoNerveCenter wsctrl LenovoPcManagerService McUICnt kxetray rstray HipsDaemon HipsTray HipsMain ADSafe kavsvc Norton Mcafee avguard SecurityHealthSystray KWatch ZhuDongFangYu 360tray 360safe QQPCMgr QQPCTray QQPCRTP BullGuardCore GlassWire avira k7gw panda avg QHActiveDefense QHWatchDog symantec mbam HitmanPro emsi BdAgent iobit zoner sophos WO17 gdata zonealarm trend fsagent antimalwareservice webroot spyshelter Lavservice killer 8021x NetPeeker NetLimiter SSTap SSTap-mod GameFirst_V Shadowsocks SSTap SuService drclient C+WClient NetScaning Clmsn BarClientView ProcessSafe iNode GOGO�ϻ� RzxClient CoobarClt nvvsvc NXPRUN LdBoxHeadless LdVBoxHeadless MEmuHeadless NoxVMHandle AndroidEmulator ddemuhandle LDSGameMaster
rem ��Ϸ���̺ڰ�����/�ڴ��СKB
for /f "tokens=1*" %%i in ('tzutil.exe /g') do set timezone=%%i %%j

for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\Language" /v InstallLanguage 2^>nul') do set Languages=%%i
if defined Languages (
	if !Languages!==0804 set SystemLanguages=��������
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

rem ��ȡ�ҵ��ĵ�·��
for /f "tokens=3,4*" %%i in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Personal 2^>nul ^|findstr "Personal"') do set mydocdir=%%i %%j %%k
if defined mydocdir (
	set mydocdir=!mydocdir:~0,-2!
) else (
	echo. >nul 2>nul
)

rem ��ȡ����ʹ�����������
set NNN=0
for /f "tokens=1 delims=," %%i in ('Getmac /v /nh /fo csv ^|findstr /r "Device ��ȱ" ^|findstr /r /v "Switch Bluetooth Direct Xbox VMware VirtualBox ZeroTier WSL Loopback û��Ӳ��"') do (
	set /a NNN+=1
	set networkname!NNN!=%%i
)
rem �ж�����ӿ����ȼ�
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

rem Win10��Ϸģʽ
if "%systemver%"=="10" (
for /f "tokens=3" %%i in ('reg query "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gamebar=%%i
if defined gamebar (
if !gamebar!==0x0 set gamebar=��Ϸģʽ: ��
if !gamebar!==0x1 set gamebar=��Ϸģʽ: ��
) else (
set "gamebar=��Ϸģʽ: ��"
)
) else (
echo. >nul
)
cls
echo ϵͳʱ��: %time:~0,8%
echo ϵͳʱ��: %timezone%
echo ��װ����: %Languages% %SystemLanguages%
echo ��Դģʽ: %powerstate%
if "%systemver%"=="10" (
echo %gamebar%
)
echo.
echo -------------------------------------------------------------------------------
echo                             ϵͳ����޸�����
echo -------------------------------------------------------------------------------
echo  1��ϵͳ�������
echo  2������������
echo  3��ϵͳ�޸�
echo  4��hosts�޸�����
echo  5��DNS���ù���
echo  6������Э��ջ����
echo  7��LSP�޸�
echo  8���ر�Windows����ǽ
echo  9������Windows����ǽ
echo 10����ʾ�����б�
echo 11������IE
echo 12��׿Խ����ģʽ
echo 13��DNS����������¼
echo 14���ָ�UAC
echo 15������UAC
echo 16��Xboxƽ̨�޸�
echo 17��ͼ�����޸�
echo 18���Զ��忪��ѡ��ϵͳ������ȴ�ʱ��
echo 19��Windows�۽���ֽ�޸�
echo 20��Windows��Դѡ��ָ�
echo 21��Windows Update���°�װ���⣨0x80070002/0x80070005������������ʹ��ϵͳ�޸�
echo 22��taskmgr.exeû����֮�����ĳ�������
echo 23������exeû����֮�����ĳ�������
echo 24���򿪿��ƶ������Զ�����
echo 25���رտ��ƶ������Զ�����
echo 26������ϵͳ����
echo 27���ر�ϵͳ����
echo 28��ȡ��Windows����״̬�����������ڣ����ã���ʹWindows��Ϊδ����״̬����
echo 29���������ӡ��޸��������ڼ�ͥ���������Ի�������רҵ�������Զ�ʧ�쳣�����⣩
echo 30��ϵͳ�̻�����������ʹ���з��գ���������־�ļ��ȣ������ñ��ݣ�
echo -------------------------------------------------------------------------------

set /p a=��ѡ����Ŀ: 
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
echo �������,�밴���������ѡ��˵�. . .
echo.
pause >nul
goto menu

:envdiag
call:systemver
call:tracerttable
call:securitysoft
call:dnsserver ����DNS������: 
call:dnseventlog
call:minidump
call:nicinterface
call:hardware
call:ieproxy
rem call:systemfirewalloff 9
call:hostsdiag
call:ipv6state
echo ����DNS�������� (Ԥ�ƺ�ʱ5-10��): 
ipconfig /flushdns >nul 2>nul
rem ��Ŀ6
call:nslookvalue www.people.com.cn www.xinhuanet.com www.cctv.com www.cac.gov.cn www.china.com.cn www.gmw.cn
set /a sum1=sum
rem ��Ŀ6
call:nslookvalue www.qstheory.cn www.ce.cn www.cri.cn www.cnr.cn www.youth.cn cn.chinadaily.com.cn
set /a sum2=sum
rem ��Ŀ6
call:nslookvalue www.163.com www.sina.com.cn www.qq.com www.taobao.com www.jd.com www.iqiyi.com
set /a sum3=sum
rem ��Ŀ6
call:nslookvalue www.baidu.com www.bing.com www.sohu.com
set /a sum4=sum

set /a sumall=sum1+sum2+sum3+sum4
set /a sumavg=sumall*100/24
echo     �ɹ���: %sumavg%%%
echo.
call:systemtime
call:ipaddress ��Ӫ��: http://myip.ipip.net/
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
call:dnsserver ����DNS������: 
call:dnseventlog
call:systemtime
pause
goto menu

:networkreset
taskkill /F /IM VeryKuai.exe >nul 2>nul
echo.
echo ǰ���޸�������LSP
netsh winsock reset >nul 2>nul
echo.

goto modeselect

:modeselect
set /p a=��ѡ������ģʽ��ģʽ1��ͨ���ã�ģʽ2�������ã�: 
if %a% equ 1 goto regularreset
if %a% equ 2 goto brutereset

:brutereset
echo.
echo ����TCP/IPЭ��
rem ��ȡ�������ƺ�����IP��Ϣ
netsh interface IP Show Address %networkname1% > %temp%\ip.txt 2>nul
for /f "tokens=3" %%i in ('type %temp%\ip.txt 2^>nul ^|findstr "IP"') do set ipsetaddress=%%i
for /f "tokens=2" %%i in ('type %temp%\ip.txt 2^>nul ^|findstr /r "Ĭ������ Gateway"') do set ipgateway=%%i
for /f "tokens=4" %%i in ('type %temp%\ip.txt 2^>nul ^|findstr /r "���� Mask"') do set ipmask=%%i

rem �ж�������������dhcp�����ֶ�
netsh interface IP Show Address %networkname1% |findstr /r "�� No" 2>nul >nul && set ipsetmode=yes || set ipsetmode=no
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

echo ����Killer����
sc config "Killer Network Service x64" start= disabled >nul 2>nul
sc config "Killer Network Service" start= disabled >nul 2>nul
sc config "Killer Bandwidth Service" start= disabled >nul 2>nul
sc config "Rivet Bandwidth Service" start= disabled >nul 2>nul

:regularreset
echo.
echo �ٴ�����LSP
netsh winsock reset >nul 2>nul
netsh winsock reset >nul 2>nul
echo.

echo ����hosts�ļ�Ȩ�޲����
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts

rem ֹͣ��ɾ����������
set drivername=vkdpi xunyoufilter xunyounpf QeeYouPacket npf uuwfp uupacket networktunnel10_x64 ylwfp TP2CNNetFilter lgdcatcher lgdcatchertdi xfilter savitar netrtp
for %%i in (%drivername%) do (
sc stop %%i >nul 2>nul
sc config %%i start= DISABLED >nul 2>nul
sc delete %%i >nul 2>nul
)
echo.

rem echo Windowsϵͳ����ǽ: �ѻ�ԭĬ�����ò��ر�
rem netsh advfirewall reset >nul 2>nul
rem netsh advfirewall set allprofiles state off >nul 2>nul
rem echo.

call:ieproxy

echo ˢ��DNS/ARP����
ipconfig /flushdns >nul 2>nul
arp -d >nul 2>nul
echo.

echo ����ͬ������ʱ��...
call:systemtimereset
echo.

rem ����ע�����Ϣ
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vkdpi" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ylwfp" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\networktunnel10_x64" /f >nul 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\XunYouFilter" /f >nul 2>nul

echo IE����޸�
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo.
set var=0
for /l %%i in (15,-1,1) do echo ����ֹͣ��������: %var%%%i && ping -n 2 127.1>nul

rem ɾ�������ļ�ʧ�ܺ�������
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
echo ��������������ֹͣ�ɹ�
echo.
echo �����ɹ�, ���������������
mshta vbscript:msgbox("�����ɹ�, ���������������",64,"��Ϣ"^)(window.close^)

echo.
pause
goto menu

:lspfix
echo.
echo LSP�޸�
netsh winsock reset
netsh winsock reset
netsh winsock reset
echo.
echo ���޸�
echo.
pause
goto menu

:systemrepair
echo.
echo 0��ǰ�÷����޸�
echo 1��SFC�޸��������޸���
echo 2��DISM����޸����߼��޸���
echo 3���������˵�

set /p user_input=��ѡ��һ����Ŀ��
if %user_input% equ 0 goto PreSFix
if %user_input% equ 1 goto SFCFIX
if %user_input% equ 2 goto DISMFIX
if %user_input% equ 3 goto menu
echo.
echo ��Ч�Ĵ��룬���������롣
ping 127.1 -n 2 >nul
goto systemrepair

:PreSFix
echo.
echo ǰ���޸�����ϲ��Է����޸�
sc config DPS start = AUTO > NUL
sc config diagsvc start = Demand > NUL
sc config WdiServiceHost start = Demand > NUL
sc config WdiSystemHost start = Demand > NUL
sc start DPS >nul
echo ǰ�÷����޸����
goto systemrepair

:SFCFIX
echo ����ʹ��SFC���߽����޸������������쳣��������ǰ�÷����޸�
echo ������������������10���ӣ����˳������������в�ѡ��DISM�����޸�
ping 127.1 -n 2 >nul
echo ����SCANNOW�����޸�ϵͳ
sfc /scannow
echo SFC�����޸����
goto menu

:DISMFIX
echo.
echo ����ʹ��DISM���߽����޸������������쳣��������ǰ�÷����޸�
echo ������������������10���ӣ����˳�������������DISM�����޸�
echo ������DISM�����쳣������Ȼ�������뿼��ʹ��ԭ��ϵͳ���񸲸ǰ�װϵͳ�޸��ļ���ϵͳ�ļ��⵽DISM���߲����޸����ƻ���
ping 127.1 -n 2 >nul
echo ʹ��DISM����У��ϵͳ�ļ�
Dism /Online /Cleanup-Image /ScanHealth
echo DISMɨ�����

:dismbreak
echo DISM����ɨ����ɣ���������ѡ��
echo 1�������޸�����洢
echo 2��δ��⵽����洢��
echo 3����������
set /p host=��������ѡ����Ŀ��
if %host% equ 1 goto DISMRestore
if %host% equ 2 goto DISMFin
if %host% equ 3 goto DISMother
echo.
echo ��Ч�Ĵ��룬���������롣
ping 127.1 -n 2 >nul
goto dismbreak

:DISMRestore
echo ʹ��DISM�����޸�ϵͳ�ļ�
Dism /Online /Cleanup-Image /RestoreHealth
echo DISM�޸�����洢���
goto DISMFin

:DISMother
echo �����г����ֳ������⣺
echo 1. �洢������𻵣���������ԭ�澵�񸲸ǰ�װϵͳ�޸�
echo 2. �Ҳ���ӳ��Դ���Ҳ���Դ�ļ����ȼ�������Ƿ�ͨ������������
echo ���Դ������⣬����ԭ�澵�����install.wim�ļ����أ�������StartComponent�����޸�
echo ���Ƽ��ķ���������ԭ�澵�񸲸ǰ�װϵͳ�޸�
echo 3. ��ϲ��Է���δ���У���������ǰ���޸�������Դ������⣬��������ԭ�澵���ļ����ǰ�װϵͳ�޸�
echo ��ͨ�û��Ƽ�ʹ��΢��ٷ���MediaCreationTool���𸲸ǡ���װ������ϵͳ
echo רҵ�û�������Ѱ��iso�ļ�ͨ�����ַ�ʽ�޸�ϵͳ������׸��
ping 127.1 -n 3 >nul
echo ����������ز˵�
echo pause
goto menu

:DISMFin
echo DISM�޸���ɣ��Ƽ�����ϵͳ
ping 127.1 -n 3 >nul
goto menu

:hsfile
echo.
echo 0���������˵�
echo 1���޸�hosts
echo 2���޸�Ȩ�޲����hosts
echo 3��ʹhostsֻ��
echo 4��ʹhosts��д
echo 5������ָ��·���ļ��ܾ�����
echo 6������ָ��·���ļ���ȫ����

echo.
set /p host=��ѡ��: 
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
rem �������
type %WINDIR%\system32\drivers\etc\hosts 2>nul |findstr "." >> %WINDIR%\system32\drivers\etc\hosts_bak
copy /y %WINDIR%\system32\drivers\etc\hosts_bak %WINDIR%\system32\drivers\etc\hosts >nul
rem ʹhosts��д
cacls.exe %WINDIR%\system32\drivers\etc\hosts /e /t /g Administrators:F
rem ɾ�������ļ�
del /s /q %WINDIR%\system32\drivers\etc\hosts_bak >nul 2>nul
start notepad.exe %WINDIR%\system32\drivers\etc\hosts
echo ���������±���hosts�޸���ɺ��밴���������
echo.
pause
ipconfig /flushdns >nul 2>nul
goto menu
:host2
echo �޸�Ȩ�޲����hosts
echo y| cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F >nul
cd. > %WINDIR%\system32\drivers\etc\hosts
echo.
pause
goto menu
:host3
echo.
rem ʹhostsֻ��
echo ��Yʹhostsֻ��: 
cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:R
echo.
pause
goto menu
:host4
echo.
rem ʹhosts��д
echo ��Yʹhosts��д: 
cacls.exe %WINDIR%\system32\drivers\etc\hosts /t /p Everyone:F
cd. > %WINDIR%\system32\drivers\etc\hosts 2>nul
echo.
pause
goto menu
:host5
echo.
set /p files=�������ļ�����·��: 
cacls.exe "%files%" /e /t /p Administrators:N
echo ����ָ��·���ļ��ܾ�����
echo.
pause
goto menu
:host6
echo.
set /p files=�������ļ�����·��: 
cacls.exe "%files%" /e /t /g Administrators:F
echo ����ָ��·���ļ���ȫ����
echo.
pause
goto menu

:iereset
echo.
del /f /q "%temp%\mb" >nul 2>nul
echo Miniblink��������ɹ�
Rundll32 InetCpl.cpl,ClearMyTracksByProcess 255
echo IE��������ɹ�
RunDll32.exe InetCpl.cpl,ResetIEtoDefaults
echo IE������
regsvr32 /s jscript.dll
regsvr32 /s vbscript.dll
echo IE������޸�
echo.
pause
goto menu

:dnsfix
echo.
echo 0���������˵�
echo 1����ѡ: 119.29.29.29    ����: 8.8.8.8
echo 2����ѡ: 223.5.5.5       ����: 8.8.8.8
echo 3����ѡ: 114.114.114.114 ����: 8.8.8.8
echo 4����ѡ: 180.76.76.76    ����: 8.8.8.8
echo 5����ѡ: 8.8.8.8         ����: 223.5.5.5
echo 6����ѡ: 9.9.9.9         ����: 223.5.5.5(����Ӫ�̽ٳ�^)
echo 7����ѡ: 4.2.2.2         ����: 223.5.5.5
echo 8���ƶ�: 101.226.4.6     ����: 223.5.5.5
echo 9����ѡ: 80.80.80.80     ����: 223.5.5.5(����Ӫ�̽ٳ�^)
echo.
set /p dns=��ѡ��: 
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
echo    ����: ISP�ٳ���114DNS
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
call:dnsserver DNS�����óɹ�: 
ipconfig /flushdns >nul 2>nul
echo DNS������ˢ��
echo.
goto:eof

:programlist
for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<΢�� \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k
for /f "tokens=3,4*" %%i in ('reg query HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<΢�� \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k
for /f "tokens=3,4*" %%i in ('reg query HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall /s 2^>nul ^|findstr "\<DisplayName" ^|findstr /v /r "\<΢�� \<Catalyst \<Office \<Microsoft \<AMD \<NVIDIA \<Intel \<Realtek \<Skype \<NVAPI"') do echo %%i %%j %%k
pause
goto menu

:powercfgperf
if "%systemver%"=="10" (
goto powercfgwin10
) else (
goto powercfgwin7
)
:powercfgwin10
powercfg /LIST |findstr "׿Խ����"
if "%errorlevel%"=="1" (
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
) else (
echo. >nul 2>nul
)
for /f "tokens=3" %%i in ('powercfg /LIST ^|findstr "׿Խ����"') do set powerguid=%%i
powercfg -s %powerguid%
echo.
goto powerlabelexit
:powercfgwin7
for /f "tokens=3" %%i in ('powercfg /LIST ^|findstr "������"') do set powerguid=%%i
powercfg -s %powerguid%
echo.
echo ��Դ����: ������(���óɹ�)
echo.
:powerlabelexit
pause
goto menu

:dnscachelist
echo.
echo DNS�����ѯ(��30s^): 
set dnsexclude=adguard sougou 360safe .cm.steampowered .cm.wmsjsteam. twitch media : images .arpa facebook pcs-sdk qq-web mousegesturesapi fanyi adtidy url.cn xunyou tyjsq .360. acfun aixifan gitee wps qhmsg azureedge sina weibo kdocs office wyjsq qy.net .ngaa. ithome img qq.com ppstream msedge smtcdns qiyi proxy-cnc xboxlive 321fenx nvidia .yy. gting map. youku ipip ip138 bilibili hdslb. microsoft toutiao news18a 126.net 163.com 127.net netease ixigua pstatp snssdk .msn. h5. googletagmanager msedge.api bdimg onedrive .live. zyx.qq digicert qzone teamviewer qun.qq lamyu qpic sobot qlogo idqqimg twitter youtube iqiyi cibntv bilivideo tdnsv6 shifen report bing bdstatic baidu xunyou taobao windows twitter vkjsq verykuai
if "%systemver%"=="10" (
powershell -executionpolicy bypass Get-DnsClientCache ^|select Entry,Data ^|Sort-Object -Property Entry -unique |findstr /v /i "%dnsexclude%"
) else (
for /f "tokens=1" %%i in ('ipconfig /displaydns ^|findstr /v /I "%dnsexclude%" ^|findstr /v ":" ^|findstr ".com .cn .org .net .info .com.cn .top .vip .shop .jp .xyz .wang .win .pub .ru .tw .eu"') do echo   %%i
)
pause
goto menu

:securitysoft
echo ��ȫ/����/����/ģ����/�������: && for /f "tokens=1,10 delims=," %%i in ('tasklist /v /fo csv ^|findstr /I "%securitysoftwareprocess%"') do echo    %%i ����:%%j

rem �������
tasklist /v /fo csv |findstr /I "2345" >nul 2>nul
if %ERRORLEVEL% equ 0 (
	set softwareresult2345=����2345ȫ��Ͱϵ��
) else (
	echo. >nul 2>nul
)

echo.
goto:eof

:minidump
echo MinidumpĿ¼: && dir %WINDIR%\Minidump |findstr �ļ�
echo.
goto:eof

:ipv6state
wmic nicConfig where "IPEnabled='True'" get IPAddress |find ":" |findstr /i "[0-9][a-f]*: [a-f][0-9]*:" >nul
if "%errorlevel%"=="0" (
echo IPv6Э��: ������ (������IPv4����^)
for /f "tokens=1,2,3" %%i in ('netsh interface ipv6 show prefixpolicies ^|findstr [0-9]') do netsh interface ipv6 set prefixpolicy %%k %%i %%j >nul 2>nul
netsh interface ipv6 set prefixpolicy ::ffff:0:0/96 100 4 >nul 2>nul
) else (
echo IPv6Э��: �ѹر�
)
echo.
goto:eof

:ieproxy
rem ��ȡ����������Ϣ
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2>nul >nul
if %ERRORLEVEL%==0 (
for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2^>nul') do set autoconfigurl=%%i
) else (
set autoconfigurl=��
)

rem ��������״̬
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2>nul >nul
if %ERRORLEVEL% equ 0 (
	reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /f >nul 2>nul
	reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL 2>nul >nul
	if !ERRORLEVEL! equ 0 (
		set autoconfigurlresult=���ش��������쳣: �޸�ʧ��
	) else (
		set autoconfigurlresult=���ش��������쳣: �޸��ɹ�
	)
) else (
	echo. >nul 2>nul
)

for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable 2^>nul') do set proxyenable=%%i
if DEFINED proxyenable (
if %proxyenable%==0x0 set proxyenable=��
if %proxyenable%==0x1 set proxyenable=��
) else (
echo. >nul 2>nul
)

for /f "tokens=3" %%i in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer 2^>nul') do set proxyserver=%%i
rem ��ȡ�������10���ַ���
echo ��������: AutoConfigURL: %autoconfigurl:~0,20% %autoconfigurlresult%
echo    ����״̬: %proxyenable%
if not "!proxyserver!" == "" (
echo    ��ַ/�˿�: %proxyserver%
)
set autoconfigurl=<nul
echo.

if "%systemver%"=="10" (
rem �����Զ��������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" /v DefaultConnectionSettings /t REG_BINARY /d 4600000000 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections" /v SavedLegacySettings /t REG_BINARY /d 4600000000 /f >nul 2>nul
) else (
echo. >nul
)
rem �����Զ�����URL
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoConfigURL /f >nul 2>nul

rem �ֶ���������
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /d "" /f >nul 2>nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "" /f >nul 2>nul
goto:eof

:systemfirewalloff
netsh advfirewall set allprofiles state off >nul 2>nul
echo Windowsϵͳ����ǽ: �ѹر�
echo.
goto:eof

:systemfirewallon
netsh advfirewall set allprofiles state on >nul 2>nul
echo Windowsϵͳ����ǽ: �ѿ���
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
	echo ����ϵͳʱ��: %date:~0,10% %time:~0,8%  ���߱���ʱ��: !timeonline!
	echo.
)

rem �������
echo %date% |findstr /c:- >nul 2>nul
if %ERRORLEVEL% equ 0 (set datedelims=-) else ( echo. >nul 2>nul )
echo %date% |findstr /c:. >nul 2>nul
if %ERRORLEVEL% equ 0 (set datedelims=.) else (set datedelims=/)
for /f "tokens=1" %%i in ('echo %date%') do (
for /f "tokens=1,2,3 delims=%datedelims%" %%a in ('echo %%i') do (
rem ��/��/��, ��/��/��, ��/��/��
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
			set dateresult=ϵͳ�����쳣%date% 
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
for /f "tokens=2,3 delims=��" %%i in ('powershell -executionpolicy bypass Invoke-RestMethod %2 -TimeoutSec 15 2^>nul') do (
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
set mturesult=����: �ϲ��豸MTUС��1400
) else (
set mturesult=
)
for /f "tokens=3" %%i in ('netsh int ip show interfaces ^|findstr /r "\<connected" ^|findstr /r "��̫�� ��������"') do set mtuvalue=%%i
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V ReleaseId 2^>nul') do set systemversion=%%i
for /f "delims=." %%i in ('wmic datafile where name^="C:\\Program Files\\Internet Explorer\\IEXPLORE.EXE" get Version 2^>nul ^|findstr /i /c:"."') do set ieversion=%%i

echo.
for /f "tokens=1,*" %%i in ('ver') do echo %%i %%j %systemversion%
echo �������: %COMPUTERNAME%
echo IE�����: %ieversion%
echo ����MTU: %mtuvalue%
if not "!mturesult!" == "" (
	echo %mturesult%
)

rem �������

if DEFINED systemversion (
	if "%systemversion%" GTR "1809" (
		echo. >nul 2>nul
	) else (
		set systemversionresult=Win10ϵͳ�汾%systemversion%����, ��������
		echo !systemversionresult!
	)
) else (
echo. >nul 2>nul
)
echo.
goto:eof

:tracerttable
rem IPV4·������ͳ��
for /f %%i in ('route print -4 300.300.300.300 ^|find /c /v ""') do set routeexclude=%%i
for /f %%i in ('route print -4 ^|find /c /v ""') do set routeall=%%i
set /a routeall=%routeall%-%routeexclude%-2
rem vpn����
for /f "tokens=4" %%i in ('route print 10.33.0.0 ^|findstr "10.33.0.0"') do set vpngateway=%%i

rem �������
if DEFINED vpngateway (
	if %routeall% GEQ 10 ( echo. >nul 2>nul ) else ( set routeresult=ģʽB·�ɱ��쳣 )
) else (
	echo. >nul 2>nul
)

echo ·�ɸ��ٽ��
echo    IPv4·�ɱ�ͳ��: %routeall%(��)
if not "!vpngateway!" == "" (
	echo    ģʽB����: %vpngateway%
)
set vpngateway=<nul
if "%powershellver%" GEQ "3" (
for /f "delims==" %%i in ('tracert -d -w 20 -h 5 114.114.114.114 ^|findstr ^[1-9] ^|findstr /v "114.114.114.114" ^|findstr /i "%ipv4ipv6%"') do (
set tracestr=%%i
set tracestr=!tracestr:ms=!
set tracestr=!tracestr:^<=!
set tracestr=!tracestr:����=!
for /f "tokens=1,2,3,4,5" %%i in ('echo !tracestr!') do (
for /f %%a in ('powershell -executionpolicy bypass Invoke-RestMethod http://whois.pconline.com.cn/ip.jsp?ip^=%%m -TimeoutSec 15 2^>nul') do set IPquyu=%%a
echo  %%i   %%j ms   %%k ms   %%l ms    %%m !IPquyu! |%temp%\mtee /a /+ %temp%\traceroute.txt
)
)
) else (
for /f "tokens=*" %%i in ('tracert -w 100 -d -h 5 114.114.114.114 ^|findstr ^[1-9] ^|findstr /v "114.114.114.114" ^|findstr /i "%ipv4ipv6%"') do echo    %%i |%temp%\mtee /a /+ %temp%\traceroute.txt
)

rem �������
type %temp%\traceroute.txt 2>nul |findstr /N "." |findstr "\<2:" |findstr "172.1[0-9]\. 10.[0-9]\. 10.10\." >nul 2>nul
if %ERRORLEVEL% equ 0 (
	set tracertresult=��������
) else (
	type %temp%\traceroute.txt 2>nul |findstr /N "." |findstr "\<3:" |findstr "192.168\. 172.1[0-9]\. 10.[0-9]\. 10.10\." >nul 2>nul
	if !ERRORLEVEL! equ 0 (
		set tracertresult=��������
	) else (
		echo. >nul 2>nul
	)
)
del /f /q %temp%\traceroute.txt >nul 2>nul

echo.
goto:eof

:nicinterface
echo ����: 
rem �����б�
	for /f "tokens=1,2,4 delims=," %%i in ('Getmac /v /nh /fo csv') do (
		set networkstatus=%%k
		echo    %%i %%j  !networkstatus:~1,7! |%temp%\mtee /a /+ %temp%\networkadapter.txt
	)

netsh wlan show Interfaces |findstr /R "\<SSID" >nul
if "%errorlevel%"=="0" (

	rem ��ȡ����WIFI�ֶ���Ϣ
	set WF=0
	for /f "tokens=2 delims=:" %%i in ('netsh wlan show Interfaces') do (
		for /f "tokens=1" %%a in ('echo %%i') do (
		set /a WF+=1
		set wifi!WF!=%%a
		)
	)

	echo    WiFi:!wifi7!   ״̬:!wifi6!   �ŵ�:!wifi14!   �ź�:!wifi17!   �ٶ�:!wifi16!Mbps

	rem WIFI���������ж�
	if "!wifi17:~0,-1!" LEQ "95" ( set wifiresult1=WIFI�źŲ��ȶ� ) else ( echo. >nul 2>nul )
	if "!wifi14!" GEQ "36" ( set wifiresult2=��ǰ5G��WIFI,������Ϸ����ʹ��2.4G,������� ) else ( echo. >nul 2>nul )

	rem wifi������Ϣ
	for /f "tokens=2,4 delims=," %%i in ('DRIVERQUERY /fo csv ^|findstr "Wireless" ^|findstr "[0-9]/[0-9]/[0-9]"') do echo    %%i ��������%%j

) else (
	echo >nul 2>nul
)

rem ͳ����������
	call:textlines %temp%\networkadapter.txt -100
	if "!textlinesnum!" GEQ "2" (
			type %temp%\networkadapter.txt 2>nul |findstr /i "tap SangforVNIC yltap" >nul 2>nul
			if !ERRORLEVEL! equ 0 (
				set networkcardresult1=��������:!textlinesnum!,��������������VPN�豸��������
			) else (
				echo. >nul 2>nul
			)

			type %temp%\networkadapter.txt 2>nul |findstr /i "vmware virtualbox" >nul 2>nul
			if !ERRORLEVEL! equ 0 (
				set networkcardresult2=�������������
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
echo Ӳ��������Ϣ: 
for /f "tokens=*" %%i in ('wmic cpu get name ^|findstr /v "Name" ^|findstr "[^\S]"') do echo    CPU:  %%i
for /f %%i in ('wmic os get TotalVisibleMemorySize ^|findstr [0-9]') do set /a ram=%%i/1024
for /f %%i in ('wmic os get SizeStoredInPagingFiles ^|findstr [0-9]') do set /a virtualram=%%i/1024
echo    �ڴ�: %ram% MB; ��ǰ���������ڴ�: %VirtualRAM% MB
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get AdapterRAM^,Name /value ^|findstr Name') do set vganame=%%i
echo    �Կ�: %vganame%
for /f "tokens=1,2" %%i in ('wmic DesktopMonitor Get ScreenWidth^,ScreenHeight ^|findstr /i "\<[0-9]"') do echo    �ֱ���: %%j*%%i
rem Ӧ�ó��������Ϣ
if "%systemver%"=="10" (
for /f "tokens=1,2,4* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName Application -EntryType Error -Newest 2 -After %year%-%month%-%day% -Source 'Application Error' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo    %%i %%j ����: %%k %%l
) else (
echo. >nul 2>nul
)

rem �������
if DEFINED ram (
	if %ram% LSS 8000 (
		set /a ram=%ram%/1000
		set ramresult=ϵͳ�ڴ�!ram!G, ��������
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
set dnsresult=��Ӫ�̿���DNS�ٳ�
echo.
) else (
echo. >nul 2>nul
)

echo %1 %dnsserverip% %dnsresult%
goto:eof

:dnseventlog
if "%systemver%"=="10" (
for /f "tokens=1,2,4,6* skip=3" %%i in ('powershell -executionpolicy bypass Get-EventLog -LogName System -EntryType Warning -Newest 3 -After %year%-%month%-%day% -Source 'Microsoft-Windows-DNS-Client' 2^>nul ^^^| Select-Object TimeGenerated^,Message 2^>nul') do echo    %%i %%j %%k��Ӧ����: %%l %%m
) else (
echo. >nul 2>nul
)
echo.
goto:eof

:hostsdiag
rem hosts�ļ�����޸�ʱ��
IF EXIST %WINDIR%\system32\drivers\etc\hosts (
cd /d %WINDIR%\system32\drivers\etc >nul 2>nul
for /f "tokens=*" %%i in ('forfiles /M hosts /C "cmd /c echo @fdate @ftime" 2^>nul') do set filetime=%%i
rem ͳ��hosts��ע������
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|findstr "." ^|find /c /v ""') do set hostsnumber=%%i
rem #UHE������
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|find /c "#UHE_"') do set hostsnumberUHE=%%i
rem ͳ��127.0.0��
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|find /c "127.0.0"') do set hostsnumber127=%%i
rem ͳ��155.89��
for /f %%i in ('type %WINDIR%\system32\drivers\etc\hosts 2^>nul ^|findstr /v /b "\<#" ^|find /c "155.89"') do set hostsnumber155=%%i
echo hosts�޸�ʱ��:    !filetime!
echo     ��Ч������Ŀ����: !hostsnumber!(��^)
echo     ��UHEע����Ŀ��:  !hostsnumberUHE!(��^)
echo     127��ͷ��Ŀ��:    !hostsnumber127!(��^)
echo     155��ͷ��Ŀ��:    !hostsnumber155!(��^)
) else (
echo hosts�ļ�: ������
)
echo.

rem �������
for /f %%i in ("%WINDIR%\system32\drivers\etc\hosts") do set hostsize1=%%~zi
echo. >> %WINDIR%\system32\drivers\etc\hosts 2>nul
for /f %%i in ("%WINDIR%\system32\drivers\etc\hosts") do set hostsize2=%%~zi
if %hostsize1% equ %hostsize2% (
set hostsresult=hosts�ļ�Ȩ���쳣
) else (
echo. >nul 2>nul
)
goto:eof

:disableuac
echo.
echo ���׽���UAC
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d "3" /f
echo.
echo ���������������
echo.
pause
goto menu

:enableuac
echo.
echo �ָ�UAC
echo.
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d "5" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d "3" /f
echo.
echo ���������������
echo.
pause
goto menu


:xboxfix
echo.
echo �޸�Xbox������Ϸ
echo.
echo ��ʱ����Teredo���
netsh int teredo set state disable > NUL

echo ���û�˶GameFirst(����ж�أ�)
sc config AsusGameFirstService start= DISABLED > NUL
sc stop AsusGameFirstService > NUL

echo ��ʱֹͣϵͳ����
sc stop XblAuthManager > NUL
sc stop XboxNetApiSvc > NUL
sc stop iphlpsvc > NUL
sc stop upnphost > NUL
sc stop SSDPSRV > NUL
sc stop FDResPub > NUL

echo �޸�ϵͳʱ��ͬ������
sc stop w32time > NUL
w32tm /unregister > NUL
w32tm /register > NUL
sc start w32time > NUL

echo ����Windows����ǽ����
netsh advfirewall reset > NUL
netsh advfirewall set allprofiles state on > NUL
echo �ų���ͻ��Windows����ǽ����
netsh advfirewall set currentprofile firewallpolicy blockinbound,allowoutbound > NUL
netsh advfirewall firewall set rule name="4jxr4b3r3du76ina39a98x8k2" new enable=no > NUL

echo ͬ��ϵͳʱ��
w32tm /resync /force > NUL

echo �޸�����������
sc config IKEEXT start= AUTO > NUL
sc config FDResPub start= AUTO > NUL
sc config SSDPSRV start= AUTO > NUL
sc config upnphost start= AUTO > NUL
sc config XblAuthManager start= AUTO > NUL
sc config XboxNetApiSvc start= AUTO > NUL

echo ����ϵͳIPv6����
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

echo ����ϵͳ����
sc start IKEEXT > NUL
sc start FDResPub > NUL
sc start SSDPSRV > NUL
sc start upnphost > NUL

echo ����IPv6ǰ׺���ȼ�
netsh int ipv6 set prefix ::1/128 50 0 > NUL
netsh int ipv6 set prefix ::/0 40 1 > NUL
netsh int ipv6 set prefix 2002::/16 30 2 > NUL
netsh int ipv6 set prefix ::/96 20 3 > NUL
netsh int ipv6 set prefix ::ffff:0:0/96 100 4 > NUL

echo ����IP Helper����
sc start iphlpsvc > NUL

echo ����Teredo�������
route delete ::/0 > NUL
netsh int teredo set state type=default > NUL
netsh int teredo set state enterpriseclient teredo.remlab.net 20 0 > NUL
netsh int ipv6 add route ::/0 "Teredo Tunneling Pseudo-Interface" > NUL

echo ����Xbox�������
sc start XboxNetApiSvc > NUL
sc start XblAuthManager > NUL

echo �޸��������н�����
echo Teredo����״̬��
netsh int teredo show state
echo.
echo ���޸�Xbox������Ϸ ������ϵͳ��������
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
rem Win10ϵͳ�汾
if DEFINED systemversionresult ( echo *%systemversionresult% >> %temp%\infocollect.txt 2>nul & set systemversionresult=<nul ) else ( echo. >nul 2>nul )

rem �ڴ��С
if DEFINED ramresult ( echo *%ramresult% >> %temp%\infocollect.txt 2>nul ) else ( echo. >nul 2>nul )

rem lsp���
if DEFINED lspresult ( echo *%lspresult% >> %temp%\infocollect.txt 2>nul & set lspresult=<nul ) else ( echo. >nul 2>nul )
if DEFINED wegamelsp ( echo *%wegamelsp% >> %temp%\infocollect.txt 2>nul & set wegamelsp=<nul ) else ( echo. >nul 2>nul )

rem ��������
if DEFINED tracertresult ( echo *%tracertresult% >> %temp%\infocollect.txt 2>nul & set tracertresult=<nul ) else ( echo. >nul 2>nul )

rem ·�ɱ�
if DEFINED routeresult ( echo *%routeresult% >> %temp%\infocollect.txt 2>nul & set routeresult=<nul ) else ( echo. >nul 2>nul )

rem ϵͳʱ��
if DEFINED dateresult ( echo *%dateresult% >> %temp%\infocollect.txt 2>nul & set dateresult=<nul ) else ( echo. >nul 2>nul )

rem 2345��ʾ
if DEFINED softwareresult2345 ( echo *%softwareresult2345% >> %temp%\infocollect.txt 2>nul & set softwareresult2345=<nul ) else ( echo. >nul 2>nul )

rem ��Ӫ��dns�ٳ�
if DEFINED dnsresult ( echo *%dnsresult% >> %temp%\infocollect.txt 2>nul & set dnsresult=<nul ) else ( echo. >nul 2>nul )

rem hosts�ж�
if DEFINED hostsresult ( echo *%hostsresult% >> %temp%\infocollect.txt 2>nul & set hostsresult=<nul ) else ( echo. >nul 2>nul )

rem AutoConfigURL�ж�
if DEFINED autoconfigurlresult ( echo *%autoconfigurlresult% >> %temp%\infocollect.txt 2>nul & set autoconfigurlresult=<nul ) else ( echo. >nul 2>nul )

rem WIFI�ź��ŵ�
if DEFINED wifiresult1 ( echo *%wifiresult1% >> %temp%\infocollect.txt 2>nul & set wifiresult1=<nul ) else ( echo. >nul 2>nul )
if DEFINED wifiresult2 ( echo *%wifiresult2% >> %temp%\infocollect.txt 2>nul & set wifiresult2=<nul ) else ( echo. >nul 2>nul )
if DEFINED networkcardresult1 ( echo *%networkcardresult1% >> %temp%\infocollect.txt 2>nul & set networkcardresult1=<nul ) else ( echo. >nul 2>nul )
if DEFINED networkcardresult2 ( echo *%networkcardresult2% >> %temp%\infocollect.txt 2>nul & set networkcardresult2=<nul ) else ( echo. >nul 2>nul )

type %temp%\netdiag.txt 2>nul >> %temp%\infocollect.txt 2>nul
type %temp%\vkgameprocessip.txt 2>nul >> %temp%\infocollect.txt 2>nul
del /f /q %temp%\netdiag.txt >nul 2>nul

rem ��Ϸ������Ϣ��������
	if EXIST %temp%\infocollect.txt (
		taskkill /F /FI "WINDOWTITLE eq netdiag.txt*" >nul 2>nul
		echo F| xcopy "%temp%\infocollect.txt" "%userprofile%\desktop\NetDiagLog\netdiag.txt" /s /c /y /i >nul 2>nul
	) else (
		echo. >nul 2>nul
	)
goto:eof

:systempath
rem ���ϵͳ��������
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
echo ���޸��û���������, ������ϵͳ�����´򿪼�鹤��
pause
exit
goto:eof

:textlines
rem ��ȡ�ļ�������,����1�ı�·�� ����2, ��ʾ���n��, nΪ����, n����Ϊ��ֵ, ������������textlinesnum
set LINES=0
for /f "delims==" %%I in ('type %1 2^>nul') do ( set /a LINES=LINES+1 & set textlinesnum=!LINES! )
rem ��ʾ����
set /a LINES=LINES-%2
more +!LINES! < %1 2>nul
goto:eof

:IconRepair
echo ��ʼ�޸�ͼ��������
ping 127.1 -n 3 >nul
echo ��ʱ������Դ����������
taskkill /im explorer.exe /f
echo ����ͼ�껺��
CD /d %userprofile%\AppData\Local
DEL IconCache.db /a
echo ������Դ������
start explorer.exe
echo �޸���ɣ������������޸�
echo pause
goto menu

:BootTime
echo ����������س�ȷ�ϣ�����������ĸ������
set /p usertime=�趨����������ѡ��ĵȴ�ʱ�䣨�룩��
bcdedit /timeout %usertime%
echo �����ÿ���������ѡ��ȴ�ʱ��Ϊ%usertime%��
echo ����������ز˵�
pause
goto menu

:WinFocus
echo.
echo ��ʼ�޸�Windows�۽��쳣����
echo ������
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
DEL /F /S /Q /A "%USERPROFILE%/AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\Settings"
echo ���²�������
PowerShell -ExecutionPolicy Unrestricted -Command "& {$manifest = (Get-AppxPackage *ContentDeliveryManager*).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}"
echo �޸���ɣ����������ԣ���������ͨ�������ĵȴ�10���ӡ�����������޸���ҹ��۽����Ͳ��ȶ���
pause
goto menu

:borecover
echo ��ʼ�ָ���Դѡ�����ã����ֻ��Ϳ�����Ч������Surface��
echo �ָ�����ģʽ
powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a
echo �ָ�ƽ��ģʽ
powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e
echo �ָ�������ģʽ
powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo �ָ�׿Խ����ģʽ��������Win10/11רҵ�����ϣ�
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

echo ���õ�Դѡ��Ϊ������
powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
echo ��Դѡ��ָ����
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
echo �޸���ɣ��������������Ը���
pause
goto menu

:taskmgrexeErr
echo ��ʼ�޸�taskmgr.exe��������
echo �ؽ�ע���ֵ
reg add "HKEY_CLASSES_ROOT\Folder\shell\open" /v "MultiSelectModel" /t REG_SZ >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\open\command" /ve /t REG_EXPAND_SZ /d "%SystemRoot%\Explorer.exe" >nul
reg add "HKEY_CLASSES_ROOT\Folder\shell\open\command" /v "DelegateExecute" /t REG_SZ >nul
echo �޸���ɣ�����������
pause
goto menu

:exeError
echo ��ʼ�޸�exe��������
echo �ؽ�ע���ֵ
reg add "HKEY_CLASSES_ROOT\.exe" /ve /t REG_SZ /d exefile
reg add "HKEY_CLASSES_ROOT\.exe" /v "Content Type" /t REG_SZ /d "application/x-msdownload"
reg add "HKEY_CLASSES_ROOT\.exe\PersistentHandler" /ve /t REG_SZ /d "{098f2470-bae0-11cd-b579-08002b30bfeb}"
echo �ؽ�exe����
assoc .exe=exefile
echo �޸���ɣ�����������
pause
goto menu

:uautorunon
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 00000095
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 00000095
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\cdrom" /v Autorun /t REG_DWORD /d 00000001
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom" /v Autorun /t REG_DWORD /d 00000001
echo ������ɣ����ƶ��豸�Զ������ѿ���
pause
goto menu



:uautorunoff
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 000000ff
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 000000ff
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\cdrom" /v Autorun /t REG_DWORD /d 00000000
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\cdrom" /v Autorun /t REG_DWORD /d 00000000
echo ������ɣ����ƶ��豸�Զ������ѹر�
pause
goto menu

:hibernateon
powercfg -h on
echo ϵͳ�����ѿ���
pause
goto menu

:hibernateoff
powercfg -h off
echo ϵͳ�����ѹر�
pause
goto menu

:deactivate
echo ���棺ʹ�ô˹��ܽ��ᵼ��Windows��Ϊδ����״̬��
echo һ������£��˹��ܽ��ڳ��ּ����쳣������Կ�쳣�������ʹ��
echo �������֪��������ʲô�����˳������������������ȷ�ϻص���ҳ��
echo ��������ײ��ܳе���������������·�����Confirm���������������ִ�Сд��
ping 127.1 -n 2 >nul
set /p input=��ȷ�����Ĳ��������ִ�Сд����
if %input% equ Confirm goto deaconfirm
echo ȷ�ϲ����쳣����ȡ������
pause
goto menu
:deaconfirm
echo ж��Windows��Կ
slmgr /upk
echo ����Windows������
slmgr /rearm
echo ������ɣ�Windows�ѱ�Ϊδ����״̬�������������
pause
goto menu

:gpeditfix
echo ��ʼ�޸����������
pushd "%~dp0"
dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package~3*.mum >List.txt
dir /b C:\Windows\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package~3*.mum >>List.txt
for /f %%i in ('findstr /i . List.txt 2^>nul') do dism /online /norestart /add-package:"C:\Windows\servicing\Packages\%%i"
echo ����޸��������������
pause
goto menu

:junkclean
echo ��ʼ��������
echo ϵͳ��ɨ��
echo.

echo �����Զ����²�����־
del /f /s /q "%windir%\SoftwareDistribution\DataStore\Logs\*.log"
del /f /s /q "%windir%\SoftwareDistribution\DataStore\Logs\*.jrs"
echo.

echo ������󱨸�
del /f /s /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*.wer"
del /f /q "%ProgramData%\Microsoft\Windows\WER\ReportArchive\*.*"
echo.

echo ����Windows Search��־�ļ�
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jcp"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jtx"
del /f /s /q "%systemdrive%\ProgramData\Microsoft\Search\Data\Applications\Windows\*.jr"
echo.

echo ����IIS��־�ļ�
del /f /s /q "%windir%\System32\LogFiles\Fax\Incoming\*.*"
del /f /s /q "%windir%\System32\LogFiles\Fax\outcoming\*.*"
del /f /s /q "%windir%\System32\LogFiles\setupcln\setupact.log"
del /f /s /q "%windir%\System32\LogFiles\setupcln\setuperr.log"
echo.

echo ����Windows������־�ļ�
del /f /s /q "%windir%\setupact.log"
del /f /s /q "%windir%\setuperr.log"
echo.

echo ����.Net Framework��־
del /f /s /q "%windir%\Microsoft.NET\Framework\*.log"
echo.

echo ����Windows��־
del /f /s /q "%windir%\*.log"
echo.

echo ����ϵͳ��ʱ�ļ�
rd /s /q %windir%\temp & md %windir%\temp
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*"
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
echo.

echo �������ת���ļ�
del /f /q %userprofile%\AppData\Local\CrashDumps\*.*
echo.

echo ����Cookies
del /f /q %userprofile%\cookies\*.*
echo Recent & Jump list
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\recent\*.*"
del /f /s /q "%AppData%\Microsoft\Windows\Recent\CustomDestinations\*.*"
echo.

echo ������ʱInternet�ļ�
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\AppData\Local\Temporary Internet Files\*.*"
echo.

echo �������建��
del /f /s /q "%windir%\ServiceProfiles\LocalService\AppData\Local\FontCache\*.dat"
echo.

echo ����CryptoAPI֤�黺��
del /f /s /q "%userprofile%\AppData\LocalLow\Microsoft\CryptnetUrlCache\Content\*.*"
echo.

echo ����Ԥ�����ļ�
del /f /s /q "%windir%\Prefetch\*.pf"
echo.

echo �����Զ����²����ļ�
del /f /s /q "%windir%\SoftwareDistribution\Download\*.*"
echo.

echo ��������ͼ����
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\*.db"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Explorer\IconCacheToDelete\*.tmp"
echo.

echo ����Microsoft Edge����
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Extension State\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Session Storage\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\JumpListIconsRecentClosed\*.tmp"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Edge\User Data\Default\Cache\*.*"
echo.

echo ����Internet Explorer����
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Internet Explorer\DOMStore\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\container.dat"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCookies\deprecated.cookie"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\IE\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\WebCache\*.*"
echo.

echo ϵͳ����������
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

echo �������
pause
goto menu