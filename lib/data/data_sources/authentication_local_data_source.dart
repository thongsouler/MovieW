import 'package:hive/hive.dart';

//Storage authentication in local storage
abstract class AuthenticationLocalDataSource {
  Future<void> saveSessionId(String sessionId);
  Future<String?> getSessionId();
  Future<void> deleteSessionId();
  Future<void> saveId(String id);
  Future<String?> getId();
  Future<void> deleteId();
}

class AuthenticationLocalDataSourceImpl extends AuthenticationLocalDataSource {
  @override
  Future<void> deleteSessionId() async {
    print('delete session - local');
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.delete('session_id');
  }

  @override
  Future<String?> getSessionId() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('session_id');
  }

  @override
  Future<void> saveSessionId(String sessionId) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('session_id', sessionId);
  }

  @override
  Future<void> deleteId() async {
    print('delete session - local');
    final authenticationBox = await Hive.openBox('authenticationBox');
    authenticationBox.delete('id');
  }

  @override
  Future<String?> getId() async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.get('id');
  }

  @override
  Future<void> saveId(String id) async {
    final authenticationBox = await Hive.openBox('authenticationBox');
    return await authenticationBox.put('id', id);
  }
}
