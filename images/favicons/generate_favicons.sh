#!/bin/bash

set -ex

svg=$1

size=(144 192 36 48 72 96 114 120 152 180 57 60 76 16 194 32 150 310 70)

echo Making bitmaps from your svg...

for i in ${size[@]}; do
  convert $svg -resize x$i "cat-$ix$i.png" 
done

echo Compressing...

## Replace with your favorite (e.g. pngquant)
# optipng -o7 favicon-*.png
#pngquant -f --ext .png favicon-*.png --posterize 4 --speed 1

echo Converting to favicon.ico...

convert $(ls -v cat-*.png) favicon.ico

## Clean-up maybe?
# rm favicon-*.png

echo Done
