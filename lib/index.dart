import 'package:alog/alog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/page/GuidePage.dart';
import 'package:homecredit/routes/route_util.dart';
import 'package:homecredit/routes/routes.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/utils/sp.dart';
import 'package:homecredit/widget/TabBar.dart';

import 'arch/api/api.dart';
import 'arch/api/log.dart';
import 'arch/api/log_util.dart';
import 'arch/net/config.dart';

class Index extends StatefulWidget {
  Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  static const methodChannel = const MethodChannel('flutter');
  @override
  void initState() {
    super.initState();
    try {
      methodChannel.setMethodCallHandler(flutterMethod);
      FlutterPlugin.startLocation();
      FlutterPlugin.getAppInstanceId();
      // SpUtil.getString(Api.token,"").then((value) {
      //   if(value.isNotEmpty){
      //     FlutterPlugin.getShowUPermission().then((value) {
      //       if (!value) {
      //         FlutterPlugin.startUPermission();
      //       }
      //     });
      //   }
      // });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return HCTabbar();
  }

  Future<dynamic> flutterMethod(MethodCall methodCall) async {
    try {
      switch (methodCall.method) {
        case 'plog':
          int type = methodCall.arguments;
          HLog.debug("click:${type}");
          if(type == 10){
            //cancel
            LogUtil.platformLog(
                optType: PointLog.GGTerms_CANCEL(), mul: false);
            LogUtil.otherLog(
                bfEvent: PointLog.GGBRTerms_CANCEL(),
                fbEvent: PointLog.GGFBTerms_CANCEL());
          }else if(type == 11){
            //agree
            LogUtil.platformLog(
                optType: PointLog.GGTerms_AGREE(), mul: false);
            LogUtil.otherLog(
                bfEvent: PointLog.GGBRTerms_AGREE(),
                fbEvent: PointLog.GGFBTerms_AGREE());
          }else if(type == 21){
            //agree
            LogUtil.platformLog(
                optType: PointLog.Terms_AGREE(), mul: false);
            LogUtil.otherLog(
                bfEvent: PointLog.BRTerms_AGREE(),
                fbEvent: PointLog.FBTerms_AGREE());
          }
          break;
      }
    }catch(e){}
  }
}
