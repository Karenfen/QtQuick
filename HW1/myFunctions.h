#pragma once

#include <QObject>
#include <math.h>
#include <string>


class Calculate : public QObject
{
    Q_OBJECT
public:
    Calculate() {}
    virtual ~Calculate() {}

    Q_INVOKABLE double heronArea(double A, double B, double C)
   {
        if (!(A > 0 && B > 0 && C > 0))
            return 0;

       double P = (A + B + C) / 2.0;

       if(!(std::isless(A, P) && std::isless(B, P) && std::isless(C, P)))
           return 0;

       double S = sqrt(P * (P - A)*(P - B)*(P - C));
       return S;
   }

    Q_INVOKABLE double heronArea(int ax, int ay, int bx, int by, int cx, int cy)
   {
        double A = segmentLength(ax, ay, bx, by);
        double B = segmentLength(bx, by, cx, cy);
        double C = segmentLength(cx, cy, ax, ay);

        if (!(A > 0 && B > 0 && C > 0))
            return 0;

       double P = (A + B + C) / 2.0;

       if(!(std::isless(A, P) && std::isless(B, P) && std::isless(C, P)))
           return 0;

       double S = sqrt(P * (P - A)*(P - B)*(P - C));
       return S;
   }

    Q_INVOKABLE double segmentLength(int x1, int y1, int x2, int y2)
    {
        if(x1 == x2 && y1 == y2)
            return 0;

        double result = std::sqrt(std::pow((x2 - x1), 2) + std::pow((y2 - y1), 2));

        return result;
    }

};
