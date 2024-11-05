import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/utils/flutter_plugin.dart';

import '../arch/api/api.dart';
import '../arch/net/config.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/sp.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    hideScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "images/splash_image.png",
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: Container(
            child: Column(
              children: [
                Text(
                  S.of(context).splash_hint,
                  style: TextStyle(fontSize: 12.0, color: HcColors.color_999999),
                ),
                SizedBox(height: 5.0,),
                Text(
                  S.of(context).splash_hint1,
                  style: TextStyle(fontSize: 12.0, color: HcColors.color_999999),
                ),
              ],
            )
          ),
        )
      ],
    );
  }

  hideScreen() {
    Future.delayed(Duration(milliseconds: 4000), () async {
      FlutterPlugin.getShowPermission().then((value) {
        if (!value) {
          FlutterPlugin.startPermission();
        } else {
          FlutterPlugin.getShowUPermission().then((value) {
            if (!value) {
              FlutterPlugin.startUPermission();
            } else {
              // FlutterPlugin.getShowGuide().then((value) {
              //   if (!value) {
              //     FlutterPlugin.startGuide();
              //   }
              // });
            }
          });
        }
      });

      // RouteUtil.push(context, Routes.index);
      // RouteUtil.pop(context);
      _gotoIndex();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<dynamic> flutterMethod(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'policy':
        Map<String, dynamic> params = {
          "url": NetConfig.PEIVACY_URL,
          "title": ''
        };
        RouteUtil.push(
          context,
          Routes.webview,
          params: params,
        );
        ALog('policy', mode: ALogMode.debug);
        break;
      case 'end':
        SpUtil.put(NetConfig.PERMISSION, true);
        _checkGuide();
        break;
    }
  }

  _checkGuide() async {
    bool flag = await SpUtil.getBool(NetConfig.GUIDE, false);
    if (!flag) {
      RouteUtil.push(context, Routes.guide);
      RouteUtil.pop(context);
    } else {
      _gotoIndex();
    }
  }

  _gotoIndex() {
    RouteUtil.push(context, Routes.index, clearStack: true);
  }
}
