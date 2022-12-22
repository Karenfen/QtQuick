#pragma once
//#include <QtQml/qqml.h>
#include <QObject>
#include <QColor>



class chartParameters : public QObject
{
    Q_OBJECT
    //QML_ELEMENT

    Q_PROPERTY(QColor color READ getColor WRITE setColor)
    Q_PROPERTY(QString label READ getLabel NOTIFY labelChanged)
    Q_PROPERTY(Type type READ getType WRITE setType NOTIFY typeChanged)
    Q_PROPERTY(int size READ getSize)
    Q_PROPERTY(QList<double> Xvalues READ getXvalues)
    Q_PROPERTY(QList<double> Yvalues READ getYvalues NOTIFY YvaluesChanged)

public:
    enum Type{LINE, MODULE, QUAD, LOG2, SIN};
    Q_ENUM(Type)

    explicit chartParameters(QObject *parent = nullptr);
    QColor getColor();
    void setColor(const QColor& newColor);
    Type getType();
    void setType(Type newType);
    QString getLabel();
    int getSize();
    QList<double> getXvalues();
    QList<double> getYvalues();

private:
    void recalculate();
    void updateLabel();
    void Y_line();
    void Y_module();
    void Y_quad();
    void Y_log2();
    void Y_sin();

signals:
    Q_SIGNAL void typeChanged(Type newType);
    Q_SIGNAL void YvaluesChanged();
    Q_SIGNAL void labelChanged(QString);

private:
    QColor color{"black"};
    QString label{"y = x"};
    Type type{LINE};
    int size{0};
    QList<double> Xvalues{};
    QList<double> Yvalues{};
};
