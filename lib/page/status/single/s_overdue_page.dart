import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/page/pay/pay_page.dart';
import 'package:marquee/marquee.dart';
import 'package:sprintf/sprintf.dart';
import '../../../arch/net/code.dart';
import '../../../generated/l10n.dart';
import '../../../res/colors.dart';
import '../../../routes/routes.dart';
import '../../../routes/route_util.dart';
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
import '../../../utils/money.dart';
import '../../vip/vip_banner_page.dart';
import '../deferred_page.dart';
import '../order_log.dart';
import 'package:decimal/decimal.dart';

class SOverduePage extends StatefulWidget {
  const SOverduePage(this.map,{Key? key, this.scrollController}) : super(key: key);
  final Map<String, dynamic> map;
  final ScrollController? scrollController;

  @override
  State<SOverduePage> createState() => SOverduePageState();
}

class SOverduePageState extends State<SOverduePage> {
  var _payWigetKey = GlobalKey();

  String? repayAmount;
  String? repayDate;
  String? loanAmount;
  String? interest;
  String? lateCharge;
  String? easypaisaNo;
  String? jazzCashNo;
  bool ep_visible = false;
  bool jc_visible = false;

  int? jazzCashFlag;
  int? easyPayFlag;

  String? orderId;

  String? overdueDaysBr;
  String? overdueDays;

  GlobalKey _easypaisaKey = GlobalKey();
  String? marqueeText;
  String? extendDuration;

