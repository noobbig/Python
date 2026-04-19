#!/bin/bash

# ১. সিস্টেম আপডেট এবং ডিপেন্ডেন্সি ইনস্টল
echo "Installing dependencies..."
sudo apt update
sudo apt install -y git zip unzip openjdk-17-jdk python3-pip \
autoconf libtool pkg-config m4 libtool-bin autoconf-archive \
libltdl-dev cmake zlib1g-dev libncurses-dev libffi-dev \
libssl-dev libtinfo-dev

# ২. বিল্ডোজার এবং সাইথন ইনস্টল
echo "Installing Buildozer and Cython..."
pip3 install --user --upgrade "cython<3.0" buildozer
export PATH=$PATH:~/.local/bin

# ৩. buildozer.spec ফাইল চেক করা
if [ -f buildozer.spec ]; then
    echo "Found existing buildozer.spec, using it..."
else
    echo "buildozer.spec not found! Creating a new one..."
    buildozer init
    # নতুন ফাইলে লাইসেন্স অটো-একসেপ্ট করার জন্য নিচের লাইনটি যোগ করা ভালো
    sed -i 's/# android.accept_sdk_license = False/android.accept_sdk_license = True/' buildozer.spec
fi

# ৪. এপিকে বিল্ড শুরু
echo "Starting APK build process..."
buildozer -v android debug
