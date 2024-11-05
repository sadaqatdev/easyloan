import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/http.dart';
import 'package:homecredit/routes/route_util.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:homecredit/utils/sp.dart';

import '../application.dart';
import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/routes.dart';
import '../utils/debounce.dart';
import '../utils/toast.dart';
import '../widget/SubTopBar.dart';

class SubmitPage extends StatefulWidget {
  const SubmitPage({Key? key}) : super(key: key);

  @override
  State<SubmitPage> createState() => _SubmitPageState();
}

class _SubmitPageState extends State<SubmitPage> {
  String? repayAmount1;
  String? repayDate1;
  String? loanAmount;
  String? interest;
  String? proFee;
  String? serCharge;
  String? disAmount;
  String? repayAmount2;
  String? repayDate2;
  String? repayAmount3;
  String? repayDate3;

  String? _currentMoney;
  String? _detailId;
  String? _productId;
  String? _orderId;

  bool _showServiceDetail = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> map = RouteUtil.getParams(context);
    repayAmount1 = map['repayAmount1'];
    repayDate1 = map['repayDate1'];
    loanAmount = map['loanAmount'];
    interest = map['interest'];
    proFee = map['proFee'];
    serCharge = map['serCharge'];
    disAmount = map['disAmount'];
    repayAmount2 = map['repayAmount2'];
    repayDate2 = map['repayDate2'];
    repayAmount3 = map['repayAmount3'];
    repayDate3 = map['repayDate3'];

    _currentMoney = map[Api.applyAmount].toString();
    _detailId = map[Api.detailId].toString();
    _productId = map[Api.productId].toString();
    _orderId = map[Api.orderId].toString();

