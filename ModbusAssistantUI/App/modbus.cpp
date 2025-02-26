#include "modbus.h"
#include "QVariant"
#include <QDebug>
#include <QModbusReply>


Modbus::Modbus(QObject *parent)
    : QObject{parent}
{
    Modbus::client = new QModbusTcpClient();
    Modbus::addr = "127.0.0.1";
    Modbus::port = "502";
}

Modbus::~Modbus()
{
    if(Modbus::client->state() == QModbusDevice::ConnectedState)
    {
        Modbus::client->disconnectDevice();
    }
}

bool Modbus::modbusConnect(QString addr, QString port)
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
        qDebug() << "Config changed, re-connecting...";
        Modbus::client->disconnectDevice();
        return true;
    }
    qDebug() << "Config: " << addr << ":" << port;
    bool connected = Modbus::client->state() == QModbusDevice::ConnectedState;
    if (!connected || parameter_changed)
    {
        Modbus::client->connectDevice();
        qDebug() << "Connecting...";
        return true;
    }
    else
    {
        qDebug() << "Already connected!";
    }
    onRead();
    return true;
}

void Modbus::onRead()
{
    readValue();
}

void Modbus::readValue()
{
    if(Modbus::client->state() == QModbusDevice::ConnectedState)
    {
        qDebug() << "Reading data from id 0...";
        QModbusDataUnit readUnit(QModbusDataUnit::HoldingRegisters, 0, 1);
        if(auto *reply = Modbus::client->sendReadRequest(readUnit, 1))
        {
            if (!reply->isFinished())
            {
                qDebug() << "Waiting for reply from TCP...";
                connect(reply, &QModbusReply::finished, this, &Modbus::receiveData);
                return;
            }
            else
            {
                QModbusDataUnit unit = reply->result();
                reply->deleteLater();
                if (unit.valueCount()>0)
                {
                    qDebug() << "Receive data: " << unit.value(0);
                }
            }
        }
    }
}

void Modbus::receiveData()
{
    QModbusReply* reply = (QModbusReply*)(sender());
    QModbusDataUnit unit = reply->result();
    reply->deleteLater();
    if (unit.valueCount()>0)
    {
        qDebug() << "Receive data: " << unit.value(0);
    }
}
