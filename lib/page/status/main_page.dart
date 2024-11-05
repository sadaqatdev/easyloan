import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/page/status/failed_page.dart';
import 'package:homecredit/page/status/first_page.dart';
import 'package:homecredit/page/status/overdue_page.dart';
import 'package:homecredit/page/status/plural_page.dart';
import 'package:homecredit/page/status/reject_page.dart';
import 'package:homecredit/page/status/repayment_page.dart';
import 'package:homecredit/page/status/under_review_page.dart';
import 'package:homecredit/utils/date.dart';
import 'package:homecredit/utils/log.dart';

import '../../arch/api/api.dart';
import '../../arch/api/log.dart';
import '../../arch/api/log_util.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../utils/aes.dart';
import '../../utils/debounce.dart';
import '../../utils/flutter_plugin.dart';
import '../../utils/sp.dart';
import '../../utils/toast.dart';
import 'order_log.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget _widget = FirstPage();

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    try {
      _index();
      _repayPoint();
      FlutterPlugin.checkNetwork();
      _getIndexDialog();
    } catch (e) {}
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scrollbar(
          child: SingleChildScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: _widget,
      )),
      onRefresh: () async {
        _index();
        return Future.delayed(Duration(seconds: 1));
      },
    );
  }

  _index() async {
    // try {
    //   Map<String, String> params = await CommonParams.addParams();
    //   ResultData resultData =
    //       await HttpManager.instance().post(Api.index(), params: params);
    //   if (resultData.success) {
    //     Map<String, dynamic> map = resultData.data;
    //
    //     int overdueStatus = map[Api.overdueStatus];
    //     int loanStatus = map[Api.loanStatus] ?? -1;
    //     //
    //     String reborrowFlag = map[Api.reborrowFlag] ?? '';
    //
    //     switch (overdueStatus) {
    //       case 0:
    //       //
    //       case 1:
    //         //
    //         if (overdueStatus != 1) {
    //           GlobalKey<RepaymentPageState> _key =
    //               GlobalKey<RepaymentPageState>();
    //           _widget = RepaymentPage(map,
    //               key: _key, scrollController: _scrollController);
    //           _key.currentState?.indexQuery();
    //         } else {
    //           GlobalKey<OverduePageState> _key = GlobalKey<OverduePageState>();
    //           _widget = OverduePage(map,
    //               key: _key, scrollController: _scrollController);
    //           _key.currentState?.indexQuery();
    //         }
    //         break;
    //       case 2:
    //         //
    //         if (loanStatus == 2) {
    //           //
    //           _widget = FailedPage(map);
    //         } else {
    //           //
    //           GlobalKey<UnderReviewPageState> _key =
    //               GlobalKey<UnderReviewPageState>();
    //           _widget = UnderReviewPage(
    //             map,
    //             key: _key,
    //           );
    //           _key.currentState?.indexQuery();
    //         }
    //         break;
    //       case 3:
    //         //
    //         _widget = RejectPage();
    //         break;
    //       case -1:
    //         if (reborrowFlag == "1") {
    //           //
    //           _widget = PluralPage();
    //         } else {
    //           //
    //           _widget = FirstPage();
    //         }
    //         break;
    //       default:
    //         break;
    //     }
    //
    //     if (map[Api.loanFinish] == '0') {
    //       OrderLog.loanFinish(map[Api.repaymentDate]);
    //     }
    //     if (map[Api.firstLoanFinish] == '0') {
    //       OrderLog.firstLoanFinish();
    //     }
    //     if (map[Api.firstLoanReject] == '0') {
    //       OrderLog.firstLoanReject();
    //     }
    //
    //     setState(() {});
    //   } else {
    //     ToastUtil.show(resultData.msg);
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  _repayPoint() async {
    try {
      String token = await SpUtil.getString(Api.token, "");
      if (token.isNotEmpty) {
        Map<String, String> params = await CommonParams.addParams();
        ResultData resultData = await HttpManager.instance()
            .post(Api.checkRepayPoint(), params: params, withLoading: false);
        if (resultData.success) {
          Map<String, dynamic> map = resultData.data;
          if (map[Api.repayPoint] == '1') {
            LogUtil.platformLog(optType: PointLog.SYSTEM_REPAY_FINISH());
            _saveRepayPoint();
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _saveRepayPoint() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.saveRepayPoint(), params: params, withLoading: false);
      if (resultData.success) {}
    } catch (e) {
      print(e);
    }
  }

  _getIndexDialog() async {
    String datetime = await SpUtil.getString(NetConfig.INDEX_DIALOG, "");
    if (datetime == DateUtil.formatDateTime(DateTime.now())) {
      return;
    }

    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.type] = "HomeCreditHomepagePopup";
      ResultData resultData = await HttpManager.instance()
          .post(Api.getAppConfig(), params: params, withLoading: false);
      if (resultData.success) {
        List list = resultData.data;
        if (list != null && list.length == 2) {
          String title = "";
          String content = "";
          list.forEach((element) {
            if (element[Api.code] == "1") {
              title = element[Api.value].toString();
            } else {
              content = element[Api.value].toString();
            }
          });
          if(title.trim().isNotEmpty && content.trim().isNotEmpty) {
            _showIndexDialog(title, content);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _showIndexDialog(String title, String content) {
    showModalBottomSheet(
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        margin: EdgeInsets.only(top: 13),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 32),
                              alignment: Alignment.center,
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('images/index_title_bg.png'),
                                  fit: BoxFit.fill, //
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              height: 234,
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: HcColors.color_007D7A, fontSize: 16),
                              ),
                              decoration: BoxDecoration(
                                  color: HcColors.color_DBF2EB,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 40),
                              width: double.infinity,
                              height: 46,
                              child: TextButton(
                                  style: ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    minimumSize:
                                        MaterialStateProperty.all(Size(0, 0)),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                  ),
                                  onPressed: () {
                                    RouteUtil.pop(context);
                                  },
                                  child: Text(S.of(context).go_text,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0))),
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
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      SpUtil.put(
          NetConfig.INDEX_DIALOG, DateUtil.formatDateTime(DateTime.now()));
    });
  }
}
