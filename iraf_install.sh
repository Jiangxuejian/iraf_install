#!/bin/bash
#script for IRAF installation under Linux
# History:
# 2011/05/25	Jiang Xuejian	First release
echo "*************************************************************"
echo "**                  IRAF installation                      **"
echo "** It will be better if you have installed tcsh and        **"
echo "** downloaded iraf-linux.tar.gz before you run this script.**"
echo "** And this script will NOT creat a new user 'iraf'        **"
echo "** ref: http://astroleaks.lamost.org/?p=1563 (Chinese)     **"
echo "** ref: http://geco.phys.columbia.edu/~rubab/iraf/iraf_step_by_step_installation"
echo "*************************************************************"
 
echo "Swithing to root. Please enter your root password:"
sudo su
echo "Insatalling tcsh. Which Linux distribution are you using? "
read -p "Please select [1]I have tsch, [2]Fedora or [3]Ubuntu:" os

input=$(echo $os |grep '[1-3]') 
if [ "$input" == "" ]; then
	echo "You input incorrectly...."
	exit 1 
fi

if [ "$os" == "1" ]; then
	echo "Good"
elif [ "$os" == "2" ]; then
      yum install tcsh
elif [ "$os" == "3" ]; then
      apt-get install tcsh
fi

sudo mkdir -p /iraf/iraf/local
cd /iraf/iraf

#useradd -s /bin/tcsh -d /iraf/iraf/local iraf 
#passwd iraf
#chown -R iraf:iraf /iraf
#  su iraf -c "setenv iraf /iraf/iraf"
cd /iraf/iraf
read -p "Do you have iraf-linux.tar.gz? [y|n]" got_it_or_not
#echo -e "[3] I have iraf-linux.tar.gz but it is NOT in /iraf/iraf"

input=$(echo $got_it_or_not |grep '[yn]') 
if [ "$input" == "" ]; then
	echo "You input incorrectly...."
	exit 1 
fi

if [ "$got_it_or_not" == "y" ]; then
	iraf_location=$(locate iraf-linux.tar.gz)
	if [ "$iraf_location" == "" ]; then
	read -p "Please input the absolute path of iraf-linux, (e.g. /home/snow/Desktop): " location 
	iraf_location=$(find $location -name iraf-linux.tar.gz)
	fi
#	echo -e "Plase enter the password for user 'iraf'"
	mv $iraf_location /iraf/iraf/
	tar -xvf  ./iraf-linux.tar.gz
	csh /iraf/iraf/unix/hlib/install
elif [ "$got_it_or_not" == "n" ]; then
	echo -e "Please be sure you are connecting to the Internet"
#	echo -e "Plase enter the password for user 'iraf'"
	wget ftp://iraf.noao.edu/iraf/v215/PCIX/iraf-linux.tar.gz
	mv $iraf_location /iraf/iraf/
	tar -xvf  ./iraf-linux.tar.gz
	/iraf/iraf/unix/hlib/install 
	csh /iraf/iraf/unix/hlib/install
#elif [ "$got_it_or_not" == "2" ]; then
#elif [ "$got_it_or_not" == "3" ]; then
#	iraf_location=$(locate iraf-linux.tar.gz)
#	mv $iraf_location /iraf/iraf/
#	tar -xvf  ./iraf-linux.tar.gz
#	echo -e "Plase enter the password for user 'iraf'"
#	csh /iraf/iraf/unix/hlib/install
fi


#====================install x11iraf===============
read -p "Do you want to install X11iraf? [y|n]" x11iraf
input=$(echo $x11iraf |grep '[yn]') 
if [ "$input" == "" ]; then
	echo "You input incorrectly...."
	exit 1 
fi

if [ "$x11iraf" == "y" ]; then
	read -p "Do you have x11iraf*.tar.gz? [y|n]" got_it_or_not
	input=$(echo $got_it_or_not |grep '[yn]') 
	if [ "$input" == "" ]; then
	echo "You input incorrectly...."
	exit 1 
	fi

	if [ "$got_it_or_not" == "y" ]; then
	x11_location=$(locate x11iraf*.tar.gz)
		if [ "$x11_location" == "" ]; then
		x11_location=$(find iraf_location -name 'x11iraf*.tar.gz');fi
		
		if [ "$x11_location" == "" ]; then
		read -p "Please input the absolute path of X11iraf, (e.g. /home/snow/Desktop): " location 
	x11_location=$(find $location -name 'x11iraf.tar.gz');fi
	
	else	
#	echo -e "Plase enter the password for user 'iraf'"
	wget http://iraf.noao.edu/x11iraf/x11iraf-v2.0BETA-bin.redhat.tar.gz;\
	mkdir /iraf/x11iraf;\
	cd /iraf/x11iraf/;\
	tar -zxf x11iraf-v2.0BETA-bin.redhat.tar.gz
		if [ "$os" == "3" ]; then
		mv lib.redhat lib.linux
		mv bin.redhat bin.linux
		fi
	./install
	fi
fi
#iraf_location=$(find $location -name iraf-linux.tar.gz)
#	su iraf -c "mv $iraf_location /iraf/iraf/"
#	su iraf -c "tar -xvf  ./iraf-linux.tar.gz"
#	echo -e "Plase enter the password for user 'iraf'"
#	su iraf -c "csh /iraf/iraf/unix/hlib/install"
#	sudo csh /iraf/iraf/unix/hlib/install
#elif [ "$got_it_or_not" == "2" ]; then

#======================install DS9=============
cd /iraf/iraf
read -p "Do you want to install DS9? [y|n]" ds9
input=$(echo $ds9 |grep '[yn]') 
if [ "$input" == "" ]; then
	echo "You input incorrectly...."
	exit 1 
fi

if [ "$ds9" == "y" ]; then
	read -p "Do you have ds9*.tar.gz? [y|n]" got_it_or_not
	input=$(echo $got_it_or_not |grep '[yn]') 
	if [ "$input" == "" ]; then
	echo "You input incorrectly...."
	exit 1 
	fi

	if [ "$got_it_or_not" == "y" ]; then
	ds9_location=$(locate ds9*.tar.gz)
		if [ "$x11_location" == "" ]; then
		ds9_location=$(find iraf_location -name 'ds9*.tar.gz');fi
		
		if [ "$ds9_location" == "" ]; then
		read -p "Please input the absolute path of DS9, (e.g. /home/snow/Desktop): " location 
	ds9_location=$(find $location -name 'ds9*.tar.gz');fi
	
	else	
#	echo -e "Plase enter the password for user 'iraf'"
	wget http://hea-www.harvard.edu/saord/download/ds9/linux/ds9.linux.6.2.tar.gz;\
	tar -zxf ds9.linux.6.2.tar.gz
	mv ds9 /usr/local/bin/
	fi
fi
#

cd
echo -e "Now enjoy IRAF using command "ecl""

