echo 
echo '======================================================================================'
echo 
echo "=========================== Coded by 0zxyx ==========================================="
echo 
echo '======================================================================================'
echo 


updatedb 2>/dev/null

sudo -l


echo 
whoami


echo 
id


echo 
echo "Grabbing Who Is Logged On"
echo 
w


echo 
echo "Grabbing Crontabs and Systemctl Timers"
echo 
crontab  -l
cat /etc/crontab
ls -la /var/spool/cron/crontabs/
systemctl list-timers


echo 
echo "Grabbing /etc/hosts"
echo 
cat /etc/hosts


echo 
echo "Grabbing Mail"
echo 
ls -la /var/mail


echo 
echo "Grabbing Listing Sockets"
echo 
ss -altp


echo 
echo "Grabbing Current Processes"
echo 
ps -ef


echo 
echo "Can $(whoami) Read Shadow"
echo 
cat /etc/shadow


echo 
echo "Can $(whoami) Write to Password"
echo 
getfacl /etc/passwd
attr -l /etc/passwd


echo 
echo "Grabbing System Capabilities"
echo 
capsh --print |sed 's/,/\r\n/g' |grep cap_sys_module


echo 
echo "Grabbing Custom Systemd Services"
echo 
find /etc/systemd/system  /usr/lib/systemd/system -type f  -printf "%T+ %p\n" |grep -v "00000000"


echo 
echo "Grabbing Users With Shell"
echo 
cat /etc/passwd | grep -v "nologin\|false\|sync"
echo 
echo "Try su With Password"
for i in $(cat /etc/passwd | grep -v "nologin\|false\|sync" | awk -F: '{print $1}'); do echo su $i ; done


echo 
echo "Grabbing Setuid Files"
echo 
find / -perm -4000 2>/dev/null


echo 
echo "Grabbing Capabilities"
echo 
getcap -r / 2>/dev/null


echo 
echo "Grabbing Files Drop By Users Inside /usr/local/sbin/ /usr/sbin/ /usr/bin /sbin /bin"
echo 
for i in /usr/local/sbin/ /usr/sbin/ /usr/bin /sbin /bin ; do find $i -type f  -printf "%T+ %p\n"  |grep -v 00000000;done


echo 
echo "Grabbing /"
echo 
ls -la / |grep -v 'bin\|dev\|home\|initrd.img.old\|lib32\|libx32\|media\|opt\|sbin\|sys\|usr\|vmlinuz\|boot\|etc\|initrd.img\|lib\|lib64\|lost+found\|mnt\|proc\|run\|srv\|tmp\|var\|vmlinuz.old\|cdrom\|snap'


echo 
echo "Grabbing /var/backups"
echo 
ls -la /var/backups


echo 
echo "Grabbing $(whoami) Group(s) Files"
echo 
for i in `groups` ;do find / -type f -group $i -ls 2>/dev/null |grep -v '/sys\|/proc\|/run'; done 


echo 
echo "Grabbing Files $(whoami) Own"
echo 
find / -type f -user $(whoami) 2> /dev/null  | grep -v '/run\|/sys\|/proc'


echo 
echo "Grabbing $(whoami) Config Files From /etc"
echo 
grep $(whoami) /etc -R 2>/dev/null


echo 
echo "Grabbing /opt  Limited to 100"
echo 
find /opt -type f |head -n 100


echo 
echo "Grabbing /var/www/  Limited to 100"
echo 
find /var/www/ -type f |head -n 100


echo 
echo "Grabbing Passwords From /var/www, /home, /etc"
echo 
grep --exclude={*.css,*.js.map,*.css.map,*.min.map,*.svg} -ri 'pwd\|passwd\|password\|dbuser\|dbpass\|dbpwd\|PWD\|credential\|token' /var/www /home/ /etc 2>/dev/null


echo 
echo "Grabbing Files Named passwd ,password ,cred.txt ,credential.txt"
echo 
find / -type f  \( -iname "passwd" -o -iname "password" -o -iname "cred.txt" -o -iname "credential.txt" \)  2>/dev/null


echo 
echo "Grabbing env"
echo 
env


echo 
echo "Grabbing /home"
echo 
ls -la /home


echo 
echo "Grabbing Users Files Limited to 100"
echo 
for i in $(ls  /home); do find /home/$i -type f |head -n 100 ;echo ; done


echo 
echo "Grabbing Users RC Files"
echo 
for i in $(ls  /home); do ls -la /home/$i |grep 'rc$' ;echo ; done


echo 
echo "Grabbing / For id_rsa ,.env Files"
echo 
find / -type f  \( -iname "id_rsa" -o -iname ".env" \)  2>/dev/null


echo 
echo "Grabbing / For PRIVATE KEY Files"
echo
grep -r 'BEGIN OPENSSH PRIVATE KEY\|BEGIN RSA PRIVATE KEY' / 2>/dev/null


echo 
echo "Grabbing Hashes Inside Files (Comming Soon)"
echo 



start_year=$(stat /etc/passwd |grep Modify |awk '{print $2}' | awk -F"-" '{print $1}')
start_month=$(stat /etc/passwd |grep Modify |awk '{print $2}' | awk -F"-" '{print $2}')
start_date=$(stat /etc/passwd |grep Modify |awk '{print $2}' | awk -F"-" '{print $3}')


echo 
echo "Grabbing Files Using /etc/passwd Date: $start_year-$start_month-$start_date"
echo 
sleep 3

if [ "$start_month" -gt 11 ]
then
        if [ "$start_date" -lt 26 ]
        then
                end_date=$((10#$start_date+6))
                fdate=$start_year-$start_month-$start_date
                sdate=$start_year-$start_month-$end_date
                echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
		echo 
                sleep 2
                find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
        else
                end_year=$(($start_year+1))
                end_month=$(($start_month-11))
                end_date=$(($start_date-25))
                end_date=$((end_date+1))
                fdate=$start_year-$start_month-$start_date
                sdate=$end_year-$end_month-$end_date
                echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
		echo 
                sleep 2
                find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
        fi

elif [ "$start_date" -lt 24 ]
then
        end_date=$((10#$start_date+5))
        fdate=$start_year-$start_month-$start_date
        sdate=$start_year-$start_month-$end_date
        echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
	echo 
        sleep 2
        find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
else
        end_month=$((start_month+1))
        end_date=$((start_date-24))
        end_date=$((end_date+1))
        fdate=$start_year-$start_month-$start_date
        sdate=$start_year-$end_month-$end_date
        echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
	echo 
        sleep 2
        find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
fi


echo 
echo "Grabbing Files/Directory $(whoami) Can Read/Write"
echo 
find / -type f -readable  2> /dev/null  | grep -v '/run\|/sys\|/proc\|/usr\|/boot\|/snap\|/etc'
find / -writable  2> /dev/null


