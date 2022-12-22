#include "chartdata.h"
#include <math.h>
#include <functional>
#include <exception>


chartData::chartData(QObject *parent) : QObject(parent)
{
    Xvalues = {7, 31, 61, 99, 129, 178, 209};
    Yvalues = {13, 10, 9, 10, 12, 20, 26};
}

void chartData::calculate()
{
    double sumX{0};
    double sumY{0};
    double sumXY{0};
    double sumXX{0};

    for(int index{0}; index < size; ++index){
        sumX += Xvalues[index];
        sumY += Yvalues[index];
        sumXY += Xvalues[index] * Yvalues[index];
        sumXX += std::pow(Xvalues[index], 2);
    }

    double det{0};
    double a{0};
    double b{0};

    det = sumXX * size - std::pow(sumX, 2);
    a = (sumXY * size - sumY * sumX) / det;
    b = (sumXX * sumY - sumXY * sumX) / det;

    std::function<double(double)>calculateY;

    if(b > 0)
        calculateY = [&](double x){ return (a * x + b);};
    else
        calculateY = [&](double x){ return (a * x * b);};

    for(int index{0}; index < size; ++index){
        Yvalues[index] = calculateY(Xvalues[index]);
    }
}

void chartData::setValues(QList<double> x, QList<double> y)
{
    if(x.size() != y.size())
        throw std::length_error("Ошибка задания координат, размеры списков должны совпадать!");

    Xvalues = x;
    Yvalues = y;
    size = Xvalues.size();
}

