# Compile and install OpenCV on WSL
A guide for installing OpenCV on a WSL machine based on the tutorial by Roman Smirnov. 

A script that does all this is included but I still recommend reading through this.

## Step 0. Pre-requirements

This guide is tested with Ubuntu WSL with WSL version 2. A guide for setting up a WSL machine can be found [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

I also recommend installing VSCode on Windows as it makes working with WSL machines convenient.

## Step 1. Install tools and libraries

Install necessary tools:

```bash
sudo apt update
sudo apt install build-essential
sudo apt install cmake
sudo apt install git
```

Install necessary libraries:

```bash
sudo apt install pkg-config libgtk-3-dev
sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev
sudo apt install libjpeg-dev libpng-dev libtiff-dev gfortran openexr libatlas-base-dev
sudo apt install python3-dev python3-numpy libtbb2 libtbb-dev libdc1394-22-dev
```

## Step 2. Download OpenCV

Clone opencv and opencv_contrib into `~/opencv_with_contrib`:

```bash
cd ~
mkdir opencv_with_contrib
cd opencv_with_contrib
git clone https://github.com/opencv/opencv.git
git clone https://github.com/opencv/opencv_contrib.git
```

## Step 3. build and install OpenCV

Set opencv and opencv_contrib versions:

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
cmake -DCMAKE_BUILD_TYPE=RELEASE -D OPENCV_GENERATE_PKGCONFIG=ON -DOPENCV_ENABLE_NONFREE=ON -DENABLE_PRECOMPILED_HEADERS=OFF -DOPENCV_EXTRA_MODULES_PATH=~/opencv_with_contrib/opencv_contrib/modules -DBUILD_opencv_legacy=OFF -DCMAKE_INSTALL_PREFIX=/usr/local ../opencv            
make -j4 #increasing the number will make building faster. Maximum value can be found by running nproc.
sudo make install
```
## Step 4. Include path for Gcc

OpenCV should now be installed but compiling C++ with opencv won't work yet.

This can be fixed by opening `~/.bashrc` in a text editor and appending the following lines to the end:

```bash
#OpenCV include path for gcc
CPLUS_INCLUDE_PATH=/usr/local/include/opencv4
export CPLUS_INCLUDE_PATH
```

## Note on compiling C++

For compiling add `pkg-config --cflags --libs opencv4` to gcc options.

## Step 5. Testing

The easiest way to test the installation is to run python3 and enter the following commands:

```python
import cv2
cv2.__version__
```
This should print your installed OpenCV version.