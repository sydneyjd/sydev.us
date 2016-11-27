#!/bin/bash

filename=$1
filedir=/home/sydney/Sources/sydev.us/blogs/
filedir1=/home/sydney/Sources/sydev.us/blogs/tmp.html
filedir2=/home/sydney/Sources/sydev.us/
blogtemplate=/home/sydney/Sources/sydev.us/blogs/blogtemplate.html
rss=/home/sydney/Sources/sydev.us/rss.xml
rss1=/home/sydney/Sources/sydev.us/rss1.xml
rsstwo=/home/sydney/Sources/sydev.us/rss2.xml
web=https://sydev.us/blogs/
blogindex=/home/sydney/Sources/sydev.us/blogs/index.html
add=/home/sydney/Sources/sydev.us/blogs/add.html
add1=/home/sydney/Sources/sydev.us/blogs/add1.html

cp -p "$blogtemplate" "$filedir$filename"
nano "$filedir1"
sed -i "29r $filedir1" "$filedir$filename"
firefox "$filedir$filename"
read -p "Does it look good enough? (y/n)" ANS
if [ "$ANS" = "y" ]; then
  echo Great!
else
  exit
fi
rm $filedir1
echo "What should be this blog posts title?"
read title
echo "What should be this blog posts description?"
read desc
cp -p "$rss1" "$rsstwo"
sed -i "3i $title" "$rsstwo"
sed -i "6i $web$filename" "$rsstwo"
sed -i "9i $desc" "$rsstwo"
sed -i "7r $rsstwo" "$rss"
sed -i "8i $desc" "$filedir$filename"
sed -i "11i $desc" "$filedir$filename"
cp -p "$add" "$add1"
sed -i "3i $web$filename" "$add1"
sed -i "5i $filename - $title" "$add1"
sed -i "39r $add1" "$blogindex"
rm "$rsstwo"
rm "$add1"
echo "There, everything *should* be done :-D, just push it to git!"
