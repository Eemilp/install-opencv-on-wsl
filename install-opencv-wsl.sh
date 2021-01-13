read -p "Install OpenCV? This can take considerable time. y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Building and Installing OpenCV..."
else
    exit
fi

sudo apt update
sudo apt install build-essential
sudo apt install cmake
sudo apt install git

sudo apt install libgtk-3-dev pkg-config
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
sudo apt install libjpeg-dev libpng-dev libtiff-dev gfortran openexr libatlas-base-dev
sudo apt install python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev

cd ~
mkdir opencv_with_contrib
cd opencv_with_contrib
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git

cd opencv
git checkout 4.5.1
cd ../opencv_contrib
git checkout 4.5.1
cd ..

mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE -D OPENCV_GENERATE_PKGCONFIG=ON -DOPENCV_ENABLE_NONFREE=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DOPENCV_EXTRA_MODULES_PATH=~/opencv_with_contrib/opencv_contrib/modules -DBUILD_opencv_legacy=OFF -DCMAKE_INSTALL_PREFIX=/usr/local ../opencv            
make -j4
sudo make install

read -p "Add OpeCV include path to ~/.bashrc? This is necessary for working with C++ y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Adding OpenCV path to default include path"
    echo $'\n\n#opencv include path for gcc\nCPLUS_INCLUDE_PATH=/usr/local/include/opencv4\nexport CPLUS_INCLUDE_PATH' >> ~/.bashrc
else
    exit
fi

echo "Done!"