import 'package:flutter/material.dart';
import 'package:homecredit/arch/api/log_util.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:homecredit/utils/log.dart';
import 'package:sprintf/sprintf.dart';
import 'dart:async';
import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../utils/toast.dart'; //Timer

class LoginFormCode extends StatefulWidget {
  /// ，60。
  final int countdown;

  /// 。
  final Function? onTapCallback;

  /// ，`false`。
  final bool available;

  String phoneNo;

  LoginFormCode(
      {Key? key,
      required this.phoneNo,
      this.countdown = 60,
      this.onTapCallback,
      this.available = false})
      : super(key: key);

  @override
  State<LoginFormCode> createState() => _LoginFormCodeState();
}

GlobalKey<_LoginFormCodeState> globalKey = GlobalKey();

final TextStyle _availableTextStyle =
    TextStyle(fontSize: 14.0, color: HcColors.color_02B17B);

final TextStyle _unavailableTextStyle =
    TextStyle(fontSize: 14.0, color: HcColors.color_999999);

final TextStyle _unavailableTimerTextStyle =
    TextStyle(fontSize: 12.0, color: HcColors.color_999999);

final BoxDecoration _availableContainerStyle = BoxDecoration(
    border: Border.all(color: HcColors.color_02B17B, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(8.0)));

final BoxDecoration _unavailableContainerStyle = BoxDecoration(
    border: Border.all(color: HcColors.color_999999, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(8.0)));

class _LoginFormCodeState extends State<LoginFormCode> {
  Timer? _timer;
  late int _seconds;
  late TextStyle inkWellTextStyle;
  late BoxDecoration inkWellContainerStyle;

  String _verifyStr = S.current.get_otp;

  bool isClick = false;

  //
  bool isCountDown = false;

  @override
  void initState() {
    _seconds = widget.countdown;
    inkWellTextStyle =
        widget.available ? _availableTextStyle : _unavailableTextStyle;
    inkWellContainerStyle = widget.available
        ? _availableContainerStyle
        : _unavailableContainerStyle;
    isClick = widget.available;
    super.initState();
  }

  void setAvailable(bool flag) {
    if (_timer != null && _timer!.isActive) {
      HLog.warning("isActive");
      return;
    }
    isClick = flag;
    inkWellTextStyle = flag ? _availableTextStyle : _unavailableTextStyle;
    inkWellContainerStyle =
        flag ? _availableContainerStyle : _unavailableContainerStyle;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant LoginFormCode oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _verifyStr = S.of(context).get_otp;
        _seconds = widget.countdown;
        inkWellTextStyle = _availableTextStyle;
        inkWellContainerStyle = _availableContainerStyle;
        isClick = true;
        isCountDown = false;
        setState(() {});
        return;
      }
      isCountDown = true;
      _seconds--;
      _verifyStr = sprintf(S.of(context).resend_text, ["$_seconds"]);
      setState(() {});
    });
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
        child: Text(
          _verifyStr,
          style: inkWellTextStyle,
        ),
        decoration: inkWellContainerStyle,
      ),
      onTap: isClick
          ? () async {
              if (widget.phoneNo.isNotEmpty && widget.phoneNo.length >= 10) {
                FlutterPlugin.getSmsCode().then((value){
                  if(value.isNotEmpty) {
                    widget.onTapCallback!(value);
                  }
                });
                _getCode();
              } else {
                ToastUtil.show(S.of(context).login_phone_len_hint);
              }
            }
          : () {
              if(isCountDown){
                return;
              }
              ToastUtil.show(S.of(context).login_phone_empty);
            },
    );
  }

  _getCode() async {
    Map<String, String> params = await CommonParams.addParams();
    params[Api.phoneNo] = widget.phoneNo;
    ResultData resultData =
        await HttpManager.instance().post(Api.getVerifCode(), params: params);
    if (resultData.success) {
      LogUtil.platformLog(
          optType: PointLog.SYSTEM_LOGIN_CODE_SUCCESS(), mul: false);
      LogUtil.otherLog(
          bfEvent: PointLog.LOGIN_CODE(), fbEvent: 'fb_mobile_activate_app');

      setState(() {
        isClick = false;
        inkWellTextStyle = _unavailableTextStyle;
        inkWellContainerStyle = _unavailableContainerStyle;
        inkWellTextStyle = _unavailableTimerTextStyle;
      });
      _startTimer();
      widget.onTapCallback!(resultData.data[Api.smsCode]);
    } else {
      ToastUtil.show(resultData.msg);
    }
  }
}
