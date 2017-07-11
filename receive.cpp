#include "receive.h"
#include <QDataStream>
#include <QTcpServer>
#include <QTcpSocket>
#include <QString>
#include <QQmlEngine>
#include <QQmlComponent>

static inline qint32 ArrayToInt(QByteArray source);
static inline QByteArray IntToArray(qint32 source);

Receive::Receive(QObject *parent) : QObject(parent)
{
    server = new QTcpServer(this);

    connect(server, SIGNAL(newConnection()), SLOT(newConnection()));
    qDebug() << "Listening:" << server->listen(QHostAddress::Any, 1024);
    QHostAddress("127.0.0.1");
    connect(server,SIGNAL(newConnection()),this,SLOT(sendFortune()));

}

void Receive::makeConnection()
{

    connect(server, SIGNAL(newConnection()), this, SLOT(sendFortune()));

    if( !server->listen( QHostAddress::Any, 1024 ) )
        qDebug() << "Couldn't listen to port";
}

void Receive::newConnection()
{
    while (server->hasPendingConnections())
    {
        QTcpSocket *socket = server->nextPendingConnection();
        connect(socket, SIGNAL(readyRead()), SLOT(readyRead()));
        connect(socket, SIGNAL(disconnected()), SLOT(disconnected()));
        QByteArray *buffer = new QByteArray();
        qint32 *s = new qint32(0);
        buffers.insert(socket, buffer);
        sizes.insert(socket, s);
    }
    if(server->hasPendingConnections())
    {
        qDebug()<<"writing";
        //            socket->write(IntToArray(textTemp));
        socket->write(textTemp);
    }
    else
    {
        qDebug()<<"no pending connection";

    }

}

void Receive::disconnected()
{
    QTcpSocket *socket = static_cast<QTcpSocket*>(sender());
    QByteArray *buffer = buffers.value(socket);
    qint32 *s = sizes.value(socket);
    socket->deleteLater();
    delete buffer;
    delete s;
}

void Receive::getText(const QString& in){
    textTemp = in.toUtf8();
    newConnection();

}

void Receive::readyRead()
{
    QTcpSocket *socket = static_cast<QTcpSocket*>(sender());
    QByteArray *buffer = buffers.value(socket);
    qint32 *s = sizes.value(socket);
    qint32 size = *s;
    while (socket->bytesAvailable() > 0)
    {
        buffer->append(socket->readAll());
        while ((size == 0 && buffer->size() >= 4) || (size > 0 && buffer->size() >= size)) //While can process data, process it
        {
            if (size == 0 && buffer->size() >= 4) //if size of data has received completely, then store it on our global variable
            {
                size = ArrayToInt(buffer->mid(0, 4));
                *s = size;
                buffer->remove(0, 4);
            }
            if (size > 0 && buffer->size() >= size) // If data has received completely, then emit our SIGNAL with the data
            {
                QByteArray data = buffer->mid(0, size);
                buffer->remove(0, size);
                size = 0;
                *s = size;
                msg = data;
                callMeFromQml();
                emit dataReceived(data);
            }
        }
    }
}


void Receive::sendFortune()
{

}




qint32 ArrayToInt(QByteArray source)
{
    qint32 temp;
    QDataStream data(&source, QIODevice::ReadWrite);
    data >> temp;
    return temp;
}

QByteArray Receive::callMeFromQml()
{
    return msg;
}

QByteArray IntToArray(qint32 source) //Use qint32 to ensure that the number have 4 bytes
{
    //Avoid use of cast, this is the Qt way to serialize objects
    QByteArray temp;
    QDataStream data(&temp, QIODevice::ReadWrite);
    data << source;
    return temp;
}
