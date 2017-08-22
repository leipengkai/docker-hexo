#!/bin/bash
IFS="|"
hexo g
cp -R public/* README.md  deploy/leipengkai.github.io
cd deploy/leipengkai.github.io
git add .
git commit -m $1
git push -u origin master

