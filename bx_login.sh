#!/bin/sh

if [ -z $CF_ORG ]; then
  CF_ORG="$BLUEMIX_ORG"
fi
if [ -z $CF_SPACE ]; then
  CF_SPACE="$BLUEMIX_SPACE"
fi


if [ -z "$BLUEMIX_USER" ] || [ -z "$BLUEMIX_PASSWORD" ] || [ -z "$BLUEMIX_ACCOUNT" ]; then
  echo "Define all required environment variables and rerun the stage."
  exit 1
fi
echo "Deploy pods"

echo "bx login -a $CF_TARGET_URL"
#bx login -a "$CF_TARGET_URL" -u "$BLUEMIX_USER" -p "$BLUEMIX_PASSWORD" -c "$BLUEMIX_ACCOUNT" -o "$CF_ORG" -s "$CF_SPACE"
bx login -a "$CF_TARGET_URL" -u "$BLUEMIX_USER" --apikey BcvtaafjqPL-Gg83CtkAtfd_uOk0jpgcepYbEJAMYWKT -c "$BLUEMIX_ACCOUNT" -o "$CF_ORG" -s "$CF_SPACE"
if [ $? -ne 0 ]; then
  echo "Failed to authenticate to Bluemix"
  exit 1
fi
bx cs region-set ap-south

# Init container clusters
echo "bx cs init"
bx cs init
if [ $? -ne 0 ]; then
  echo "Failed to initialize to Bluemix Container Service"
  exit 1
fi
