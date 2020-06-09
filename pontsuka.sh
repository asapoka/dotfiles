##
# pontsuka.sh
# bayfmのインターネットラジオ音源をwgetするシェル
# 実行したタイミングによって、取得できる日付が異なるので、シェル内で日付特定する処理を実施している
##

# 作業ディレクトリ
WORK_DIR=~/pontsuka/

# シェル実行した曜日を取得
youbi=$(date +%w)

# PONTSUKAの放送日を取得
PONTSUKA_DATE=$(date -d "$youbi days ago" +%Y%m%d)

# wgetするURLを生成
URL_prefix="http://vod.bayfm.jp/VODFILES/artist/bump-"
URL_posfix=".mp3"
URL=$URL_prefix$PONTSUKA_DATE$URL_posfix

# 出力ファイル名を生成
FILE_NAME=bump-$PONTSUKA_DATE$URL_posfix

# 既存ファイルを上書きしないようランダムなファイル名で作業する
TEMP_FILE_NAME=$(mktemp)
RET_FILE=$(mktemp)

# ${0##*/}でシェル名が取得できる
echo "start ${0##*/}"

# 作業ディレクトリに移動する
cd $WORK_DIR

# 作業ディレクトリ存在してなかったら、作成してからcd
case $? in
    "1" )
      mkdir $WORK_DIR
      cd $WORK_DIR ;;
esac

echo $PONTSUKA_DATE
echo wget $URL

#ファイル名衝突しないように、ランダムなファイル名でwgetする
wget -q -O $TEMP_FILE_NAME $URL

# wget の結果判定
case $? in
    "0" ) echo "wget is successful" ;;
    "8" ) echo "[Error] 404" ;;
esac

# md5のハッシュ値を取得する
MD5=$(md5sum $TEMP_FILE_NAME) >> /dev/null

echo $MD5
# ワークディレクトリにすでに保存されているすべてのファイルのハッシュ値を取得
md5sum * > $RET_FILE

# さっきwgetしてきたファイルがすでに保有しているか確認する
# ファイル名だけで判断すると0バイトファイルで上書きしてしまう危険性があるためハッシュ値を確認する
grep $MD5 $RET_FILE >> /dev/null

if [ $? = 1 ]; then
  # 同一のファイルを保有してなければ、リネームしてDropboxへアップロードする
  mv $TEMP_FILE_NAME $WORK_DIR$FILE_NAME
  ~/Dropbox-Uploader/dropbox_uploader.sh upload $WORK_DIR$FILE_NAME $FILE_NAME
else
  # すでに保有している場合はアップロードせずに終了
  rm $TEMP_FILE_NAME
  echo "the same file already exists"
  exit 0
fi


rm $RET_FILE

echo "pontsuka up ${0##/}"
