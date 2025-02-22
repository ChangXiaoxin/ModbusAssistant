#include "modbusassistant.h"
#include "./ui_modbusassistant.h"

ModbusAssistant::ModbusAssistant(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::ModbusAssistant)
{
    ui->setupUi(this);
}

ModbusAssistant::~ModbusAssistant()
{
    delete ui;
}
