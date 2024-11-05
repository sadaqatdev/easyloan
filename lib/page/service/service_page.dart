import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../utils/clipboard.dart';
import '../../utils/debounce.dart';
import '../../utils/toast.dart';
import '../../widget/SubTopBar.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  String? hintText;

  List phoneList = [];
  List whatsappList = [];
  List emailList = [];

  @override
  void initState() {
    super.initState();
    _queryInfo();
  }

  _queryInfo() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppValueList(), params: params, mul: false);
      if (resultData.success) {

        setState(() {
          hintText = resultData.data[Api.desc];
          phoneList = resultData.data[Api.mobiles];
          whatsappList = resultData.data[Api.whatsapps];
          emailList = resultData.data[Api.emails];
        });
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubTopBar(
        S.of(context).consumer_hotline,
        backgroundColor: Colors.white,
      ),
      body: Scrollbar(
          child: SingleChildScrollView(
              // physics: BouncingScrollPhysics(),
              child: Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).hotline_phone,
                      style: TextStyle(
                          fontSize: 18.0, color: HcColors.color_333333),
                    )),
                Image(
                  image: AssetImage('images/ic_call_us.png'),
                  width: 15.0,
                  height: 15.0,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  S.of(context).call_us,
                  style:
                      TextStyle(fontSize: 14.0, color: HcColors.color_FF5545),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding:
                  EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _listWidget(phoneList,1),
              ),
              decoration: BoxDecoration(
                  color: HcColors.color_DBF2EB,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).hotline_whatsapp,
                      style: TextStyle(
                          fontSize: 18.0, color: HcColors.color_333333),
                    )),
                Image(
                  image: AssetImage('images/ic_chat.png'),
                  width: 15.0,
                  height: 13.0,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  S.of(context).chat_us,
                  style:
                      TextStyle(fontSize: 14.0, color: HcColors.color_36D091),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding:
              EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _listWidget(whatsappList,2),
              ),
              decoration: BoxDecoration(
                  color: HcColors.color_DBF2EB,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).hotline_email,
                      style: TextStyle(
                          fontSize: 18.0, color: HcColors.color_333333),
                    )),
                Image(
                  image: AssetImage('images/ic_email_us.png'),
                  width: 14.0,
                  height: 11.0,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  S.of(context).email_us,
                  style:
                      TextStyle(fontSize: 14.0, color: HcColors.color_469BE7),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding:
              EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _listWidget(emailList,3),
              ),
              decoration: BoxDecoration(
                  color: HcColors.color_DBF2EB,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      S.of(context).focus_on,
                      style: TextStyle(
                          fontSize: 18.0, color: HcColors.color_333333),
                    )),
                Image(
                  image: AssetImage('images/ic_follow.png'),
                  width: 13.0,
                  height: 13.0,
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  S.of(context).follow_us,
                  style:
                      TextStyle(fontSize: 14.0, color: HcColors.color_FF8E4E),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding:
                  EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Text(
                      "Facebook",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: HcColors.color_007D7A,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      if (Debounce.checkClick()) {
                        _jump2Browser("https://www.facebook.com/Sarmayamf");
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Text(
                      "Twitter",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: HcColors.color_007D7A,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      if (Debounce.checkClick()) {
                        _jump2Browser("https://twitter.com/sarmayamf");
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Text(
                      "Instagram",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: HcColors.color_007D7A,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      if (Debounce.checkClick()) {
                        _jump2Browser(
                            "https://www.instagram.com/sarmayamicrofinance/?hl=en");
                      }
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: HcColors.color_DBF2EB,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              hintText ?? '',
              style: TextStyle(fontSize: 16.0, color: HcColors.color_6B6B6B),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ))),
      backgroundColor: HcColors.white,
    );
  }

  List<Widget> _listWidget(List listData,int type) {
    List<Widget> listWidget = [];
    if (listData.isNotEmpty && listData.length > 0) {
      for (var value in listData) {

        listWidget.add(InkWell(
          child: Text(
            value["mobileFistLowJuly"] ?? '',
            style: TextStyle(
              fontSize: 16.0,
              color: HcColors.color_007D7A,
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () {
            String text = value["mobileFistLowJuly"];
            if (Debounce.checkClick()) {
              ClipboardUtil.setDataToast(text);
              if(type == 1){
                _jump2Browser('tel:' + text);
              }else if(type == 2){
                _jump2Browser("https://api.whatsapp.com/send?phone="+text);
              }else{
                _jump2Browser('mailto:' + text);
              }
            }
          },
        ));

        if(listData.length - 1 != listData.indexOf(value)) {
          listWidget.add(SizedBox(
            height: 10,
          ));
        }
      }
    }

    return listWidget;
  }

  _jump2Browser(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      }
    } catch (e) {}
  }
}
