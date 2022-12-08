#pragma once

#include <QObject>
#include <math.h>


class Calculate : public QObject
{
    Q_OBJECT
public:
    Calculate() {}
    virtual ~Calculate() {}
    Q_INVOKABLE double heronArea(int A, int B, int C)
   {
       double P = (double)(A + B + C) / 2.0;
       double S = sqrt(P * (P - A)*(P - B)*(P - C));
       return S;
   }
};
