#/usr/bin/bash


git init
git remote add origin https://github.com/la-jig/Brackeys-Jam-2023.git
git clone https://github.com/la-jig/Brackeys-Jam-2023.git ./tmp

mv ./tmp/* .
rm -rf ./tmp

echo "git add *.*
git add *

git commit -m "$1"
git push -u origin master --force" > commit

chmod +x commit
