import 'package:flutter/material.dart';
import 'package:homecredit/entity/AppConfigEntity.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../utils/appconfig.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';

class SelectItemWrap extends StatefulWidget {
  final String title;
  final Color? titleColor;
  final Color? backgroundColor;
  final String keyName;
  String defaultText;
  AppConfig? appConfig;

  final Function? onTapCallback;

  SelectItemWrap(
      String this.defaultText,
      {Key? key,
      this.title = '',
      this.titleColor,
      this.backgroundColor,
      this.keyName = '',
      this.onTapCallback, this.appConfig
      })
      : super(key: key);

  @override
  State<SelectItemWrap> createState() => _SelectItemWrapState();
}

class _SelectItemWrapState extends State<SelectItemWrap> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.backgroundColor,),
      child: Column(
        children: [
          Text(widget.title,
              style: TextStyle(
                color: widget.titleColor,
                fontSize: 14.0,
              )),
          InkWell(
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              padding: EdgeInsets.only(
                  top: 12.0, left: 13.0, right: 15.0, bottom: 12.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Row(
                children: [
                  widget.defaultText.isEmpty
                      ? Text(
                    widget.title,
                    style: TextStyle(
                      color: HcColors.color_999999,
                      fontSize: 14.0,
                    ),
                  )
                      : Text(widget.defaultText,
                      style: TextStyle(
                        color: HcColors.color_333333,
                        fontSize: 14.0,
                      )),
                  Spacer(),
                  Image(
                      image: AssetImage('images/ic_right_arrow.png'),
                      width: 9.0,
                      height: 12.0),
                ],
              ),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              widget.appConfig ??= AppConfig();
              widget.appConfig?.getAppConfig(Api.payTypeValue(), context, (id, text) {
                setState(() {
                  if(text.isNotEmpty) {
                    widget.onTapCallback!(id,text);
                  }
                });
              });
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}