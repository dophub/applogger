/// Log Türleri
/// [LogType.API] Http log
/// [LogType.NAV] Navigation log
/// [LogType.ERR] Exception error
/// [LogType.APPERR] Framework Error
/// [LogType.LOG] General log
enum LogType { API, NAV, ERR, APPERR, LOG }

enum NavigationEnum { didPop, didPush, didRemove, didReplace }