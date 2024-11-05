import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../res/colors.dart';
import '../utils/debounce.dart';

//、
class LoginButton extends StatelessWidget {
  final String? title;
  final bool enable;

  final VoidCallback? onPressed;
  final VoidCallback? onEnabled;

  const LoginButton(
      {Key? key,
      this.title,
      this.enable = true,
      this.onPressed,
      this.onEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
      width: double.infinity,
      height: 46.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(),
      child:
          Text(title!, style: TextStyle(color: Colors.white, fontSize: 22.0)),
      decoration: BoxDecoration(
        color: enable ? HcColors.color_02B17B : HcColors.color_EEEEEE,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
      onTap: enable ? onPressed : onEnabled,
    );
  }
}
