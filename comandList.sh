#!/bin/bash

# ১. সিস্টেম আপডেট এবং প্রয়োজনীয় সব টুলস ইনস্টল করা
echo "Step 1: Installing system dependencies..."
sudo apt update
sudo apt install -y git zip unzip openjdk-17-jdk python3-pip
sudo apt install -y autoconf libtool pkg-config m4 libtool-bin autoconf-archive libltdl-dev cmake
sudo apt install -y zlib1g-dev libncurses-dev libffi-dev libssl-dev libtinfo-dev

# ২. জাভা এনভায়রনমেন্ট সেটআপ (যাতে বিল্ডোজার জাভা খুঁজে পায়)
echo "Step 2: Setting up Java PATH..."
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

# ৩. বিল্ডোজার এবং সাইথন ইনস্টল করা
echo "Step 3: Installing Buildozer and Cython..."
pip3 install --user --upgrade "cython<3.0" buildozer
export PATH=$PATH:~/.local/bin

# ৪. buildozer.spec ফাইল চেক করা
echo "Step 4: Checking buildozer.spec file..."
if [ -f buildozer.spec ]; then
    echo "Found existing buildozer.spec, using it."
else
    echo "buildozer.spec not found! Initializing a new one..."
    buildozer init
    # নতুন ফাইলে লাইসেন্স অটো-একসেপ্ট অন করা যাতে বিল্ড না থামে
    sed -i 's/# android.accept_sdk_license = False/android.accept_sdk_license = True/' buildozer.spec
fi

# ৫. বিল্ড শুরু করা (Verbose মোডে যাতে সব লগ দেখা যায়)
echo "Step 5: Starting APK build process..."
buildozer -v android debug
