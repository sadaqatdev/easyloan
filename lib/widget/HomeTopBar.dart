import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/res/colors.dart';

import '../generated/l10n.dart';
import '../page/service/service_call.dart';

class HomeTopBar extends StatefulWidget {
  final Function? onTapCallback;

  const HomeTopBar({Key? key, this.onTapCallback}) : super(key: key);

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HcColors.color_02B17B,
      ),
      child: Stack(
        children: [
          Image(image: AssetImage('images/top_bg.png'),
          width: double.infinity,),
          Container(
            margin: EdgeInsets.only(bottom: 30.0),
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            // color: ,
            child: Row(
              children: [
                Image(
                  image: AssetImage('images/ic_logo_small.png'),
                  width: 29.0,
                  height: 26.0,
                ),
                SizedBox(width: 10.0),
                Expanded(
                    child: Text(
                      S.of(context).app_name,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold
                      ),
                    )),
                ServiceCall(onTapCallback: widget.onTapCallback),
              ],
            ),
          )
        ],
        alignment: AlignmentDirectional.bottomCenter,
      ),
    );
  }


}
