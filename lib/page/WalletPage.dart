import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/entity/BankCard.dart';
import 'package:homecredit/generated/l10n.dart';
import 'package:homecredit/utils/sp.dart';
import 'package:homecredit/widget/HcInput.dart';
import 'package:sprintf/sprintf.dart';

import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/RegexUtil.dart';
import '../utils/appconfig.dart';
import '../utils/debounce.dart';
import '../utils/toast.dart';
import '../widget/InputItem.dart';
import '../widget/MySeparator.dart';
import '../widget/NextButton.dart';
import '../widget/PrivacyPolicy.dart';
import '../widget/ScrollWidget.dart';
import '../widget/SelectItem.dart';
import '../widget/SelectItemWrap.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String? typeId;
  String? typeText;
  String? accountText = S.current.mobile_wallet_account;
  String? accountRepeatText = S.current.confirm_mobile_wallet_account;
  String? typeHint = S.current.mobile_wallet_hint;

  //
  String currentId = "-1";

  ImageProvider? _mwImage;
  ImageProvider? _bkImage;
  ImageProvider? _cnicImage;

  TextStyle? _mwStyle;
  TextStyle? _bkStyle;
  TextStyle? _cnicStyle;

  String? bankCardTypeId;
  String? bankCardTypeText;

  bool isBankCard = false;

  final branchCodeController = TextEditingController();
  final numberController = TextEditingController();
  final numberRepeatController = TextEditingController();

  List<BankCard>? bankCardList;

  AppConfig _appConfig = new AppConfig();

  bool enable = false;

  String numberOnOff = "0";

  //
  String? typeIdTemp;
  String? bankIdTemp;
  String? branchCodeTemp;
  String? accountTemp;
  bool notFilledIn = false;

  String? name;

  @override
  void initState() {
    super.initState();
    _queryBasicInfo();
    LogUtil.platformLog(optType: PointLog.SYSTEM_ENTER_BANK_CARD_INF());
  }

  String formartData(dynamic object) {
    if (object == null) {
      return '';
    }
    return object.toString();
  }

  _queryBasicInfo() async {
    try {
      String fullName = await SpUtil.getString(Api.fullName, "");
      name = fullName;
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.bankCardList(), params: params, mul: true);
      if (resultData.success) {
        List list = resultData.data;
        if (list.isNotEmpty && list.length > 0) {
          BankCard bankCard = BankCard.fromJson(list[0]);
          if (bankCard != null) {
            setState(() {
              typeId = formartData(bankCard.possibleHairHopelessGet);
              typeText = bankCard.theseYoungPower ?? '';
              numberController.text = bankCard.saltyFact ?? '';
              numberRepeatController.text = bankCard.saltyFact ?? '';
              branchCodeController.text =
                  bankCard.convenientBoxPreciousStraightAntique ?? '';
              bankCardTypeId =
                  formartData(bankCard.rudeUnableSayingCrossPosition);
              bankCardTypeText = bankCard.expensiveCuriousPrimaryVariety ?? '';

              typeIdTemp = typeId;
              bankIdTemp = bankCardTypeId;
              branchCodeTemp = branchCodeController.text;
              accountTemp = numberController.text;

              _changeView(firstLoad: true);

              enable = _checkNextButton();
            });
          }
        } else {
          notFilledIn = true;
          LogUtil.platformLog(optType: PointLog.CLICK_BANK_CARD_BOX());
        }
        _getAppConfig();
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _checkNextButton() {
    if (typeId == null || typeId!.isEmpty) {
      return false;
    }
    if (numberController.text.trim().isEmpty) {
      return false;
    }
    if (numberRepeatController.text.trim().isEmpty) {
      return false;
    }

    if (typeId == "0") {
      if (branchCodeController.text.trim().isEmpty) {
        return false;
      }
      if (bankCardTypeId == null || bankCardTypeId!.isEmpty) {
        return false;
      }
    }

    return true;
  }

  _getAppConfig() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.type] = Api.bankMobileOpenSwitchValue();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppConfig(), params: params, mul: true);
      if (resultData.success) {
        List list = resultData.data;
        if (list.isNotEmpty && list.length > 0) {
          Map map = list[0];
          numberOnOff = map[Api.value].toString();
          print('---------${numberOnOff}---------');
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    branchCodeController.dispose();
    numberController.dispose();
    numberRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(
      title: S.of(context).bank_card_title,
      pointType: 4,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
              child: Column(
                children: [
                  Image(image: AssetImage('images/top_bg_rocket4.png')),
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
              margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Text(
                S.of(context).bank_card_top_hint,
                style: TextStyle(
                  color: HcColors.color_007D7A,
                  fontSize: 12.0,
                ),
              ),
              alignment: Alignment.topLeft,
            ),
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
                    S.of(context).choose_the_method,
                    style: TextStyle(
                        color: HcColors.color_333333,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HcColors.color_FFE9E9,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: [
                          SelectItemWrap(
                            typeText ?? "",
                            title: S.of(context).type,
                            titleColor: HcColors.color_FF5545,
                            keyName: Api.payTypeValue(),
                            appConfig: _appConfig,
                            onTapCallback: (id, text) {
                              setState(() {
                                typeId = id;
                                typeText = text;
                                _changeView();
                                enable = _checkNextButton();
                              });
                            },
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    typeHint ?? '',
                    style: TextStyle(
                      color: HcColors.color_333333,
                      fontSize: 16.0,
                    ),
                  ),
                  //---- end ----

                  // bank card 
                  Visibility(
                      visible: isBankCard,
                      child: Column(
                        children: [
                          SelectItem(
                            bankCardTypeText ?? "",
                            title: S.of(context).bank,
                            titleColor: HcColors.color_469BE7,
                            backgroundColor: HcColors.color_DDEFFB,
                            keyName: Api.bankNameListValue(),
                            onTapCallback: (id, text) {
                              setState(() {
                                bankCardTypeId = id;
                                bankCardTypeText = text;
                                enable = _checkNextButton();
                              });
                            },
                          ),
                          InputItem(
                            '',
                            title: S.of(context).branch_code,
                            titleColor: HcColors.color_FF8E4E,
                            backgroundColor: HcColors.color_FDF1DD,
                            controller: branchCodeController,
                            inputFormatters: [
                              RegexFormatter(regex: RegexUtil.regexFirstNotNull),
                              LengthLimitingTextInputFormatter(20),
                            ],
                            onChanged: (value) {
                              setState(() {
                                enable = _checkNextButton();
                              });
                            },
                          ),
                        ],
                      )),

                  //  
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HcColors.color_FFE9E9,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: [
                          Text(accountText ?? '',
                              style: TextStyle(
                                color: HcColors.color_FF5545,
                                fontSize: 14.0,
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(
                                  top: 12.0,
                                  left: 13.0,
                                  right: 15.0,
                                  bottom: 12.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: HcInput(
                                maxLength: 20,
                                controller: numberController,
                                inputFormatters: [
                                  RegexFormatter(regex: RegexUtil.regexFirstNotNull),
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    enable = _checkNextButton();
                                  });
                                },
                                hint: accountText,
                              )),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: HcColors.color_DCFCEF,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: [
                          Text(accountRepeatText ?? '',
                              style: TextStyle(
                                color: HcColors.color_1CBC7A,
                                fontSize: 14.0,
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 10.0),
                              padding: EdgeInsets.only(
                                  top: 12.0,
                                  left: 13.0,
                                  right: 15.0,
                                  bottom: 12.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: HcInput(
                                maxLength: 20,
                                controller: numberRepeatController,
                                inputFormatters: [
                                  RegexFormatter(regex: RegexUtil.regexFirstNotNull),
                                  LengthLimitingTextInputFormatter(20),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    enable = _checkNextButton();
                                  });
                                },
                                hint: accountRepeatText,
                              )),
                          Visibility(
                              visible: typeId == "2",
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Image(
                                  image: AssetImage('images/espay_guide.png'),
                                  width: 299.0,
                                  height: 95,
                                ),
                              )),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),

                  //Mobile Wallet Account Name
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: HcColors.color_DDEFFB,
                        borderRadius:
                        BorderRadius.all(Radius.circular(15.0))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.0,
                          left: 15.0,
                          right: 15.0,
                          bottom: 15.0),
                      child: Column(
                        children: [
                          Text(
                              'Mobile Wallet Account Name',
                              style: TextStyle(
                                color: HcColors.color_469BE7,
                                fontSize: 14.0,
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            padding: EdgeInsets.only(
                                top: 12.0,
                                left: 13.0,
                                right: 8.0,
                                bottom: 12.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(15.0))),
                            child: Text(
                                name ?? '',
                                style: TextStyle(fontSize: 14.0, color: HcColors.color_333333)),
                          ),
                        ],
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                      ),
                    ),
                    width: double.infinity,
                  ),

                  // Confirm Button
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      width: double.infinity,
                      height: 46.0,
                      alignment: Alignment.center,
                      child: Text(S.of(context).confirm,
                          style:
                              TextStyle(color: Colors.white, fontSize: 22.0)),
                      decoration: BoxDecoration(
                        color: enable
                            ? HcColors.color_02B17B
                            : HcColors.color_EEEEEE,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onTap: enable
                        ? () async {
                            if (Debounce.checkClick()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              String account1 = numberController.text;
                              String account2 = numberRepeatController.text;
                              if (account1 != account2) {
                                ToastUtil.show(S.of(context).input_error);
                                return;
                              }
                              _saveBasicInfo();
                            }
                          }
                        : () {
                            ToastUtil.show(S.of(context).button_disable_hint);
                          },
                  ),

                  Container(
                    child: PrivacyPolicy(),
                    margin: EdgeInsets.only(top: 10.0, bottom: 10),
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
          color: HcColors.color_DBF2EB,
        ),
      ),
      centerTitle: false,
    );
  }

  _changeView({firstLoad = false}) {
    if (typeId == '0') {
      //
      typeHint = S.current.bank_card_hint;
      accountText = S.current.bank_account;
      accountRepeatText = S.current.confirm_bank_account;
      _mwImage = AssetImage('images/ic_mw_0.png');
      _bkImage = AssetImage('images/ic_bk_1.png');
      _cnicImage = AssetImage('images/ic_cnic_0.png');
      _mwStyle = _unavailableTextStyle;
      _bkStyle = _availableTextStyle;
      _cnicStyle = _unavailableTextStyle;
      isBankCard = true;

      if(!firstLoad){
        numberController.text = "";
        numberRepeatController.text = "";
      }

    } else if (typeId == '3') {
      //CNIC
      typeHint = S.current.cnic_hint;
      accountText = S.current.cnic_number;
      accountRepeatText = S.current.confirm_cnic_number;
      _mwImage = AssetImage('images/ic_mw_0.png');
      _bkImage = AssetImage('images/ic_bk_0.png');
      _cnicImage = AssetImage('images/ic_cnic_1.png');
      _mwStyle = _unavailableTextStyle;
      _bkStyle = _unavailableTextStyle;
      _cnicStyle = _availableTextStyle;
      isBankCard = false;
    } else {
      //WALLET
      typeHint = S.current.mobile_wallet_hint;
      accountText = S.current.mobile_wallet_account;
      accountRepeatText = S.current.confirm_mobile_wallet_account;
      _mwImage = AssetImage('images/ic_mw_1.png');
      _bkImage = AssetImage('images/ic_bk_0.png');
      _cnicImage = AssetImage('images/ic_cnic_0.png');
      _mwStyle = _availableTextStyle;
      _bkStyle = _unavailableTextStyle;
      _cnicStyle = _unavailableTextStyle;
      isBankCard = false;

      if (numberOnOff == "1") {
        SpUtil.getString(Api.mobile, '')
            .then((value) {
              if (value.isNotEmpty) {
                numberController.text = value;
                numberRepeatController.text = value;
                setState(() {
                  enable = _checkNextButton();
                });
              }
            });
      }
    }
    currentId = typeId ?? "-1";
  }

  _saveBasicInfo() async {
    try {
      LogUtil.platformLog(optType: PointLog.CLICK_BANK_CARD_SUBMIT());
      LogUtil.otherLog(
          bfEvent: PointLog.CLICK_BANK_CARD_SUBMIT(),
          fbEvent: PointLog.CLICK_BANK_CARD_SUBMIT());

      if (!notFilledIn) {
        if (checkDiff()) {
          //
          LogUtil.platformLog(optType: PointLog.CLICK_BANK_CARD_SUBMIT_T());
        }
      }

      Map<String, String> params = await CommonParams.addParams();
      params[Api.bankAccountNumber] = numberController.text;
      params[Api.payType] = typeId ?? '';
      if (typeId == '0') {
        //BANK
        params[Api.bankName] = bankCardTypeId ?? '';
        params[Api.branchCode] = branchCodeController.text;
      }

      ResultData resultData = await HttpManager.instance()
          .post(Api.addBank(), params: params, mul: true);
      if (resultData.success) {
        if (notFilledIn) {
          notFilledIn = false;
          LogUtil.platformLog(optType: PointLog.CLICK_BANK_CARD_NP());
          //（）
          LogUtil.otherLog(
              bfEvent: PointLog.SYSTEM_FIRST_APPLY_SUCCESS(),
              fbEvent: 'fb_mobile_add_to_cart');
        }

        typeIdTemp = typeId;
        bankIdTemp = bankCardTypeId;
        branchCodeTemp = branchCodeController.text;
        accountTemp = numberController.text;

        _showDialog1();
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  bool checkDiff() {
    try {
      String accountNumber = numberController.text;
      if (typeId == null || typeId!.isEmpty) {
        return false;
      }
      if (typeId == '0') {
        //BANK
        if (bankIdTemp != bankCardTypeId) {
          return true;
        }
        if (branchCodeTemp != branchCodeTemp) {
          return true;
        }
      }
      if (accountNumber != accountTemp) {
        return true;
      }
    } catch (e) {}
    return false;
  }

  _selectType() {
    _appConfig.getAppConfig(Api.payTypeValue(), context, (id, text) {
      setState(() {
        typeId = id;
        typeText = text;
        _changeView();
        enable = _checkNextButton();
      });
    });
  }

  _showDialog1() {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                              Text(
                                S.of(context).bk_dialog_hint1,
                                style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 16.0),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 30,
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
                                              RouteUtil.pop(context);
                                              _showDialog2();
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

  _showDialog2() async {
    String name = await SpUtil.getString(Api.fullName, "");
    String cnic = await SpUtil.getString(Api.idNo, "");

    String undertaking_content =
        sprintf(S.of(context).undertaking_content, [name, cnic]);

    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                              Row(
                                children: [
                                  Text(
                                    S.of(context).undertaking,
                                    style: TextStyle(
                                        color: HcColors.color_333333,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                undertaking_content,
                                style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 16.0),
                              ),
                              SizedBox(
                                height: 30,
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
                                              RouteUtil.pop(context);
                                              RouteUtil.push(
                                                  context, Routes.select);
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
}

final TextStyle _availableTextStyle = TextStyle(
    color: HcColors.color_333333, fontSize: 12.0, fontWeight: FontWeight.w500);

final TextStyle _unavailableTextStyle = TextStyle(
    color: HcColors.color_999999, fontSize: 12.0, fontWeight: FontWeight.w500);
