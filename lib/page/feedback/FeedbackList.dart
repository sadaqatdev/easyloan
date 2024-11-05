import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../widget/SubTopBar.dart';
import 'FeedbackMsg.dart';

class FeedbackList extends StatefulWidget {
  const FeedbackList({Key? key}) : super(key: key);

  @override
  State<FeedbackList> createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {

  List typeList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getCustLeavingMessageReply(), params: params, mul: false);
      if (resultData.success) {
        setState(() {
          typeList = resultData
              .data["southSatisfactionSkillfulStudent"]; //custLeavingMessageVos
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HcColors.color_DBF2EB,
      appBar: SubTopBar(
        S.current.app_name,
        offstage: false,
      ),
      body: RefreshIndicator(
        child: Scrollbar(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                // 
                decoration: BoxDecoration(
                  color: HcColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(), //
                  shrinkWrap: true,

                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Text(
                        S.of(context).feedback_list_title,
                        style: TextStyle(
                            color: HcColors.color_333333,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(), //
                          shrinkWrap: true, //
                          // itemCount : typeList.length ,
                          itemCount: typeList.length,
                          itemBuilder: (context, index) {
                            var data = typeList[index];
                            var name = data["arabicMetre"]; //messageTypeDesc
                            var messageType = data[
                            "roundaboutPatternAttractiveSense"]; //messageType
                            var status =
                            data["sadSurroundingGetModestJune"]; //replyStatus

                            return Container(
                                decoration: BoxDecoration(
                                    color: HcColors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: HcColors.color_36D091)),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                padding: EdgeInsets.fromLTRB(3, 3, 15, 3),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FeedbackMsg(
                                              type: messageType.toString(),
                                            )));
                                  },
                                  child: Row(
                                    children: [
                                      status == 1
                                          ? Container(
                                        child: Text(
                                          S.of(context).replied,
                                          style: TextStyle(
                                              color: HcColors.white,
                                              fontSize: 12),
                                        ),
                                        padding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 12),
                                        decoration: BoxDecoration(
                                          color: HcColors.color_1CBC7A,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      )
                                          : Container(
                                        child: Text(
                                          S.of(context).no_reply,
                                          style: TextStyle(
                                              color: HcColors.white,
                                              fontSize: 12),
                                        ),
                                        padding:
                                        EdgeInsets.fromLTRB(12, 12, 12, 12),
                                        decoration: BoxDecoration(
                                          color: HcColors.color_FF5545,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: Text(
                                            "$name",
                                            style: TextStyle(
                                                color: HcColors.color_02B17B,
                                                fontSize: 14),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Image(
                                        image:
                                        AssetImage("images/icon_feed_arrow.png"),
                                        width: 17,
                                        height: 17,
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                    ),
                  ],
                ),
              ),
            )),
        onRefresh: () async {
          initData();
          return Future.delayed(Duration(seconds: 1));
        },
      )
    );
  }
}
