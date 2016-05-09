#!/bin/bash        
echo '-----------------------------------------------------'
echo 'Check sudo privileges...'
echo '-----------------------------------------------------'
if test $UID -ne 0
then
	echo 'type sudo before this script.'
	exit 1
fi

echo '-----------------------------------------------------'
echo 'Check system verion...'
echo '-----------------------------------------------------'
platform='unknown'
unamestr=`cat /etc/issue.net`
if [[ "$unamestr" != 'Ubuntu 14.04.4' ]]; then
   platform="$unamestr"
   echo 'You have' "$platform"'. You have to install 14.04.4-Ubuntu'
fi

cd 
cd Download
cd Pobrane

echo '-----------------------------------------------------'
echo 'Dependencies...'
echo '-----------------------------------------------------'
sudo apt-get update && sudo apt-get upgrade 

echo '-----------------------------------------------------'
echo 'Dependencies - OpenCV...'
echo '-----------------------------------------------------'
sudo apt-get install build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libavformat-dev libswscale-dev python-dev python-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
 
echo '-----------------------------------------------------'
echo 'Dependencies - Aruco...'
echo '-----------------------------------------------------'
sudo apt-get install libicu-dev freeglut3 freeglut3-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libxine-dev
 
echo '-----------------------------------------------------'
echo 'Dependencies - Bionik-game-CC...'
echo '-----------------------------------------------------'
sudo apt-get install libsdl2-dev 

echo '-----------------------------------------------------'
echo 'Dependencies - JSON...'
echo '-----------------------------------------------------'
sudo apt-get install libboost-test-dev libcurl libcurl3 libcurl4-openssl-dev libmicrohttpd-dev libargtable2-dev libjson0-dev libjson-glib-dev libjsoncpp-dev libjsonrpccpp-dev libjsonrpccpp-tools

echo '-----------------------------------------------------'
echo 'Dependencies - QT...'
echo '-----------------------------------------------------'
sudo apt-get install qt5-default qt5

# Dep - Update & Upgrade
sudo apt-get update && sudo apt-get upgrade

echo '-----------------------------------------------------'
echo 'Download lib-JSON-RPC and install...'
echo '-----------------------------------------------------'
git clone git://github.com/cinemast/libjson-rpc-cpp.git
cd libjson-rpc-cpp
mkdir build  && cd build
cmake -DCOMPILE_TESTS=NO ..
make
sudo make install
cd ../..

echo '-----------------------------------------------------'
echo 'Download OpenCV and install...'
echo '-----------------------------------------------------'
curl -o opencv-3.0.0.zip https://codeload.github.com/Itseez/opencv/zip/3.0.0
unzip "opencv-3.0.0.zip"
cd opencv-3.0.0/
mkdir build && cd build/
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j2
sudo make install
cd ../..

echo '-----------------------------------------------------'
echo 'Download Aruco and install...'
echo '-----------------------------------------------------'
wget http://sourceforge.net/projects/aruco/files/1.2.4/aruco-1.2.4.tgz
tar zxvf aruco-1.2.4.tgz 
cd aruco-1.2.4/
mkdir build && cd build/
cmake -DCMAKE_CXX_FLAGS="-std=c++11" ..
make
sudo make install
cd ../..

echo '-----------------------------------------------------'
echo 'Clean build files...'
echo '-----------------------------------------------------'
rm -rf aruco-1.2.4/build/
rm -f aruco-1.2.4.tgz
rm -rf opencv-3.0.0/build/
rm -f opencv-3.0.0.zip
rm -rf libjson-rpc-cpp/build/

echo '-----------------------------------------------------'
echo 'Get Bionik-game-CC from github...'
echo '-----------------------------------------------------'
git clone https://github.com/R-J-J/Bionik-game-CC.git
chmod -R u+rwx Bionik-game-CC/