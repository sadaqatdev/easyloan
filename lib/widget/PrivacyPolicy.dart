import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:homecredit/generated/l10n.dart';
import 'package:homecredit/res/colors.dart';
import '../arch/net/config.dart';
import '../utils/debounce.dart';
import '../utils/flutter_plugin.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text.rich(TextSpan(children: [
        TextSpan(
          text: 'If you continue,you agree to the ',
          style: TextStyle(color: HcColors.color_333330, fontSize: 13.0),
        ),
        TextSpan(
            text: '<Terms & conditions>',
            style: TextStyle(color: HcColors.color_007D7A, fontSize: 13.0),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // debugPrint("Terms & conditions");
                if (Debounce.checkClick()) {
                  FlutterPlugin.openWebview(NetConfig.TERM_URL);
                }
              }),
        TextSpan(
          text: ' and ',
          style: TextStyle(color: HcColors.color_333330, fontSize: 13.0),
        ),
        TextSpan(
            text: '<Privacy Policy> ',
            style: TextStyle(color: HcColors.color_007D7A, fontSize: 13.0),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // debugPrint("Privacy Policy");
                if (Debounce.checkClick()) {
                  FlutterPlugin.openWebview(NetConfig.PEIVACY_URL);
                }
              }),
        TextSpan(
          text: 'carefully.',
          style: TextStyle(color: HcColors.color_333330, fontSize: 13.0),
        ),
      ])),
      decoration: BoxDecoration(),
    );
  }
}
