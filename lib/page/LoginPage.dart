import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/arch/net/http.dart';
import 'package:homecredit/arch/net/params.dart';
import 'package:homecredit/routes/route_util.dart';
import 'package:homecredit/utils/debounce.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/utils/toast.dart';
import 'package:homecredit/widget/LoginButton.dart';
import 'package:homecredit/widget/LoginFormCode.dart';
import 'package:homecredit/widget/LoginInput.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/config.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/routes.dart';
import '../utils/RegexUtil.dart';
import '../utils/flutter_plugin.dart';
import '../utils/sp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginBtnEnable = false;
  bool otpBtnEnable = false;

  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  bool checkboxSelected = true;

  @override
  void initState() {
    initValue();
    super.initState();

    try {
      FlutterPlugin.checkNetwork();
    } catch (e) {}
  }

  void initValue() async {
    phoneController.text = await SpUtil.getString(Api.userId, "");
  }

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Scrollbar(
            child: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            width: double.infinity,
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    S.of(context).login_enter_phone,
                    style: TextStyle(
                      color: HcColors.color_02B17B,
                      fontSize: 33.0,
                    ),
                  ),
                  Text(
                    S.of(context).login_number,
                    style: TextStyle(
                      color: HcColors.color_02B17B,
                      fontSize: 33.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    S.of(context).login_hint,
                    style: TextStyle(
                      color: HcColors.color_007D7A,
                      fontSize: 14.0,
                    ),
                  ),
                  //
                  Container(
                    padding:
                        EdgeInsets.only(top:20.0,left: 15.0, right: 15.0, bottom: 25.0),
                    margin: EdgeInsets.only(top: 18.0),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 45.0,
                              height: 45.0,
                              child: Center(
                                child: Image.asset('images/ic_login_user.png',
                                    width: 24.0, height: 28.0),
                              ),
                              decoration: BoxDecoration(
                                  color: HcColors.color_D7E6E1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image(
                                            image:
                                                AssetImage('images/ic_pk.png'),
                                            width: 22.0,
                                            height: 22.0),
                                        Text(
                                          "+92",
                                          style: TextStyle(
                                            fontSize: 14.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    LoginInput(
                                      controller: phoneController,
                                      hint: S.of(context).login_input_text_hint,
                                      inputType: TextInputType.number,
                                      onChanged: (v) {
                                        if (v.isNotEmpty) {
                                          globalKey.currentState
                                              ?.setAvailable(true);
                                        } else {
                                          globalKey.currentState
                                              ?.setAvailable(false);
                                        }
                                        _checkLoginBtn();
                                      },
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(20),
                                        //
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]'))
                                        //
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 45.0,
                              height: 45.0,
                              child: Center(
                                child: Image.asset('images/ic_login_pwd.png',
                                    width: 24.0, height: 28.0),
                              ),
                              decoration: BoxDecoration(
                                  color: HcColors.color_D7E6E1,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      S.of(context).login_input_code,
                                      style: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: LoginInput(
                                            controller: codeController,
                                            hint: S
                                                .of(context)
                                                .login_input_code_hint,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  6),
                                              FilteringTextInputFormatter.allow(
                                                  RegExp('[A-Z,a-z,0-9]'))
                                              //
                                            ],
                                            inputType: TextInputType.number,
                                            onChanged: (v) {
                                              _checkLoginBtn();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                              ),
                            ),
                            LoginFormCode(
                              key: globalKey,
                              phoneNo: phoneController.text,
                              onTapCallback: (smscode) {
                                codeController.text = smscode;
                                _checkLoginBtn();
                              },
                            ),
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    decoration: BoxDecoration(
                        color: HcColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //
                  Row(
                    children: [
                      Checkbox(
                          value: checkboxSelected,
                          onChanged: (value) {
                            checkboxSelected = !checkboxSelected;
                            setState(() {});
                            _checkLoginBtn();
                          }),
                      Expanded(
                        child: Text.rich(TextSpan(children: [
                          TextSpan(
                            text: 'I have read ',
                            style: TextStyle(
                                color: HcColors.color_333330, fontSize: 12.0),
                          ),
                          TextSpan(
                              text: 'Terms & conditions',
                              style: TextStyle(
                                color: HcColors.color_1770C9,
                                fontSize: 12.0,
                                decoration: TextDecoration.underline,
                                decorationColor: HcColors.color_1770C9,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // debugPrint("Terms & conditions");
                                  if (Debounce.checkClick()) {
                                    FlutterPlugin.openWebview(
                                        NetConfig.PEIVACY_URL);
                                  }
                                }),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                                color: HcColors.color_333330, fontSize: 12.0),
                          ),
                          TextSpan(
                              text: 'Privacy Policy ',
                              style: TextStyle(
                                color: HcColors.color_1770C9,
                                fontSize: 12.0,
                                decoration: TextDecoration.underline,
                                decorationColor: HcColors.color_1770C9,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // debugPrint("Privacy Policy");
                                  if (Debounce.checkClick()) {
                                    FlutterPlugin.openWebview(
                                        NetConfig.PEIVACY_URL);
                                  }
                                }),
                          TextSpan(
                            text: 'carefully.',
                            style: TextStyle(
                                color: HcColors.color_333330, fontSize: 12.0),
                          ),
                        ])),
                      )
                    ],
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                    child: Text(
                      S.of(context).login_bottom_hint,
                      style: TextStyle(
                        color: HcColors.color_86867C,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //
                  LoginButton(
                    title: S.of(context).go_text,
                    enable: loginBtnEnable,
                    onPressed: () {
                      if (Debounce.checkClick()) {
                        _doLogin();
                      }
                    },
                    onEnabled: () {
                      if (Debounce.checkClick()) {
                        if (phoneController.text.isEmpty) {
                          ToastUtil.show(S.of(context).login_phone_empty);
                          return;
                        }
                        if (codeController.text.isEmpty || codeController.text.length < 4) {
                          ToastUtil.show(S.of(context).login_code_empty);
                          return;
                        }
                        if (!checkboxSelected) {
                          ToastUtil.show(S.of(context).login_cb_hint);
                          return;
                        }
                      }
                    },
                  ),
                  //SECP
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      S.of(context).secp_text,
                      style: TextStyle(
                          fontSize: 11.0, color: HcColors.color_333330),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              alignment: Alignment.topLeft,
            ),
            decoration: BoxDecoration(),
          ),
        )),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
      backgroundColor: HcColors.color_DBF2EB,
    );
  }

  _doLogin() async {
    LogUtil.platformLog(optType: PointLog.CLICK_LOGIN_LOGIN(), mul: false);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<String, String> params = await CommonParams.addParams();
    Map<dynamic, dynamic> map = await FlutterPlugin.getGaid();
    params[Api.phoneNo] = phoneController.text;
    params[Api.smsCode] = codeController.text;
    params[Api.gaid] = map[Api.gaid].toString();
    String appInstanceId = await FlutterPlugin.getAppInstanceIdValue();
    if (appInstanceId.isNotEmpty) {
      params[Api.appInstanceId] = appInstanceId;
    }
    params[Api.versionName] = packageInfo.version;

    ResultData resultData =
        await HttpManager.instance().post(Api.loginForSms(), params: params);
    if (resultData.success) {
      LogUtil.platformLog(optType: PointLog.SYSTEM_LOGIN_SUCCESS(), mul: false);

      if (resultData.data[Api.newCustFlag].toString() == "1") {
        LogUtil.platformLog(
            optType: PointLog.SYSTEM_FIRST_REGISTER_SUCCESS(), mul: false);
        LogUtil.otherLog(
            bfEvent: PointLog.FIRST_REGISTER_SUCCESS(),
            fbEvent: 'fb_mobile_complete_registration');
      }

      String testCustFlag = resultData.data[Api.testCustFlag].toString();
      SpUtil.put(Api.token, resultData.data[Api.token]);
      SpUtil.put(Api.userId, resultData.data[Api.userId].toString());
      SpUtil.put(Api.mobile, phoneController.text);
      SpUtil.put(Api.testCustFlag, testCustFlag);

      try {
        //
        FlutterPlugin.setCrispLogin(phoneController.text);
        FlutterPlugin.setSessionSegment(
            testCustFlag == "1" ? "test" : "EasyLoan");
      } catch (e) {}

      RouteUtil.push(context, Routes.index, clearStack: true);
    } else {
      ToastUtil.show(resultData.msg);
    }
  }

  _checkLoginBtn() {
    if (phoneController.text.length >= 10 &&
        codeController.text.length >= 4 &&
        checkboxSelected) {
      loginBtnEnable = true;
    } else {
      loginBtnEnable = false;
    }
    setState(() {});
  }
}
