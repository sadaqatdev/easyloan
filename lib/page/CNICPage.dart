import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/widget/MySeparator.dart';
import 'package:homecredit/widget/SelectItemWrap.dart';
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
import '../utils/date.dart';
import '../utils/debounce.dart';
import '../utils/flutter_plugin.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';
import '../widget/HcInput.dart';
import '../widget/InputItem.dart';
import '../widget/NextButton.dart';
import '../widget/PrivacyPolicy.dart';
import '../widget/Province.dart';
import '../widget/ScrollWidget.dart';
import '../widget/SelectItem.dart';
import '../widget/SelectItem1.dart';

class CNICPage extends StatefulWidget {
  const CNICPage({Key? key}) : super(key: key);

  @override
  State<CNICPage> createState() => _CNICPageState();
}

const int frontImage = 1;
const int backImage = 2;
const int faceImage = 3;

const String uploadIDCard = "00";
const String uploadFace = "01";

class _CNICPageState extends State<CNICPage> {
  String frontImage1 = "";
  String backImage1 = "";
  String faceImage1 = "";

  String? dateOfBirth;
  String? dateOfIssue;
  String? dateOfExpriry;

  String frontImageUrl = '';
  String backImageUrl = '';
  String faceImageUrl = '';

  String? genderId;
  String? genderText;

  final nameController = TextEditingController();
  final numberController = TextEditingController();

  bool enable = false;

  String? cardFrontFlag;
  String? cardBackFlag;
  String? faceVerified;

  int queryType = 0;

  @override
  void initState() {
    super.initState();
    _queryBasicInfo();
    LogUtil.platformLog(optType: PointLog.SYSTEM_ENTER_ID_INF());
    try {
      FlutterPlugin.startLocation();
    } catch (e) {}
  }

