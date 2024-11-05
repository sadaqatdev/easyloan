import 'package:flutter/material.dart';
import 'package:homecredit/entity/OrderItem.dart';
import 'package:homecredit/entity/ProductItem.dart';
import 'package:homecredit/page/order/item_failed_page.dart';
import 'package:homecredit/page/order/item_loanable_page.dart';
import 'package:homecredit/page/order/item_overdue_page.dart';
import 'package:homecredit/page/order/item_reject_page.dart';
import 'package:homecredit/page/order/item_repayment_page.dart';
import 'package:homecredit/page/order/item_under_review_page.dart';
import 'package:homecredit/page/service/service_call.dart';
import 'package:homecredit/page/vip/banner_page.dart';
import '../arch/api/api.dart';
import '../arch/net/config.dart';
import '../arch/net/http.dart';
import '../arch/net/params.dart';
import '../arch/net/result_data.dart';
import '../generated/l10n.dart';
import '../res/colors.dart';
import '../routes/route_util.dart';
import '../routes/routes.dart';
import '../utils/debounce.dart';
import '../utils/log.dart';
import '../utils/sp.dart';
import '../utils/toast.dart';
import '../widget/PrivacyPolicy.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderItem>? orderList = [];
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    _orderListForMulApp();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: Scrollbar(
          child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('images/top_bg_small.png'),
                  width: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: HcColors.color_02B17B,
                ),
              ),

              Stack(children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    S.of(context).my_order,
                    style: TextStyle(
                        fontSize: 24.0,
                        color: HcColors.color_333333,
                        fontWeight: FontWeight.w500),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HcColors.white,
                  ),
                ),
                Positioned(
                  right: 15,
                  child: ServiceCall(),
                )
              ],),



              isEmpty
                  ?
                  // no date
                  Container(
                      margin: EdgeInsets.only(top: 80),
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Image(
                            image: AssetImage('images/ic_cart.png'),
                            width: 145,
                            height: 121,
                          ),
                          SizedBox(height: 20),
                          Text(
                            S.of(context).order_no_date,
                            style: TextStyle(
                                fontSize: 16.0, color: HcColors.color_333333),
                          ),
                        ],
                      ),
                    )
                  :
                  // status list
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                      decoration: BoxDecoration(),
                      child: MediaQuery.removePadding(
                        context: context,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderList?.length,
                          itemBuilder: (BuildContext context, int index) {
                            OrderItem item = orderList![index];
                            int viewStatus = int.parse(
                                item.classicalGasSmellyRice.toString());
                            switch (viewStatus) {
                              case NetConfig.TYPE_ORDER_STATUS_FINISH:
                                return OrderLoanablePage(
                                  item: item,
                                );
                              case NetConfig.TYPE_ORDER_STATUS_REPAY:
                                return OrderRepaymentPage(
                                  item: item,
                                );
                              case NetConfig.TYPE_ORDER_STATUS_OVERDUE:
                                return OrderOverDuePage(
                                  item: item,
                                );
                              case NetConfig.TYPE_ORDER_STATUS_REVIEW:
                                return OrderUnderReviewPage(
                                  item: item,
                                );
                              case NetConfig.TYPE_ORDER_STATUS_REJECT:
                                return OrderRejectPage(
                                  item: item,
                                );
                              case NetConfig.TYPE_ORDER_STATUS_FAILED:
                                return OrderFailedPage(
                                  item: item,
                                );
                              default:
                                return Container();
                            }
                          },
                        ),
                        removeTop: true,
                      ),
                    ),

              Container(
                margin: EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0,bottom: 20.0),
                child: PrivacyPolicy(),
              ),

              // BannerPage(
              //   margin: EdgeInsets.only(left:15,right:15,top: 15.0, bottom: 20.0),
              // ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      )),
      onRefresh: () async {
        _orderListForMulApp();
        return Future.delayed(Duration(seconds: 1));
      },
    );
  }

  _orderListForMulApp() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.orderListForMulApp(), params: params);
      if (resultData.success) {
        List list = resultData.data;
        orderList = list.map((e) {
          return OrderItem.fromJson(e);
        }).toList();
        if (orderList!.isNotEmpty) {
          isEmpty = false;
        } else {
          isEmpty = true;
        }
        setState(() {});
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {
      print(e);
    }
  }
}
