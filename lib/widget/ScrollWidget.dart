import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:homecredit/utils/log.dart';

import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../generated/l10n.dart';
import 'SubTopBar.dart';

class ScrollWidget extends StatefulWidget {
  final Widget? child;
  final String? title;
  final bool centerTitle;
  final int pointType;

  final bool needContext;

  ScrollWidget({
    Key? key,
    this.child,
    this.title,
    this.centerTitle = true, this.pointType = 0, this.needContext = false,
  }) : super(key: key);

  @override
  State<ScrollWidget> createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: SubTopBar(widget.title ?? '', backPressed: (){
            _logPoint();
            Navigator.of(context).pop();
          },),
          body: widget.needContext ? widget.child : GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Scrollbar(
                child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: widget.child,
            )),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
        ));
  }

  _logPoint(){
    switch (widget.pointType) {
      case 1:
        LogUtil.platformLog(optType: PointLog.CLICK_BASIC_INF_RT());
        break;
      case 2:
        LogUtil.platformLog(optType: PointLog.CLICK_CONTACT_INF_RT());
        break;
      case 3:
        LogUtil.platformLog(optType: PointLog.CLICK_ID_INF_RT());
        break;
      case 4:
        LogUtil.platformLog(optType: PointLog.CLICK_BANK_CARD_INF_RT());
        break;
    }
  }

  Future<bool> _onWillPop() {

    if(EasyLoading.isShow){
      return Future.value(false);
    }

    _logPoint();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }
}
