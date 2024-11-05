import 'package:flutter/material.dart';
import 'package:homecredit/utils/clipboard.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:sprintf/sprintf.dart';

import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';
import '../../utils/toast.dart';

class PayPage extends StatefulWidget {
  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;
  final String? easypaisaNo;
  final String? jazzCashNo;
  final bool ep_visible;
  final bool jc_visible;

  PayPage(
      {Key? key,
      this.easypaisaNo,
      this.ep_visible = false,
      this.jc_visible = false,
      this.margin,
      this.border, this.jazzCashNo})
      : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Easypaisa
        Visibility(
          visible: widget.ep_visible,
          child: Container(
            margin: widget.margin,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/easypaysa_logo.png'),
                      width: 93.0,
                      height: 70.0,
                    ),
                    Image(
                      image: AssetImage('images/repayment_steps.png'),
                      width: 184.0,
                      height: 69.0,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15.0,
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    sprintf(S.of(context).easypaisa_hint1,[S.of(context).app_name]),
                    style: TextStyle(
                      color: HcColors.color_333333,
                      fontSize: 14.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: HcColors.color_DBF2EB,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15.0,
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: S.of(context).easypaisa_hint21,
                          style: TextStyle(
                              color: Color(0xFF333333), fontSize: 14.0),
                        ),
                        TextSpan(
                          text: S.of(context).easypaisa_hint22,
                          style: TextStyle(
                              color: HcColors.color_02B17B, fontSize: 14.0),
                        ),
                      ])),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).easypaisa_app,
                                style: TextStyle(
                                  color: HcColors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(width: 2,),
                              Image(
                                image: AssetImage('images/ic_tan_white.png'),
                                width: 12.0,
                                height: 12.0,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
                              color: HcColors.color_7579E7,
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                        ),
                        onTap: () {
                          _showSteps(Image(
                              image: AssetImage('images/ic_pay_app.png')));
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).easypaisa_retailer,
                                style: TextStyle(
                                  color: HcColors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(width: 2,),
                              Image(
                                image: AssetImage('images/ic_tan_white.png'),
                                width: 12.0,
                                height: 12.0,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
                              color: HcColors.color_469BE7,
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                        ),
                        onTap: () {
                          _showSteps(Image(
                              image: AssetImage('images/ic_pay_retailer.png')));
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child: Row(
                            children: [
                              Text(
                                S.of(context).easypaisa_ussd,
                                style: TextStyle(
                                  color: HcColors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(width: 2,),
                              Image(
                                image: AssetImage('images/ic_tan_white.png'),
                                width: 12.0,
                                height: 12.0,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          decoration: BoxDecoration(
                              color: HcColors.color_FF8E4E,
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                        ),
                        onTap: () {
                          _showSteps(
                              Image(image: AssetImage('images/ic_pay_ussd.png')));
                        },
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: HcColors.color_DBF2EB,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Image(
                        image: AssetImage('images/ic_pay_phone.png'),
                        width: 20.0,
                        height: 29.0,
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 38,
                          child: Row(
                            children: [
                              Text(S.of(context).consumer_id,
                                  style: TextStyle(
                                      color: HcColors.color_666666,
                                      fontSize: 14.0)),
                              Text(widget.easypaisaNo ?? '',
                                  style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: HcColors.color_02B17B),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextButton(
                              style: ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize:
                                    MaterialStateProperty.all(Size(0, 0)),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                              ),
                              onPressed: () {
                                if (Debounce.checkClick()) {
                                  if (widget.easypaisaNo!.isNotEmpty) {
                                    ClipboardUtil.setDataToast(
                                        widget.easypaisaNo!);
                                  }
                                }
                              },
                              child: Text(S.of(context).copy,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0))),
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                              color: HcColors.color_02B17B,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                        )
                      ],
                    )),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Divider(
                    height: 1,
                    color: HcColors.color_DBF2EB,
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only( bottom: 20.0,),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/ic_under_warn.png'),
                        width: 28.0,
                        height: 28.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          S.of(context).easypaisa_warn_hint,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: HcColors.color_02B17B,
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: widget.border,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // JAZZ CASH
        Visibility(
          visible: widget.jc_visible,
          child: Container(
            margin: widget.margin,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/jazzcash_logo.png'),
                      width: 84.0,
                      height: 48.0,
                    ),
                    Image(
                      image: AssetImage('images/repayment_steps.png'),
                      width: 184.0,
                      height: 69.0,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15.0,
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    sprintf(S.of(context).easypaisa_hint1,[S.of(context).app_name]),
                    style: TextStyle(
                      color: HcColors.color_333333,
                      fontSize: 14.0,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: HcColors.color_DBF2EB,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 15.0,
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: S.of(context).easypaisa_hint23,
                          style: TextStyle(
                              color: Color(0xFF333333), fontSize: 14.0),
                        ),
                        TextSpan(
                          text: S.of(context).easypaisa_hint22,
                          style: TextStyle(
                              color: HcColors.color_02B17B, fontSize: 14.0),
                        ),
                      ])),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 15,right: 15),
                          padding: EdgeInsets.only(top: 8,bottom: 8),
                          child: Row(
                          children: [
                            Text(
                              S.of(context).jazz_cash_app,

                              style: TextStyle(
                                color: HcColors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(width: 2,),
                            Image(
                              image: AssetImage('images/ic_tan_white.png'),
                              width: 12.0,
                              height: 12.0,
                            ),
                          ],
                            mainAxisAlignment: MainAxisAlignment.center,
                        ),
                          decoration: BoxDecoration(
                            color: HcColors.color_7579E7,
                              borderRadius: BorderRadius.all(Radius.circular(15.0))
                          ),
                        ),
                        onTap: () {
                          _showSteps(Image(
                              image: AssetImage('images/jazzcash_app.png')));
                        },
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: HcColors.color_DBF2EB,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                //
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Image(
                        image: AssetImage('images/ic_pay_phone.png'),
                        width: 20.0,
                        height: 29.0,
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 38,
                              child: Row(
                                children: [
                                  Text(S.of(context).consumer_id,
                                      style: TextStyle(
                                          color: HcColors.color_666666,
                                          fontSize: 14.0)),
                                  Text(widget.jazzCashNo ?? '',
                                      style: TextStyle(
                                          color: HcColors.color_333333,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              padding: EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: HcColors.color_02B17B),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                  style: ButtonStyle(
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minimumSize:
                                    MaterialStateProperty.all(Size(0, 0)),
                                    padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                  ),
                                  onPressed: () {
                                    if (Debounce.checkClick()) {
                                      if (widget.jazzCashNo!.isNotEmpty) {
                                        ClipboardUtil.setDataToast(
                                            widget.jazzCashNo!);
                                      }
                                    }
                                  },
                                  child: Text(S.of(context).copy,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0))),
                              padding: EdgeInsets.only(
                                  top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                              decoration: BoxDecoration(
                                  color: HcColors.color_02B17B,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                            )
                          ],
                        )),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Divider(
                    height: 1,
                    color: HcColors.color_DBF2EB,
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only( bottom: 20.0,),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/ic_under_warn.png'),
                        width: 28.0,
                        height: 28.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          S.of(context).easypaisa_warn_hint,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: HcColors.color_02B17B,
                          ),
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: widget.border,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
        ),

      ],
    );
  }

  _showSteps(Widget child) {
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
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 13),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              child,
                              Container(
                                margin: EdgeInsets.only(top: 30, bottom: 30),
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
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0))),
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
