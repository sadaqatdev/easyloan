import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../utils/debounce.dart';
import '../utils/toast.dart';

class TimerCountDown extends StatefulWidget {
  Function onTimerFinish;
  Function? onTapCallback;
  String phoneNo;
  int indexNo;

  TimerCountDown({required this.onTimerFinish, required this.phoneNo,required this.indexNo, this.onTapCallback})
      : super();

  @override
  State<StatefulWidget> createState() => TimerCountDownState();
}

class TimerCountDownState extends State<TimerCountDown> {
  late Timer _timer;
  int _countdownTime = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Debounce.checkClick()) {
          if (widget.phoneNo.isEmpty) {
            return;
          }
          if (_countdownTime == 0) {
            _getCode();
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
        decoration: BoxDecoration(
          color: _countdownTime > 0
              ? Color(0xFFB8B8B8)
              : HcColors.color_02B17B,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          _countdownTime > 0
              ? sprintf(S.of(context).resend_text, ["$_countdownTime"])
              : S.of(context).get_otp,
          style: TextStyle(
            fontSize: 14,
            color: _countdownTime > 0 ? Colors.white : HcColors.white,
          ),
        ),
      ),
    );
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => {
              setState(() {
                if (_countdownTime < 1) {
                  widget.onTimerFinish();
                  _timer.cancel();
                } else {
                  _countdownTime = _countdownTime - 1;
                }
              })
            });
  }

  _getCode() async {
    Map<String, String> params = await CommonParams.addParams();
    params[Api.phoneNo] = widget.phoneNo;
    params[Api.linkmanValue] = widget.indexNo.toString();
    ResultData resultData =
        await HttpManager.instance().post(Api.getSaveLinkmanInfoVerifCode(), params: params);
    if (resultData.success) {

      setState(() {
        _countdownTime = 60;
      });
      //
      startCountdownTimer();

      widget.onTapCallback!(resultData.data[Api.smsCode]);

    } else {
      ToastUtil.show(resultData.msg);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
