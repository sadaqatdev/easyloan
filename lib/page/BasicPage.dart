import 'package:alog/alog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/arch/api/log.dart';
import 'package:homecredit/arch/api/log_util.dart';
import 'package:homecredit/entity/BasicEntity.dart';
import 'package:homecredit/utils/StringUtil.dart';
import 'package:homecredit/utils/aes.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/widget/PrivacyPolicy.dart';
import 'package:homecredit/widget/ScrollWidget.dart';
import 'package:homecredit/widget/SelectItem.dart';
import 'package:homecredit/widget/SubTopBar.dart';
import 'package:homecredit/widget/NextButton.dart';
import 'package:homecredit/page/WorkPage.dart';

import '../arch/api/api.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/CustomTextFieldFormatter.dart';
import '../utils/RegexUtil.dart';
import '../utils/flutter_plugin.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';
import '../widget/InputItem.dart';
import '../widget/MySeparator.dart';
import '../widget/Province.dart';

class BasicPage extends StatefulWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  State<BasicPage> createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  String? salaryId;
  String? salaryText;

  // 
  String? provinceText;
  String? provinceId;
  String? cityId;
  String? provinceName;
  String? cityName;

  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final paddressController = TextEditingController();

  bool enable = false;

  bool notFilledIn = false;

  //2023-05-25 
  String? occupationId;
  String? occupationText;
  String? monthly_incomeId;
  String? monthly_incomeText;
  String? foreignDebtsId;
  String? foreignDebtsText;

  final debtController = TextEditingController();

  bool unemployed = true;
  bool externaldebt = false;

  @override
  void initState() {
    super.initState();
    _queryBasicInfo();
    _addLog();
  }

  _queryBasicInfo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.custInfoBasicQuery(), params: params, mul: true);
      if (resultData.success) {

        String email = resultData.data[Api.email] ?? '';
        if(email.isEmpty){
          notFilledIn = true;
          LogUtil.platformLog(optType: PointLog.CLICK_BASIC_INF_BOX());
        }

        setState(() {
          occupationId = formartData(resultData.data[Api.workType]);
          occupationText = resultData.data[Api.workTypeDesc];
          monthly_incomeId = formartData(resultData.data[Api.monthlyIncomeScope]);
          monthly_incomeText = resultData.data[Api.monthlyIncomeScopeDesc];

          // salaryId = resultData.data[Api.salaryLimit];
          // salaryText = resultData.data[Api.salaryLimitDesc];

          foreignDebtsId = resultData.data[Api.foreignDebts];
          foreignDebtsText = resultData.data[Api.foreignDebtsDesc];

          provinceText = resultData.data[Api.homeAddress] ?? '';
          provinceId = resultData.data[Api.residentialStateCode] ?? '';
          cityId = resultData.data[Api.residentialCityCode] ?? '';
          provinceName = resultData.data[Api.residentialState] ?? '';
          cityName = resultData.data[Api.residentialCity] ?? '';

          emailController.text = resultData.data[Api.email];
          addressController.text = resultData.data[Api.fullAddress] ?? '';
          paddressController.text = resultData.data[Api.permanentAddress] ?? '';

          if(foreignDebtsId == '1'){
            externaldebt = true;
            debtController.text = resultData.data[Api.foreignDebtsAmount] ?? '';
          }

          enable = _checkNextButton();
        });

      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
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

  _checkNextButton() {
    if (emailController.text.trim().isEmpty) {
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      return false;
    }
    if (paddressController.text.trim().isEmpty) {
      return false;
    }
    if (provinceText == null || provinceText!.isEmpty) {
      return false;
    }
    // if (salaryId == null || salaryId!.isEmpty) {
    //   return false;
    // }
    if (occupationId == null || occupationId!.isEmpty) {
      return false;
    }
    if (monthly_incomeId == null || monthly_incomeId!.isEmpty) {
      return false;
    }
    if (foreignDebtsId == null || foreignDebtsId!.isEmpty) {
      return false;
    }
    if(foreignDebtsId == '1') {
      if (debtController.text.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    emailController.dispose();
    debtController.dispose();
    addressController.dispose();
    paddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(
      title: S.of(context).basic_information,
      pointType: 1,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: Column(
                children: [
                  Image(image: AssetImage('images/top_bg_rocket1.png')),
                  SizedBox(
                    height: 6.0,
                  ),
                  MySeparator(
                    color: HcColors.white,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 25.0),
              child: Text(
                S.of(context).basic_information_top_hint,
                style: TextStyle(
                  color: HcColors.color_007D7A,
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
                    S.of(context).basic_information,
                    style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),

                  //  E-mail
                  InputItem(
                    '',
                    title: S.of(context).email,
                    titleColor: HcColors.color_469BE7,
                    backgroundColor: HcColors.color_DDEFFB,
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    inputFormatters: [
                      RegexFormatter(regex: RegexUtil.regexFirstNotNull),
                      FilteringTextInputFormatter.deny(RegExp('[ ]'))
                    ],
                    onChanged: (value) {
                      setState(() {
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  //  Salary
                  // SelectItem(
                  //   salaryText ?? "",
                  //   title: S.of(context).salary_text,
                  //   titleColor: HcColors.color_FF8E4E,
                  //   backgroundColor: HcColors.color_FDF1DD,
                  //   keyName: Api.salaryLimitValue(),
                  //   hintText: S.of(context).salary_text_hint,
                  //   onTapCallback: (id, text) {
                  //     setState(() {
                  //       salaryId = id;
                  //       salaryText = text;
                  //       enable = _checkNextButton();
                  //     });
                  //   },
                  // ),

                  //  Occupation
                  SelectItem(
                    occupationText ?? "",
                    title: S.of(context).occupation,
                    titleColor: HcColors.color_FF5545,
                    backgroundColor: HcColors.color_FFE9E9,
                    keyName: Api.newWorkTypeValue(),
                    onTapCallback: (id, text) {
                      setState(() {
                        occupationId = id;
                        occupationText = text;
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  //  Monthly Income
                  SelectItem(
                    monthly_incomeText ?? "",
                    title: S.of(context).monthly_income,
                    titleColor: HcColors.color_1CBC7A,
                    backgroundColor: HcColors.color_DCFCEF,
                    keyName: 'vaptMonthlyIncom',
                    onTapCallback: (id, text) {
                      setState(() {
                        monthly_incomeId = id;
                        monthly_incomeText = text;
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  //  Do you have any outstanding debts with other loan companies
                  SelectItem(
                    foreignDebtsText ?? "",
                    title: S.of(context).debt_title,
                    titleColor: HcColors.color_469BE7,
                    backgroundColor: HcColors.color_DDEFFB,
                    hintText: "Please select",
                    keyName: Api.foreignDebtsValue(),
                    onTapCallback: (id, text) {
                      setState(() {
                        foreignDebtsId = id;
                        foreignDebtsText = text;
                        if(id == '1'){
                          externaldebt = true;
                        }else{
                          externaldebt = false;
                        }
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  //  Amount owed to other companies
                  Visibility(visible: externaldebt,child:
                  InputItem(
                    '',
                    title: S.of(context).debt_amout,
                    titleColor: HcColors.color_FF8E4E,
                    backgroundColor: HcColors.color_FDF1DD,
                    controller: debtController,
                    inputType: TextInputType.number,
                    hintText: "Please input",
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
                      CustomTextFieldFormatter(digit: 2)
                    ],
                    onChanged: (value) {
                      setState(() {
                        enable = _checkNextButton();
                      });
                    },
                  ),),

                  //  Current Province
                  Province(
                    provinceText ?? '',
                    title: S.of(context).current_province,
                    titleColor: HcColors.color_FF5545,
                    backgroundColor: HcColors.color_FFE9E9,
                    onTapCallback: (map) {
                      setState(() {
                        provinceName = map['provinceName'];
                        cityName = map['cityName'];
                        provinceText =
                            provinceName! + ' ' + cityName!;
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  //  Current Address
                  InputItem(
                    '',
                    title: S.of(context).current_address,
                    titleColor: HcColors.color_1CBC7A,
                    backgroundColor: HcColors.color_DCFCEF,
                    controller: addressController,
                    onChanged: (value) {
                      setState(() {
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  // Permanent Address
                  InputItem(
                    '',
                    title: S.of(context).permanent_address,
                    titleColor: HcColors.color_469BE7,
                    backgroundColor: HcColors.color_DDEFFB,
                    controller: paddressController,
                    onChanged: (value) {
                      setState(() {
                        enable = _checkNextButton();
                      });
                    },
                  ),

                  NextButton(
                    pressed: enable
                        ? () {
                            _saveBasicInfo();
                          }
                        : null,
                  ),

                  PrivacyPolicy()
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
    );
  }

  _saveBasicInfo() async {
    try {

      String email = emailController.text;
      if(!StringUtil.isEmail(email)){
        ToastUtil.show(S.of(context).email_error);
        return;
      }

      LogUtil.platformLog(optType: PointLog.CLICK_BASIC_INF_SUBMIT());

      Map<String, String> params = await CommonParams.addParams();
      params[Api.fullAddress] = addressController.text;
      params[Api.permanentAddress] = paddressController.text;
      params[Api.email] = emailController.text;
      // params[Api.salaryLimit] = salaryId ?? '';
      params[Api.workType] = occupationId ?? '';
      params[Api.monthlyIncomeScope] = monthly_incomeId??'';
      params[Api.foreignDebts] = foreignDebtsId ?? '';
      if(foreignDebtsId == '1'){
        params[Api.foreignDebtsAmount] = debtController.text;
      }

      params[Api.homeAddress] = provinceText ?? '';
      params[Api.residentialState] = provinceName ?? '';
      params[Api.residentialStateCode] = provinceId ?? '';
      params[Api.residentialCity] = cityName ?? '';
      params[Api.residentialCityCode] = cityId ?? '';

      ResultData resultData = await HttpManager.instance()
          .post(Api.saveBasicCustInfo(), params: params, mul: true);
      if (resultData.success) {

        if(notFilledIn){
          notFilledIn = false;
          LogUtil.platformLog(optType: PointLog.CLICK_BASIC_INF_NP());
        }

        try{
          //
          FlutterPlugin.setUserEmail(emailController.text);
        }catch(e){}

        RouteUtil.push(context, Routes.contact);
        // RouteUtil.push(context, Routes.work);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  String formartData(dynamic object) {
    if (object == null) {
      return '';
    }
    return object.toString();
  }
}