  _queryBasicInfo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.custInfoBasicQuery(), params: params, mul: true);
      if (resultData.success) {
        HLog.error(resultData.data[Api.permanentAddress]);
        setState(() {
          dateOfBirth = resultData.data[Api.birthDay] ?? '';
          dateOfIssue = resultData.data[Api.validDate] ?? '';
          dateOfExpriry = resultData.data[Api.expiryDate] ?? '';

          genderId = formartData(resultData.data[Api.sex]);
          genderText = resultData.data[Api.sexDesc];

          nameController.text = resultData.data[Api.fullName] ?? '';
          numberController.text = resultData.data[Api.idNo] ?? '';
        });
        _queryImageInfo();
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      HLog.error(e);
    }
  }

  String formartData(dynamic object) {
    if (object == null) {
      return '';
    }
    return object.toString();
  }

  _checkNextButton() {
    if (nameController.text.trim().isEmpty) {
      return false;
    }
    if (genderId == null || genderId!.isEmpty) {
      return false;
    }
    if (numberController.text.trim().isEmpty) {
      return false;
    }
    if (dateOfBirth == null || dateOfBirth!.isEmpty) {
      return false;
    }
    if (dateOfIssue == null || dateOfIssue!.isEmpty) {
      return false;
    }
    if (dateOfExpriry == null || dateOfExpriry!.isEmpty) {
      return false;
    }
    if (cardFrontFlag != "1") {
      return false;
    }
    if (cardBackFlag != "1") {
      return false;
    }
    if (faceVerified != "1") {
      return false;
    }
    return true;
  }

  _queryImageInfo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getIdentificationResult(), params: params, mul: true);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        cardFrontFlag = map[Api.cardFrontFlag].toString();
        cardBackFlag = map[Api.cardBackFlag].toString();
        faceVerified = map[Api.faceVerified].toString();
        if (queryType == 0) {
          frontImageUrl = map[Api.cardFrontUrl] ?? '';
          backImageUrl = map[Api.cardBackUrl] ?? '';
          faceImageUrl = map[Api.afaceUrl] ?? '';
        }
        setState(() {
          enable = _checkNextButton();
        });
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollWidget(
      title: S.of(context).cnic,
      pointType: 3,
      needContext: true,
      child: Builder(
          builder: (BuildContext context) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Scrollbar(
                    child: SingleChildScrollView(
                  // physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 10.0, left: 15.0, right: 15.0),
                          child: Column(
                            children: [
                              Image(
                                  image:
                                      AssetImage('images/top_bg_rocket3.png')),
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
                          margin: EdgeInsets.only(
                              top: 10.0, left: 10.0, right: 25.0),
                          child: Text(
                            S.of(context).cnic_top_hint,
                            style: TextStyle(
                              color: HcColors.color_007D7A,
                              fontSize: 12.0,
                            ),
                          ),
                          alignment: Alignment.topLeft,
                        ),

                        // Upload CNIC
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
                                S.of(context).upload_cnic,
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                S.of(context).please_take,
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),

                              // Front Back Image
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 155.0,
                                          height: 106.0,
                                          child: frontImage1.isNotEmpty
                                              ? Image.file(File(frontImage1))
                                              : Image.network(
                                                  frontImageUrl,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context,
                                                      exception, stackTrace) {
                                                    return Image(
                                                      image: AssetImage(
                                                          'images/camera_front.png'),
                                                      width: 155.0,
                                                      height: 106.0,
                                                    );
                                                  },
                                                ),
                                        ),
                                        onTap: () {
                                          if (Debounce.checkClick()) {
                                            _openImagePicker(frontImage);
                                            LogUtil.platformLog(
                                                optType: PointLog
                                                    .CLICK_ID_PICTURE_SUBMIT_1());
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        S.of(context).front,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        child: Container(
                                          width: 155.0,
                                          height: 106.0,
                                          child: backImage1.isNotEmpty
                                              ? Image.file(File(backImage1))
                                              : Image.network(
                                                  backImageUrl,
                                                  width: 155.0,
                                                  height: 106.0,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        value: loadingProgress
                                                                    .expectedTotalBytes !=
                                                                null
                                                            ? loadingProgress
                                                                    .cumulativeBytesLoaded /
                                                                loadingProgress
                                                                    .expectedTotalBytes!
                                                            : null,
                                                      ),
                                                    );
                                                  },
                                                  errorBuilder: (context,
                                                      exception, stackTrace) {
                                                    return Image(
                                                      image: AssetImage(
                                                          'images/camera_back.png'),
                                                      width: 155.0,
                                                      height: 106.0,
                                                    );
                                                  },
                                                ),
                                        ),
                                        onTap: () {
                                          if (Debounce.checkClick()) {
                                            _openImagePicker(backImage);
                                            LogUtil.platformLog(
                                                optType: PointLog
                                                    .CLICK_ID_PICTURE_SUBMIT_2());
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        S.of(context).back,
                                        style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),

                              //  Enter CNIC Information
                              Container(
                                margin: EdgeInsets.only(top: 15.0),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: HcColors.color_DBF2EB,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 15.0,
                                      left: 15.0,
                                      right: 15.0,
                                      bottom: 15.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Image(
                                                image: AssetImage(
                                                    'images/ic_sfrz.png'),
                                                width: 23.0,
                                                height: 23.0),
                                            SizedBox(width: 5.0),
                                            Text(
                                                S
                                                    .of(context)
                                                    .enter_cnic_information,
                                                style: TextStyle(
                                                  color: Color(0xff333333),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      MySeparator(
                                        color: HcColors.color_02B17B,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),

                                      //  Name
                                      Text(S.of(context).name,
                                          style: TextStyle(
                                            color: HcColors.color_02B17B,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        child: HcInput(
                                          controller: nameController,
                                          onChanged: (value) {
                                            setState(() {
                                              enable = _checkNextButton();
                                            });
                                          },
                                          hint: S.of(context).name,
                                        ),
                                      ),

                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      //  Gender
                                      SelectItem1(
                                        genderText ?? "",
                                        title: S.of(context).gender,
                                        titleColor: HcColors.color_1CBC7A,
                                        keyName: Api.sexValue(),
                                        onTapCallback: (id, text) {
                                          setState(() {
                                            genderId = id;
                                            genderText = text;
                                            enable = _checkNextButton();
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(S.of(context).cnic_number,
                                          style: TextStyle(
                                            color: HcColors.color_02B17B,
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        child: HcInput(
                                          controller: numberController,
                                          inputType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            LengthLimitingTextInputFormatter(
                                                13),
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9]")),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              enable = _checkNextButton();
                                            });
                                          },
                                          hint: S.of(context).cnic_number,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(S.of(context).date_of_birth,
                                          style: TextStyle(
                                            color: HcColors.color_02B17B,
                                            fontSize: 14.0,
                                          )),
                                      InkWell(
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                          padding: EdgeInsets.only(
                                              top: 12.0,
                                              left: 13.0,
                                              right: 15.0,
                                              bottom: 12.0),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          child: Row(
                                            children: [
                                              (dateOfBirth == null ||
                                                      dateOfBirth!.isEmpty)
                                                  ? Text(
                                                      S
                                                          .of(context)
                                                          .date_of_birth,
                                                      style: TextStyle(
                                                        color: HcColors
                                                            .color_999999,
                                                        fontSize: 14.0,
                                                      ),
                                                    )
                                                  : Text(dateOfBirth ?? '',
                                                      style: TextStyle(
                                                        color: HcColors
                                                            .color_333333,
                                                        fontSize: 14.0,
                                                      )),
                                              Spacer(),
                                              Image(
                                                  image: AssetImage(
                                                      'images/ic_rl.png'),
                                                  width: 17.0,
                                                  height: 14.0),
                                            ],
                                          ),
                                        ),
                                        onTap: () async {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          _showPickerDateTime2(context);
                                        },
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(S.of(context).date_of_issue,
                                          style: TextStyle(
                                            color: HcColors.color_02B17B,
                                            fontSize: 14.0,
                                          )),
                                      InkWell(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            padding: EdgeInsets.only(
                                                top: 12.0,
                                                left: 13.0,
                                                right: 15.0,
                                                bottom: 12.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            child: Row(
                                              children: [
                                                (dateOfIssue == null ||
                                                        dateOfIssue!.isEmpty)
                                                    ? Text(
                                                        S
                                                            .of(context)
                                                            .date_of_issue,
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_999999,
                                                          fontSize: 14.0,
                                                        ),
                                                      )
                                                    : Text(dateOfIssue ?? '',
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_333333,
                                                          fontSize: 14.0,
                                                        )),
                                                Spacer(),
                                                Image(
                                                    image: AssetImage(
                                                        'images/ic_rl.png'),
                                                    width: 17.0,
                                                    height: 14.0),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _showPickerDateTime(context, 1);
                                          }),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(S.of(context).date_of_expiry,
                                          style: TextStyle(
                                            color: HcColors.color_02B17B,
                                            fontSize: 14.0,
                                          )),
                                      InkWell(
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            padding: EdgeInsets.only(
                                                top: 12.0,
                                                left: 13.0,
                                                right: 15.0,
                                                bottom: 12.0),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15.0))),
                                            child: Row(
                                              children: [
                                                (dateOfExpriry == null ||
                                                        dateOfExpriry!.isEmpty)
                                                    ? Text(
                                                        S
                                                            .of(context)
                                                            .date_of_expiry,
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_999999,
                                                          fontSize: 14.0,
                                                        ),
                                                      )
                                                    : Text(dateOfExpriry ?? '',
                                                        style: TextStyle(
                                                          color: HcColors
                                                              .color_333333,
                                                          fontSize: 14.0,
                                                        )),
                                                Spacer(),
                                                Image(
                                                    image: AssetImage(
                                                        'images/ic_rl.png'),
                                                    width: 17.0,
                                                    height: 14.0),
                                              ],
                                            ),
                                          ),
                                          onTap: () async {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            _showPickerDateTime(context, 2);
                                          }),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                S.of(context).face_recognition,
                                style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),

                              Container(
                                width: double.infinity,
                                child: InkWell(
                                  child: Container(
                                    width: 168.0,
                                    height: 168.0,
                                    child: faceImage1.isNotEmpty
                                        ? Image.file(File(faceImage1))
                                        : Image.network(
                                            faceImageUrl,
                                            width: 168.0,
                                            height: 168.0,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, exception,
                                                stackTrace) {
                                              return Image(
                                                image: AssetImage(
                                                    'images/camera_face.png'),
                                                width: 168.0,
                                                height: 168.0,
                                              );
                                            },
                                          ),
                                  ),
                                  onTap: () {
                                    if (Debounce.checkClick()) {
                                      if (cardFrontFlag != "1" ||
                                          cardBackFlag != "1") {
                                        ToastUtil.show(
                                            S.of(context).id_card_empty);
                                        return;
                                      }
                                      _openImagePicker(faceImage);
                                      LogUtil.platformLog(
                                          optType:
                                              PointLog.CLICK_ID_FACE_SUBMIT());
                                    }
                                  },
                                ),
                                alignment: Alignment.center,
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
                )),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              )),
    );
  }

  _openImagePicker(int type) async {
    bool camera_status = await FlutterPlugin.checkCameraPermission();
    bool storage_status = await FlutterPlugin.checkWriteStroagePermission();
    if (camera_status) {
      String filePath = await FlutterPlugin.startCamera(type == 3 ? 0 : 1);
      // HLog.debug(filePath);
      // HLog.debug(File(filePath).lengthSync());
      if (filePath.isNotEmpty) {
        switch (type) {
          case frontImage:
            LogUtil.platformLog(optType: PointLog.ID_PICTURE_SUBMIT_1_T());
            setState(() {
              frontImage1 = filePath;
            });
            _uploadImageV2('05');
            break;
          case backImage:
            LogUtil.platformLog(optType: PointLog.ID_PICTURE_SUBMIT_2_T());
            setState(() {
              backImage1 = filePath;
            });
            _uploadImageV2('06');
            break;
          case faceImage:
            LogUtil.platformLog(optType: PointLog.ID_FACE_SUBMIT_T());
            setState(() {
              faceImage1 = filePath;
            });
            _uploadImage(uploadFace);
            break;
        }

        setState(() {});
      } else {
        switch (type) {
          case frontImage:
            LogUtil.platformLog(optType: PointLog.ID_PICTURE_SUBMIT_1_F());
            break;
          case backImage:
            LogUtil.platformLog(optType: PointLog.ID_PICTURE_SUBMIT_2_F());
            break;
          case faceImage:
            LogUtil.platformLog(optType: PointLog.ID_FACE_SUBMIT_F());
            break;
        }
      }
    } else {
      print('~~~~~~~~~~~~no permission~~~~~~~~~~~~~');
      // Map<Permission, PermissionStatus> statuses = await [
      //   Permission.camera,
      //   Permission.storage,
      // ].request();
      FlutterPlugin.openAppSettings();
    }
  }

  _uploadImage(String type) async {
    try {
      FormData formData = FormData.fromMap({
        Api.type: type,
        // Api.userId: await SpUtil.getString(Api.userId)
      });
      if (type == uploadIDCard) {
        if (frontImage1.isEmpty && backImage1.isEmpty) {
          return;
        }
        formData.files.add(MapEntry(
            Api.frontImage,
            MultipartFile.fromFileSync(frontImage1,
                filename: 'frontImage.jpg')));
        formData.files.add(MapEntry(Api.backImage,
            MultipartFile.fromFileSync(backImage1, filename: 'backImage.jpg')));

        LogUtil.platformLog(optType: PointLog.ID_PICTURE_UPLOAD());
      } else {
        if (faceImage1.isEmpty) {
          return;
        }
        formData.files.add(MapEntry(Api.frontImage,
            MultipartFile.fromFileSync(faceImage1, filename: 'faceImage.jpg')));
      }

      ResultData resultData = await HttpManager.instance()
          .postImage(Api.identification(), params: formData, mul: true);
      if (resultData.success) {
        // ，
        queryType = 1;
        _queryImageInfo();
      } else {
        ToastUtil.show(resultData.msg);
        if (type == uploadIDCard) {
          frontImage1 = "";
          backImage1 = "";
        } else {
          faceImage1 = "";
        }
        setState(() {});
      }
    } catch (e) {}
  }

  _saveBasicInfo() async {
    try {
      LogUtil.platformLog(optType: PointLog.CLICK_ID_INF_SUBMIT());
      LogUtil.otherLog(
          bfEvent: PointLog.CLICK_ID_INF_SUBMIT(),
          fbEvent: PointLog.CLICK_ID_INF_SUBMIT());

      Map<String, String> params = await CommonParams.addParams();
      params[Api.fullName] = nameController.text;
      params[Api.sex] = genderId ?? '';
      params[Api.idNo] = numberController.text;
      params[Api.validDate] = dateOfIssue ?? '';
      params[Api.birthDay] = dateOfBirth ?? '';
      params[Api.expiryDate] = dateOfExpriry ?? '';

      ResultData resultData = await HttpManager.instance()
          .post(Api.saveBasicCustInfo(), params: params, mul: true);
      if (resultData.success) {
        SpUtil.put(Api.fullName, nameController.text);
        SpUtil.put(Api.idNo, numberController.text);
        RouteUtil.push(context, Routes.wallet);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _showPickerDateTime(BuildContext context, int type) {
    Picker(
            adapter: DateTimePickerAdapter(
                type: PickerDateTimeType.kDMY,
                isNumberMonth: false,
                value: DateUtil.toDateTime("2000-01-01")),
            title: Text(""),
            textAlign: TextAlign.right,
            selectedTextStyle: TextStyle(color: HcColors.color_02B17B),
            onConfirm: (Picker picker, List value) {
              String datetime = picker.adapter.toString();
              setState(() {
                if (type == 1) {
                  dateOfIssue =
                      DateUtil.formatDateTime(DateUtil.toDateTime(datetime));
                } else {
                  dateOfExpriry =
                      DateUtil.formatDateTime(DateUtil.toDateTime(datetime));
                }
                enable = _checkNextButton();
              });
            },
            onSelect: (Picker picker, int index, List<int> selected) {})
        .showBottomSheet(context);
  }

  _showPickerDateTime2(BuildContext context) {
    var nowDate = DateTime.now();
    var date = DateTime(nowDate.year - 10, nowDate.month, nowDate.day);
    Picker(
            adapter: DateTimePickerAdapter(
                type: PickerDateTimeType.kDMY,
                isNumberMonth: false,
                yearBegin: 1950,
                maxValue: date,
                value: DateUtil.toDateTime("2000-01-01")),
            title: Text(""),
            textAlign: TextAlign.right,
            selectedTextStyle: TextStyle(color: HcColors.color_02B17B),
            onConfirm: (Picker picker, List value) {
              String datetime = picker.adapter.toString();
              setState(() {
                dateOfBirth =
                    DateUtil.formatDateTime(DateUtil.toDateTime(datetime));
                enable = _checkNextButton();
              });
            },
            onSelect: (Picker picker, int index, List<int> selected) {})
        .showBottomSheet(context);
  }

  _uploadImageV2(String type) async {
    try {
      FormData formData = FormData.fromMap({
        Api.type: type,
        // Api.userId: await SpUtil.getString(Api.userId)
      });
      String fileUrl = '';
      if (type == '05') {
        formData.files.add(MapEntry(Api.frontImage,
            MultipartFile.fromFileSync(frontImage1, filename: 'frontImage.jpg')));
      } else {
        formData.files.add(MapEntry(Api.backImage,
            MultipartFile.fromFileSync(backImage1, filename: 'backImage.jpg')));
      }
      HLog.error(fileUrl);
      ResultData resultData = await HttpManager.instance()
          .postImage(Api.identificationV2(), params: formData, mul: true);
      if (resultData.success) {
        if (type == '05') {
          String birthDay = resultData.data[Api.birthDay];
          if (birthDay.isNotEmpty) {
            dateOfBirth = birthDay;
          }
          String validDate = resultData.data[Api.validDate];
          if (validDate.isNotEmpty) {
            dateOfIssue = validDate;
          }
          String expiryDate = resultData.data[Api.expiryDate];
          if (expiryDate.isNotEmpty) {
            dateOfExpriry = expiryDate;
          }
          String sexId = resultData.data[Api.sex];
          String sexText = resultData.data[Api.sexDesc];
          if (sexId.isNotEmpty && sexText.isNotEmpty) {
            genderId = sexId;
            genderText = sexText;
          }
          String fullName = resultData.data[Api.name];
          if (fullName.isNotEmpty) {
            nameController.text = fullName;
          }
          String idNo = resultData.data[Api.idNo];
          if (idNo.isNotEmpty) {
            numberController.text = idNo;
          }
          setState(() {});
        }

        // ，
        queryType = 1;
        _queryImageInfo();

      } else {
        ToastUtil.show(resultData.msg);
        if (type == '05') {
          frontImage1 = "";
        } else {
          backImage1 = "";
        }
        setState(() {});
      }
    } catch (e) {}
  }
}
