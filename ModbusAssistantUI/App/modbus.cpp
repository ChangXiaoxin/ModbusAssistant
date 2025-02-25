#include "modbus.h"
#include "QVariant"
#include <QDebug>


Modbus::Modbus(QObject *parent)
    : QObject{parent}
{
    Modbus::client = new QModbusTcpClient();
    Modbus::addr = "127.0.0.1";
    Modbus::port = "502";
}

bool Modbus::connect(QString addr, QString port)
{
    Modbus::client->setConnectionParameter(QModbusDevice::NetworkAddressParameter, addr);
    Modbus::client->setConnectionParameter(QModbusDevice::NetworkPortParameter, port.toInt());
    Modbus::client->setNumberOfRetries(10);
    Modbus::client->setTimeout(5000);
    bool parameter_changed = Modbus::addr != addr;
    parameter_changed |= Modbus::port != port;
    if (parameter_changed)
    {
        Modbus::addr = addr;
        Modbus::port = port;
        // TODO disconnect to modbus
    }
    qDebug() << "Ip got" << addr << ":" << port;
    bool success = Modbus::client->state() == QModbusDevice::ConnectedState;
    if (!success || parameter_changed)
    {
        Modbus::client->connectDevice();
        qDebug() << "Connecting...";
    }
    qDebug() << "State: " << Modbus::client->state();
    QModbusDataUnit readUnit(QModbusDataUnit::HoldingRegisters, 0, 10);
    auto *reply = Modbus::client->sendReadRequest(readUnit, 1);
    if(reply)
    {
        qDebug() << reply->result().value(0);
    }
    return success;
}
