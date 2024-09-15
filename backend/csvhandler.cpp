#include "csvhandler.h"

bool compatibleFileContent(const QString &thirdColHeader) {
  return (thirdColHeader == "target_speed") ? true : false;
}

CsvHandler::CsvHandler(QObject *parent) : QObject(parent), m_speedValue(0) {
  m_timer = std::make_shared<QTimer>(this);
  connect(m_timer.get(), &QTimer::timeout, this, &CsvHandler::getSpeed);
}

double CsvHandler::speedValue() const { return m_speedValue; }

void CsvHandler::getSpeed() {
  if (m_index < speeds.size()) {
    m_speedValue = speeds[m_index].value * 3.6;
    qDebug() << m_speedValue;
    m_index++;
    emit speedValueChanged();

    // 100ms sleep intervals to make a better simulation
    m_timer->start(100);
  } else {
    m_timer->stop();
  }
}

void CsvHandler::openFile(const QString &filename) {
  QStringList data;
  QString line;

  // QML gives file names with "file://" prefix
  // removing it
  qDebug() << "Given filename from QML: " + filename;
  QString qmlFilename = filename;
  QString localFilename = qmlFilename.replace("file://", "");
  qDebug() << "Local filename: " + localFilename;

  QFile file(localFilename);

  if (!file.exists()) {
    qDebug() << "file not found\n";
    qDebug() << "Path: " + localFilename;
    throw std::runtime_error("File not found.");
  }

  if (file.open(QIODevice::ReadOnly)) {
    if (!file.atEnd()) {
      line = file.readLine().trimmed();
      data = line.split(",");
      // check if file is not compatible
      if (!compatibleFileContent(data[2])) {
        qDebug() << "File contents incompatible";
        qDebug() << data[2] << " != target_speed";
        qDebug() << "Try a different file";
        file.close();
        setGoodFile(false);
        // Early return
        return;
      }
      qDebug() << "Accepted file. Continuing.";
    }

    // read speed values and append them
    while (!file.atEnd()) {
      line = file.readLine().trimmed();
      if (!line.isEmpty()) {
        data = line.split(",");
        speeds.push_back(CsvEntry(data[2].toDouble()));
      }
    }
    file.close();
    setGoodFile(true);
  }
}

bool CsvHandler::goodFile() const { return m_goodFile; }

void CsvHandler::setGoodFile(bool newGoodFile) {
  if (m_goodFile == newGoodFile)
    return;
  m_goodFile = newGoodFile;
  emit goodFileChanged();
}
