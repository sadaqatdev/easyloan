import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homecredit/utils/aes.dart';
import 'package:homecredit/utils/toast.dart';
import 'package:homecredit/widget/InputItemWrap.dart';
import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../entity/AppConfigEntity.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/RegexUtil.dart';
import '../utils/flutter_plugin.dart';
import '../utils/loading.dart';
import '../utils/log.dart';
import '../utils/sp.dart';
import '../widget/HcInput.dart';
import '../widget/InputItem.dart';
import '../widget/LoginFormCode.dart';
import '../widget/MySeparator.dart';
import '../widget/NextButton.dart';
import '../widget/PrivacyPolicy.dart';
import '../widget/ScrollWidget.dart';
import '../widget/SelectItem.dart';
import '../generated/l10n.dart';
import '../widget/TimerCountDown.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool enable = false;

  //
  bool notFilledIn = false;
  List<AppConfigEntity> contactList = [];
  int items = 0;

  List<ContactsBean> contactsBeanList = []; // 
  List contasctList = []; // 

  @override
  void initState() {
    super.initState();
    _queryListNum(); // 
    LogUtil.platformLog(optType: PointLog.SYSTEM_ENTER_CONTACT_INF());
  }

  _queryListNum() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.type] = "custlinkmannumber"; // 
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppConfig(), params: params, mul: true);

      if (resultData.success) {
        contactList.clear();

        List list = resultData.data;
        contactList = list.map((e) {
          return AppConfigEntity.fromJson(e);
        }).toList();

        if (contactList.length > 0) {
          String? park = contactList[0].personalProperHallPark;
          if (null != park) {
            items = int.parse(park);

            // 
            _queryBasicInfo();
          }
        }
      }
    } catch (e) {}
  }

  _queryBasicInfo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.linkmanQueryV2(), params: params, mul: true);
      if (resultData.success) {
        contasctList.clear();
        contasctList = resultData.data[Api.linkmanResponse]; //linkmanResponse
        if (null != contasctList) {
          setState(() {
            contactsBeanList.clear();
            var size = contasctList.length;
            if (size == items) {
              for (int i = 0; i < size; i++) {
                var data = contasctList[i];
                addContactBean(data);
              }
            } else if (size < items) {
              for (int i = 0; i < size; i++) {
                var data = contasctList[i];
                addContactBean(data);
              }
              var addAize = items - size;
              for (int j = 0; j < addAize; j++) {
                contactsBeanList.add(ContactsBean());
              }
            } else if (size > items) {
              for (int i = 0; i < items; i++) {
                var data = contasctList[i];
                addContactBean(data);
              }
            } else {
              for (int i = 0; i < items; i++) {
                var contactBean =  ContactsBean();
                contactsBeanList.add(contactBean);
              }
            }
            enable = _checkNextButton();
          });

          if (contactsBeanList.isNotEmpty) {
            var data = contactsBeanList[0];
            if (data.phoneController.text.isEmpty) {
              notFilledIn = true;
              LogUtil.platformLog(optType: PointLog.CLICK_CONTACT_INF_BOX());
            }
          }
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      HLog.error(e);
    }
  }

  addContactBean(dynamic object){
    try{
      var contactBean = ContactsBean();
      contactBean.relationship1Id = object[Api.relationship].toString(); //relationship
      contactBean.relationship1Text = object[Api.relationshipName].toString(); //relationshipName
      contactBean.phoneController.text = object[Api.phoneNumber].toString(); //phoneNumber
      contactBean.nameController.text = object[Api.name].toString(); //name
      contactBean.phoneText = object[Api.phoneNumber].toString(); //phoneNumber
      contactsBeanList.add(contactBean);
    }catch(e){
      print(e);
    }
  }

  String formartData(dynamic object) {
    if (object == null) {
      return '';
    }
    return object.toString();
  }

  _checkNextButton() {
    for (int i = 0; i < contactsBeanList.length; i++) {
      var contactsBean = contactsBeanList[i];
      if (contactsBean.relationship1Text.isEmpty ||
          contactsBean.phoneController.text.isEmpty ||
          contactsBean.relationship1Id.isEmpty ||
          contactsBean.nameController.text.isEmpty) {
        return false;
      }
      if(contactsBean.showOTP && contactsBean.otpController.text.isEmpty){
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(
      title: S.of(context).contact,
      pointType: 2,
      child: Container(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  child: Column(
                    children: [
                      Image(image: AssetImage('images/top_bg_rocket2.png')),
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
                    S.of(context).contact_top_hint,
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
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(), //
                      shrinkWrap: true, //
                      itemCount: items,
                      itemBuilder: (context, index) {
                        var contactsBean = contactsBeanList[index];

                        return Column(
                          children: [
                            Text(
                              "Reference contact ${index + 1}",
                              style: TextStyle(
                                  color: HcColors.color_333333,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                            //  Emergency Contact 1
                            //  Relationship
                            SelectItem(
                              contactsBean.relationship1Text,
                              title: S.of(context).relationship,
                              titleColor: HcColors.color_FF5545,
                              backgroundColor: HcColors.color_FFE9E9,
                              keyName: Api.newRelationshipValue(),
                              onTapCallback: (id, text) {
                                setState(() {
                                  contactsBean.relationship1Id = id;
                                  contactsBean.relationship1Text = text;
                                  enable = _checkNextButton();
                                });
                              },
                            ),
                            //  Name
                            InputItem(
                              '',
                              title: S.of(context).name,
                              titleColor: HcColors.color_1CBC7A,
                              backgroundColor: HcColors.color_DCFCEF,
                              controller: contactsBean.nameController,
                              inputFormatters: [
                                RegexFormatter(
                                    regex: RegexUtil.regexFirstNotNull),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  enable = _checkNextButton();
                                });
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            //  Mobile Phone Number
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
                                    Container(
                                      child: Column(
                                        children: [
                                          Text(
                                              S.of(context).mobile_phone_number,
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
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: HcInput(
                                                    controller: contactsBean
                                                        .phoneController,
                                                    inputType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if(contactsBean.phoneText != value){
                                                          contactsBean.showOTP = true;
                                                        }else{
                                                          contactsBean.showOTP = false;
                                                          contactsBean.otpController.text = "";
                                                        }
                                                        enable =  _checkNextButton();
                                                      });
                                                    },
                                                    inputFormatters: [
                                                      RegexFormatter(
                                                          regex: RegexUtil.regexFirstNotNull),
                                                      LengthLimitingTextInputFormatter( 20),
                                                      //
                                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                                                    ],
                                                    hint: S.of(context).mobile_phone_number,
                                                  ),
                                                ),

                                                //
                                                Visibility(
                                                  child: Column(children: [
                                                    TimerCountDown(
                                                      onTimerFinish: () {
                                                        print("Countdown ended-" + index.toString());
                                                      },
                                                      phoneNo: contactsBean.phoneController.text,
                                                      indexNo: index,
                                                      onTapCallback: (smscode) {
                                                        contactsBean.otpController.text = smscode;
                                                        enable =  _checkNextButton();
                                                        setState(() { });
                                                      },
                                                    ),
                                                  ],),
                                                  visible: contactsBean.showOTP,
                                                )

                                              ],
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                      ),
                                    ),

                                    //
                                    Visibility(
                                      child: Column(children: [
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      InputItemWrap(
                                        '',
                                        title: S.of(context).enter_otp,
                                        titleColor: HcColors.color_469BE7,
                                        backgroundColor: HcColors.color_DDEFFB,
                                        controller: contactsBean.otpController,
                                        inputType: TextInputType.number,
                                        inputFormatters: [
                                          RegexFormatter(
                                              regex: RegexUtil.regexFirstNotNull),
                                          LengthLimitingTextInputFormatter(6),
                                          //
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]'))
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            enable = _checkNextButton();
                                          });
                                        },
                                      ),
                                    ],),
                                    visible: contactsBean.showOTP,
                                    )


                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                              width: double.infinity,
                            ),

                            SizedBox(
                              height: 15.0,
                            ),

                            Container(
                              child: Text(
                                'Need to contact your friend to obtain a verifcationcode',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: HcColors.color_02B17B,
                                  textBaseline: TextBaseline.alphabetic,
                                ),
                              ),
                              width: double.infinity,
                            ),

                            Visibility(child:  SizedBox(
                              height: 25.0,
                            ),
                            visible: index != items - 1,
                            )

                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        );
                      }),
                  padding: EdgeInsets.only(
                    left: 20.0,
                    top: 15.0,
                    right: 20.0,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0,top: 5.0),
              child: Column(
                children: [
                  NextButton(
                    pressed: enable
                        ? () {
                            List<ContactsBean> tempList = [];
                            tempList.addAll(contactsBeanList);
                            for (var i = 0; i < contactsBeanList.length; i++) {
                              ContactsBean bean = contactsBeanList[i];
                              for (var j = 0; j < tempList.length; j++) {
                                ContactsBean bean1 = tempList[j];
                                if (j != i) {
                                  if (bean1.phoneController.text ==
                                      bean.phoneController.text) {
                                    ToastUtil.show(
                                        S.of(context).contact_same_hint);
                                    return;
                                  }
                                }
                              }
                            }
                            _saveBasicInfo();
                          }
                        : null,
                  ),
                  PrivacyPolicy()
                ],
              ),
              decoration: BoxDecoration(color: HcColors.white),
            )
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
      LogUtil.platformLog(optType: PointLog.CLICK_CONTACT_INF_SUBMIT());

      if (notFilledIn) {
        notFilledIn = false;
        LogUtil.platformLog(optType: PointLog.CLICK_CONTACT_INF_NP());
      }
      if (checkDiff()) {
        //
        LogUtil.platformLog(optType: PointLog.CLICK_CONTACT_INF_SUBMIT_T());
      }

      var paramsList = [];
      for (int i = 0; i < contactsBeanList.length; i++) {
        var contactsBean = contactsBeanList[i];
        var params = {
          "relationship": contactsBean.relationship1Id,
          "phoneNumber": contactsBean.phoneController.text,
          "name": contactsBean.nameController.text,
          "code": contactsBean.otpController.text,
          "userId": await SpUtil.getString(Api.userId, "")
        };
        // if(contactsBean.showOTP && contactsBean.otpController.text.isNotEmpty){
        //   params["code"] = contactsBean.otpController.text;
        // }
        paramsList.add(params);
      }

      var encode = json.encode(paramsList);
      String paramsJson = encode.replaceAll(r"(\)", "").toString().trim();

      print("encode paramsJson " + paramsJson);
      ResultData resultData = await HttpManager.instance().postJson(
          Api.saveLinkmanInfoV2(),
          params: AesUtil.encrypt(paramsJson),
          mul: true);
      if (resultData.success) {
        contasctList.clear();
        for (ContactsBean bean in contactsBeanList) {
          contasctList.add(bean); // 
        }
        _checkPermission();
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  bool checkDiff() {
    try {
      for (int i = 0; i < contactsBeanList.length; i++) {
        var contactsBean = contactsBeanList[i];
        var data = contasctList[i];
        String relationshipName = data[Api.relationshipName].toString(); //relationshipName
        String phoneNumber = data[Api.phoneNumber].toString(); //phoneNumber
        String name = data[Api.name].toString(); //name
        if (contactsBean.phoneController.text != phoneNumber &&
            contactsBean.nameController.text != name &&
            contactsBean.relationship1Text != relationshipName) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }

  _checkPermission() async {
    // bool flag = await FlutterPlugin.showConfirmDialog(1);
    // if (flag) {
    LogUtil.platformLog(optType: PointLog.CLICK_AUTHORIZE_CONFIRM());

    Map<dynamic, dynamic> map = await FlutterPlugin.requestAllPermission();
    // {android.permission.READ_SMS: 0,
    //   android.permission.ACCESS_COARSE_LOCATION: 0,
    //   android.permission.WRITE_CALENDAR: 0,
    //   android.permission.READ_CALL_LOG: 0,
    //   android.permission.READ_CALENDAR: 0,
    //   android.permission.CAMERA: 0,
    //   android.permission.READ_PHONE_STATE: -1,
    //   android.permission.WRITE_EXTERNAL_STORAGE: -1}
    var camera_status = map["android.permission.CAMERA"];
    var sms_status = map["android.permission.READ_SMS"];
    var calendar_status = map["android.permission.WRITE_CALENDAR"];
    var location_status = map["android.permission.ACCESS_COARSE_LOCATION"];
    var storage_status = map["android.permission.WRITE_EXTERNAL_STORAGE"];
    var call_status = map["android.permission.READ_CALL_LOG"];

    if (camera_status != 0) {
      Map<String, String> map = {
        'title': 'camera',
        'message': "need camera permission, go to settings"
      };
      bool flag = await FlutterPlugin.showDialog(map);
      if (flag) {
        FlutterPlugin.openAppSettings();
      }
      return;
    }
    // else if (sms_status != 0) {
    //   Map<String, String> map = {
    //     'title': 'sms',
    //     'message': "need sms permission, go to settings"
    //   };
    //   bool flag = await FlutterPlugin.showDialog(map);
    //   if (flag) {
    //     FlutterPlugin.openAppSettings();
    //   }
    //   return;
    // }
    // else if (calendar_status != 0) {
    //   Map<String, String> map = {
    //     'title': 'calendar',
    //     'message': "need calendar permission, go to settings"
    //   };
    //   bool flag = await FlutterPlugin.showDialog(map);
    //   if (flag) {
    //     FlutterPlugin.openAppSettings();
    //   }
    //   return;
    // }
    else if (location_status != 0) {
      Map<String, String> map = {
        'title': 'location',
        'message': "need location permission, go to settings"
      };
      bool flag = await FlutterPlugin.showDialog(map);
      if (flag) {
        FlutterPlugin.openAppSettings();
      }
      return;
    }

    //
    // if (call_status != 0) {
    //   Map<String, String> map = {
    //     'title': 'call records',
    //     'message': "need call records permission, go to settings"
    //   };
    //   bool flag = await FlutterPlugin.showDialog(map);
    //   if (flag) {
    //     FlutterPlugin.openAppSettings();
    //   }
    //   return;
    // }

    //android 13  android.permission.READ_MEDIA_IMAGES
    // bool tiramisu = await FlutterPlugin.checkTIRAMISU();
    // if (tiramisu) {
    //   bool readMediaImages = await FlutterPlugin.checkReadMediaImages();
    //   if (!readMediaImages) {
    //     Map<String, String> map = {
    //       'title': 'media images storage',
    //       'message': "need media images storage permission, go to settings"
    //     };
    //     bool flag = await FlutterPlugin.showDialog(map);
    //     if (flag) {
    //       FlutterPlugin.openAppSettings();
    //     }
    //     return;
    //   }
    // }else{
    //   if(storage_status != 0){
    //     Map<String, String> map = {
    //       'title': 'write storage',
    //       'message': "need write storage permission, go to settings"
    //     };
    //     bool flag = await FlutterPlugin.showDialog(map);
    //     if (flag) {
    //       FlutterPlugin.openAppSettings();
    //     }
    //     return;
    //   }
    // }

    LoadingUtil.show();
    String json = await FlutterPlugin.getJson()
        .onError((error, stackTrace) => LoadingUtil.hide());
    _uploadJson(json);
    // } else {
    //   LogUtil.platformLog(optType: PointLog.CLICK_AUTHORIZE_CANCEL());
    // }
  }

  _uploadJson(String json) async {
    try {
      // Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance().postJson(
          Api.msgFeatureV3(),
          params: AesUtil.encrypt(json),
          mul: true);
      if (resultData.success) {
        RouteUtil.push(context, Routes.cnic);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    try {
      if (contactsBeanList.isNotEmpty) {
        for (int i = 0; i < contactsBeanList.length; i++) {
          var contactsBean = contactsBeanList[i];
          contactsBean.nameController.dispose();
          contactsBean.phoneController.dispose();
          contactsBean.otpController.dispose();
        }
      }
    } catch (e) {}
    super.dispose();
  }
}

class ContactsBean {
  String relationship1Id = "";
  String relationship1Text = "";
  String phoneText = "";
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  bool showOTP = false;
}