    return Scaffold(
      appBar: SubTopBar(
        S.of(context).app_name,
        offstage: false,
        showSubProductName: true,
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          S.of(context).loan_amount,
                          style: TextStyle(
                            color: HcColors.color_666666,
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            loanAmount ?? '',
                            style: TextStyle(
                                color: HcColors.color_02B17B,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          'PKR',
                          style: TextStyle(
                            color: HcColors.color_333333,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          S.of(context).loan_term,
                          style: TextStyle(
                            color: HcColors.color_666666,
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            '91',
                            style: TextStyle(
                                color: HcColors.color_02B17B,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Text(
                          S.of(context).days,
                          style: TextStyle(
                            color: HcColors.color_333333,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              //
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 20.0,
                                  bottom: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF36D091),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.5))),
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  S.of(context).stage1,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            // DottedLine(
                            //   direction: Axis.vertical,
                            //   lineLength: double.infinity,
                            //   lineThickness: 1.0,
                            //   dashLength: 4.0,
                            //   dashColor: Colors.black,
                            // ),
                          ],
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFDCFCEF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).repayment_date,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  repayDate1 ?? '',
                                  style: TextStyle(
                                      color: Color(0xFFFF5545),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF36D091),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10.0),
                                                topLeft: Radius.circular(10.0),
                                                bottomRight:
                                                    Radius.circular(10.0))),
                                        child: Text(
                                          S.of(context).detail,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 10.0,
                                            bottom: 15.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  S.of(context).loan_amount,
                                                  style: TextStyle(
                                                    color:
                                                        HcColors.color_333333,
                                                    fontSize: 12.0,
                                                  ),
                                                )),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                    text: 'PKR',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 12.0),
                                                  ),
                                                  TextSpan(
                                                    text: loanAmount ?? '',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
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
                                                    color:
                                                        HcColors.color_333333,
                                                    fontSize: 12.0,
                                                  ),
                                                )),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                    text: 'PKR',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 12.0),
                                                  ),
                                                  TextSpan(
                                                    text: interest ?? '',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
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
                                                  S.of(context).processing_Fee,
                                                  style: TextStyle(
                                                    color:
                                                        HcColors.color_333333,
                                                    fontSize: 12.0,
                                                  ),
                                                )),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                    text: 'PKR',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 12.0),
                                                  ),
                                                  TextSpan(
                                                    text: proFee ?? '',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
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
                                                        S
                                                            .of(context)
                                                            .service_charge,
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_333333,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                      Image(
                                                        image: AssetImage(
                                                            'images/ic_service_warn.png'),
                                                        width: 10.0,
                                                        height: 10.0,
                                                      ),
                                                    ],
                                                  )),
                                                  Text.rich(TextSpan(children: [
                                                    TextSpan(
                                                      text: 'PKR',
                                                      style: TextStyle(
                                                          color: HcColors
                                                              .color_999999,
                                                          fontSize: 12.0),
                                                    ),
                                                    TextSpan(
                                                      text: serCharge ?? '',
                                                      style: TextStyle(
                                                          color: HcColors
                                                              .color_333333,
                                                          fontSize: 12.0),
                                                    ),
                                                  ])),
                                                  Image(
                                                    image: _showServiceDetail
                                                        ? AssetImage(
                                                            'images/ic_s_down.png')
                                                        : AssetImage(
                                                            'images/ic_s_right.png'),
                                                    width: 10.0,
                                                    height: 10.0,
                                                  ),
                                                ],
                                              ),
                                              onTap: () {
                                                print(
                                                    '---------------------------');
                                                setState(() {
                                                  _showServiceDetail =
                                                      !_showServiceDetail;
                                                });
                                              },
                                            ),
                                            Visibility(
                                              visible: _showServiceDetail,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 6.0),
                                                child: DottedBorder(
                                                  color: Color(0xFF36D091),
                                                  dashPattern: [8, 4],
                                                  borderType: BorderType.RRect,
                                                  radius: Radius.circular(10),
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .nadra_verification,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_999999,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .cib_tasdeeq,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_999999,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .aml_cft_fee,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_999999,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .transcation_fee,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_999999,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .sms_charges,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_999999,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 6.0,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  S
                                                      .of(context)
                                                      .disbursal_amount,
                                                  style: TextStyle(
                                                    color:
                                                        HcColors.color_333333,
                                                    fontSize: 12.0,
                                                  ),
                                                )),
                                                Text.rich(TextSpan(children: [
                                                  TextSpan(
                                                    text: 'PKR',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 12.0),
                                                  ),
                                                  TextSpan(
                                                    text: disAmount ?? '',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
                                                        fontSize: 12.0),
                                                  ),
                                                ])),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  S.of(context).repayment_amount,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'PKR',
                                    style: TextStyle(
                                        color: Color(0xFFFF5545),
                                        fontSize: 12.0),
                                  ),
                                  TextSpan(
                                    text: repayAmount1 ?? '',
                                    style: TextStyle(
                                        color: Color(0xFFFF5545),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                              ],
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),

                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 20.0,
                                  bottom: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF469BE7),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.5))),
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  S.of(context).stage2,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            // DashLine(
                            //     size: Size(1, 200),
                            //     color: Color(0xFF36D091),
                            //     dashLineSize: 6,
                            //     spacingSize: 4,
                            //     direction: DashLine.DIRECTION_VERTICAL),
                          ],
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFDDEFFB),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).repayment_date,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  repayDate2 ?? '',
                                  style: TextStyle(
                                      color: Color(0xFFFF5545),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  S.of(context).repayment_amount,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'PKR',
                                    style: TextStyle(
                                        color: Color(0xFFFF5545),
                                        fontSize: 12.0),
                                  ),
                                  TextSpan(
                                    text: repayAmount2,
                                    style: TextStyle(
                                        color: Color(0xFFFF5545),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                              ],
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 20.0,
                                  bottom: 20.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFFFF8E4E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.5))),
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  S.of(context).stage3,
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                            // DashLine(
                            //     size: Size(1, 200),
                            //     color: Color(0xFF36D091),
                            //     dashLineSize: 6,
                            //     spacingSize: 4,
                            //     direction: DashLine.DIRECTION_VERTICAL),
                          ],
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFFDF1DD),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).repayment_date,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  repayDate3 ?? '',
                                  style: TextStyle(
                                      color: Color(0xFFFF5545),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  S.of(context).repayment_amount,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 14.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'PKR',
                                    style: TextStyle(
                                        color: Color(0xFFFF5545),
                                        fontSize: 12.0),
                                  ),
                                  TextSpan(
                                    text: repayAmount3 ?? '',
                                    style: TextStyle(
                                        color: Color(0xFFFF5545),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ])),
                              ],
                            ),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    // Confirm Button
                    Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: TextButton(
                          style: ButtonStyle(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minimumSize: MaterialStateProperty.all(Size(0, 0)),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          onPressed: () {
                            if(Debounce.checkClick()) {
                              _confirm();
                            }
                          },
                          child: Text(S.of(context).confirm,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0))),
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFFF5545),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                padding: EdgeInsets.only(
                    left: 20.0, top: 15.0, right: 20.0, bottom: 15.0),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xFFFFE9E9),
          ),
        ),
      )),
    );
  }

  _confirm() async {
    try {

      LogUtil.platformLog(optType: PointLog.CLICK_LOAN_SUBMIT());

      Map<String, String> params = await CommonParams.addParams();
      params[Api.applyAmount] = _currentMoney!;
      params[Api.detailId] = _detailId!;
      params[Api.productId] = _productId!;
      params[Api.orderId] = _orderId!;
      params[Api.lbs] = await FlutterPlugin.getLocation();
      ResultData resultData =
          await HttpManager.instance().post(Api.submitOrder(), params: params,mul: true);
      if (resultData.success) {
        _addLog();
        _showDialog();
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  _addLog() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getReborrowFlag(), params: params, mul: true);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        String flag = map[Api.reborrowFlag].toString();
        if(flag != "1"){
          LogUtil.platformLog(optType: PointLog.SYSTEM_FIRST_LOAN_SUCCESS());
          LogUtil.otherLog(
              bfEvent: PointLog.CLICK_LOAN_SUBMIT(),
              fbEvent: 'fb_mobile_initiated_checkout');
        }
        LogUtil.platformLog(optType: PointLog.SYSTEM_LOAN_SUCCESS());
      }
    } catch (e) {}
  }

  _showDialog() {
    showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
      )),
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('images/ic_success.png'),
                      width: 274,
                      height: 162,
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        S.of(context).success_hint,
                        style: TextStyle(
                          color: HcColors.color_333333,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 60.0,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: MaterialButton(
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          height: 46.0,
                          disabledColor: HcColors.color_EEEEEE,
                          color: HcColors.color_02B17B,
                          onPressed: () {
                            RouteUtil.push(context, Routes.index, clearStack: true);
                          },
                          child: Text(S.of(context).ok,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0))),
                    ),
                  ],
                ),
              );
          },
        );
      },
    ).then((value) {
      RouteUtil.push(context, Routes.index, clearStack: true);
    });
  }
}
