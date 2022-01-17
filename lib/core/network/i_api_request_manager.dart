import 'package:meta/meta.dart';

abstract class IApiRequestManager {
  Future<dynamic> getRequest({@required String path, Map<String, String> parameters});

  Future<dynamic> postRequest({@required String path, Map<String, String> parameters, dynamic body});
}
