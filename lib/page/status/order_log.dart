
import 'package:alog/alog.dart';
import 'package:homecredit/generated/l10n.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:sprintf/sprintf.dart';

import '../../arch/api/api.dart';
import '../../arch/api/log.dart';
import '../../arch/api/log_util.dart';

class OrderLog{

  static loanFinish(String date,{format: 'dd-MM-yyyy',subMap}) {
    try {
      LogUtil.platformLog(optType: PointLog.SYSTEM_LOAN_FINISH(),subMap : subMap);
      LogUtil.otherLog(
          bfEvent: PointLog.LOAN_FINISH(),
          fbEvent: 'fb_mobile_achievement_unlocked');

      Map<String, String> map = {
        'date': date,
        'format': format,
        'title': sprintf(S.current.calendar_title,[S.current.app_name]),
        'description': sprintf(S.current.calendar_description,[S.current.app_name])
      };

      FlutterPlugin.addCalendarEvent(map);

    } catch (e) {
    }
  }

  static firstLoanFinish({subMap}) {
    try {
      LogUtil.platformLog(optType: PointLog.SYSTEM_FIRST_LOAN_FINISH(),subMap : subMap);
      LogUtil.otherLog(
          bfEvent: PointLog.FIRST_LOAN_FINISH(),
          fbEvent: 'fb_mobile_purchase');
    } catch (e) {
    }
  }

  static firstLoanReject({subMap}) {
    try {
      LogUtil.platformLog(optType: PointLog.SYSTEM_FIRST_LOAN_REJECT(),subMap : subMap);
    } catch (e) {
    }
  }

}