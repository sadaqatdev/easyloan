import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/page/service/service_item.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:homecredit/utils/log.dart';

import '../../arch/api/api.dart';
import '../../arch/net/config.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';
import '../../utils/sp.dart';

class ServiceCall extends StatefulWidget {
  final int type;
  final Function? onTapCallback;

  const ServiceCall({Key? key, this.type = 0, this.onTapCallback})
      : super(key: key);

  @override
  State<ServiceCall> createState() => _ServiceCallState();
}

class _ServiceCallState extends State<ServiceCall> {
  late Widget child;

  @override
  Widget build(BuildContext context) {
    if (widget.type == 1) {
      child = Column(
        children: [
          Image(
            image: AssetImage('images/ic_mine_cus.png'),
            width: 26.0,
            height: 26.0,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            S.of(context).customer_service,
            style: TextStyle(fontSize: 12.0, color: HcColors.color_333333),
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      child = Image(
          image: AssetImage('images/ic_kefu.png'), width: 31.0, height: 31.0);
    }

    return InkWell(
      child: child,
      onTap: () async {
        if (Debounce.checkClick()) {
          // _queryWhatsup();
          if (widget.type == 0) {
            //
            // String token = await SpUtil.getString(Api.token,"");
            // if(token.isNotEmpty){
            //   String mobile = await SpUtil.getString(Api.mobile,"");
            //   if(mobile.isNotEmpty) {
            //     FlutterPlugin.setCrispLogin(mobile);
            //   }
            //   String testCustFlag = await SpUtil.getString(Api.testCustFlag,"");
            //   if(testCustFlag.isNotEmpty) {
            //     FlutterPlugin.setSessionSegment(
            //         testCustFlag == "1" ? "test" : "EasyLoan");
            //   }
            //   FlutterPlugin.openCrisp();
            // }else{
            //   RouteUtil.push(context, Routes.service,onTapCallback: widget.onTapCallback);
            // }
            _showMenuDialog();
          } else {
            RouteUtil.push(context, Routes.service);
          }
        }
      },
    );
  }

  _queryWhatsup() async {
    try {
      if (NetConfig.appMobile.isNotEmpty) {
        _showDialog();
        return;
      }
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData =
          await HttpManager.instance().post(Api.getAppInfo(), params: params);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        NetConfig.appMobile = map[Api.appMobile];
        if (NetConfig.appMobile.isNotEmpty) {
          _showDialog();
        }
      }
    } catch (e) {}
  }

  _showDialog() {
    List<String> list = NetConfig.appMobile.split(",");
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.0,
                        ),
                        Text(
                          S.of(context).telephone_number,
                          style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          child: MediaQuery.removePadding(
                            context: context,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: list.length,
                              itemBuilder: (BuildContext context, int index) {
                                String value = list[index];
                                return ServiceItem(
                                  title: value,
                                  index: index,
                                );
                              },
                            ),
                            removeTop: true,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                  ),
                  Positioned(
                    right: 40,
                    child: InkWell(
                      child: Image(
                        image: AssetImage('images/ic_dialog_close.png'),
                        width: 25.0,
                        height: 25.0,
                      ),
                      onTap: () {
                        RouteUtil.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _showMenuDialog() {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.only(top: 13),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0))),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: 10,
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'images/ic_mine_feed.png'),
                                            width: 38.0,
                                            height: 36.0,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            S.of(context).dialog_online_service,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: HcColors.color_333333),
                                          ),
                                          Spacer(),
                                          Image(
                                              image: AssetImage('images/ic_right_arrow.png'),
                                              width: 9.0,
                                              height: 12.0),
                                        ],
                                      ),
                                      onTap: () async{
                                        if (Debounce.checkClick()) {
                                              String mobile = await SpUtil.getString(Api.mobile,"");
                                              if(mobile.isNotEmpty) {
                                                FlutterPlugin.setCrispLogin(mobile);
                                              }
                                              String testCustFlag = await SpUtil.getString(Api.testCustFlag,"");
                                              if(testCustFlag.isNotEmpty) {
                                                FlutterPlugin.setSessionSegment(
                                                    testCustFlag == "1" ? "test" : "EasyLoan");
                                              }
                                              FlutterPlugin.openCrisp();
                                        }
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:15.0,bottom: 15.0),
                                      child: DottedLine(
                                        dashLength: 10,
                                        // dashGapLength: 10,
                                        lineThickness: 1,
                                        dashColor: HcColors.color_02B17B,
                                        // dashGapColor: Colors.red,
                                      ),
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'images/ic_mine_cus.png'),
                                            width: 32.0,
                                            height: 32.0,
                                          ),
                                          SizedBox(
                                            width: 21,
                                          ),
                                          Text(
                                            S.of(context)
                                                .dialog_customer_service,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: HcColors.color_333333),
                                          ),
                                          Spacer(),
                                          Image(
                                              image: AssetImage('images/ic_right_arrow.png'),
                                              width: 9.0,
                                              height: 12.0),
                                        ],
                                      ),
                                      onTap: () async{
                                        if (Debounce.checkClick()) {
                                          RouteUtil.push(context, Routes.service,onTapCallback: widget.onTapCallback);
                                        }
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:15.0,bottom: 15.0),
                                      child: DottedLine(
                                        dashLength: 10,
                                        // dashGapLength: 10,
                                        lineThickness: 1,
                                        dashColor: HcColors.color_02B17B,
                                        // dashGapColor: Colors.red,
                                      ),
                                    ),
                                    InkWell(
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'images/ic_mine_cx.png'),
                                            width: 38.0,
                                            height: 39.0,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            S.of(context)
                                                .dialog_cancel_an_order,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: HcColors.color_333333),
                                          ),
                                          Spacer(),
                                          Image(
                                              image: AssetImage('images/ic_right_arrow.png'),
                                              width: 9.0,
                                              height: 12.0),
                                        ],
                                      ),
                                      onTap: () async{
                                        if (Debounce.checkClick()) {
                                          String mobile = await SpUtil.getString(Api.mobile,"");
                                          if(mobile.isNotEmpty) {
                                            FlutterPlugin.setCrispLogin(mobile);
                                          }
                                          String testCustFlag = await SpUtil.getString(Api.testCustFlag,"");
                                          if(testCustFlag.isNotEmpty) {
                                            FlutterPlugin.setSessionSegment(
                                                testCustFlag == "1" ? "test" : "EasyLoan");
                                          }
                                          FlutterPlugin.openCrisp();
                                        }
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top:15.0,bottom: 15.0),
                                      child: DottedLine(
                                        dashLength: 10,
                                        // dashGapLength: 10,
                                        lineThickness: 1,
                                        dashColor: HcColors.color_02B17B,
                                        // dashGapColor: Colors.red,
                                      ),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40,
                    child: InkWell(
                      child: Image(
                        image: AssetImage('images/ic_dialog_close.png'),
                        width: 25.0,
                        height: 25.0,
                      ),
                      onTap: () {
                        RouteUtil.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
