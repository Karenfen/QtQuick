#pragma once
#include <QObject>



class chartData : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int size READ getSize)
    Q_PROPERTY(QList<double> Xvalues READ getXvalues NOTIFY XvaluesChanged)
    Q_PROPERTY(QList<double> Yvalues READ getYvalues NOTIFY YvaluesChanged)

public:
    explicit chartData(QObject *parent = nullptr);
    Q_INVOKABLE int getSize(){return size;}
    Q_INVOKABLE QList<double> getXvalues(){return Xvalues;};
    Q_INVOKABLE QList<double> getYvalues(){return Yvalues;};
    Q_INVOKABLE void calculate();
    Q_INVOKABLE void setValues(QList<double> x, QList<double> y);

signals:
    Q_SIGNAL void XvaluesChanged();
    Q_SIGNAL void YvaluesChanged();

private:
    int size{7};
    QList<double> Xvalues{};
    QList<double> Yvalues{};
};

