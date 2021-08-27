#!/bin/bash

rm -r _demo/apk/*
rm -r _demo/canvaskit/*
rm -r _demo/html/*
flutter clean

flutter build apk --split-per-abi
cp build/app/outputs/apk/release/app-* _demo/apk/

flutter build web --web-renderer canvaskit
cp -r build/web/* _demo/canvaskit
sed -i "" 's|\="/"|\="/flutter_bizpage/canvaskit/"|' _demo/canvaskit/index.html

flutter build web --web-renderer html
cp -r build/web/* _demo/html
sed -i "" 's|\="/"|\="/flutter_bizpage/html/"|' _demo/html/index.html

git add .
git commit -m "update demo"
git push origin main
git subtree push --prefix _demo origin gh-pages
