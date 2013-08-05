import QtQuick 2.0

TextEdit {
  width: 200
  height: 200
  //フォーカスを設定する
  focus: true                           // [1]
  //シグナルハンドラ
  Keys.onReturnPressed: {
    outputlog("return pressed", event)
    event.accepted=false                // [2]
  }
  Keys.onPressed: outputlog("pressed", event)
  Keys.onReleased: outputlog("released", event)
  //ログを加工して出力する
  function outputlog(text, event){
    var modifiers = []
    //特殊キーの入力状態を確認して追加する
    //Shiftキーを押しているか
    if(event.modifiers & Qt.ShiftModifier){
      modifiers.push("shift")
    }
    //Ctrlキー、Commandキーを押しているか
    if(event.modifiers & Qt.ControlModifier){
      modifiers.push("ctrl")
    }
    //Altキーを押しているか
    if(event.modifiers & Qt.AltModifier){
      modifiers.push("alt")
    }
    //Windowsキー、Controlキーを押しているか
    if(event.modifiers & Qt.MetaModifier){
      modifiers.push("meta")
    }
    //キーパッドのキーを押しているか
    if(event.modifiers & Qt.KeypadModifier){
      modifiers.push("keypad")
    }
    //情報を連結して出力
    console.debug("%1,%2,%3,%4"
                  .arg(text)
                  .arg(event.key)           //キーコード
                  .arg(event.text)          //キーの文字
                  .arg(modifiers.join(",")))//特殊キーの状態
  }
}
