#ifndef RECEIVE_H
#define RECEIVE_H

#include <QObject>
#include <QDebug>
#include <QTcpServer>
#include <QTcpSocket>
#include <QLocalServer>
#include <QSignalMapper>

class QTcpSocket;

class Receive : public QObject
{
    Q_OBJECT

public:
    explicit Receive(QObject *parent = 0);
    QByteArray message(){return msg;}
    void setMessage(QByteArray str);
    void send(const QString text);
    void sendAnswer(QByteArray text);
    void makeConnection();

signals:
    void dataReceived(QString);

public slots:
    void newConnection();
    void disconnected();
    void readyRead();
    void getText(const QString& in);
    QByteArray callMeFromQml();
//    bool connectToHost(QString host);
    void sendFortune();


public:
    QTcpServer *server;
    QHash<QTcpSocket*, QByteArray*> buffers;
    QHash<QTcpSocket*, qint32*> sizes;
    QByteArray msg;
    QTcpSocket *socket;
    QByteArray textTemp;

};

#endif // RECEIVE_H
