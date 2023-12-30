##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uO1
##Nc3NCtDXTlaDjofG5iZk2WPAYUJmYsyatrSuyoam9+PQiyzaXY8GTEdLziqqXBy7DfMUUaYU5NAUA0gud/APu7SDGr6vR6Zdy612aOru
##Kd3HFJGZHWLWoLaVvnQmhQ==
##LM/RF4eFHHGZ7/L34W0ltxK9DyVL
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4dI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+VslQ=
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
##L8/UAdDXTlaDjofG5iZk2WPAYUJmYsyatrSuyoam9+PQnyDKQo4bWWh/gyiyAVO4OQ==
##Kc/BRM3KXhU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba

#读取当前时间
$current_date = Get-Date -Format "yyyyMMdd"  
#组合需要查找的备份文件名
$file_name1 = "zkeco_"  
$file_name2 = $current_date
$file_name3 = "030000_1.sql"
$file_name = "$file_name1$file_name2$file_name3"
#指定查找目录
$sourceFolder = "C:\Users\HNCJ-liaobingzhi\Desktop\zkecodatabak"  
#指定转移目录
$destinationFolder = "C:\Users\HNCJ-liaobingzhi\Desktop\allbak"  
#通过文件名+查找目录找到文件
$file = Get-ChildItem -Path $sourceFolder -Filter $file_name -Recurse -Force -ErrorAction SilentlyContinue 
#如果找到文件，则转移至备份目录
if ($null -ne $file) {Copy-Item -Path $file.FullName -Destination $destinationFolder}