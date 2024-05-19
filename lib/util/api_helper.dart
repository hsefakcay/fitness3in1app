import 'edamam_api.dart';

class ApiHelper {
  static final String appId = '11ecc164';
  static final String appKey = '9aa237a49211b700afe9a8e5fc512287';
  static final EdamamAPI edamamAPI = EdamamAPI(appId: appId, appKey: appKey);
}
