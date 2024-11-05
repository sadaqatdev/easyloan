import 'package:flutter/material.dart';
import 'package:homecredit/entity/BankCard.dart';
import 'package:homecredit/generated/l10n.dart';
import 'package:homecredit/utils/appconfig.dart';
import 'package:homecredit/widget/HcInput.dart';

import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/debounce.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';
import '../widget/InputItem.dart';
import '../widget/MySeparator.dart';
import '../widget/NextButton.dart';
import '../widget/ScrollWidget.dart';
import '../widget/SelectItem.dart';
import '../widget/SelectItemWrap.dart';
import '../widget/SubTopBar.dart';
import 'SelectPage.dart';
import 'WaitPage.dart';

class UpdateWalletPage extends StatefulWidget {
  const UpdateWalletPage({Key? key}) : super(key: key);

  @override
  State<UpdateWalletPage> createState() => _UpdateWalletPageState();
}

class _UpdateWalletPageState extends State<UpdateWalletPage> {
  String? typeId;
  String? typeText;
  String? accountText = S.current.mobile_wallet_account;
  String? accountRepeatText = S.current.confirm_mobile_wallet_account;
  String? typeHint = S.current.mobile_wallet_hint;

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

  String? _orderId;

  AppConfig _appConfig = new AppConfig();

  bool enable = false;

  //
  String? typeIdTemp;
  String? bankIdTemp;
  String? branchCodeTemp;
  String? accountTemp;

  String? name;

  @override
  void initState() {
    super.initState();
    _queryBasicInfo();
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
    Map<String, dynamic> map = RouteUtil.getParams(context);
    _orderId = map[Api.orderId].toString();

    return ScrollWidget(
      title: S.of(context).bank_card_title,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image(
                        image: AssetImage('images/ic_under_warn.png'),
                        width: 44.0,
                        height: 44.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        S.of(context).tips,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: HcColors.color_02B17B,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Text(
                    S.of(context).update_wallet_hint,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: HcColors.color_02B17B,
                    ),
                  ),
                ],
              ),
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
                        color: Color(0xffffe9e9),
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

                  //---- start ----
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // Row(
                  //   children: [
                  //     InkWell(
                  //       child: Container(
                  //         width: 99.0,
                  //         height: 124.0,
                  //         alignment: Alignment.bottomCenter,
                  //         padding: EdgeInsets.only(bottom: 10.0),
                  //         child: Text(
                  //           S.of(context).mobile_wallet,
                  //           style: _mwStyle ?? _availableTextStyle,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //             image:
                  //                 _mwImage ?? AssetImage('images/ic_mw_0.png'),
                  //             fit: BoxFit.fill, // 
                  //           ),
                  //         ),
                  //       ),
                  //       onTap: () {
                  //         _selectType();
                  //       },
                  //     ),
                  //     InkWell(
                  //       child: Container(
                  //         width: 99.0,
                  //         height: 124.0,
                  //         alignment: Alignment.bottomCenter,
                  //         padding: EdgeInsets.only(bottom: 10.0),
                  //         child: Text(
                  //           S.of(context).bank_card,
                  //           style: _bkStyle ?? _unavailableTextStyle,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //             image:
                  //                 _bkImage ?? AssetImage('images/ic_bk_0.png'),
                  //             fit: BoxFit.fill, // 
                  //           ),
                  //         ),
                  //       ),
                  //       onTap: () {
                  //         _selectType();
                  //       },
                  //     ),
                  //     InkWell(
                  //       child: Container(
                  //         width: 99.0,
                  //         height: 124.0,
                  //         alignment: Alignment.bottomCenter,
                  //         padding: EdgeInsets.only(bottom: 10.0),
                  //         child: Text(
                  //           S.of(context).cnic,
                  //           style: _cnicStyle ?? _unavailableTextStyle,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //             image: _cnicImage ??
                  //                 AssetImage('images/ic_cnic_0.png'),
                  //             fit: BoxFit.fill, // 
                  //           ),
                  //         ),
                  //       ),
                  //       onTap: () {
                  //         _selectType();
                  //       },
                  //     ),
                  //   ],
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // ),
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
                                controller: numberController,
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
                        color: Color(0xffDCFCEF),
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
                                controller: numberRepeatController,
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
              typeId = bankCard.possibleHairHopelessGet ?? '';
              typeText = bankCard.theseYoungPower ?? '';
              numberController.text = bankCard.saltyFact ?? '';
              numberRepeatController.text = bankCard.saltyFact ?? '';
              branchCodeController.text =
                  bankCard.convenientBoxPreciousStraightAntique ?? '';
              bankCardTypeId = bankCard.rudeUnableSayingCrossPosition ?? '';
              bankCardTypeText = bankCard.expensiveCuriousPrimaryVariety ?? '';

              typeIdTemp = typeId;
              bankIdTemp = bankCardTypeId;
              branchCodeTemp = branchCodeController.text;
              accountTemp = numberController.text;

              _changeView();

              enable = _checkNextButton();
            });
          }
        }
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

  _changeView() {
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
    }
  }

  _saveBasicInfo() async {
    try {
      LogUtil.platformLog(optType: PointLog.CLICK_BANK_UPDATE_SUBMIT());

      if (checkDiff()) {
        //
        LogUtil.platformLog(optType: PointLog.CLICK_BANK_CARD_SUBMIT_T());
      }

      Map<String, String> params = await CommonParams.addParams();
      params[Api.bankAccountNumber] = numberController.text;
      params[Api.payType] = typeId ?? '';
      if (typeId == '0') {
        params[Api.bankName] = bankCardTypeId ?? '';
        params[Api.branchCode] = branchCodeController.text;
      }
      params[Api.orderId] = _orderId ?? '';
      params[Api.orderFaildAddFlag] = "1";

      ResultData resultData = await HttpManager.instance()
          .post(Api.addBank(), params: params, mul: true);
      if (resultData.success) {
        RouteUtil.push(context, Routes.index, clearStack: true);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  bool checkDiff() {
    try {
      String accountNumber = numberController.text;
      if (typeId!.isEmpty) {
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
}

final TextStyle _availableTextStyle = TextStyle(
    color: HcColors.color_333333, fontSize: 12.0, fontWeight: FontWeight.w500);

final TextStyle _unavailableTextStyle = TextStyle(
    color: HcColors.color_999999, fontSize: 12.0, fontWeight: FontWeight.w500);
