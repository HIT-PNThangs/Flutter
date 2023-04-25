enum LocaleType {
  en,
  vi,
}

final _i18nModel = <LocaleType, Map<String, Object>>{
  LocaleType.en: {
    'cancel': 'Cancel',
    'done': 'Done',
    'today': 'Today',
    'monthShort': [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ],
    'monthLong': [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ],
    'day': ['Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'],
    'am': 'AM',
    'pm': 'PM'
  },
  LocaleType.vi: {
    'cancel': 'Hủy bỏ',
    'done': 'Xong',
    'today': 'Hôm nay',
    'monthShort': [
      'Thg1',
      'Thg2',
      'Thg3',
      'Thg4',
      'Thg5',
      'Thg6',
      'Thg7',
      'Thg8',
      'Thg9',
      'Thg10',
      'Thg11',
      'Thg12'
    ],
    'monthLong': [
      'Tháng 1',
      'Tháng 2',
      'Tháng 3',
      'Tháng 4',
      'Tháng 5',
      'Tháng 6',
      'Tháng 7',
      'Tháng 8',
      'Tháng 9',
      'Tháng 10',
      'Tháng 11',
      'Tháng 12'
    ],
    'day': ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'],
    'am': 'SA',
    'pm': 'CH'
  },
};

/// Get international object for [localeType]
Map<String, Object> i18nObjInLocale(LocaleType? localeType) =>
    _i18nModel[localeType] ?? _i18nModel[LocaleType.en] as Map<String, Object>;

/// Get international lookup for a [localeType], [key] and [index].
String i18nObjInLocaleLookup(LocaleType localeType, String key, int index) {
  final i18n = i18nObjInLocale(localeType);
  final i18nKey = i18n[key] as List<String>;
  return i18nKey[index];
}
