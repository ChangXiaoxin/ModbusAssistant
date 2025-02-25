#ifndef MODBUS_H
#define MODBUS_H

#include <QObject>
#include <QModbusTcpClient>

class Modbus : public QObject
{
    Q_OBJECT
public:
    QModbusTcpClient *client;
    QString addr, port;
    explicit Modbus(QObject *parent = nullptr);
    Q_INVOKABLE bool connect(QString addr, QString port);

};

#endif // MODBUS_H
