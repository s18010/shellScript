#!/bin/sh

OPTION="opt$1"
BACKUP_DATE=$(date +"%Y%m%d")
BACKUP_DIR="backup_dir"
SOURCELIST="sourcelist.txt"
ERROR_LOG="errorlog.txt"
#ERROR_LOG="/tmp/errorlog.txt"

# ホスト名でバックアップ対象ファイルを切り替え
HOST=$(hostname -s)
NEW_BACKUP="${BACKUP_DIR}/${BACKUP_DATE}/${BACKUP_DATE}_${HOST}_backup"

# 毎バックアップ前にエラーログ削除、新規作成
[ -f $ERROR_LOG ] && rm -f $ERROR_LOG; touch $ERROR_LOG
echo "Backing up ${HOST}" | tee -a $ERROR_LOG

# yes/no判定
function confirm() {
  if [[ "$OPTION" = "opt-y" ]]; then
    return
  else
    echo $1
    read ANSWER
    if [[ $ANSWER != [yY] ]]; then
      exit 1
    fi
  fi
}

confirm "Backup now? (y/n)"
# $BACKUP_DIRがなければ処理中断
if [ ! -d $BACKUP_DIR ]; then
  echo "The Backup Directory does not exist"
  exit 1
fi

mkdir -p $NEW_BACKUP 2>> $ERROR_LOG
if [ $? -ne 0 ]; then
  exit 1
fi

cat $SOURCELIST | while read FILE_PATH
do
  # SOURCELISTに空行があればスキップ
  [ ${#FILE_PATH} -eq 0 ] && continue
  # リストがファイルかディレクトリでなければスキップ
  [ -f ${FILE_PATH} ] || [ -d ${FILE_PATH} ] || echo "${FILE_PATH}をスキップしました。" | tee -a $ERROR_LOG
  [ -f ${FILE_PATH} ] || [ -d ${FILE_PATH} ] || continue
  cp -frp $FILE_PATH $NEW_BACKUP 2>> $ERROR_LOG
  # コピーの成功判定
  if [[ $? -ne 0 ]]; then
    echo "An error occured while copying the file" | tee -a $ERROR_LOG
    exit 1 
  fi
done

# バックアップデータを圧縮
# cd "${BACKUP_DIR}/${BACKUP_DATE}" && tar -zcf "${BACKUP_DATE}_${HOST}_config.tar.gz" "${BACKUP_DATE}_${HOST}_config" 2>> $ERROR_LOG
tar -C "${BACKUP_DIR}/${BACKUP_DATE}" -zcf "${BACKUP_DIR}/${BACKUP_DATE}_${HOST}_config.tar.gz" "${BACKUP_DATE}_${HOST}_config" 2>> $ERROR_LOG

# 圧縮前のファイルを削除
if [[ $? -eq 0 ]]; then
  # echo "Backup completed" | tee -a $ERROR_LOG
  rm -r  "$NEW_BACKUP" 2>> $ERROR_LOG
else
  echo "An error occured while copying the file" | tee -a $ERROR_LOG
  exit 1
fi

# 世代管理(5世代残しそれ以前のファイルは削除)
# DIR_COUNT=$(ls $BACKUP_DIR -U1 | wc -l)
DIR_COUNT=$(ls -d $BACKUP_DIR/20?????? -U1 | wc -l)

confirm "Delete old backup? (y/n)"
if [ $DIR_COUNT -ge 6 ]; then
#  NUM=0
  NUM=$(expr $DIR_COUNT - 5)
  OLDER_FILES=$(ls -d $BACKUP_DIR/20?????? | sort -n | head -${NUM})
  rm -r $OLDER_FILES
fi

