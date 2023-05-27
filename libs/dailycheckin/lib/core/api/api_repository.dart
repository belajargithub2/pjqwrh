import '../model/setting_model.dart';
import 'api_provider.dart';

class ApiRepository{
  final _provider = ApiProvider();

  Future<SettingModel> fetchSetting(String baseUrl, String deviceCode){
    return _provider.fetchSetting(baseUrl, deviceCode);
  }
}