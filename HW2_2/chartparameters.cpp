#include "chartparameters.h"
#include <math.h>
#include <stdexcept>
#include <iostream>


chartParameters::chartParameters(QObject *parent) : QObject(parent)
{
    double value_{0};
    while( value_ <= 5.0)
    {
        Xvalues.append(value_);
        Yvalues.append(value_);
        value_ += 0.1;
    }

    size = Xvalues.size();
}

QColor chartParameters::getColor()
{
    return color;
}

void chartParameters::setColor(const QColor& newColor)
{
    if(newColor == color)
        return;

    color = newColor;
}

chartParameters::Type chartParameters::getType()
{
    return type;
}

void chartParameters::setType(Type newType)
{
    if(type == newType)
        return;

    type = newType;
    recalculate();
    updateLabel();
}

QString chartParameters::getLabel()
{
    return label;
}

int chartParameters::getSize()
{
    return size;
}

QList<double> chartParameters::getXvalues()
{
    return Xvalues;
}

QList<double> chartParameters::getYvalues()
{
    return Yvalues;
}

void chartParameters::recalculate()
{
    switch (type) {
    case LINE:
        Y_line();
        break;
    case MODULE:
        Y_module();
        break;
    case QUAD:
        Y_quad();
        break;
    case SIN:
        Y_sin();
        break;
    case LOG2:
        Y_log2();
        break;
    default:
        return;
        break;
    }

    emit YvaluesChanged();
}

void chartParameters::updateLabel()
{
    switch (type) {
    case LINE:
        label = "y = x";
        break;
    case MODULE:
        label = "y = |x - 2.5|";
        break;
    case QUAD:
        label = "y = x^2";
        break;
    case SIN:
        label = "y = sin(x)";
        break;
    case LOG2:
        label = "y = log2(x)";
        break;
    default:
        return;
        break;
    }

    emit labelChanged(label);
}

void chartParameters::Y_line()
{
    for(int iter{0}; iter < size; ++iter)
    {
        Yvalues[iter] = Xvalues[iter];
    }
}

void chartParameters::Y_module()
{
    for(int iter{0}; iter < size; ++iter)
    {
        Yvalues[iter] = std::abs(Xvalues[iter] - 2.5);
    }
}

void chartParameters::Y_quad()
{
    for(int iter{0}; iter < size; ++iter)
    {
        Yvalues[iter] = std::pow(Xvalues[iter], 2);
    }
}

void chartParameters::Y_log2()
{
    for(int iter{0}; iter < size; ++iter)
    {
        Yvalues[iter] = std::log2(Xvalues[iter]);
    }
}

void chartParameters::Y_sin()
{
    for(int iter{0}; iter < size; ++iter)
    {
        Yvalues[iter] = std::sin(Xvalues[iter]);
    }
}
