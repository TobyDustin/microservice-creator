#!/bin/bash
nest || sudo npm i -g @nestjs/cli
clear

echo What is the name of the microservice?
read NAME

echo install dependencies?
read INSTALL



mkdir $NAME
cd $NAME/
git init

echo ____________UI______________
git clone https://github.com/TobyDustin/ui-template
cd ui-template/
rm -rf .git
if [ $INSTALL == "y" ];
then
rm package-lock.json
rm -rf node_modules
npm i 
fi
cd ../


echo ____________SERVER______________
git clone https://github.com/TobyDustin/srv-template
cd srv-template/
rm -rf .git
if [ $INSTALL == "y" ];
then
rm package-lock.json
rm -rf node_modules
npm i 
fi
cd ../
echo ____________DOCKER______________
git clone https://github.com/TobyDustin/docker-compose-template

echo ____________MOVING DOCKER-COMPOSE FILE______________
cd docker-compose-template/
mv ./docker-compose.yml ../
cd ../
rm -rf docker-compose-template/

mv ui-template/ $NAME-ui/
mv srv-template $NAME-srv/

echo ____________RENAMING FILES______________
sed -i "" "s/template-ui/$NAME-ui/g" ./$NAME-ui/package.json
sed -i "" "s/template-srv/$NAME-srv/g" ./$NAME-srv/package.json
sed -i "" "s/template-ui/$NAME-ui/g" ./docker-compose.yml
sed -i "" "s/template-srv/$NAME-srv/g" ./docker-compose.yml


git add .
git commit -m "first steps"
