import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/entity/ProductItem.dart';
import 'package:homecredit/page/product/item_failed_page.dart';
import 'package:homecredit/page/product/item_loanable_page.dart';
import 'package:homecredit/page/product/item_overdue_page.dart';
import 'package:homecredit/page/product/item_reject_page.dart';
import 'package:homecredit/page/product/item_repayment_page.dart';
import 'package:homecredit/page/product/item_under_review_page.dart';
import 'package:homecredit/page/product/product.dart';
import 'package:homecredit/page/status/first_page.dart';
import 'package:homecredit/page/status/order_log.dart';
import 'package:homecredit/page/status/single/s_failed_page.dart';
import 'package:homecredit/page/status/single/s_overdue_page.dart';
import 'package:homecredit/page/status/single/s_reject_page.dart';
import 'package:homecredit/page/status/single/s_repayment_page.dart';
import 'package:homecredit/page/status/single/s_under_review_page.dart';
import 'package:homecredit/res/colors.dart';
import 'package:homecredit/utils/log.dart';
import 'package:homecredit/utils/sp.dart';
import 'package:homecredit/widget/HomeTopBar.dart';
import 'package:sprintf/sprintf.dart';
import '../arch/api/api.dart';
import '../arch/api/log.dart';
import '../arch/api/log_util.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../routes/route_util.dart';
import '../utils/date.dart';
import '../utils/flutter_plugin.dart';
import '../utils/toast.dart';
import '../../utils/money.dart';
import '../widget/PrivacyPolicy.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _widget = FirstPage();
  ScrollController? _scrollController;

  List<ProductItem>? productList = [];
  List<ProductItem>? applyList = [];
  List<ProductItem>? statusList = [];
  ProductItem? item;
  bool isMul = false;

  String? maxAmount;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() {});

    SpUtil.getString(Api.token).then((value) {
      if (value.isNotEmpty) {
        _indexForMulAppV2();
        _updateOrderPoint();
        _getIndexDialog();
      }
    });

    try {
      FlutterPlugin.checkNetwork();
    } catch (e) {}
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  _updateOrderPoint() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance().post(
          Api.updateOrderPoint(),
          params: params,
          mul: false,
          withLoading: false);
      if (resultData.success) {
        List list = resultData.data;
        for (var map in list) {
          Map<String, String> subMap = {
            Api.appssid: map[Api.appssid].toString(),
            Api.curUserId: map[Api.curUserId].toString()
          };
          if (map[Api.loanFinish] == '0') {
            OrderLog.loanFinish(map[Api.endDate],
                format: 'yyyy-MM-dd', subMap: subMap);
          }
          if (map[Api.firstLoanFinish] == '0') {
            OrderLog.firstLoanFinish(subMap: subMap);
          }
          if (map[Api.firstLoanReject] == '0') {
            OrderLog.firstLoanReject(subMap: subMap);
          }
          if (map[Api.repayPoint] == '0') {
            try {
              //
              LogUtil.platformLog(
                  optType: PointLog.SYSTEM_REPAY_FINISH(), subMap: subMap);
              Map<String, String> params = await CommonParams.addParams();
              HttpManager.instance().post(Api.saveRepayPoint(), params: params);
            } catch (e) {}
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scrollbar(
          child: SingleChildScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        child: isMul ? _getMulView() : _widget,
      )),
      onRefresh: () async {
        SpUtil.getString(Api.token).then((value) {
          if (value.isNotEmpty) {
            _indexForMulAppV2();
            _updateOrderPoint();
          }
        });

        return Future.delayed(Duration(seconds: 1));
      },
    );
  }

  Widget _getMulView() {
    return Container(
      child: Column(
        children: [
          // TopBar(),
          HomeTopBar(
            onTapCallback: () {
              // SpUtil.getString(Api.token).then((value) {
              //   if (value.isNotEmpty) {
              //     _indexForMulAppV2();
              //     _updateOrderPoint();
              //   }
              // });
            },
          ),

          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                // color: HcColors.color_DBF2EB,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0))),
            child: Column(
              children: [
                statusList!.isEmpty
                    ? Container()
                    : MediaQuery.removePadding(
                        context: context,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: statusList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductItem item = statusList![index];
                            int viewStatus = int.parse(
                                item.classicalGasSmellyRice.toString());
                            switch (viewStatus) {
                              // case NetConfig.TYPE_PRODUCT_STATUS_APPLY:
                              //   return ProductLoanablePage(
                              //     item: item, position: index,
                              //   );
                              case NetConfig.TYPE_PRODUCT_STATUS_REPAY:
                                return ProductRepaymentPage(
                                  item: item,
                                );
                              case NetConfig.TYPE_PRODUCT_STATUS_OVERDUE:
                                return ProductOverDuePage(
                                  item: item,
                                );
                              case NetConfig.TYPE_PRODUCT_STATUS_WAIT:
                                return ProductUnderReviewPage(
                                  item: item,
                                );
                              case NetConfig.TYPE_PRODUCT_STATUS_REJECT:
                                return ProductRejectPage(
                                  item: item,
                                );
                              case NetConfig.TYPE_PRODUCT_STATUS_FAILED:
                                return ProductFailedPage(
                                  item: item,
                                );
                              default:
                                return Container();
                            }
                          },
                        ),
                        removeTop: true,
                      ),

                //Max Credit Amount
                Visibility(
                  visible: applyList!.isNotEmpty,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).max_credit_amount,
                              style: TextStyle(
                                  fontSize: 20, color: HcColors.color_333333),
                            ),
                            Spacer(),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'PKR',
                                style: TextStyle(
                                    color: HcColors.color_02B17B,
                                    fontSize: 14.0),
                              ),
                              TextSpan(
                                text: maxAmount ?? '',
                                style: TextStyle(
                                    color: HcColors.color_02B17B,
                                    fontSize: 18.0),
                              ),
                            ])),
                          ],
                        ),
                        decoration: BoxDecoration(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 12, bottom: 8),
                        child: Text(
                          sprintf(S.of(context).max_credit_amount_hint,
                              [maxAmount ?? '']),
                          style: TextStyle(
                              color: HcColors.color_02B17B, fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/apply_dottedline.png'),
                            fit: BoxFit.fill, // 
                          ),
                        ),
                      ),
                      applyList!.isEmpty
                          ? Container()
                          : MediaQuery.removePadding(
                              context: context,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: applyList?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  ProductItem item = applyList![index];
                                  return ProductLoanablePage(
                                    item: item,
                                    position: index,
                                  );
                                },
                              ),
                              removeTop: true,
                            ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                      top: 20.0, left: 15.0, right: 15.0, bottom: 20.0),
                  child: PrivacyPolicy(),
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }

  _indexForMulAppV2() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.indexForMulAppV2(), params: params);
      if (resultData.success) {
        List list = resultData.data;
        productList = list.map((e) {
          return ProductItem.fromJson(e);
        }).toList();

        if (productList!.length == 1) {
          //
          isMul = false;
          item = productList![0];
          ProductCommon.saveOrderParams(item!);
          _index();
        } else if (productList!.length > 1) {
          //
          isMul = true;
          statusList?.clear();
          applyList?.clear();
          productList?.forEach((element) {
            int viewStatus =
                int.parse(element.classicalGasSmellyRice.toString());
            if (viewStatus == NetConfig.TYPE_PRODUCT_STATUS_APPLY) {
              applyList?.add(element);
            } else {
              statusList?.add(element);
            }
            // 
            try {
              String totalAmount = element.blueTinNervousThe ?? '';
              HLog.debug(totalAmount);
              if (element.uglyImpressionArcticParkingPlayer ==
                  NetConfig.APP_SSID) {
                double temp = double.parse(totalAmount);
                maxAmount = temp.moneyFormat;
              }
            } catch (e) {
              HLog.debug(e);
            }
          });
        }
        setState(() {});
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      HLog.debug(e);
    }
  }

  _index() async {
    try {
      GlobalKey _key = GlobalKey();

      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData =
          await HttpManager.instance().post(Api.index(), params: params);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;

        int overdueStatus = map[Api.overdueStatus];
        int loanStatus = map[Api.loanStatus] ?? -1;
        //：0- 1-
        String reborrowFlag = map[Api.reborrowFlag] ?? '';

        switch (overdueStatus) {
          case 0:
            //,，
            _widget = SRepaymentPage(map,
                key: _key, scrollController: _scrollController);
            break;
          case 1:
            //
            _widget = SOverduePage(map,
                key: _key, scrollController: _scrollController);
            break;
          case 2:
            //
            if (loanStatus == 2) {
              //，
              _widget = SFailedPage(map);
            } else {
              //
              _widget = SUnderReviewPage(
                map,
                key: _key,
              );
            }
            break;
          case 3:
            //，
            _widget = SRejectPage();
            break;
          case -1:
            // if (reborrowFlag == "1") {
            //   //，
            //   _widget = PluralPage();
            // } else {
            //   //，
            //   _widget = FirstPage();
            // }
            _widget = FirstPage();
            break;
          default:
            break;
        }

        if (map[Api.loanFinish] == '0') {
          OrderLog.loanFinish(map[Api.repaymentDate]);
        }
        if (map[Api.firstLoanFinish] == '0') {
          OrderLog.firstLoanFinish();
        }
        if (map[Api.firstLoanReject] == '0') {
          OrderLog.firstLoanReject();
        }

        setState(() {});
      } else {
        ToastUtil.show(resultData.msg);
      }
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
      ResultData resultData = await HttpManager.instance().post(
          Api.getAppConfig(),
          params: params,
          withLoading: false,
          mul: false);
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
          if (title.trim().isNotEmpty && content.trim().isNotEmpty) {
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
                                content,
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
