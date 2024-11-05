import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:homecredit/res/colors.dart';
import 'package:homecredit/utils/log.dart';

import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../generated/l10n.dart';
import '../page/service/service_call.dart';
import '../utils/sp.dart';

class SubTopBar extends StatefulWidget  implements PreferredSizeWidget {

  late String title;
  final bool centerTitle;
  final bool offstage;
  final Color backgroundColor;
  final bool showSubProductName;
  final bool showLeading;

  final VoidCallback? backPressed;

  SubTopBar(@required String this.title,{Key? key, this.centerTitle = true, this.offstage = true, this.backgroundColor = HcColors.color_DBF2EB, this.showSubProductName = false, this.backPressed, this.showLeading = true}) : super(key: key);

  @override
  State<SubTopBar> createState() => _SubTopBarState();

  @override
  Size get preferredSize => getSize();

  Size getSize() {
    return Size(double.infinity, 50.0);
  }
}

class _SubTopBarState extends State<SubTopBar> {
  @override
  Widget build(BuildContext context) {

    if(widget.showSubProductName) {
      SpUtil.getString(Api.appName, '').then((value) {
        setState(() {
          widget.title = value;
        });
      });
    }

    return AppBar(
      centerTitle: widget.centerTitle,
      backgroundColor: widget.backgroundColor,
      title: Text(
        widget.title,
        style: TextStyle(
          color: HcColors.color_333333,
          fontSize: 20.0,
        ),
      ),
      elevation: 0,
      leading:widget.showLeading ?  IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(39, 37, 54, 1),
        ),
        onPressed: widget.backPressed ?? (){
          Navigator.of(context).pop();
        },
      ):null,
      actions: [
        Offstage(
          offstage: widget.offstage,
          child: Container(
            margin: EdgeInsets.only(right: 15),
            child: ServiceCall(),
          ),
        )
      ],
    );
  }
}

