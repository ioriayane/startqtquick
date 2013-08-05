#include "triangle.h"
#include <QPainter>

Triangle::Triangle(QQuickPaintedItem *parent):
  QQuickPaintedItem(parent)
{
}
Triangle::~Triangle()
{
}
//colorプロパティ取得
const QColor &Triangle::color() const
{
  return m_color;
}
//colorプロパティ更新 [1]
void Triangle::setColor(const QColor &color)
{
  if (m_color == color)
    return;
  m_color = color;
  emit colorChanged(color); //変更シグナル通知
  update();                 //色が変更されたら更新
}
//描画処理  [2]
void Triangle::paint(QPainter *painter)
{
  qreal width = boundingRect().width();
  qreal height = boundingRect().height();
  qreal pen_width = 1;
  //三角形の辺を点で作成
  QPointF points[4] = {
      QPointF(width / 2, pen_width),
      QPointF(width    , height - pen_width),
      QPointF(pen_width, height - pen_width),
      QPointF(width / 2, pen_width)
  };
  //色とアンチエイリアスの設定
  QPen pen(color(), pen_width);
  painter->setPen(pen);
  painter->setRenderHints(QPainter::Antialiasing, antialiasing());
  //描画
  painter->drawPolygon(points, 4);
}

