import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/page/vip/banner_page.dart';
import 'package:homecredit/utils/flutter_plugin.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/widget/PrivacyPolicy.dart';
import '../../application.dart';
import '../../arch/api/log.dart';
import '../../arch/api/log_util.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/routes.dart';
import '../../utils/sp.dart';
import '../../widget/StatusTopBar.dart';
import '../../widget/SubTopBar.dart';
import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../utils/toast.dart';
import '../../utils/money.dart';
import 'order_log.dart';

class UnderReviewPage extends StatefulWidget {
  const UnderReviewPage({Key? key}) : super(key: key);

  @override
  State<UnderReviewPage> createState() => UnderReviewPageState();
}

class UnderReviewPageState extends State<UnderReviewPage> {
  String? repayAmt;
  String? applyDate;

  @override
  void initState() {
    super.initState();
    _indexQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubTopBar(
        S.of(context).app_name,
        backgroundColor: Colors.white,
        offstage: false,
        showSubProductName: true,
      ),
      body:  Scrollbar(
        child: SingleChildScrollView(
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
                                  image: AssetImage('images/ic_under_1.png'),
                                  width: 59.0,
                                  height: 59.0,
                                ),
                                Text(
                                  S.of(context).under_n_review,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: HcColors.color_36D091,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Image(
                                  image: AssetImage('images/ic_under_sj.png'),
                                  width: 29.0,
                                  height: 20.0,
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
                                  image: AssetImage('images/ic_reject_0.png'),
                                  width: 59.0,
                                  height: 59.0,
                                ),
                                Text(
                                  S.of(context).reject_n_application,
                                  style: TextStyle(
                                      fontSize: 12.0, color: HcColors.color_999999),
                                  textAlign: TextAlign.center,
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
                            color: HcColors.color_DCFCEF,
                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Image(
                                  image: AssetImage('images/ic_under_2.png'),
                                  width: 59.0,
                                  height: 59.0,
                                ),
                                Text(
                                  S.of(context).under_n_review,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: HcColors.color_36D091,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Column(
                              children: [
                                Text(
                                  S.of(context).loan_amount,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: 'PKR',
                                    style: TextStyle(
                                        color: HcColors.color_02B17B, fontSize: 16.0),
                                  ),
                                  TextSpan(
                                    text: repayAmt ?? '',
                                    style: TextStyle(
                                        color: HcColors.color_02B17B,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ])),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  S.of(context).date_of_application,
                                  style: TextStyle(
                                    color: HcColors.color_333333,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  applyDate ?? '',
                                  style: TextStyle(
                                    color: HcColors.color_02B17B,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('images/ic_under_warn.png'),
                              width: 44.0,
                              height: 44.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Flexible(
                              child: Text(
                                S.of(context).under_review_hint,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: HcColors.color_02B17B,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                  margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                  child: PrivacyPolicy(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                  child: Text(S.of(context).repayment_reminder,
                    style: TextStyle(
                        color: HcColors.color_FF5545,
                        fontSize: 14
                    ),),
                ),
                BannerPage(
                  margin: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 15.0, right: 15.0),
                ),
              ],
            ),
            decoration: BoxDecoration(color: HcColors.color_DBF2EB),
          ),
        ),
      ),
    );
  }

  _indexQuery() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.index(), params: params, mul: true);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;

        try {
          if (map[Api.loanFinish] == '0') {
            OrderLog.loanFinish(map[Api.repaymentDate]);
          }
          if (map[Api.firstLoanFinish] == '0') {
            OrderLog.firstLoanFinish();
          }
          if (map[Api.firstLoanReject] == '0') {
            OrderLog.firstLoanReject();
          }
        } catch (e) {}

        setState(() {
          double amount = map[Api.creditAmount];
          repayAmt = ' ' + amount.moneyFormat;
          applyDate = resultData.data[Api.applyDate];
        });

      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

}
