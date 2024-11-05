import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../utils/debounce.dart';

class ServiceItem extends StatefulWidget {
  final String title;
  final int index;

  const ServiceItem({Key? key, this.title = '', this.index = 0})
      : super(key: key);

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 40, right: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Visibility(
            visible: widget.index == 0,
            child: Container(
              margin: EdgeInsets.only(right: 60),
              child: Image(
                image: AssetImage('images/ic_pay_sj.png'),
                width: 29,
                height: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: HcColors.color_469BE7,
                      fontSize: 16.0,
                      decoration: TextDecoration.underline,
                      // decorationStyle: TextDecorationStyle.dashed
                    ),
                  ),
                  onTap: () {
                    if (Debounce.checkClick()) {
                      _jump2Call();
                    }
                  },
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  child: Image(
                    image: AssetImage('images/ic_call.png'),
                    width: 22,
                    height: 22,
                  ),
                  onTap: () {
                    _jump2Call();
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            decoration: BoxDecoration(
              color: HcColors.color_DBF2EB,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  _jump2Call() async {
    try {
      String url = 'tel:' + widget.title;
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {}
  }
}
