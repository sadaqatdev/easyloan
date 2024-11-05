import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:homecredit/generated/l10n.dart';
import 'package:homecredit/res/colors.dart';

import '../utils/debounce.dart';
import '../utils/flutter_plugin.dart';
import '../utils/toast.dart';

class NextButton extends StatelessWidget {
  const NextButton({Key? key, this.pressed = null}) : super(key: key);

  final Function? pressed;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: HcColors.color_DBF2EB,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: 8.0,
          //     bottom: 8.0,
          //   ),
          //   child: Text.rich(TextSpan(children: [
          //     TextSpan(
          //       text: S.of(context).next_hint,
          //       style: TextStyle(color: Color(0xFF333333), fontSize: 10.0),
          //     ),
          //     TextSpan(
          //       text: ' 2,000',
          //       style: TextStyle(color: HcColors.color_007D7A, fontSize: 12.0),
          //     ),
          //   ])),
          // ),
          InkWell(
            child: Container(
              width: double.infinity,
              height: 46.0,
              alignment: Alignment.center,
              margin: EdgeInsets.only(),
              child: Text(S.of(context).next,
                  style: TextStyle(color: Colors.white, fontSize: 22.0)),
              decoration: BoxDecoration(
                color: pressed != null
                    ? HcColors.color_02B17B
                    : HcColors.color_EEEEEE,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onTap: pressed == null
                ? () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (Debounce.checkClick()) {
                      try {
                        FlutterPlugin.checkNetwork().then((value) {
                          if (value) {
                            ToastUtil.show(S.of(context).button_disable_hint);
                          }
                        });
                      } catch (e) {}
                    }
                  }
                : () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (Debounce.checkClick()) {
                      try {
                        FlutterPlugin.checkNetwork().then((value) {
                          if (value) {
                            pressed!();
                          }
                        });
                      } catch (e) {}
                    }
                  },
          )
        ],
      ),
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
    );
  }
}
