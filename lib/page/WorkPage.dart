import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/toast.dart';
import '../widget/InputItem.dart';
import '../widget/MySeparator.dart';
import '../widget/ScrollWidget.dart';
import '../widget/SelectItem.dart';
import 'ContactPage.dart';
import '../widget/NextButton.dart';
import '../widget/SubTopBar.dart';

class WorkPage extends StatefulWidget {
  const WorkPage({Key? key}) : super(key: key);

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  String? occupationId;
  String? occupationText;
  String? monthly_incomeId;
  String? monthly_incomeText;
  String? job_typeId;
  String? job_typeText;
  String? payPeriod;

  final companyNameController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final companyAddressController = TextEditingController();

  bool unemployed = true;

  bool enable = false;

  bool notFilledIn = false;

  @override
  void initState() {
    super.initState();
    _queryBasicInfo();
  }

  _queryBasicInfo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.custInfoBasicQuery(), params: params, mul:true);
      if (resultData.success) {

        String text = resultData.data[Api.workTypeDesc] ?? '';
        if(text.isEmpty){
          notFilledIn = true;
          LogUtil.platformLog(optType: PointLog.CLICK_WORK_INF_BOX());
        }

        setState(() {
          occupationId = formartData(resultData.data[Api.workType]);
          occupationText = resultData.data[Api.workTypeDesc];
          monthly_incomeId = formartData(resultData.data[Api.monthlyIncomeScope]);
          monthly_incomeText = resultData.data[Api.monthlyIncomeScopeDesc];
          job_typeId = formartData(resultData.data[Api.position]);
          job_typeText = resultData.data[Api.positionDesc];
          payPeriod = formartData(resultData.data[Api.payPeriod]);

          companyNameController.text = resultData.data[Api.companyName]??'';
          companyPhoneController.text = resultData.data[Api.companyPhone]??'';
          companyAddressController.text = resultData.data[Api.companyAddress]??'';

          if(occupationId == '4'){
            unemployed = false;
          }
          enable = _checkNextButton();
        });

        _addLog();

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
          LogUtil.otherLog(
              bfEvent: PointLog.CLICK_FIRST_INDEX_APPLY(),
              fbEvent: 'fb_mobile_add_to_wishlist');
        }
      }
    } catch (e) {}
  }

  String formartData(dynamic object){
    if(object == null){
      return '';
    }
    return object.toString();
  }

  _checkNextButton() {
    if (occupationId == null || occupationId!.isEmpty) {
      return false;
    }
    if(occupationId != '4') {
      if (monthly_incomeId == null || monthly_incomeId!.isEmpty) {
        return false;
      }
      if (job_typeId == null || job_typeId!.isEmpty) {
        return false;
      }
      if (payPeriod == null || payPeriod!.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    companyNameController.dispose();
    companyPhoneController.dispose();
    companyAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(
      title: S.of(context).professional_information,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child:Column(
                children: [
                  Image(image: AssetImage('images/top_bg_rocket2.png')),
                  SizedBox(height: 6.0,),
                  MySeparator(color: HcColors.white,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 25.0),
              child: Row(
                children: [
                  Text(
                    S.of(context).get_quota,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    '+ PKR 2,000',
                    style: TextStyle(
                      color: Color(0xFFFF5545),
                      fontSize: 12.0,
                    ),
                  ),
                  Image(
                      image: AssetImage('images/ic_up_arrow.png'),
                      width: 7.0,
                      height: 12.0),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'PKR',
                        style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: 10.0,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        '3,000',
                        style: TextStyle(
                          color: Color(0xFFFF5545),
                          fontSize: 17.0,
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.end,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 25.0),
              child: Text(
                S.of(context).prof_information_top_hint,
                style: TextStyle(
                  color: Color(0xFFFF5545),
                  fontSize: 12.0,
                ),
              ),
              alignment: Alignment.topLeft,
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
                  Text(
                    S.of(context).professional_information,
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),
                  //  Occupation
                  SelectItem(
                    occupationText ?? "",
                    title: S.of(context).occupation,
                    titleColor: HcColors.color_02B17B,
                    backgroundColor: HcColors.color_DBF2EB,
                    keyName: Api.workTypeValue(),
                    onTapCallback: (id, text) {
                      setState(() {
                        occupationId = id;
                        occupationText = text;
                        if(id == '4'){
                          unemployed = false;
                        }else{
                          unemployed = true;
                        }
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  //  Monthly Income
                  Visibility(visible: unemployed,child:
                  SelectItem(
                    monthly_incomeText ?? "",
                    title: S.of(context).monthly_income,
                    titleColor: HcColors.color_1CBC7A,
                    backgroundColor: HcColors.color_DCFCEF,
                    keyName: Api.monthlyIncomValue(),
                    onTapCallback: (id, text) {
                      setState(() {
                        monthly_incomeId = id;
                        monthly_incomeText = text;
                        enable = _checkNextButton();
                      });
                    },
                  ),),
                  //  Salary Pay Date
                  Visibility(visible: unemployed,child:
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffDDEFFB),
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: [
                          Text(
                              S.of(context).salary_pay_date,
                              style: TextStyle(
                                color: HcColors.color_469BE7,
                                fontSize: 14.0,
                              )
                          ),
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(
                                  top: 12.0, left: 13.0, right: 15.0, bottom: 12.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                              child: Row(
                                children: [

                                  (payPeriod == null || payPeriod!.isEmpty)
                                      ? Text(
                                    S.of(context).salary_pay_date,
                                    style: TextStyle(
                                      color: HcColors.color_999999,
                                      fontSize: 14.0,
                                    ),
                                  )
                                      : Text(payPeriod ?? '',
                                      style: TextStyle(
                                        color: HcColors.color_333333,
                                        fontSize: 14.0,
                                      )),

                                  Spacer(),
                                  Image(
                                      image: AssetImage('images/ic_rl.png'),
                                      width: 17.0,
                                      height: 14.0),
                                ],
                              ),
                            ),
                            onTap: (){
                              _showDialog();
                            },
                          ),

                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),),
                  //  Job Type
                  Visibility(visible: unemployed,child:
                  SelectItem(
                    job_typeText ?? "",
                    title: S.of(context).job_type,
                    titleColor: HcColors.color_FF8E4E,
                    backgroundColor: HcColors.color_FDF1DD,
                    keyName: Api.positionValue(),
                    onTapCallback: (id, text) {
                      setState(() {
                        job_typeId = id;
                        job_typeText = text;
                        enable = _checkNextButton();
                      });
                    },
                  ),),
                  //  Company Name
                  Visibility(visible: unemployed,child:
                  InputItem(
                    '',
                    title: S.of(context).company_name,
                    titleColor: HcColors.color_7579E7,
                    subTitle: S.of(context).optional,
                    subTitleColor: HcColors.color_02B17B,
                    backgroundColor: HcColors.color_E6E8FF,
                    controller: companyNameController,
                  ), ),
                  //  Company Phone number
                  Visibility(visible: unemployed,child:
                  InputItem(
                    '',
                    title: S.of(context).company_phone_number,
                    titleColor: HcColors.color_02B17B,
                    subTitle: S.of(context).optional,
                    subTitleColor: HcColors.color_02B17B,
                    backgroundColor: HcColors.color_DBF2EB,
                    controller: companyPhoneController,
                  ),),
                  //  Company Address
                  Visibility(visible: unemployed,child:
                  InputItem(
                    '',
                    title: S.of(context).company_address,
                    titleColor: HcColors.color_1CBC7A,
                    subTitle: S.of(context).optional,
                    subTitleColor: HcColors.color_02B17B,
                    backgroundColor: HcColors.color_DCFCEF,
                    controller: companyAddressController,
                  ),),

                  NextButton(pressed: enable
                      ? () {
                    _saveBasicInfo();
                  }
                      : null,),
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
    );
  }

  _saveBasicInfo() async {
    try {
      LogUtil.platformLog(optType: PointLog.CLICK_WORK_INF_SUBMIT());
      
      Map<String, String> params = await CommonParams.addParams();
      params[Api.workType] = occupationId ?? '';
      if(occupationId != '4'){
        params[Api.position] = job_typeId??'';
        params[Api.monthlyIncomeScope] = monthly_incomeId??'';
        params[Api.payPeriod] = payPeriod??'';
        params[Api.companyName] = companyNameController.text;
        params[Api.companyPhone] =companyPhoneController.text;
        params[Api.companyAddress] =companyAddressController.text;
      }

      ResultData resultData = await HttpManager.instance()
          .post(Api.saveBasicCustInfo(), params: params, mul: true);
      if (resultData.success) {

        if(notFilledIn){
          notFilledIn = false;
          LogUtil.platformLog(optType: PointLog.CLICK_WORK_INF_NP());
        }

        RouteUtil.push(context, Routes.contact);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  List<String>? payPeriodList = [];
  List<bool>? pressedAttentions = [];
  TextStyle? textStyle;

  _showDialog() {
    if(payPeriodList!.isEmpty){
      for (int i = 1; i < 32; i++) {
        payPeriodList!.add(i.toString());
      }
      pressedAttentions = payPeriodList?.map((e) => false).toList();
    }
    showModalBottomSheet(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Text(
                            S.of(context).close,
                            style: TextStyle(
                              color: HcColors.color_333333,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                        InkWell(
                          child: Text(
                            S.of(context).confirm,
                            style: TextStyle(
                              color: HcColors.color_02B17B,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            String text = '';
                            for (int i = 0; i < pressedAttentions!.length; i++) {
                              if(pressedAttentions![i]){
                                text = payPeriodList![i];
                                payPeriod = text;
                                break;
                              }
                            }
                            if(text.isNotEmpty) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: payPeriodList?.length,
                        itemBuilder: (BuildContext context, int index) {

                          bool pressAttention = pressedAttentions![index];
                          textStyle = pressAttention
                              ? _availableTextStyle
                              : _unavailableTextStyle;

                          return InkWell(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    payPeriodList![index],
                                    style: textStyle,
                                  ),
                                  decoration: BoxDecoration(),
                                ),
                                Divider(
                                  thickness: 1,
                                  color: HcColors.color_DDDDDD,
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                for (int i = 0;
                                i < pressedAttentions!.length;
                                i++) {
                                  if (i == index) {
                                    pressedAttentions![i] = true;
                                  } else {
                                    pressedAttentions![i] = false;
                                  }
                                }
                                textStyle = pressedAttentions![index]
                                    ? _availableTextStyle
                                    : _unavailableTextStyle;
                              });
                            },
                          );
                        },
                      )),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      setState((){
        enable = _checkNextButton();
      });
    });
  }
}

final TextStyle _availableTextStyle =
TextStyle(fontSize: 16.0, color: HcColors.color_333333);

final TextStyle _unavailableTextStyle =
TextStyle(fontSize: 14.0, color: HcColors.color_999999);


