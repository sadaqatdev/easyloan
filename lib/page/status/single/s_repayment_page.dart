import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/code.dart';
import 'package:homecredit/page/status/deferred_page.dart';
import 'package:homecredit/page/pay/pay_page.dart';
import 'package:sprintf/sprintf.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../routes/route_util.dart';
import '../../../routes/routes.dart';
import '../../../utils/debounce.dart';
import '../../../utils/log.dart';
import '../../../widget/StatusTopBar.dart';
import '../../../widget/SubTopBar.dart';
import '../../../arch/api/api.dart';
import '../../../arch/net/http.dart';
import '../../../arch/net/params.dart';
import '../../../arch/net/result_data.dart';
import '../../../utils/toast.dart';
import "package:intl/intl.dart";
import '../../vip/vip_banner_page.dart';
import '../../../../utils/money.dart';
import '../order_log.dart';

class SRepaymentPage extends StatefulWidget {
  const SRepaymentPage(this.map,{Key? key, this.scrollController}) : super(key: key);
  final Map<String, dynamic> map;
  final ScrollController? scrollController;

  @override
  State<SRepaymentPage> createState() => SRepaymentPageState();
}

class SRepaymentPageState extends State<SRepaymentPage> {
  var _payWigetKey = GlobalKey();

  String? repayAmount;
  String? repayDate;
  String? loanAmount;
  String? interest;
  String? easypaisaNo;
  String? jazzCashNo;
  bool ep_visible = false;
  bool jc_visible = false;

  int? jazzCashFlag;
  int? easyPayFlag;

  String? orderId;

  GlobalKey _easypaisaKey = GlobalKey();

  String? extendDuration;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,() {
      _indexQuery();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SubTopBar(
            S.of(context).app_name,
            backgroundColor: Colors.white,
            offstage: false,
            showSubProductName: true,
            showLeading: false,
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_under_0.png'),
                            width: 59.0,
                            height: 59.0,
                          ),
                          Text(
                            S.of(context).under_n_review,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HcColors.color_999999,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_repayment_1.png'),
                            width: 59.0,
                            height: 59.0,
                          ),
                          Text(
                            S.of(context).pending_n_repayment,
                            style: TextStyle(
                                fontSize: 12.0, color: HcColors.color_469BE7),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Image(
                            image: AssetImage('images/ic_repayment_sj.png'),
                            width: 29.0,
                            height: 20.0,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_overdue_0.png'),
                            width: 59.0,
                            height: 59.0,
                          ),
                          Text(
                            S.of(context).overdue_n_0_days,
                            style: TextStyle(
                                fontSize: 12.0, color: HcColors.color_999999),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_reject_0.png'),
                            width: 59.0,
                            height: 59.0,
                          ),
                          Text(
                            S.of(context).reject_n_application,
                            style: TextStyle(
                                fontSize: 12.0, color: HcColors.color_999999),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      color: HcColors.color_DDEFFB,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_repayment_2.png'),
                            width: 57.0,
                            height: 57.0,
                          ),
                          Text(
                            S.of(context).pending_n_repayment,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HcColors.color_469BE7,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Column(
                        children: [
                          Text(
                            S.of(context).repayment_amount,
                            style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_469BE7, fontSize: 16.0),
                            ),
                            TextSpan(
                              text: repayAmount ?? '',
                              style: TextStyle(
                                  color: HcColors.color_469BE7,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ])),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            S.of(context).repayment_date,
                            style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            repayDate ?? '',
                            style: TextStyle(
                              color: HcColors.color_469BE7,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )
                    ],
                  ),
                ),

