import 'package:dop_logger/src/model/user_model.dart';

/// Paketi init yaptıktan sonra configure edebilmek için yazıldı
class Configuration {
  DopLoggerUser _user = DopLoggerUser();

  /// Http log status
  late bool httpLog;

  /// Navigation log status
  late bool navigationLog;

  /// Hata oluştuğunda uygulama kapansın mı
  bool killAppOnError = false;

  /// Flutter tarafından hata oluştuğunda uygulama kapansın mı
  bool killAppOnErrorCausedByFlutter = false;

  void setUser(DopLoggerUser user) {
    _user = user;
  }

  DopLoggerUser get user => _user;
}
