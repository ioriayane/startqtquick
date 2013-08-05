//DBオブジェクトを取得
function db(){
  return LocalStorage.openDatabaseSync("QGALLERY"
                                       , "1.0"
                                       , "Application data"
                                       , 10000)
}
//テーブルが存在しない時に作成する
function createTable(tx){
  tx.executeSql("CREATE TABLE IF NOT EXISTS ImageComment(key TEXT, value TEXT)")
}
//読み込み
function readData(key, defaultValue){
  var ret = defaultValue
  db().transaction(
        function(tx){
          //テーブルの存在確認
          createTable(tx)
          //読み込み
          var rs = tx.executeSql('SELECT value FROM ImageComment WHERE key=?'
                                 , key)
          //データがあれば返り値にする
          if(rs.rows.length > 0){
            ret = rs.rows.item(0).value
          }
        }
        )
  return ret
}
//保存
function saveData(key, value){
  db().transaction(
        function(tx){
          //テーブルの存在確認
          createTable(tx)
          //保存済みか確認
          var currentValue = readData(key)
          if(currentValue === undefined){
            //未登録のときインサート
            tx.executeSql('INSERT INTO ImageComment VALUES(?, ?)'
                          , [ key, value ])
          }else if (currentValue !== value) {
            //更新されていたら保存する
            tx.executeSql('UPDATE ImageComment SET value = ? WHERE key = ?'
                          , [ value, key ])
          }else{
            //同じ内容なので何もしない
          }
        }
        )
}