                //
                Container(
                  margin: EdgeInsets.only(
                      left: 15.0, right: 15, top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 46,
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
                                  _scrollToWidget();
                                }
                              },
                              child: Text(S.of(context).repay,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24.0))),
                          padding: EdgeInsets.only(
                              top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                          decoration: BoxDecoration(
                              color: HcColors.color_02B17B,
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            height: 46,
                            child: TextButton(
                                style: ButtonStyle(
                                  tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                                  minimumSize:
                                  MaterialStateProperty.all(Size(0, 0)),
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.zero),
                                ),
                                onPressed: () {
                                  if (Debounce.checkClick()) {
                                    _getDetail();
                                  }
                                },
                                child: Text(
                                  extendDuration ?? '',
                                  style: TextStyle(
                                      color: HcColors.color_007D7A,
                                      fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                )),
                            padding: EdgeInsets.only(),
                            decoration: BoxDecoration(
                                color: HcColors.color_DBF2EB,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
          ),

          //
          Container(
            margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
            child: Text(S.of(context).repayment_reminder,
              style: TextStyle(
                  color: HcColors.color_FF5545,
                  fontSize: 14
              ),),
          ),

          Container(
            margin: EdgeInsets.only(top: 20, left: 20, bottom: 15),
            width: double.infinity,
            child: Text(
              S.of(context).fast_repayment,
              style: TextStyle(
                  color: HcColors.color_02B17B,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
          ),

          //
          PayPage(
            key: _payWigetKey,
            margin: EdgeInsets.only(left: 15.0, right: 15),
            easypaisaNo: easypaisaNo,
            jazzCashNo: jazzCashNo,
            ep_visible: ep_visible,
            jc_visible: jc_visible,
          ),

          // DETAIL
          Container(
            key: _easypaisaKey,
            margin:
            EdgeInsets.only(top: 15.0, left: 15.0, right: 15, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HcColors.color_02B17B,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      )),
                  child: Text(
                    S.of(context).detail,
                    style: TextStyle(
                      color: HcColors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 12.0, bottom: 15.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                S.of(context).repayment_amount,
                                style: TextStyle(
                                  color: HcColors.color_02B17B,
                                  fontSize: 14.0,
                                ),
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_999999, fontSize: 14.0),
                            ),
                            TextSpan(
                              text: repayAmount ?? '',
                              style: TextStyle(
                                  color: HcColors.color_333333, fontSize: 14.0),
                            ),
                          ])),
                        ],
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                S.of(context).repayment_date,
                                style: TextStyle(
                                  color: HcColors.color_02B17B,
                                  fontSize: 14.0,
                                ),
                              )),
                          Text(
                            repayDate ?? '',
                            style: TextStyle(
                                color: HcColors.color_333333, fontSize: 14.0),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                S.of(context).loan_amount,
                                style: TextStyle(
                                  color: HcColors.color_02B17B,
                                  fontSize: 14.0,
                                ),
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_999999, fontSize: 14.0),
                            ),
                            TextSpan(
                              text: loanAmount ?? '',
                              style: TextStyle(
                                  color: HcColors.color_333333, fontSize: 14.0),
                            ),
                          ])),
                        ],
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                S.of(context).interest,
                                style: TextStyle(
                                  color: HcColors.color_02B17B,
                                  fontSize: 14.0,
                                ),
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_999999, fontSize: 14.0),
                            ),
                            TextSpan(
                              text: interest ?? '',
                              style: TextStyle(
                                  color: HcColors.color_333333, fontSize: 14.0),
                            ),
                          ])),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: HcColors.color_DDEFFB,
                        width: 1,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top:20),
            child: Image(
              width: 329,
              height: 355,
              image: AssetImage('images/repayment_img.png'),
            ),
          ),

          // VipBannerPage(),
        ],
      ),
      decoration: BoxDecoration(color: HcColors.color_DBF2EB),
    );
  }

  _indexQuery() async {
    try {
      Map<String, dynamic> map = widget.map;

      if (map.isNotEmpty) {

        String duration = map[Api.duration].toString();
        extendDuration =
            sprintf(S.of(context).extend_duration_format, [duration]);

        setState(() {
          orderId = map[Api.orderId].toString();

          double amount = map[Api.repayAmt];
          double creditAmount = map[Api.creditAmount];
          double intAmount = map[Api.intAmount];

          repayAmount = ' ' + amount.moneyFormat;
          loanAmount = ' ' + creditAmount.moneyFormat;
          interest = ' ' + intAmount.moneyFormat;
          repayDate = map[Api.repaymentDate] ?? '';

          easyPayFlag = map[Api.easyPayFlag];
          if (easyPayFlag == 1) {
            ep_visible = true;
          }
          jazzCashFlag = map[Api.jazzCashFlag];
          if (jazzCashFlag == 1) {
            jc_visible = true;
          }
        });

        _queryEpNo();
      }
    } catch (e) {
      print(e);
    }
  }

  _queryEpNo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.payType] = Code.PAYTYPE_NORMAL;
      ResultData resultData = await HttpManager.instance()
          .post(Api.repaymentInitiate(), params: params, mul: true);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        setState(() {
          easypaisaNo = map[Api.payOutId];
          jazzCashNo = map[Api.jazzCashPayOutId];
        });
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _scrollToWidget() {
    try {
      RenderBox box =
          _payWigetKey.currentContext!.findRenderObject() as RenderBox;
      Offset topLeftPosition = box.localToGlobal(Offset.zero);
      print(topLeftPosition.dy);
      widget.scrollController?.jumpTo(topLeftPosition.dy);
    } catch (e) {
      print(e);
    }
  }

  _getDetail() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.payType] = '01';
      params[Api.orderId] = orderId ?? '';
      ResultData resultData = await HttpManager.instance()
          .post(Api.repayDetail(), params: params, mul: true);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        if (map.isNotEmpty) {
          _showDialog(map);
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _showDialog(Map<String, dynamic> map) {
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
                    height: double.infinity,
                    margin: EdgeInsets.only(top: 13),
                    child: DeferredPage(
                      ep_visible: ep_visible,
                      jc_visible: jc_visible,
                      map: map,
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
}