  String? overdueRate;
  bool _showLatefee = false;
  double? deductionFee;

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
                            image: AssetImage('images/ic_repayment_0.png'),
                            width: 59.0,
                            height: 59.0,
                          ),
                          Text(
                            S.of(context).pending_n_repayment,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: HcColors.color_999999),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_overdue_1.png'),
                            width: 59.0,
                            height: 59.0,
                          ),
                          Text(
                            overdueDaysBr ?? '',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: HcColors.color_FF8E4E),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Image(
                            image: AssetImage('images/ic_overdue_sj.png'),
                            width: 29.0,
                            height: 20.0,
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
                                fontSize: 12.0,
                                color: HcColors.color_999999),
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
                      color: HcColors.color_FDF1DD,
                      borderRadius:
                      BorderRadius.all(Radius.circular(15.0))),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_overdue_2.png'),
                            width: 57.0,
                            height: 57.0,
                          ),
                          Text(
                            overdueDays ?? '',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: HcColors.color_FF8E4E,
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
                                  color: HcColors.color_FF8E4E,
                                  fontSize: 16.0),
                            ),
                            TextSpan(
                              text: repayAmount ?? '',
                              style: TextStyle(
                                  color: HcColors.color_FF8E4E,
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
                              color: HcColors.color_FF8E4E,
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
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                minimumSize:
                                MaterialStateProperty.all(Size(0, 0)),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.zero),
                              ),
                              onPressed: () {
                                if (Debounce.checkClick()) {
                                  _scrollToWidget();
                                }
                              },
                              child: Text(S.of(context).repay,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.0))),
                          padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: 8.0,
                              left: 12.0,
                              right: 12.0),
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
                            padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                                left: 12.0,
                                right: 12.0),
                            decoration: BoxDecoration(
                                color: HcColors.color_DBF2EB,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0))),
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
            child: Text(
              S.of(context).repayment_reminder,
              style: TextStyle(color: HcColors.color_FF5545, fontSize: 14),
            ),
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
            margin: EdgeInsets.only(
                top: 15.0, left: 15.0, right: 15, bottom: 20),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HcColors.color_FDF1DD,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0))),
                  child: Text(
                    S.of(context).detail,
                    style: TextStyle(
                      color: HcColors.color_FF8E4E,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: 10.0, bottom: 15.0, left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                S.of(context).repayment_amount,
                                style: TextStyle(
                                  color: HcColors.color_333333,
                                  fontSize: 12.0,
                                ),
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_999999,
                                  fontSize: 12.0),
                            ),
                            TextSpan(
                              text: repayAmount ?? '',
                              style: TextStyle(
                                  color: HcColors.color_333333,
                                  fontSize: 12.0),
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
                                  color: HcColors.color_333333,
                                  fontSize: 12.0,
                                ),
                              )),
                          Text(
                            repayDate ?? '',
                            style: TextStyle(
                                color: HcColors.color_333333,
                                fontSize: 12.0),
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
                                  color: HcColors.color_333333,
                                  fontSize: 12.0,
                                ),
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_999999,
                                  fontSize: 12.0),
                            ),
                            TextSpan(
                              text: loanAmount ?? '',
                              style: TextStyle(
                                  color: HcColors.color_333333,
                                  fontSize: 12.0),
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
                                  color: HcColors.color_333333,
                                  fontSize: 12.0,
                                ),
                              )),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: 'PKR',
                              style: TextStyle(
                                  color: HcColors.color_999999,
                                  fontSize: 12.0),
                            ),
                            TextSpan(
                              text: interest ?? '',
                              style: TextStyle(
                                  color: HcColors.color_333333,
                                  fontSize: 12.0),
                            ),
                          ])),
                        ],
                      ),
                      SizedBox(
                        height: 6.0,
                      ),

                      // Late payment charge
                      InkWell(
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      S.of(context).late_payment_charge,
                                      style: TextStyle(
                                        color: HcColors.color_FF5545,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Image(
                                      image:
                                      AssetImage('images/ic_detail_ts.png'),
                                      width: 12.0,
                                      height: 13.0,
                                    )
                                  ],
                                )),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'PKR',
                                style: TextStyle(
                                    color: HcColors.color_FF5545,
                                    fontSize: 12.0),
                              ),
                              TextSpan(
                                text: lateCharge ?? '',
                                style: TextStyle(
                                    color: HcColors.color_FF5545,
                                    fontSize: 12.0),
                              ),
                            ])),
                            Image(
                              image: _showLatefee
                                  ? AssetImage('images/ic_s_down.png')
                                  : AssetImage('images/ic_s_right.png'),
                              width: 10.0,
                              height: 10.0,
                            ),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _showLatefee = !_showLatefee;
                          });
                        },
                      ),
                      Visibility(
                        visible: _showLatefee,
                        child: Container(
                          margin: EdgeInsets.only(top: 6.0),
                          child: DottedBorder(
                            color: HcColors.color_FF5545,
                            dashPattern: [8, 4],
                            borderType: BorderType.RRect,
                            radius: Radius.circular(10),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(
                                    S.of(context).late_fee,
                                    style: TextStyle(
                                      color: HcColors.color_FF5545,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    overdueRate ?? '',
                                    style: TextStyle(
                                      color: HcColors.color_FF5545,
                                      fontSize: 12.0,
                                    ),
                                  )
                                ],
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                              ),
                            ),
                          ),
                        ),
                      ),

                      (deductionFee != null && deductionFee! > 0)
                          ? Column(
                        children: [
                          SizedBox(
                            height: 6.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    S.of(context).deduction_fee,
                                    style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 12.0,
                                    ),
                                  )),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: 'PKR',
                                  style: TextStyle(
                                      color: HcColors.color_999999,
                                      fontSize: 12.0),
                                ),
                                TextSpan(
                                  text: deductionFee?.moneyFormat,
                                  style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 12.0),
                                ),
                              ])),
                            ],
                          ),
                        ],
                      )
                          : Container()
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: HcColors.color_FDF1DD,
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),

          //
          Container(
            margin: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage('images/ic_under_warn.png'),
                      width: 28.0,
                      height: 28.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      S.of(context).warning,
                      style: TextStyle(
                          fontSize: 20.0,
                          color: HcColors.color_02B17B,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  S.of(context).overdue_warn,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: HcColors.color_02B17B,
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
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
      HLog.error("--------------------------------------------------------------");
      if (map.isNotEmpty) {

        String duration = map[Api.duration].toString();
        extendDuration =
            sprintf(S.of(context).extend_duration_format, [duration]);

        setState(() {
          orderId = map[Api.orderId].toString();

          String days = map[Api.overdueDays].toString();
          overdueDays = sprintf(S.of(context).overdue_0_days_format, [days]);
          overdueDaysBr =
              sprintf(S.of(context).overdue_n_0_days_format, [days]);

          double amount = map[Api.repayAmt];
          double creditAmount = map[Api.creditAmount];
          double intAmount = map[Api.intAmount];

          double lateFeeValue = map[Api.lateFee];
          lateCharge = ' ' + lateFeeValue.moneyFormat;

          repayAmount = ' ' + amount.moneyFormat;
          loanAmount = ' ' + creditAmount.moneyFormat;
          interest = ' ' + intAmount.moneyFormat;

          repayDate = map[Api.repaymentDate] ?? '';

          easyPayFlag = map[Api.easyPayFlag];
          if (easyPayFlag == 1) {
            ep_visible = true;
            _queryEpNo();
          }
          jazzCashFlag = map[Api.jazzCashFlag];
          if (jazzCashFlag == 1) {
            jc_visible = true;
          }
          deductionFee = map[Api.deductionFee] ?? 0;
          String rate = map[Api.overdueRate].toString();
          overdueRate = "${Decimal.parse(rate) * Decimal.parse("100")}%/day";
        });

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
    } catch (e) {}
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
          map[Api.overdueRate] = overdueRate;
          map[Api.deductionFee] = deductionFee;
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
