#!/bin/sh

#exec > ${PROJECT_DIR}/prebuild.log 2>&1
#echo "${BUILT_PRODUCTS_DIR}/"

#################################
### Copy files from AppConfig ###
#################################
echo "Copying files from AppConfig"
cp -a LocalizationExample/AppConfig/*.lproj ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app

