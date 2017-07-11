#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QIcon>
#include <QtCore>
#include <iostream>
#include <QTextStream>
#include <QQmlContext>
#include <QQmlComponent>
#include "receive.h"
#include <QQuickView>
#include <QQmlEngine>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext *context = engine.rootContext();
    Receive receive;
//    qDebug()<< receive.connectToHost("127.0.0.1");
//    receive.connectToHost("127.0.0.1");
//    receive.sendFortune();
    context->setContextProperty("sentMessage",&receive);
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));

    QObject *topLevel = engine.rootObjects().value(0);
    QQuickWindow *window = qobject_cast<QQuickWindow *>(topLevel);

    window->setFlags( /*Qt::Dialog |*/ Qt::CustomizeWindowHint | Qt::WindowTitleHint );

    QObject::connect(window,SIGNAL(sendTextToC(QString)),&receive,SLOT(getText(QString)));


    return app.exec();
}




