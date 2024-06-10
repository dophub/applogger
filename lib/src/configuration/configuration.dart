import 'package:app_logger/src/model/user_model.dart';

/// Paketi init yaptıktan sonra configure edebilmek için yazıldı
class Configuration {
  AppLoggerUser _user = AppLoggerUser();

  /// Http log status
  late bool httpLog;

  /// Navigation log status
  late bool navigationLog;

  /// Should the application close when an error occurs?
  bool killAppOnError = false;

  /// Should Flutter close the application when an error occurs?
  bool killAppOnErrorCausedByFlutter = false;

  void setUser(AppLoggerUser user) {
    _user = user;
  }

  AppLoggerUser get user => _user;
}
