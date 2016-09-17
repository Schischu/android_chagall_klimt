# Getting sources

## Marshmallow
repo init -u https://github.com/Schischu/android_chagall_klimt.git -b marshmallow-release

## Nougat
repo init -u https://github.com/Schischu/android_chagall_klimt.git -b nougat-release

repo sync

# Building sources
./build.sh <device> <clean/noclean>

./build.sh chagalllte noclean
