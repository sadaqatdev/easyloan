import 'dart:async';

import 'package:alog/alog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/utils/date.dart';
import 'package:homecredit/utils/sp.dart';
import 'package:homecredit/widget/PrivacyPolicy.dart';
import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/config.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/debounce.dart';
import '../utils/dialog.dart';
import '../utils/flutter_plugin.dart';
import '../utils/log.dart';
import '../utils/toast.dart';
import '../widget/DashLine.dart';
import '../widget/GridDayItem.dart';
import '../widget/GridMoneyItem.dart';
import '../widget/SubTopBar.dart';
import 'package:dotted_line/dotted_line.dart';
import "package:intl/intl.dart";
import '../../utils/money.dart';
import 'package:decimal/decimal.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({Key? key}) : super(key: key);

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  List<Map<String, dynamic>> _moneyList = [];
  List<Map<String, dynamic>> _termList = [];

  String? repayAmount1;
  String? repayDate1;
  String? repayDate1d;
  String? loanAmount;
  String? interest;
  String? proFee;
  String? serCharge;
  String? disAmount;
  String? repayAmount2;
  String? repayDate2;
  String? repayAmount3;
  String? repayDate3;

  bool _showProcessingDetail = false;
  bool _showServiceDetail = false;

  DateTime? serverTime;
  double incrAmount = 0;

  bool isSingle = false;

  bool testCustFlag = false;

  String? data1;
  String? data1d;
  String? data2;
  String? data3;

  bool checkboxSelected = true;

  double intD = 0;
  String periodTime = "";
  String? apr;

  @override
  void initState() {
    super.initState();
    FlutterPlugin.initTextToSpeech();
    _getAppConfig();
    SpUtil.getString(Api.testCustFlag, "0").then((value) {
      if (value == "1") {
        testCustFlag = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SubTopBar(
          S.of(context).app_name,
          backgroundColor: Colors.white,
          offstage: false,
          showSubProductName: true,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            try {
              _moneyList = [];
              _termList = [];
              currentMoneyIndex = 0;
              currentDayIndex = 0;
              _showProcessingDetail = false;
              _showServiceDetail = false;
              _getAppConfig();
            } catch (e) {}
            return Future.delayed(Duration(seconds: 1));
          },
          child: Scrollbar(
              child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 20),
                    child: Column(
                      children: [
                        Text(
                          S.of(context).loan_amount,
                          style: TextStyle(
                            color: HcColors.color_333333,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 15.0),

                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: _moneyList.length,
                        //   itemBuilder: this._itemMoneyFunc,
                        // ),
                        RawScrollbar(
                          thumbColor: HcColors.color_FFF200,
                          radius: Radius.circular(3),
                          thickness: 6,
                          isAlwaysShown: true,
                          child: Container(
                            width: double.infinity,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: _moneyList.length,
                              itemBuilder: this._itemMoneyFunc,
                            ),
                            constraints: BoxConstraints(maxHeight: 240),
                          ),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    decoration: BoxDecoration(
                        color: HcColors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        )),
                  ),

                  //
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    S.of(context).repayment_term,
                                    style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    testCustFlag
                                        ? (data1 ?? '')
                                        : (repayDate1 ?? ''),
                                    style: TextStyle(
                                        color: HcColors.color_02B17B,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20.0,
                              ),

                              // view
                              Visibility(
                                  visible: testCustFlag,
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 60,
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 3,
                                                      decoration: BoxDecoration(
                                                        color: HcColors
                                                            .color_000000,
                                                      ),
                                                    ),
                                                  ),
                                                  Image(
                                                    width: 25,
                                                    height: 25,
                                                    image: AssetImage(
                                                        'images/ic_item_sel.png'),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 3,
                                                      decoration: BoxDecoration(
                                                        color: HcColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                    height: 50,
                                                    margin: EdgeInsets.only(
                                                        left: 20),
                                                    alignment: Alignment.center,
                                                    child: Text(data1 ?? '',
                                                        style: TextStyle(
                                                          color: HcColors.white,
                                                          fontSize: 14.0,
                                                        )),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: HcColors
                                                            .color_02B17B,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)))),
                                              )
                                            ],
                                          )),
                                      InkWell(
                                        child: Container(
                                            height: 60,
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HcColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Image(
                                                      width: 25,
                                                      height: 25,
                                                      image: AssetImage(
                                                          'images/ic_item_lock.png'),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HcColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(data2 ?? '',
                                                          style: TextStyle(
                                                            color:
                                                                HcColors.white,
                                                            fontSize: 14.0,
                                                          )),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: HcColors
                                                              .color_D5D5D5,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      8.0)))),
                                                )
                                              ],
                                            )),
                                        onTap: () {
                                          HDailog.showDataDialog(context);
                                        },
                                      ),
                                      InkWell(
                                        child: Container(
                                            height: 60,
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HcColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    Image(
                                                      width: 25,
                                                      height: 25,
                                                      image: AssetImage(
                                                          'images/ic_item_lock.png'),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: 3,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: HcColors
                                                              .color_000000,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(data3 ?? '',
                                                          style: TextStyle(
                                                            color:
                                                                HcColors.white,
                                                            fontSize: 14.0,
                                                          )),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: HcColors
                                                              .color_D5D5D5,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      8.0)))),
                                                )
                                              ],
                                            )),
                                        onTap: () {
                                          HDailog.showDataDialog(context);
                                        },
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )),

                              Visibility(
                                visible: !testCustFlag,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _termList.length,
                                  itemBuilder: this._itemDayFunc,
                                ),
                              ),

                              SizedBox(
                                height: 10.0,
                              ),

                              // DETAIL
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      width: 120,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: HcColors.color_02B17B,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10.0),
                                              topLeft: Radius.circular(10.0))),
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
                                                  color: HcColors.color_02B17B,
                                                  fontSize: 14.0,
                                                ),
                                              )),
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text: 'PKR ',
                                                  style: TextStyle(
                                                      color:
                                                          HcColors.color_999999,
                                                      fontSize: 14.0),
                                                ),
                                                TextSpan(
                                                  text: loanAmount ?? '',
                                                  style: TextStyle(
                                                      color:
                                                          HcColors.color_333333,
                                                      fontSize: 14.0),
                                                ),
                                              ])),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Visibility(
                                              visible: intD != 0,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Text(
                                                        S.of(context).interest,
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_02B17B,
                                                          fontSize: 14.0,
                                                        ),
                                                      )),
                                                      Text.rich(
                                                          TextSpan(children: [
                                                        TextSpan(
                                                          text: 'PKR ',
                                                          style: TextStyle(
                                                              color: HcColors
                                                                  .color_999999,
                                                              fontSize: 14.0),
                                                        ),
                                                        TextSpan(
                                                          text: interest ?? '',
                                                          style: TextStyle(
                                                              color: HcColors
                                                                  .color_333333,
                                                              fontSize: 14.0),
                                                        ),
                                                      ])),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                ],
                                              )),
                                          InkWell(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Row(
                                                  children: [
                                                    Text(
                                                      S
                                                          .of(context)
                                                          .processing_Fee,
                                                      style: TextStyle(
                                                        color: HcColors
                                                            .color_02B17B,
                                                        fontSize: 14.0,
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
                                                    text: 'PKR ',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 14.0),
                                                  ),
                                                  TextSpan(
                                                    text: proFee ?? '',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
                                                        fontSize: 14.0),
                                                  ),
                                                ])),
                                                Image(
                                                  image: _showProcessingDetail
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
                                              setState(() {
                                                _showProcessingDetail =
                                                    !_showProcessingDetail;
                                              });
                                            },
                                          ),
                                          Visibility(
                                            visible: _showProcessingDetail,
                                            child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8.0),
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .operation_cost,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .risk_cost,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .verification_cost,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .credit_scoring,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color:
                                                        HcColors.color_DBF2EB,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
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
                                                            .color_02B17B,
                                                        fontSize: 14.0,
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
                                                    text: 'PKR ',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 14.0),
                                                  ),
                                                  TextSpan(
                                                    text: serCharge ?? '',
                                                    style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
                                                        fontSize: 14.0),
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
                                              setState(() {
                                                _showServiceDetail =
                                                    !_showServiceDetail;
                                              });
                                            },
                                          ),
                                          Visibility(
                                            visible: _showServiceDetail,
                                            child: Container(
                                              width: double.infinity,
                                              margin: EdgeInsets.only(top: 8.0),
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .nadra_verification,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .cib_tasdeeq,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .aml_cft_fee,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .transcation_fee,
                                                          style: TextStyle(
                                                            color: HcColors
                                                                .color_666666,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .sms_charges,
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_666666,
                                                          fontSize: 12.0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color:
                                                        HcColors.color_DBF2EB,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                S.of(context).disbursal_amount,
                                                style: TextStyle(
                                                  color: HcColors.color_02B17B,
                                                  fontSize: 14.0,
                                                ),
                                              )),
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text: 'PKR ',
                                                  style: TextStyle(
                                                      color:
                                                          HcColors.color_999999,
                                                      fontSize: 14.0),
                                                ),
                                                TextSpan(
                                                  text: disAmount ?? '',
                                                  style: TextStyle(
                                                      color:
                                                          HcColors.color_333333,
                                                      fontSize: 14.0),
                                                ),
                                              ])),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          // InkWell(
                                          //   child: Row(
                                          //     children: [
                                          //       Text(
                                          //         S.of(context).late_fee,
                                          //         style: TextStyle(
                                          //           color:
                                          //               HcColors.color_02B17B,
                                          //           fontSize: 14.0,
                                          //         ),
                                          //       ),
                                          //       SizedBox(
                                          //         width: 3.0,
                                          //       ),
                                          //       Image(
                                          //         image: AssetImage(
                                          //             'images/ic_help.png'),
                                          //         width: 20.0,
                                          //         height: 20.0,
                                          //       ),
                                          //     ],
                                          //   ),
                                          //   onTap: () {
                                          //     showDialog(
                                          //         barrierDismissible: true,
                                          //         //
                                          //         context: context,
                                          //         builder: (context) {
                                          //           return AlertDialog(
                                          //             // titlePadding: EdgeInsets.all(10),
                                          //             elevation: 10,
                                          //             backgroundColor:
                                          //                 Colors.white,
                                          //             //
                                          //             shape:
                                          //                 RoundedRectangleBorder(
                                          //                     borderRadius:
                                          //                         BorderRadius
                                          //                             .circular(
                                          //                                 10)),
                                          //             //
                                          //             // icon: Icon(Icons.work_rounded),
                                          //             content: Text(S
                                          //                 .of(context)
                                          //                 .overdue_dialog_tips),
                                          //             contentTextStyle:
                                          //                 TextStyle(
                                          //                     color:
                                          //                         Colors.black),
                                          //             //text
                                          //             actions: [
                                          //               InkWell(
                                          //                 child: Padding(
                                          //                   padding:
                                          //                       EdgeInsets.all(
                                          //                           8.0),
                                          //                   child: Text(S
                                          //                       .of(context)
                                          //                       .ok),
                                          //                 ),
                                          //                 onTap: () {
                                          //                   Navigator.of(
                                          //                           context)
                                          //                       .pop();
                                          //                 },
                                          //               ),
                                          //             ],
                                          //           );
                                          //         });
                                          //   },
                                          // ),
                                          Row(
                                            children: [
                                              Text(
                                                S.of(context).late_fee,
                                                style: TextStyle(
                                                  color:
                                                  HcColors.color_FF5545,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 3.0,
                                              ),
                                              Image(
                                                image: AssetImage(
                                                    'images/ic_help.png'),
                                                width: 20.0,
                                                height: 20.0,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: double.infinity,
                                            margin: EdgeInsets.only(top: 8.0),
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(S.of(context).overdue_dialog_tips,
                                              style: TextStyle(
                                              color:
                                              HcColors.color_FF5545,
                                              fontSize: 14.0,
                                            ),),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color:
                                                  HcColors.color_FF5545,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        5.0))),
                                          ), 
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text("APR",
                                                    style: TextStyle(
                                                      color: HcColors.color_02B17B,
                                                      fontSize: 14.0,
                                                    ),
                                                  )),
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text: apr ?? '',
                                                  style: TextStyle(
                                                      color:
                                                      HcColors.color_333333,
                                                      fontSize: 14.0),
                                                ),
                                              ])),
                                            ],
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 15.0,
                              ),

                              Row(
                                children: [
                                  Text(
                                    S.of(context).repayment_amount,
                                    style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Spacer(),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: 'PKR ',
                                      style: TextStyle(
                                          color: HcColors.color_02B17B,
                                          fontSize: 12.0),
                                    ),
                                    TextSpan(
                                      text: repayAmount1 ?? '',
                                      style: TextStyle(
                                          color: HcColors.color_02B17B,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ])),
                                ],
                              ),

                              //
                              SizedBox(
                                height: 8.0,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        S.of(context).cooling_of_period,
                                        style: TextStyle(
                                          color: HcColors.color_333333,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Spacer(),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: 'Before ',
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 12.0),
                                        ),
                                        TextSpan(
                                          text: periodTime,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ])),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 15.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).about_period_content,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                    ),
                                    decoration: BoxDecoration(
                                        color: HcColors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),

                              Column(
                                children: [
                                  Text(
                                    S.of(context).officer_designated,
                                    style: TextStyle(
                                      color: HcColors.color_333333,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: 10.0,
                                        bottom: 15.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          S.of(context).officer_name,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                          S.of(context).officer_email,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                          S.of(context).officer_phone,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                          S.of(context).officer_address,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                    ),
                                    decoration: BoxDecoration(
                                        color: HcColors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                              ),
                            ],
                          ),
                        ),

                        // Confirm Button
                        Container(
                          margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 46,
                                    child: TextButton(
                                        style: ButtonStyle(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  Size(0, 0)),
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero),
                                        ),
                                        onPressed: () {
                                          if (Debounce.checkClick()) {
                                            RouteUtil.pop(context);
                                          }
                                        },
                                        child: Text(
                                          S.of(context).cancel,
                                          style: TextStyle(
                                              color: HcColors.color_02B17B,
                                              fontSize: 20.0),
                                          textAlign: TextAlign.center,
                                        )),
                                    padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 12.0,
                                        right: 12.0),
                                    decoration: BoxDecoration(
                                        color: HcColors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0))),
                                  )),
                              SizedBox(width: 15),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 46,
                                  child: TextButton(
                                      style: ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        minimumSize: MaterialStateProperty.all(
                                            Size(0, 0)),
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                      ),
                                      onPressed: () {
                                        if (Debounce.checkClick()) {
                                          _confirm();
                                        }
                                      },
                                      child: Text(S.of(context).confirm,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0))),
                                  padding: EdgeInsets.only(
                                      top: 8.0,
                                      bottom: 8.0,
                                      left: 12.0,
                                      right: 12.0),
                                  decoration: BoxDecoration(
                                      color: HcColors.color_02B17B,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: PrivacyPolicy(),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    padding: EdgeInsets.only(
                        left: 20.0, top: 15.0, right: 20.0, bottom: 15.0),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: HcColors.color_DBF2EB,
              ),
            ),
          )),
        ));
  }

  int? _term;
  int realterm = 0;
  int currentMoneyIndex = 0;
  int currentDayIndex = 0;
  int? _detailId;
  double? _currentMoney;
  int? _productId;

  _getAppConfig() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.type] = Api.newrealtermValue();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppConfig(), params: params, mul: true);
      if (resultData.success) {
        List list = resultData.data;
        if (list.isNotEmpty && list.length > 0) {
          Map map = list[0];
          realterm = int.parse(map[Api.code].toString());
          print('---------${realterm}---------');
          _queryProduct();
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _queryProduct() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.queryProduct(), params: params, mul: true);
      if (resultData.success) {
        _productId = resultData.data[Api.productId];
        serverTime =
            DateUtil.toDateTime(resultData.data[Api.serverTime].toString());
        periodTime =
            DateUtil.formatDateTime(serverTime!.add(Duration(days: 1)));
        List list = resultData.data[Api.prodetailList];
        if (list.isNotEmpty && list.length > 0) {
          _setMoneyData(list[0]);
          _term = list[0][Api.duration];
          _detailId = list[0][Api.detailId];
          int lastDuration = 0;
          list.forEach((element) {
            int duration = element[Api.duration];
            if (lastDuration < duration) {
              lastDuration = duration;
            }
            // String dateText = DateUtil.formatDateTime(
            //     serverTime!.add(Duration(days: (duration + realterm))));
            String dateText = duration.toString() + 'Days';
            Map<String, dynamic> map = element;
            map['text'] = dateText;
            map['click'] = true;
            _termList.add(map);
          });
          if (_termList.isNotEmpty && _termList.length > 0) {
            int addDay = 7;
            if (_termList.length == 1) {
              Map<String, dynamic> map = {};
              // String dateText = DateUtil.formatDateTime(serverTime!
              //     .add(Duration(days: (lastDuration + addDay + realterm))));
              String dateText = (lastDuration + addDay).toString() + 'Days';
              map['text'] = dateText;
              map['click'] = false;
              _termList.add(map);
              addDay = addDay + 7;

              map = {};
              // dateText = DateUtil.formatDateTime(serverTime!
              //     .add(Duration(days: (lastDuration + addDay + realterm))));
              dateText = (lastDuration + addDay).toString() + 'Days';
              map['text'] = dateText;
              map['click'] = false;
              _termList.add(map);
            } else {
              Map<String, dynamic> map = {};
              // String dateText = DateUtil.formatDateTime(serverTime!
              //     .add(Duration(days: (lastDuration + addDay + realterm))));
              String  dateText = (lastDuration + addDay).toString() + 'Days';
              map['text'] = dateText;
              map['click'] = false;
              _termList.add(map);
            }
            setState(() {});
          }

          _calculation();
        }

        //view
        if (testCustFlag) {
          // data1 =
          //     DateUtil.formatDateTime(serverTime!.add(Duration(days: (91))));
          data1d = DateUtil.formatDateTime(serverTime!.add(Duration(days: (91))));
          data1 = '91Days';
          // data2 = DateUtil.formatDateTime(
          //     serverTime!.add(Duration(days: (91 * 2))));
          data2 = '182Days';
          // data3 = DateUtil.formatDateTime(
          //     serverTime!.add(Duration(days: (91 * 3))));
          data3 = '273Days';

          setState(() {});
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  _setMoneyData(Map map) {
    _moneyList.clear();
    incrAmount = map[Api.incrAmount];
    double maxAmount = map[Api.maxCreditAmount];
    double minAmount = map[Api.minCreditAmount];

    ALog(
        'incrAmount=${incrAmount},maxAmount=${maxAmount}, minAmount=${minAmount}',
        mode: ALogMode.info);

    List<double> tempList = [];
    if (maxAmount == minAmount) {
      tempList.add(maxAmount);
    } else if (maxAmount > minAmount) {
      while (minAmount <= maxAmount) {
        tempList.add(minAmount);
        minAmount = minAmount + incrAmount;
      }
      double lastAmount = tempList[tempList.length - 1];
      if (lastAmount < maxAmount) {
        tempList.add(maxAmount);
      }
    }
    for (int i = tempList.length - 1; i >= 0; i--) {
      Map<String, dynamic> map = {};
      map["value"] = tempList[i];
      map["enable"] = true;
      _moneyList.add(map);
    }
    if (_moneyList.length > 0) {
      currentMoneyIndex = 0;
      _currentMoney = _moneyList[0]["value"];
      if (_moneyList.length == 1) {
        isSingle = true; //
        Map<String, dynamic> map = {};
        map["value"] = maxAmount + incrAmount;
        map["enable"] = false;
        _moneyList.add(map);
        map = {};
        map["value"] = maxAmount + (incrAmount * 2);
        map["enable"] = false;
        _moneyList.add(map);
        map = {};
        map["value"] = maxAmount + (incrAmount * 3);
        map["enable"] = false;
        _moneyList.add(map);
      } else {
        Map<String, dynamic> map = {};
        map["value"] = maxAmount + incrAmount;
        map["enable"] = false;
        _moneyList.add(map);
      }

      setState(() {});
    }
  }

  Widget _itemMoneyFunc(BuildContext context, int index) {
    bool isCheck = currentMoneyIndex == index;
    double money = _moneyList[index]["value"];
    bool enable = _moneyList[index]["enable"];
    return GridViewItem(
      title: money.toStringAsFixed(0),
      stepMoney: incrAmount.toStringAsFixed(0),
      lastPosition: _moneyList.length - 1,
      selected: isCheck,
      index: index,
      selectIndex: currentMoneyIndex,
      enable: enable,
      isSingle: isSingle,
      onTapCallback: (position, value) {
        setState(() {
          currentMoneyIndex = position;
          _currentMoney = _moneyList[position]["value"];
        });
        _calculation();
      },
    );
  }

  Widget _itemDayFunc(BuildContext context, int index) {
    bool isCheck = currentDayIndex == index;
    Map<String, dynamic> map = _termList[index];
    return GridDayItem(
      title: map['text'],
      selected: isCheck,
      index: index,
      selectIndex: currentDayIndex,
      lastPosition: _termList.length - 1,
      enable: map['click'],
      onTapCallback: (position, value) {
        print('${position}========${value}');

        setState(() {
          currentDayIndex = position;
          _term = _termList[position][Api.duration];
          _detailId = _termList[position][Api.detailId];
        });

        _setMoneyData(_termList[index]);

        _calculation();
      },
    );
  }

  _calculation() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.applyAmount] = _currentMoney.toString();
      params[Api.detailId] = _detailId.toString();
      ResultData resultData = await HttpManager.instance()
          .post(Api.preAmount(), params: params, mul: true);
      if (resultData.success) {
        _speakText();

        Map<String, dynamic> map = resultData.data;
        setState(() {
          loanAmount = _currentMoney!.moneyFormat;
          intD = map[Api.intAmount];
          interest = intD.moneyFormat;
          double proD = map[Api.processingFee];
          proFee = proD.moneyFormat;
          double serD = map[Api.serviceFeeNew];
          serCharge = serD.moneyFormat;
          double disD = map[Api.disbursalAmount];
          disAmount = disD.moneyFormat;

          double amount = map[Api.preAmountField];
          repayAmount1 = amount.moneyFormat;
          double amount1 = amount * 0.01;
          repayAmount2 = amount1.moneyFormat;
          repayAmount3 = amount1.moneyFormat;

          // repayDate1 = DateUtil.formatDateTime(
          //     serverTime!.add(Duration(days: (_term! + realterm))));
          repayDate1 = _term.toString() + 'Days';
          repayDate1d = DateUtil.formatDateTime(
              serverTime!.add(Duration(days: (_term! + realterm))));

          repayDate2 = DateUtil.formatDateTime(
              serverTime!.add(Duration(days: (_term! + realterm + 45))));
          repayDate3 = DateUtil.formatDateTime(
              serverTime!.add(Duration(days: (_term! + realterm + 91))));

          if(_term == 14){
            apr = "834%";
          }else if(_term == 21){
            apr = "608%";
          } else{
            apr = "";
          }
          
        });

      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  _speakText() async {
    try{
      String name = await SpUtil.getString(Api.fullName, "");
      String date = testCustFlag ? data1d ?? '' : (repayDate1d ?? '');
      String text_en = "Dear ${name}, your current loan amount is ${loanAmount}, with a loan term of ${_term} days and a maturity date of ${date}. The amount to be repaid upon maturity is ${repayAmount1}";
      String text_ur = "معزز ${name}، آپ کے موجودہ قرض کی رقم ${loanAmount} ہے، جس میں قرض کی مدت ${_term} دن ہے اور ${date} کی میچورٹی تاریخ ہے۔ میچورٹی پر ادا کی جانی والی رقم ${repayAmount1} ہے۔";

      Map<String, String> map = {
        'text_ur': text_ur,
        'text_en': text_en
      };
      FlutterPlugin.speakText(map);
    }catch (e) {
      print(e);
    }
  }

  _confirm() async {
    //
    if (_detailId == null || _productId == null) {
      ToastUtil.show(S.current.product_query_fail);
      return;
    }
    try {
      LogUtil.platformLog(optType: PointLog.CLICK_LOAN_APPLY());

      Map<String, String> params = await CommonParams.addParams();
      params[Api.applyAmount] = _currentMoney.toString();
      params[Api.detailId] = _detailId.toString();
      params[Api.productId] = _productId.toString();
      ResultData resultData = await HttpManager.instance()
          .post(Api.preSubmitOrder(), params: params, mul: true);
      if (resultData.success) {
        String orderId = resultData.data[Api.orderId].toString();
        //
        List<dynamic> urls = resultData.data[Api.newContractList];
        String url = "";
        if (urls.isNotEmpty) {
          url = urls[0]["url"];
        }
        _showConfirmDialog(orderId, url);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  _showConfirmDialog(String orderId, String url) {
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
                    child: Center(
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
                                width: 120,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: HcColors.color_02B17B,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                    )),
                                child: Text(
                                  S.of(context).loan_detail,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: 12.0,
                                    bottom: 15.0,
                                    left: 20.0,
                                    right: 20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          S.of(context).disbursal_amount,
                                          style: TextStyle(
                                            color: HcColors.color_02B17B,
                                            fontSize: 14.0,
                                          ),
                                        )),
                                        Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: 'PKR ',
                                            style: TextStyle(
                                                color: HcColors.color_999999,
                                                fontSize: 14.0),
                                          ),
                                          TextSpan(
                                            text: disAmount ?? '',
                                            style: TextStyle(
                                                color: HcColors.color_333333,
                                                fontSize: 14.0),
                                          ),
                                        ])),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
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
                                            text: 'PKR ',
                                            style: TextStyle(
                                                color: HcColors.color_999999,
                                                fontSize: 14.0),
                                          ),
                                          TextSpan(
                                            text: repayAmount1 ?? '',
                                            style: TextStyle(
                                                color: HcColors.color_333333,
                                                fontSize: 14.0),
                                          ),
                                        ])),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
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
                                        Text.rich(TextSpan(children: [
                                          TextSpan(
                                            text: testCustFlag
                                                ? (data1d ?? '')
                                                : (repayDate1d ?? ''),
                                            style: TextStyle(
                                                color: HcColors.color_333333,
                                                fontSize: 14.0),
                                          ),
                                        ])),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: HcColors.color_DBF2EB, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(S.of(context).confirm_loan_hint,
                                    style: TextStyle(
                                        color: HcColors.color_999999,
                                        fontSize: 16.0)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 46,
                                        child: TextButton(
                                            style: ButtonStyle(
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              minimumSize:
                                                  MaterialStateProperty.all(
                                                      Size(0, 0)),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.zero),
                                            ),
                                            onPressed: () {
                                              if (Debounce.checkClick()) {
                                                RouteUtil.pop(context);
                                                LogUtil.platformLog(
                                                    optType: PointLog
                                                        .CLICK_LOAN_CANCEL());
                                              }
                                            },
                                            child: Text(
                                              S.of(context).cancel,
                                              style: TextStyle(
                                                  color: HcColors.color_02B17B,
                                                  fontSize: 20.0),
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
                                      )),
                                  SizedBox(width: 15),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      height: 46,
                                      child: TextButton(
                                          style: ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size(0, 0)),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                          ),
                                          onPressed: () {
                                            if (Debounce.checkClick()) {
                                              if (!checkboxSelected) {
                                                ToastUtil.show(S
                                                    .of(context)
                                                    .loan_agreement_hint);
                                                return;
                                              }
                                              RouteUtil.pop(context);
                                              _submit(orderId);
                                            }
                                          },
                                          child: Text(S.of(context).confirm,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0))),
                                      padding: EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          left: 12.0,
                                          right: 12.0),
                                      decoration: BoxDecoration(
                                          color: HcColors.color_02B17B,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: checkboxSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          checkboxSelected = value!;
                                        });
                                      },
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    Text.rich(TextSpan(children: [
                                      TextSpan(
                                        text: 'Please review the ',
                                        style: TextStyle(
                                            color: HcColors.color_333330,
                                            fontSize: 13.0),
                                      ),
                                      TextSpan(
                                          text: '<loan agreement>',
                                          style: TextStyle(
                                              color: HcColors.color_007D7A,
                                              fontSize: 13.0),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              if (Debounce.checkClick()) {
                                                if (url.isNotEmpty) {
                                                  FlutterPlugin.openWebview(
                                                      url);
                                                }
                                              }
                                            }),
                                    ]))
                                  ],
                                ),
                                decoration: BoxDecoration(),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              PrivacyPolicy(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ),
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

  _submit(String orderId) async {
    try {
      LogUtil.platformLog(optType: PointLog.CLICK_LOAN_SUBMIT());

      Map<String, String> params = await CommonParams.addParams();
      params[Api.applyAmount] = _currentMoney.toString();
      params[Api.detailId] = _detailId.toString();
      params[Api.productId] = _productId.toString();
      params[Api.orderId] = orderId;
      params[Api.lbs] = await FlutterPlugin.getLocation();
      ResultData resultData = await HttpManager.instance()
          .post(Api.submitOrder(), params: params, mul: true);
      if (resultData.success) {
        LogUtil.platformLog(optType: PointLog.SYSTEM_LOAN_SUCCESS());
        _addLog();
        _showSuccessDialog();
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
        if (flag != "1") {
          LogUtil.platformLog(optType: PointLog.SYSTEM_FIRST_LOAN_SUCCESS());
          LogUtil.otherLog(
              bfEvent: PointLog.CLICK_LOAN_SUBMIT(),
              fbEvent: 'fb_mobile_initiated_checkout');
        }
      }
    } catch (e) {}
  }

  //
  late Timer _timer;
  String remainTime = "";
  late StateSetter mySetState;

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _startTimer() {
    int _seconds = 2;
    remainTime = "2s";
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      HLog.error("========${_seconds}");
      if (_seconds == 0) {
        _cancelTimer();
        RouteUtil.pop(context);
      }
      _seconds--;
      remainTime = "${_seconds}s";
      if (mySetState != null) {
        mySetState(() {});
      }
    });
  }

  _showSuccessDialog() {
    _startTimer();
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
            mySetState = setState;
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
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
                  SizedBox(
                    height: 20.0,
                  ),
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
                  SizedBox(
                    height: 20.0,
                  ),
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
                          _cancelTimer();
                          RouteUtil.push(context, Routes.index,
                              clearStack: true);
                        },
                        child: Text(S.of(context).ok,
                            style: TextStyle(
                                color: Colors.white, fontSize: 22.0))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    remainTime,
                    style:
                        TextStyle(fontSize: 24.0, color: HcColors.color_02B17B),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: PrivacyPolicy(),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      _cancelTimer();
      RouteUtil.push(context, Routes.index, clearStack: true);
    });
  }
}
