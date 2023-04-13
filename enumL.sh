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
pinky


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
echo "Can $(whoami) Read/Write passwd/shadow Files"
echo 
cat /etc/shadow
ls -la /etc/{passwd,shadow}
getfacl /etc/{passwd,shadow}
attr -l /etc/{passwd,shadow}


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
echo "Grabbing Files Drop By Users Inside /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin"
echo 
for i in /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin ; do find $i -type f  -printf "%T+ %p\n"  |grep -v 00000000;done


echo 
echo "Can $(whoami) Write Inside /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin"
echo 
find /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin -writable  2>/dev/null


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
grep --exclude={*.css,*.js.map,*.css.map,*.min.map,*.svg} -Ri 'pwd\|passwd\|password\|dbuser\|db_user\|user\|db_password\|db_passwd\|dbpass\|dbpwd\|PWD\|credential\|token\|postgresql' /var/www /home/ /etc 2>/dev/null


echo 
echo "Grabbing .htpasswd/.htaccess From /"
echo
find / \( -iname ".htpasswd" -o -iname ".htaccess" \)  2>/dev/null


echo 
echo "Grabbing php Dangerous Functions From /var/www/"
echo
grep -Ri 'system\|exec\|passthru\|shell_exec\|`\|popen\|proc_open\|pcntl_exec\|file_put_contents\|file_get_contents\|ob_start\|array_diff_uassoc\|array_diff_ukey\|array_filter\|array_intersect_uassoc\|array_intersect_ukey\|array_map\|array_reduce\|array_udiff_assoc\|array_udiff_uassoc\|array_udiff\|array_uintersect_assoc\|array_uintersect_uassoc\|array_uintersect\|array_walk_recursive\|array_walk\|assert_options\|uasort\|uksort\|usort\|preg_replace_callback\|spl_autoload_register\|iterator_apply\|call_user_func\|call_user_func_array\|register_shutdown_function\|register_tick_function\|set_error_handler\|set_exception_handler\|session_set_save_handler\|sqlite_create_aggregate\|sqlite_create_function\|phpinfo\|posix_mkfifo\|posix_getlogin\|posix_ttyname\|getenv\|get_current_user\|proc_get_status\|get_cfg_var\|disk_free_space\|disk_total_space\|diskfreespace\|getcwd\|getlastmo\|getmygid\|getmyinode\|getmypid\|getmyuid\|extract\|parse_str\|putenv\|ini_set\|mail\|header\|proc_nice\|proc_terminate\|proc_close\|pfsockopen\|fsockopen\|apache_child_terminate\|posix_kill\|posix_mkfifo\|posix_setpgid\|posix_setsid\|posix_setuid\|fopen\|tmpfile\|bzopen\|gzopen\|chgrp\|chmod\|chown\|copy\|lchgrp\|lchown\|link\|mkdir\|move_uploaded_file\|rename\|rmdir\|symlink\|tempnam\|touch\|unlink\|imagepng\|imagewbmp\|image2wbmp\|imagejpeg\|imagexbm\|imagegif\|imagegd\|imagegd2\|iptcembed\|ftp_get\|ftp_nb_get\|file_exists\|file\|fileatime\|filectime\|filegroup\|fileinode\|filemtime\|fileowner\|fileperms\|filesize\|filetype\|glob\|is_dir\|is_executable\|is_file\|is_link\|is_readable\|is_uploaded_file\|is_writable\|is_writeable\|linkinfo\|lstat\|parse_ini_file\|pathinfo\|readfile\|readlink\|realpath\|stat\|gzfile\|readgzfile\|getimagesize\|imagecreatefromgif\|imagecreatefromjpeg\|imagecreatefrompng\|imagecreatefromwbmp\|imagecreatefromxbm\|imagecreatefromxpm\|ftp_put\|ftp_nb_put\|exif_read_data\|read_exif_data\|exif_thumbnail\|exif_imagetype\|hash_file\|hash_hmac_file\|hash_update_file\|md5_file\|sha1_file\|highlight_file\|show_source\|php_strip_whitespace\|get_meta_tags\|curl_exec\|curl_multi_exec\|scandir\|chdir\|chroot\|closedir\|dir\|getcwd\|opendir\|readdir\|rewinddir\|serialize\|unserialize' /var/www/ 2>/dev/null


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
echo "Grabbing Readable /proc/*/cwd Directories"
echo 
find /proc/ -readable -regex "/proc/[0-9]+/cwd" -exec ls -la {} \; 2>/dev/null


echo 
echo "Grabbing Readable /proc/*/environ Files"
echo
find /proc/ -type f -readable  -regex "/proc/[0-9]+/environ" -name environ 2>/dev/null


echo 
echo "Grabbing / For docker.sock Files"
echo
timeout 60 find / -iname docker.sock 2>/dev/null


echo 
echo "Grabbing / For PRIVATE KEY Files"
echo
timeout 120 grep -r 'BEGIN OPENSSH PRIVATE KEY\|BEGIN RSA PRIVATE KEY' / 2>/dev/null


echo 
echo "Grabbing Files/Directory $(whoami) Can Read/Write"
echo 
find / -type f -readable  2> /dev/null  | grep -v '/run\|/sys\|/proc\|/usr\|/boot\|/snap\|/etc'
find / -writable  2> /dev/null





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




