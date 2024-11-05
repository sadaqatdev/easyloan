import 'package:package_info_plus/package_info_plus.dart';
import '../../utils/flutter_plugin.dart';
import '../../utils/sp.dart';
import '../api/api.dart';
import 'config.dart';

class CommonParams {
  static Future<Map<String, dynamic>> addHeaders(String api) async {
    Map<String, dynamic> headers = {
      Api.client_id: NetConfig.APP_SSID,
      Api.language: NetConfig.LANGUAGE,
      Api.mulFlag: '1'
    };
    SpUtil.getString(Api.userId).then((value) {
      if (value.isNotEmpty) {
        headers[Api.currentUserId] = value;
      }
    });
    SpUtil.getString(Api.token).then((value) {
      if (value.isNotEmpty) {
        headers[Api.token] = value;
      }
    });
    String imei = await FlutterPlugin.getImei();
    if(imei.isNotEmpty){
      headers[Api.imei] = imei;
    }
    return headers;
  }

  static Future<Map<String, String>> addParams() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, String> params = {
      Api.appssid: NetConfig.APP_SSID,
      Api.language: NetConfig.LANGUAGE,
      Api.channel: NetConfig.CHANNEL,
      Api.versionCode: packageInfo.buildNumber,
      Api.versionName: packageInfo.version
    };
    String imei = await FlutterPlugin.getImei();
    if(imei.isNotEmpty){
      params[Api.imei] = imei;
    }
    String lbs = await FlutterPlugin.getLocation();
    if(lbs.isNotEmpty){
      params[Api.gpsInfo] = lbs;
      params[Api.lbs] = lbs;
    }
    SpUtil.getString(Api.userId).then((value) {
      if (value.isNotEmpty) {
        params[Api.userId] = value;
      }
    });
    SpUtil.getString(Api.token).then((value) {
      if (value.isNotEmpty) {
        params[Api.token] = value;
      }
    });
    return params;
  }

  static Future<String> someBoothLastProvince(
      dynamic params, dynamic headers) async {
    try {
      Map<String, dynamic> newParams = {};
      params.forEach((key, value) {
        if (value != null && value.toString().isNotEmpty) {
          newParams[key] = value;
        }
      });
      //
      if (headers[Api.client_id] != null &&
          headers[Api.client_id].toString().isNotEmpty) {
        newParams[Api.client_id] = headers[Api.client_id];
      }
      if (headers[Api.currentUserId] != null &&
          headers[Api.currentUserId].toString().isNotEmpty) {
        newParams[Api.currentUserId] = headers[Api.currentUserId];
      }
      if (headers[Api.token] != null &&
          headers[Api.token].toString().isNotEmpty) {
        newParams[Api.token] = headers[Api.token];
      }
      List<String> keys = newParams.keys.toList();
      // key
      keys.sort((a, b) {
        List<int> al = a.codeUnits;
        List<int> bl = b.codeUnits;
        for (int i = 0; i < al.length; i++) {
          if (bl.length <= i) return 1;
          if (al[i] > bl[i]) {
            return 1;
          } else if (al[i] < bl[i]) return -1;
        }
        return 0;
      });
      String str = "";
      keys.forEach((element) {
        str += (element + "=" + newParams[element] + "&");
      });
      if (str != null && str.length > 0) {
        str = str.substring(0, str.length - 1);
        return str;
      }
    } catch (e) {
      print(e);
    }
    return '';
  }
}
