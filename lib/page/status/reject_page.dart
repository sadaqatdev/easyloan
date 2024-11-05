import 'package:flutter/material.dart';
import 'package:homecredit/page/vip/vip_banner_page.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../widget/PrivacyPolicy.dart';
import '../../widget/StatusTopBar.dart';
import '../../widget/SubTopBar.dart';

class RejectPage extends StatefulWidget {

  const RejectPage({Key? key}) : super(key: key);

  @override
  State<RejectPage> createState() => _RejectPageState();
}

class _RejectPageState extends State<RejectPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: SubTopBar(
          S.of(context).app_name,
          backgroundColor: Colors.white,
          offstage: false,
          showSubProductName: true,
        ),
        body:  Scrollbar(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Image(
                                      image: AssetImage('images/ic_under_0.png'),
                                      width: 59.0,
                                      height: 59.0,
                                    ),
                                    Text(
                                      S.of(context).under_n_review,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: HcColors.color_999999,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image(
                                      image: AssetImage('images/ic_repayment_0.png'),
                                      width: 59.0,
                                      height: 59.0,
                                    ),
                                    Text(
                                      S.of(context).pending_n_repayment,
                                      style: TextStyle(
                                          fontSize: 12.0, color: HcColors.color_999999),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image(
                                      image: AssetImage('images/ic_overdue_0.png'),
                                      width: 59.0,
                                      height: 59.0,
                                    ),
                                    Text(
                                      S.of(context).overdue_n_0_days,
                                      style: TextStyle(
                                          fontSize: 12.0, color: HcColors.color_999999),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image(
                                      image: AssetImage('images/ic_reject_1.png'),
                                      width: 59.0,
                                      height: 59.0,
                                    ),
                                    Text(
                                      S.of(context).reject_n_application,
                                      style: TextStyle(
                                          fontSize: 12.0, color: HcColors.color_7579E7),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Image(
                                      image: AssetImage('images/ic_reject_sj.png'),
                                      width: 29.0,
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                            decoration: BoxDecoration(
                                color: HcColors.color_E6E8FF,
                                borderRadius: BorderRadius.all(Radius.circular(15.0))),
                            child: Column(
                              children: [
                                Image(
                                  image: AssetImage('images/ic_reject_2.png'),
                                  width: 57.0,
                                  height: 57.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        S.of(context).reject_hint1,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: HcColors.color_7579E7,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        S.of(context).reject_hint2,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: HcColors.color_7579E7,
                                        ),
                                      ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0))),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 20.0, left: 15.0, right: 15.0),
                      child: PrivacyPolicy(),
                    ),

                    // VipBannerPage(),zw
                  ],
                ),
                decoration: BoxDecoration(color: HcColors.color_DBF2EB),
                padding: EdgeInsets.only(bottom: 120),
              ),
            )),
      );
  }

}
