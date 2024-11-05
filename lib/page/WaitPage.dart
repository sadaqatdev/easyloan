import 'dart:async';

import 'package:flutter/material.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/debounce.dart';
import '../utils/loading.dart';
import '../widget/LoginButton.dart';
import '../widget/PrivacyPolicy.dart';

class WaitPage extends StatefulWidget {
  const WaitPage({Key? key}) : super(key: key);

  @override
  State<WaitPage> createState() => _WaitPageState();
}

class _WaitPageState extends State<WaitPage> {
  Timer? _timer;
  int _seconds = 4;
  String remainTime = '00:00:04';

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        RouteUtil.push(context, Routes.select);
        RouteUtil.pop(context);
        return;
      }
      _seconds--;
      String value = _seconds.toString();
      if (_seconds < 10) {
        value = '0${_seconds}';
      }
      remainTime = "00:00:$value";
      setState(() {});
    });
  }

  void _cancelTimer() {
    remainTime = '00:00:00';
    if (_timer != null) {
      _timer!.cancel();
    }
    LoadingUtil.hide();
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
    LogUtil.platformLog(optType: PointLog.SYSTEM_ENTER_AUTHORIZE());
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  child: Image(
                    image: AssetImage('images/top_bg_small.png'),
                    width: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: HcColors.color_02B17B,
                  ),
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Image(
                      image: AssetImage('images/ic_circle.png'),
                      width: 107,
                      height: 107,
                    ),
                    Text(
                      S.of(context).please_wait_i,
                      style: TextStyle(
                          fontSize: 16.0, color: HcColors.color_333333),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      remainTime,
                      style: TextStyle(
                          fontSize: 35.0, color: HcColors.color_02B17B),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  S.of(context).wait_hint,
                  style:
                      TextStyle(fontSize: 16.0, color: HcColors.color_333333),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: LoginButton(
                    title: S.of(context).continue_text,
                    // enable: loginBtnEnable,
                    onPressed: () {
                      if (Debounce.checkClick()) {
                        LogUtil.platformLog(optType: PointLog.CLICK_AUTHORIZE_CONTINUE());
                        _checkPermission();
                      }
                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: PrivacyPolicy(),
              ))
        ],
      ),
    );
  }

  _checkPermission() async {
    LoadingUtil.show();
    _startTimer();
  }


}
