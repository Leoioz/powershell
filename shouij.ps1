##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uK1
##Nc3NCtDXThU=
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4dI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ49I=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjofG5iZk2WPAYUJmYsyatrSuyoam9+PQnyDKQo4bWWjwYvx04Lo5hjOUtDpbsckUNQ==
##Kc/BRM3KXxU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
`powershell -Command "Start-Process PowerShell -ArgumentList '-Command &{Import-Module Posh-Privilege; Set-Privilege -Name SeBackupPrivilege -Value True; Set-Privilege -Name SeRestorePrivilege -Value True; Set-Privilege -Name SeTakeOwnPrivilege -Value True; Set-Privilege -Name SeAuditPrivilege -Value True; Set-Privilege -Name SeSystemtimePrivilege -Value True; Set-Privilege -Name SeTimeZonePrivilege -Value True; Set-Privilege -Name SeProfilePrivilege -Value True; Set-Privilege -Name SeCreateTokenPrivilege -Value True; Set-Privilege -Name SeShutdownPrivilege -Value True; Set-Privilege -Name SeSyncAgentPrivilege -Value True; Set-Privilege -Name SeDenyNetworkLogonRight -Value True; Set-Privilege -Name SeBatchLogonRight -Value True; Set-Privilege -Name InteractiveLogonRight -Value True; Set-Privilege -Name NetworkLogonRight -Value True; Set-Privilege -Name ServiceLogonRight -Value True; Set-Privilege -Name BackupLogonRight -Value True; Set-Privilege -Name RemoteShutdownPrivilege -Value True; Set-Privilege -Name TcbLogonRight -Value True; Set-Privilege -Name TcbPasswordChange privilege = true; Set-Privilege -Name TcbPrimaryDomainControllerLogonRight = true}'"
#获取板载品牌和型号信息
$brand = (Get-WmiObject -Class Win32_ComputerSystem -Property "Manufacturer").Manufacturer  
$model = (Get-WmiObject -Class Win32_ComputerSystem -Property "Model").Model  
$info0 = "（注意复制冒号后面所有内容）`n"
$info1 = "`n 04、你的计算机品牌型号：$brand $model`n" 

#获取初始系统安装日期
$installtime = (Get-WmiObject -Class Win32_OperatingSystem | Select-Object InstallDate).InstallDate
$year = $installtime.Substring(0,4)
$mounth = $installtime.Substring(4,2)
$day =  $installtime.Substring(6,2)
$info2 = "`n 05、初始安装日期：$year/$mounth/$day`n"

#获取系统序列号
#$serialnumber = (Get-WmiObject -Class Win32_BaseBoard -Property SerialNumber).SerialNumber
$serialnumber=wmic baseboard get SerialNumber /value | findstr /i "SerialNumber"
$serialnumber =$serialnumber -replace "SerialNumber=",""
$info3 = "`n 06、计算机序列号：$serialnumber`n"

#获取硬盘序列号拼接
$drives = Get-WmiObject -Class Win32_DiskDrive -Filter "DeviceID like '%'"  
$serialNumbers = @()  
foreach ($drive in $drives) {  
    $serialNumber = $drive.SerialNumber  
    $serialNumbers += $serialNumber  }  
$disknumber = $serialNumbers -join "/"
$disknumber = $disknumber -replace " ",""
$info4 = "`n 07、硬盘序列号：$disknumber `n"

# 获取物理网卡的IPv4地址  
#$physicalNetworkCards = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }  
#$physicalNetworkCards | ForEach-Object {  
#    $ipv4Addresses = Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue -InterfaceAlias $_.Name  
#    if ($ipv4Addresses) {  
#        $ipv4Address = $ipv4Addresses[0].IPAddress  
#        # 过滤掉包含指定字符的地址  
#        if ( ($ipv4Address -like "10.11.*")) { $ipAddress=$ipv4Address}}}

$ipAddress = ipconfig /all | findstr /i "10.11.*(首选)"
$ipAddress1 =$ipAddress -replace "   IPv4 地址 . . . . . . . . . . . . :","" 
$ipAddress2 =$ipAddress1.Substring(0,12)
$info5 = "`n 08、IP地址：$ipAddress2 `n"


# 获取物理网卡的MAC地址
$ipv4mac = Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -eq $ipAddress } | Get-NetAdapter | Select-Object -ExpandProperty MacAddress
$info6 = "`n 09、MAC地址：$ipv4mac `n"

#保存输出
$endfile = "$info0$info1$info2$info3$info4$info5$info6"
$desktop = [System.Environment]::GetFolderPath("Desktop")  
$relativePath = ".\电脑信息.txt"  
$endpath = "$desktop$relativePath"
$endfile | Out-File -FilePath $endpath
Start-Process "$desktop$relativePath"

#$filePath = Join-Path $desktop $relativePath  
#Add-Content -Path $filePath -Value $endfile
