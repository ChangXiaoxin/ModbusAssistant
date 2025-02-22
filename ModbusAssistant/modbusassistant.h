#ifndef MODBUSASSISTANT_H
#define MODBUSASSISTANT_H

#include <QMainWindow>

QT_BEGIN_NAMESPACE
namespace Ui {
class ModbusAssistant;
}
QT_END_NAMESPACE

class ModbusAssistant : public QMainWindow
{
    Q_OBJECT

public:
    ModbusAssistant(QWidget *parent = nullptr);
    ~ModbusAssistant();

private:
    Ui::ModbusAssistant *ui;
};
#endif // MODBUSASSISTANT_H
