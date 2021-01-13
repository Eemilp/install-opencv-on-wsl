# Compile and install OpenCV on WSL
A guide for installing OpenCV on a WSL machine based on the tutorial by Roman Smirnov. 

A script that does all this is also included but I still recommend reading through these

## Step 0. Pre-requirements

This guide assumes a working Ubuntu WSL. 

I also recommend installing VSCode for working with WSL

## Step 1. Tools and libraries

Install necessary tools

```bash
sudo apt update
sudo apt install build-essentials
sudo apt install cmake
sudo apt install git
```

and libraries

```bash
sudo apt install pkg-config libgtk-3-dev
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
sudo apt install libjpeg-dev libpng-dev libtiff-dev gfortran openexr libatlas-base-dev
sudo apt install python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev
```

## Step 2. Download OpenCV

OpenCV is dowloaded to the home folder

```bash
cd ~
mkdir opencv_with_contrib
cd opencv_with_contrib
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
```

## Step 3. build and install OpenCV

Set OpenCV and OpenCV_contrib versions:

```bash
cd opencv
git checkout 4.5.1
cd ../opencv_contrib
git checkout 4.5.1
cd ..
```

Now build the project. This will take some time!

```bash
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE -DOPENCV_ENABLE_NONFREE=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DOPENCV_EXTRA_MODULES_PATH=~/opencv_with_contrib/opencv_contrib/modules -DBUILD_opencv_legacy=OFF -DCMAKE_INSTALL_PREFIX=/usr/local ../opencv            
make -j5
make install
```
## Step 3.5. Optional things

OpenCV should now be installed but there are a few additional things that make life easier.

Typically in C++ examples opencv is included like this:

```C++
#inlcude<opencv2/core.hpp> //this wont work, because we haven't specified the include path

#incldue<opencv4/opencv2/core.hpp> // instead this works
```
This can be fixed by opening `~/.bashrc` in a text editor and appending the following lines to the end:

```bash
#opencv include path for gcc
CPLUS_INCLUDE_PATH=/usr/local/include/opencv4
export CPLUS_INCLUDE_PATH
```

## Step 4. Test the installation

```bash

```