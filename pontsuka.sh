youbi=$(date +%w)
WORK_DIR=~/pontsuka/
PONTSUKA_DATE=$(date -d "$youbi days ago" +%Y%m%d)
URL_prefix="http://vod.bayfm.jp/VODFILES/artist/bump-"
URL_posfix=".mp3"
URL=$URL_prefix$PONTSUKA_DATE$URL_posfix
FILE_NAME=bump-$PONTSUKA_DATE$URL_posfix
TEMP_FILE_NAME=$(mktemp)
RET_FILE=$(mktemp)

cd $WORK_DIR

case $? in
    "1" ) mkdir $WORK_DIR
esac

echo $PONTSUKA_DATE
echo wget $URL
wget -q -O $TEMP_FILE_NAME $URL

case $? in
    "0" ) echo "wget is successful" ;;
    "8" ) echo "[Error] 404" ;;
esac

MD5=$(md5sum $TEMP_FILE_NAME)

echo $MD5
md5sum * > $RET_FILE

grep $MD5 $RET_FILE

if [ $? = 1 ]; then
  # 1バイトでも中身があれば何もしない
  mv $TEMP_FILE_NAME $WORK_DIR$FILE_NAME
  /home/ec2-user/Dropbox-Uploader/dropbox_uploader.sh upload $WORK_DIR$FILE_NAME $FILE_NAME
else
  # 0バイトだったら消す
  rm $TEMP_FILE_NAME
  echo "the same file already exists"
fi
rm $RET_FILE
