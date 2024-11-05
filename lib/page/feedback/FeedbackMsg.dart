import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../utils/debounce.dart';
import '../../utils/log.dart';
import '../../utils/toast.dart';
import '../../widget/SubTopBar.dart';

class FeedbackMsg extends StatefulWidget {
  final String type;

  const FeedbackMsg({Key? key, required this.type}) : super(key: key);

  @override
  State<FeedbackMsg> createState() => _FeedbackMsgState(type);
}

class _FeedbackMsgState extends State<FeedbackMsg> with WidgetsBindingObserver {
  final String type;

  _FeedbackMsgState(this.type);

  List<dynamic> msgList = [];
  bool isSubmit = false; // 
  bool isShowSubmit = true; // 
  TextEditingController inputMsg = TextEditingController();
  String tips = "";
  String replyStatus = "";

  _initData() async {
    try {
      //
      Map<String, String> params = await CommonParams.addParams();
      params["roundaboutPatternAttractiveSense"] = type; //messageType
      ResultData resultData = await HttpManager.instance()
          .post(Api.getCustLeavingMessageByType(), params: params, mul: false);
      if (resultData.success) {
        setState(() {
          var data = resultData.data;

          tips = data["plainBreathTaxCandy"]; //closePrompt
          replyStatus =
              data["sadSurroundingGetModestJune"].toString(); //replyStatus
          msgList = data[
              "undergroundFilmSignalClearPage"]; //custLeavingMessageInfoList

          if (msgList.length > 0) {
            // 
            if ("0" == replyStatus) {
              // 
              isShowSubmit = false;
            } else {
              // 
              isShowSubmit = true;
            }
          } else {
            // 
            isShowSubmit = true;
          }
        });
      } else {
        isShowSubmit = true;
      }
    } catch (e) {}
  }

  saveMsg() async {
    try {
      //
      Map<String, String> params = await CommonParams.addParams();
      params["roundaboutPatternAttractiveSense"] = type; //messageType
      params["merryLevelHorribleDrum"] = inputMsg.text; //message
      ResultData resultData = await HttpManager.instance()
          .post(Api.saveCustLeavingMessage(), params: params, mul: false);
      if (resultData.success) {
        _initData();
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HcColors.color_DBF2EB,
      appBar: SubTopBar(
        S.current.app_name,
        offstage: false,
      ),
      // resizeToAvoidBottomInset : false ,
      body: WillPopScope(
        //
        onWillPop: () async => false,
        child: Scrollbar(child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    S.of(context).feedback_list_title,
                    style: TextStyle(
                        color: HcColors.color_333333,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                //
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 254,
                    // 
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border:
                        Border.all(color: HcColors.color_1CBC7A, width: 1)),
                    child: ListView.builder(
                        itemCount: msgList.length,
                        itemBuilder: (context, index) {
                          var msgData = msgList[index];
                          var repay =
                          msgData["thickTeenagerIndeedBuilding"]; // repay
                          var message =
                          msgData["merryLevelHorribleDrum"]; // message

                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: HcColors.color_02B17B,
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            message,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      "images/icon_kefu_my.png",
                                      width: 40,
                                      height: 40,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      "images/icon_logi.png",
                                      width: 40,
                                      height: 40,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            //#F1FDF9
                                              color: HcColors.color_DBF2EB,
                                              borderRadius:
                                              BorderRadius.circular(20)),
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            "$repay",
                                            style: TextStyle(
                                                color: HcColors.color_007D7A,
                                                fontSize: 14),
                                          ),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })),

                //
                Visibility(
                  visible: isShowSubmit,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 219,
                    // 
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: HcColors.color_DCFCEF,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: HcColors.color_1CBC7A, width: 0.9), // 
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(),
                          child: Image.asset(
                            "images/ic_feed_edit.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                              maxLines: 20,
                              maxLength: 200,
                              controller: inputMsg,
                              decoration: InputDecoration(
                                  hintText: S.of(context).please_enter,
                                  // 
                                  hintStyle: TextStyle(
                                      color: HcColors.color_02B17B, fontSize: 14),
                                  border: InputBorder.none,
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.all(Radius.circular(9.0)),
                                  // ),
                                  isCollapsed: true),
                              style: TextStyle(color: HcColors.color_333333),
                              showCursor: true,
                              // 
                              onChanged: (content) {
                                if (content.isNotEmpty && content.length > 0) {
                                  setState(() {
                                    isSubmit = true;
                                  });
                                } else {
                                  setState(() {
                                    isSubmit = false;
                                  });
                                }
                              },
                            ))
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Text(
                    tips,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),

                //
                Row(
                  children: [
                    Visibility(
                        child: Expanded(
                            child: ReturnButton(S.of(context).return_text, () {
                              Navigator.pop(context);
                            }))),
                    Visibility(
                        visible: isShowSubmit,
                        child: isSubmit
                            ? Expanded(
                            child: SubmitLightButton(
                                S.of(context).submit_text, () {
                              saveMsg();
                            }))
                            : Expanded(
                            child: SubmitGreyButton(
                                S.of(context).submit_text, () {
                              ToastUtil.show(
                                  S.of(context).button_disable_hint);
                            })))
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: HcColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
          ),
        ),)
      ),
    );
  }
}

Widget SubmitLightButton(String content, VoidCallback? pressed) {
  return Container(
    height: 46,
    margin: EdgeInsets.fromLTRB(10, 5, 20, 20),
    child: TextButton(
      onPressed: () {
        if (Debounce.checkClick()) {
          pressed?.call();
        }
      },
      child: Text(
        content,
        style: TextStyle(fontSize: 20, color: HcColors.white),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(HcColors.color_02B17B),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    ),
  );
}

Widget ReturnButton(String content, VoidCallback? pressed) {
  return Container(
    height: 46,
    margin: EdgeInsets.fromLTRB(20, 5, 10, 20),
    child: TextButton(
      onPressed: () {
        if (Debounce.checkClick()) {
          pressed?.call();
        }
      },
      child: Text(
        content,
        style: TextStyle(fontSize: 20, color: HcColors.color_007D7A),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(HcColors.color_D7E6E1),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    ),
  );
}

Widget SubmitGreyButton(String content, VoidCallback? pressed) {
  return Container(
    height: 46,
    margin: EdgeInsets.fromLTRB(10, 5, 20, 20),
    child: TextButton(
      onPressed: () {
        if (Debounce.checkClick()) {
          pressed?.call();
        }
      },
      child: Text(
        content,
        style: TextStyle(fontSize: 20, color: HcColors.color_999999),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(HcColors.color_EEEEEE),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
    ),
  );
}
