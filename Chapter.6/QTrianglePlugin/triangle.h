#ifndef TRIANGLE_H
#define TRIANGLE_H

#include <QQuickPaintedItem>

class Triangle : public QQuickPaintedItem   // [1]
{
  Q_OBJECT
  Q_DISABLE_COPY(Triangle)
  //プロパティを公開  [2]
  Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)

public:
  Triangle(QQuickPaintedItem *parent = 0);
  ~Triangle();

  //プロパティの参照と設定       [3]
  const QColor &color() const;
  void setColor(const QColor &color);
  //描画処理のオーバーライド     [4]
  void paint(QPainter *painter);

signals:
  //シグナルの定義           [5]
  void colorChanged(const QColor &color);

private:
  //プロパティの内部保持変数     [6]
  QColor m_color;
};

#endif // TRIANGLE_H
