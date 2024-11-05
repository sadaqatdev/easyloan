import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/page/HomePage.dart';
import 'package:homecredit/page/pay/pay_page.dart';
import 'package:sprintf/sprintf.dart';

import '../../arch/api/api.dart';
import '../../arch/net/code.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../utils/log.dart';
import '../../utils/toast.dart';
import '../../utils/money.dart';

class DeferredPage extends StatefulWidget {
  final Map<String, dynamic> map;
  final bool ep_visible;
  final bool jc_visible;

  DeferredPage(
      {Key? key,
      this.ep_visible = false,
      this.jc_visible = false,
      this.map = const {}})
      : super(key: key);

  @override
  State<DeferredPage> createState() => _DeferredPageState();
}

class _DeferredPageState extends State<DeferredPage> {
  String? easypaisaNo;
  String? jazzCashNo;

  String? extFee;
  String? interest;
  String? serCharge;
  String? lateCharge;
  String? updateDueDate;
  String? payAmount;
  String? extendedHint;
  String? overdueRate;

  bool _showServiceDetail = false;
  bool _showLatefee = false;
  bool _isOverdue = false;
  double? deductionFee;

  @override
  void initState() {
    super.initState();
    _queryEpNo();
  }

  @override
  Widget build(BuildContext context) {
    updateDueDate = widget.map[Api.extendDate];
    double afterExtendOrderAmtValue = widget.map[Api.afterExtendOrderAmt];
    extFee = ' ' + afterExtendOrderAmtValue.moneyFormat;
    double interestValue = widget.map[Api.interest];
    interest = ' ' + interestValue.moneyFormat;
    double serviceFeeNewValue = widget.map[Api.serviceFeeNew];
    serCharge = ' ' + serviceFeeNewValue.moneyFormat;

    double lateFeeValue = widget.map[Api.lateFee];
    lateCharge = ' ' + lateFeeValue.moneyFormat;
    double repayAmtValue = widget.map[Api.repayAmt];
    payAmount = ' ' + repayAmtValue.moneyFormat;
    overdueRate = widget.map[Api.overdueRate] ?? '';
    if (overdueRate == '') {
      _isOverdue = false;
    } else {
      _isOverdue = true;
    }

    extendedHint =
        sprintf(S.current.extended_hint, [payAmount, updateDueDate, payAmount]);

    deductionFee = widget.map[Api.deductionFee];

    return Scrollbar(
        child: SingleChildScrollView(
      // physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 20),
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

            Text(
              extendedHint ?? '',
              style: TextStyle(
                fontSize: 12.0,
                color: HcColors.color_02B17B,
              ),
            ),

            //Update Due Date
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    S.of(context).update_due_date,
                    style: TextStyle(
                      color: HcColors.color_333333,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    updateDueDate ?? '',
                    style: TextStyle(
                        color: HcColors.color_02B17B,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),

            // DETAIL
            Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HcColors.color_DBF2EB,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0))),
                    child: Text(
                      S.of(context).detail,
                      style: TextStyle(
                        color: HcColors.color_02B17B,
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
                              S.of(context).extended_fee,
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
                                text: extFee ?? '',
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
                        InkWell(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Text(
                                    S.of(context).service_charge,
                                    style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Image(
                                    image:
                                        AssetImage('images/ic_detail_ts.png'),
                                    width: 12.0,
                                    height: 13.0,
                                  ),
                                ],
                              )),
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text: 'PKR',
                                  style: TextStyle(
                                      color: HcColors.color_999999,
                                      fontSize: 12.0),
                                ),
                                TextSpan(
                                  text: serCharge ?? '',
                                  style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 12.0),
                                ),
                              ])),
                              Image(
                                image: _showServiceDetail
                                    ? AssetImage('images/ic_s_down.png')
                                    : AssetImage('images/ic_s_right.png'),
                                width: 10.0,
                                height: 10.0,
                              ),
                            ],
                          ),
                          onTap: () {
                            setState(() {
                              _showServiceDetail = !_showServiceDetail;
                            });
                          },
                        ),
                        Visibility(
                          visible: _showServiceDetail,
                          child: Container(
                            margin: EdgeInsets.only(top: 6.0),
                            child: DottedBorder(
                              color: Color(0xFF36D091),
                              dashPattern: [8, 4],
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      S.of(context).nadra_verification,
                                      style: TextStyle(
                                        color: HcColors.color_999999,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).cib_tasdeeq,
                                      style: TextStyle(
                                        color: HcColors.color_999999,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).aml_cft_fee,
                                      style: TextStyle(
                                        color: HcColors.color_999999,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).transcation_fee,
                                      style: TextStyle(
                                        color: HcColors.color_999999,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).sms_charges,
                                      style: TextStyle(
                                        color: HcColors.color_999999,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                            visible: _isOverdue,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 6.0,
                                ),
                                InkWell(
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Text(
                                            S.of(context).late_payment_charge,
                                            style: TextStyle(
                                              color: HcColors.color_333333,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          Image(
                                            image: AssetImage(
                                                'images/ic_detail_ts.png'),
                                            width: 12.0,
                                            height: 13.0,
                                          ),
                                        ],
                                      )),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: 'PKR',
                                          style: TextStyle(
                                              color: HcColors.color_999999,
                                              fontSize: 12.0),
                                        ),
                                        TextSpan(
                                          text: lateCharge ?? '',
                                          style: TextStyle(
                                              color: HcColors.color_333333,
                                              fontSize: 12.0),
                                        ),
                                      ])),
                                      Image(
                                        image: _showLatefee
                                            ? AssetImage('images/ic_s_down.png')
                                            : AssetImage(
                                                'images/ic_s_right.png'),
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
                                      color: Color(0xFF36D091),
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
                                                color: HcColors.color_999999,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              overdueRate ?? '',
                                              style: TextStyle(
                                                color: HcColors.color_999999,
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
                              ],
                            )),

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
                    color: HcColors.color_DBF2EB,
                    width: 1,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),

            //
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Text(
                S.of(context).repayment_reminder,
                style: TextStyle(color: HcColors.color_FF5545, fontSize: 14),
              ),
            ),

            // Payment Amount
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Text(
                    S.of(context).payment_amount,
                    style: TextStyle(
                      color: HcColors.color_333333,
                      fontSize: 16.0,
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                      text: 'PKR',
                      style: TextStyle(
                          color: HcColors.color_02B17B, fontSize: 16.0),
                    ),
                    TextSpan(
                      text: payAmount ?? '',
                      style: TextStyle(
                          color: HcColors.color_02B17B,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ])),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),

            PayPage(
              easypaisaNo: easypaisaNo,
              jazzCashNo: jazzCashNo,
              ep_visible: widget.ep_visible,
              jc_visible: widget.jc_visible,
              border: Border.all(
                color: HcColors.color_DBF2EB,
                width: 1,
              ),
            ),

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
        decoration: BoxDecoration(),
      ),
    ));
  }

  _queryEpNo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.payType] = Code.PAYTYPE_ROLLOVER;
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
}
