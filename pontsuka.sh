youbi=$(date +%w)
WORK_DIR=/home/ec2-user/pontsuka/
PONTSUKA_DATE=$(date -d "$youbi days ago" +%Y%m%d)
URL_prefix="http://vod.bayfm.jp/VODFILES/artist/bump-"
URL_posfix=".mp3"
URL=$URL_prefix$PONTSUKA_DATE$URL_posfix
FILE_NAME=bump-$PONTSUKA_DATE$URL_posfix

echo wget $URL
wget -O $WORK_DIR$FILE_NAME $URL
case $? in
    "0" ) /home/ec2-user/Dropbox-Uploader/dropbox_uploader.sh upload $WORK_DIR$FILE_NAME $FILE_NAME ;;
    "8" ) echo "[Error] 404" ;;
esac
