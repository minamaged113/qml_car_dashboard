#ifndef CSVENTRY_H
#define CSVENTRY_H

class CsvEntry {
public:
  /*!
   * \brief value The speed value from csv file
   */
  double value;

  /*!
   * \brief CsvEntry Constructor
   * \param val The speed value from csv file
   */
  CsvEntry(const double &val);
};

#endif // CSVENTRY_H
