
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <qtwebengineglobal.h>

#include "headers/jsondownloader.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();

    QQmlApplicationEngine engine;
    qmlRegisterType<JsonDownloader>("org.jsonDownloader", 1, 0, "JsonDownloader");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
