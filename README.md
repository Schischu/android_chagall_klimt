# Getting sources

repo init -u https://github.com/Schischu/android_chagall_klimt.git -b marshmallow-release

repo sync

# Building sources
./build.sh <device> <clean/noclean>

./build.sh chagalllte noclean
