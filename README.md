# Getting sources

repo init -u https://github.com/Schischu/android_chagall_klimt.git -b android-6.0.1_r10
repo sync

# Building sources
./build.sh <device> <clean/noclean>
./build.sh chagalllte noclean
