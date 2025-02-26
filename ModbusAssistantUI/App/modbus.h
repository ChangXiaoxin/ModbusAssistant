#ifndef MODBUS_H
#define MODBUS_H

#include <QObject>
#include <QModbusTcpClient>

class Modbus : public QObject
{
    Q_OBJECT
public:
    ~Modbus();
    QModbusTcpClient *client;
    QString addr, port;
    explicit Modbus(QObject *parent = nullptr);
    Q_INVOKABLE bool modbusConnect(QString addr, QString port);

private slots:
    void onRead();
    void receiveData();

private:
    void readValue();
};

#endif // MODBUS_H
