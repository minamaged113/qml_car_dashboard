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
  /*!
   * \brief speeds A vector of vehicle speeds read from CSV file
   */
  std::vector<CsvEntry> speeds;

  /*!
   * \brief CsvHandler Constructor
   */
  explicit CsvHandler(QObject *parent = nullptr);

  /*!
   * \brief speedValue
   * \return The current speed value
   */
  double speedValue() const;

  /*!
   * \brief goodFile
   * \return `true` if the file is compatible, `false` otherwise
   */
  bool goodFile() const;

  /*!
   * \brief setGoodFile
   *    Set the goodFile property.
   * \param newGoodFile `true` if the file is compatible. `false` otherwise.
   */
  void setGoodFile(bool newGoodFile);

signals:
  /*!
   * \brief speedValueChanged
   *    Signal emitted when the speedValue has been set.
   */
  void speedValueChanged();

  /*!
   * \brief goodFileChanged
   *    Signal emitted when the goodFile has been set.
   */
  void goodFileChanged();

public slots:
  /*!
   * \brief getSpeed
   *    Read a speed from the vector of speeds, then sets the speedValue.
   *    Finall, emits speedValueChanged signal
   */
  void getSpeed();

  /*!
   * \brief openFile
   *    Opens a file given from QML, checks its compatibility, and
   *    reads the data if compatible. Then emits goodFileChanged signal
   * \param filePath QString with filepath passed through QML
   */
  void openFile(const QString &filePath);

private:
  double m_speedValue = 0;
  std::shared_ptr<QTimer> m_timer;
  long long m_index = 0;
  bool m_goodFile = false;
};

#endif // CSVHANDLER_H
