#include "backend/csvhandler.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  QQmlApplicationEngine engine;

  CsvHandler fh;
  qmlRegisterSingletonInstance("CsvHandler", 1, 0, "CsvHandler", &fh);

  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.loadFromModule("qml_car_dashboard", "Main");

  return app.exec();
}
