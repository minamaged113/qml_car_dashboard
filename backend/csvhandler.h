#ifndef CSVHANDLER_H
#define CSVHANDLER_H

#include "csventry.h"

#include <QDebug>
#include <QFile>
#include <QObject>
#include <QQmlEngine>
#include <QString>
#include <QStringList>
#include <QTimer>
#include <qqmlintegration.h>

class CsvHandler : public QObject {
  Q_OBJECT
  Q_PROPERTY(double speedValue READ speedValue NOTIFY speedValueChanged)
  Q_PROPERTY(
      bool goodFile READ goodFile WRITE setGoodFile NOTIFY goodFileChanged)

public:
  std::vector<CsvEntry> speeds;
  explicit CsvHandler(QObject *parent = nullptr);
  double speedValue() const;

  bool goodFile() const;
  void setGoodFile(bool newGoodFile);

signals:
  void speedValueChanged();
  void goodFileChanged();

public slots:
  void getSpeed();
  void openFile(const QString &filePath);

private:
  double m_speedValue = 0;
  std::shared_ptr<QTimer> m_timer;
  long long m_index = 0;
  bool m_goodFile = false;
};

#endif // CSVHANDLER_H
