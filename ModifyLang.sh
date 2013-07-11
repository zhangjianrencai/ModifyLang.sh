#! /bin/sh

MainMenu(){
  chose=$1
	case $chose in 
		'1')
			echo ""
			echo "You can change the following locale:"
			echo ""
			locale -a | grep fr > ./fr_temp
			awk '{print NR,$0}' ./fr_temp > ./fr_temp2
			mv ./fr_temp2 ./fr_temp
			awk '{print $0}' ./fr_temp
			;;
		'2')
			echo ""
			echo "You can change the following locale:"
			echo ""
			locale -a | grep zh > ./zh_temp
			awk '{print NR,$0}' ./zh_temp > ./zh_temp2
			mv ./zh_temp2 ./zh_temp
			awk '{print $0}' ./zh_temp
			;; 
		'3')
			echo ""
			echo "You can change the following locale"
			echo ""
			locale -a | grep ja > ./ja_temp
			awk '{print NR,$0}' ./ja_temp > ./ja_temp2
			mv ./ja_temp2 ./ja_temp
			awk '{print $0}' ./ja_temp
			;;
		'Q'|'q')
			exit
			;;
	esac
}

RUN(){
	CHR=$1
	echo "the CHR is '$CHR'"
	case "`uname -s`" in 
		AIX)
			chmod 777 /etc/environment
	 		awk '/^LANG=/{$0="LANG='$CHR'"}1' /etc/environment > /etc/Temp
			mv /etc/Temp /etc/environment
			echo "change success! congratulations!"
			;;	
		HP-UX)
			chmod 777 /etc/TIMEZONE
			awk '/^LANG=/{$0="LANG='$CHR'"}1' /etc/TIMEZONE > /etc/Temp
			mv /etc/Temp /etc/TIMEZONE
			echo "change success! congratulations!"
			;;
		SunOS*)
			chmod 777 /etc/TIMEZONE
			sed 's/^LANG=.*$/LANG='$CHR'/' /etc/TIMEZONE > /etc/Temp
			mv /etc/Temp /etc/TIMEZONE
			echo "change success! congratulations!"
			;;
		*)
			echo "sorry, the version can't support `uname -s` so far"
			;;
esac
}
#From here, must think about Muti-Platfrom: AIX/Linux Redhat /etc/environment
#Solaris/HP   /etc/TIMEZONE   		

SonMenu(){
	echo "
****************The Second Menu*************************
********************************************************
Continue install	Press 'The number of Language' *
Back to the MainMenu	Press 'B(b)'                   *
Quit the script		Press 'Q(q)'                   * 
Please make you choose:                                *
********************************************************" 
	read sonchoose
	NUM=$sonchoose
	if [ $NUM = "B" ];then
		return
	elif [ $NUM = "b" ];then
		return
	elif [ $NUM = "Q" ];then
		exit
	elif [ $NUM = "q" ];then
		exit
	else
		echo "now I will response your choose '$NUM'....."
	fi
	case $1 in
		'1')
			if [ $NUM -eq 1 ];then
				CHR=`awk '/^1 f/{print $2}' ./fr_temp`
				echo $CHR
			elif [ $NUM -eq 2 ];then
				CHR=`awk '/^2 f/{print $2}' ./fr_temp`
				echo $CHR
			else
				CHR=`awk '/^'$NUM'/{print $2}' ./fr_temp`		
				echo $CHR		
			fi
			;;
		'2')
			if [ $NUM -eq 1 ]; then
				CHR=`awk '/^1 z/{print $2}' ./zh_temp`
				echo $CHR
			elif [ $NUM -eq 2 ]; then
				CHR=`awk '/^2 z/{print $2}' ./zh_temp` 
			else
				CHR=`awk '/^'$NUM'/{print $2}' ./zh_temp`
				echo $CHR
			fi
			;;
		'3')
			if [ $NUM -eq 1 ];then 
				CHR=`awk '/^1 j/{print $2}' ./ja_temp`
				echo $CHR
			elif [ $NUM -eq 2 ];then
				CHR=`awk '/^2 j/{print $2}' ./ja_temp`
			else
				CHR=`awk '/^'$NUM'/{print $2}' ./ja_temp`
				echo $CHR
			fi
			;;
	esac	
	RUN $CHR
}

while ((1)); do
	clear
echo "
*******The Main Menu************
********************************
Please make your choose:       *
install fr   	Press '1'      *
install zh   	Press '2'      *
instakk ja	Press '3'      *
Quit		Press 'Q or q' *
********************************
"
	echo "Please make your Choose:"
	read choose
	MainMenu $choose
	if [ $choose = "Q" ]; then
		exit
	elif [ $choose = "q" ];then
		exit
	else	
		SonMenu $choose
	fi
	echo ""
	echo "******************************************"
	echo "Do you want to continue the percess? (y/n)"
	echo "Please make your choose:"
	read key
	if [ $key = "y" ] ; then	
		continue
	else 
		exit
	fi
 done





