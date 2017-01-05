youbi=$(date +%w)
WORK_DIR=~/pontsuka/
PONTSUKA_DATE=$(date -d "$youbi days ago" +%Y%m%d)
URL_prefix="http://vod.bayfm.jp/VODFILES/artist/bump-"
URL_posfix=".mp3"
URL=$URL_prefix$PONTSUKA_DATE$URL_posfix
FILE_NAME=bump-$PONTSUKA_DATE$URL_posfix


cd $WORK_DIR

echo $PONTSUKA_DATE
echo wget $URL
wget -O $WORK_DIR$FILE_NAME $URL

case $? in
    "0" ) echo "wget is successful" ;;
    "8" ) echo "[Error] 404" ;;
esac

if [ -s $WORK_DIR$FILE_NAME ]; then
  # 1バイトでも中身があれば何もしない
  /home/ec2-user/Dropbox-Uploader/dropbox_uploader.sh upload $WORK_DIR$FILE_NAME $FILE_NAME
else
  # 0バイトだったら消す
  rm $WORK_DIR$FILE_NAME
  echo "mp3 file is 0 byte deleted"
fi
