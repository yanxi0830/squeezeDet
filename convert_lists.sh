#!/bin/bash
set -x

DATA_PATH="predata"

name=$1
image_list_path=$2
label_list_path=$3

source ~/lns/xiyan/venv/squeezeDet/bin/activate

mkdir $DATA_PATH
mkdir "$DATA_PATH/$name"
mkdir "$DATA_PATH/$name/ImageSets"
mkdir "$DATA_PATH/$name/training"
mkdir "$DATA_PATH/$name/training/image_2"
mkdir "$DATA_PATH/$name/training/label_2"

for i in `cat $image_list_path`; do cp "$i" "$DATA_PATH/$name/training/image_2"; done
for i in `cat $label_list_path`; do cp "$i" "$DATA_PATH/$name/training/label_2"; done
# cp `cat $image_list_path` "$DATA_PATH/$name/training/image_2"
# cp `cat $label_list_path` "$DATA_PATH/$name/training/label_2"

ls "$DATA_PATH/$name/training/image_2/" | grep ".png" | sed s/.png// > "$DATA_PATH/$name/ImageSets/trainval.txt"

rm "data/KITTI"
cd data
ln -s "../$DATA_PATH/$name" "KITTI"
python2 "random_split_train_val.py"
