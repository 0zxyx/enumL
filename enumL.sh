echo ""
echo '======================================================================================'
echo ""
echo "=========================== Coded by 0zxyx ==========================================="
echo ""
echo '======================================================================================'
echo ""


updatedb 2>/dev/null

sudo -l

eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo ""

whoami

sleep 1
echo ""
id

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Who Is Logged On"
echo ""
w


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Crontabs"
echo ""
cat /etc/crontab


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Mail"
echo ""
ls -la /var/mail

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Listing Sockets"
echo ""
ss -altp

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Current Processes"
echo ""
ps -ef

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Can $(whoami) Read Shadow"
echo ""
cat /etc/shadow


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing System Capabilities"
echo ""
capsh --print |sed 's/,/\r\n/g' |grep cap_sys_module

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Custom Systemd Services"
echo ""
find /etc/systemd/system  /usr/lib/systemd/system -type f  -printf "%T+ %p\n" |grep -v "00000000"

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Users With Shell"
echo ""
cat /etc/passwd | grep -v "nologin\|false\|sync"
echo ""
echo "Try su With Password"
for i in $(cat /etc/passwd | grep -v "nologin\|false\|sync" | awk -F: '{print $1}'); do echo su $i ; done


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Setuid Files"
echo ""
find / -perm -4000 2>/dev/null


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Capabilities"
echo ""
getcap -r / 2>/dev/null


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Files Drop By Users Inside /usr/sbin/ /usr/bin /sbin /bin"
echo ""
for i in /usr/sbin/ /usr/bin /sbin /bin ; do find $i -type f  -printf "%T+ %p\n"  |grep -v 00000000;done



sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing /"
echo ""
ls -la / |grep -v 'bin\|dev\|home\|initrd.img.old\|lib32\|libx32\|media\|opt\|sbin\|sys\|usr\|vmlinuz\|boot\|etc\|initrd.img\|lib\|lib64\|lost+found\|mnt\|proc\|run\|srv\|tmp\|var\|vmlinuz.old\|cdrom\|snap'


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing /var/backups"
echo ""
ls -la /var/backups



sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing $(whoami) Group(s) Files"
echo ""
for i in `groups` ;do find / -type f -group $i -ls 2>/dev/null |grep -v '/sys\|/proc\|/run'; done 

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Files $(whoami) Own"
echo ""
find / -user $(whoami) 2> /dev/null  | grep -v '/run\|/sys\|/proc'



sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing $(whoami) Config Files From /etc"
echo ""
grep $(whoami) /etc -R 2>/dev/null


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing /opt  Limited to 100"
echo ""
find /opt |head -n 100


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing /var/www/  Limited to 100"
echo ""
find /var/www/  |head -n 100


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Passwords From /var/www"
echo ""
grep --exclude={*.css,*.js,*.js.map,*.css.map,*.min.map,*.svg} -ri 'pwd\|passwd\|password\|dbuser\|dbpass\|PWD\|PASSWD\|PASSWORD' /var/www 2>/dev/null

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Files Named passwd ,password ,cred.txt ,credential.txt"
echo ""
find / -type f  \( -iname "passwd" -o -iname "password" -o -iname "cred.txt" -o -iname "credential.txt" \)  2>/dev/null

sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Hashes Inside Files (comming soon)"
echo ""



sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing /home"
echo ""
ls -la /home


sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Users Files"
echo ""
for i in $(ls  /home); do find /home/$i ;echo ; done



sleep 1
eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo ""

start_year=$(stat /etc/passwd |grep Modify |awk '{print $2}' | awk -F"-" '{print $1}')
start_month=$(stat /etc/passwd |grep Modify |awk '{print $2}' | awk -F"-" '{print $2}')
start_date=$(stat /etc/passwd |grep Modify |awk '{print $2}' | awk -F"-" '{print $3}')

echo "Grabbing Files Using /etc/passwd Date: $start_year-$start_month-$start_date"
echo ""
sleep 3

if [ "$start_month" -gt 11 ]
then
        if [ "$start_date" -lt 26 ]
        then
                end_date=$((10#$start_date+6))
                fdate=$start_year-$start_month-$start_date
                sdate=$start_year-$start_month-$end_date
                echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
		echo ""
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
		echo ""
                sleep 2
                find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
        fi

elif [ "$start_date" -lt 24 ]
then
        end_date=$((10#$start_date+5))
        fdate=$start_year-$start_month-$start_date
        sdate=$start_year-$start_month-$end_date
        echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
	echo ""
        sleep 2
        find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
else
        end_month=$((start_month+1))
        end_date=$((start_date-24))
        end_date=$((end_date+1))
        fdate=$start_year-$start_month-$start_date
        sdate=$start_year-$end_month-$end_date
        echo "find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null"
	echo ""
        sleep 2
        find / -type f -newermt $fdate ! -newermt $sdate -ls  2>/dev/null
fi


eval printf '=%.0s' {1..$(stty size | cut -d' ' -f2)}
echo "Grabbing Files $(whoami) Can Read"
read -n 1 -s -r -p "Press any key to continue..."
echo ""
find / -readable  2> /dev/null  | grep -v '/run\|/sys\|/proc\|/usr\|/boot\|/snap\|/etc'





