import 'package:alog/alog.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/utils/flutter_plugin.dart';

import '../net/http.dart';
import '../net/params.dart';
import '../net/result_data.dart';
import 'api.dart';

class LogUtil {
  static platformLog({required String optType, mul = true, subMap}) async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      Map<dynamic, dynamic> map = await FlutterPlugin.getGaid();
      params[Api.optType] = optType;
      params[Api.mobile_language] = NetConfig.LANGUAGE;
      params[Api.user_agent] = map[Api.user_agent].toString();
      params[Api.os_version] = map[Api.os_version].toString();
      params[Api.equipmentBrand] = map[Api.equipmentBrand].toString();
      params[Api.equipmentType] = map[Api.equipmentType].toString();
      params[Api.gaid] = map[Api.gaid].toString();
      params[Api.lbs] = await FlutterPlugin.getLocation();

      String uuid = await FlutterPlugin.getUniqueID();
      if(uuid != null && uuid.isNotEmpty){
        params[Api.uuid] = uuid;
      }

      HttpManager.instance().post(Api.uploadOperation(),
          params: params, mul: mul, withLoading: false, subMap: subMap);
    } catch (e) {
      ALog(e, mode: ALogMode.error);
    }
  }

  static otherLog({required String bfEvent, String fbEvent = ''}) {
    FlutterPlugin.branchAndFirebaseEvent(bfEvent);
    FlutterPlugin.facebookEvent(fbEvent);
  }
}
