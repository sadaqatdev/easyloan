import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import '../../arch/api/api.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../entity/OrderItem.dart';
import '../../entity/ProductItem.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';
import '../../utils/money.dart';
import '../../utils/toast.dart';
import '../status/order_log.dart';
import 'order.dart';

class OrderRepaymentPage extends StatefulWidget {
  final OrderItem item;
  const OrderRepaymentPage({Key? key, required this.item}) : super(key: key);

  @override
  State<OrderRepaymentPage> createState() => _OrderRepaymentPageState();
}

class _OrderRepaymentPageState extends State<OrderRepaymentPage> {
  double? repayAmount;
  String? extendDuration;

  //
  bool ep_visible = false;
  bool jc_visible = false;

  @override
  void initState() {
    super.initState();
  }

  _initDate(){
    try{
      repayAmount = widget.item.fastPartnerRareLemonade;
      String duration = widget.item.probableStandardNervousThe.toString();
      extendDuration = sprintf(S.of(context).extend_duration_format,[duration]);
    }catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _initDate();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Container(
            width: 286.0,
            height: 30.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )),
            child:
            Row(
              children: [
                Image(image: AssetImage('images/sjx_blu.png'),
                  width: 11,height: 11,),
                SizedBox(width: 5,),
                Text(S.of(context).pending_repayment,
                    style: TextStyle(color: HcColors.color_469BE7, fontSize: 14.0)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: HcColors.color_DDEFFB,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                children: [

                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.item.mexicanTermCartoonBlueHusband ?? '',
                        width: 27.0,
                        height: 27.0,
                        placeholder: (context, url) => CircularProgressIndicator(
                          color: HcColors.color_02B17B,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        widget.item.rectangleSelfRainbowTomato ?? '',
                        style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15,bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  S.of(context).repayment_amount,
                                  style: TextStyle(
                                    color:
                                    HcColors.color_469BE7,
                                    fontSize: 14.0,
                                  ),
                                )),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                text: 'PKR ',
                                style: TextStyle(
                                    color: HcColors
                                        .color_999999,
                                    fontSize: 14.0),
                              ),
                              TextSpan(
                                text: repayAmount?.moneyFormat,
                                style: TextStyle(
                                    color: HcColors
                                        .color_333333,
                                    fontSize: 14.0),
                              ),
                            ])),
                          ],
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                                  S.of(context).repayment_date,
                                  style: TextStyle(
                                    color:
                                    HcColors.color_469BE7,
                                    fontSize: 14.0,
                                  ),
                                )),
                            Text(
                              widget.item.strictSheepSomeone ?? '',
                              style: TextStyle(
                                color: HcColors.color_333333,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                        color: HcColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),

                  Row(
                    children: [

                      Expanded(child: Container(
                        height: 46,
                        child: TextButton(
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: MaterialStateProperty.all(Size(0, 0)),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              _gotoDeferred();
                            },
                            child: Text(extendDuration ?? '',
                              style: TextStyle(
                                  color: HcColors.color_007D7A, fontSize: 12.0),
                              textAlign: TextAlign.center,
                            )),
                        padding: EdgeInsets.only(),
                        decoration: BoxDecoration(
                            color: HcColors.color_D7E6E1,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      )),
                      SizedBox(width: 15,),
                      Expanded(child: Container(
                        height: 46,
                        child: TextButton(
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: MaterialStateProperty.all(Size(0, 0)),
                              padding: MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            onPressed: () {
                              _gotoRepayment();
                            },
                            child: Text(S.of(context).repay,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0))),
                        padding: EdgeInsets.only(),
                        decoration: BoxDecoration(
                            color: HcColors.color_02B17B,
                            borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      )),
                    ],
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _gotoRepayment(){
    try {
      if (Debounce.checkClick()) {
        OrderCommon.saveOrderParams(widget.item);
        String extendDuration = widget.item.probableStandardNervousThe
            .toString();
        Map<String, dynamic> map = {
          Api.extendDuration: extendDuration
        };
        RouteUtil.push(context, Routes.repayment,
            checkLogin: true, params: map);
      }
    }catch(e){
      print(e);
    }
  }

  _gotoDeferred(){
    try {
      if (Debounce.checkClick()) {
        OrderCommon.saveOrderParams(widget.item);
        _indexQuery();
      }
    }catch(e){
      print(e);
    }
  }

  _indexQuery() async {
    try {
      Map<String, String> params = await CommonParams.addParams();
      ResultData resultData = await HttpManager.instance()
          .post(Api.index(), params: params,mul: true);
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
        }catch(e){}


        String orderId = map[Api.orderId].toString();

        int easyPayFlag = map[Api.easyPayFlag];
        if(easyPayFlag == 1){
          ep_visible = true;
        }
        int jazzCashFlag = map[Api.jazzCashFlag];
        if(jazzCashFlag == 1){
          jc_visible = true;
        }

        _getDetail(orderId);

      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }

  _getDetail(String orderId) async{
    try {
      Map<String, String> params = await CommonParams.addParams();
      params[Api.payType] = '01';
      params[Api.orderId] = orderId;
      ResultData resultData = await HttpManager.instance()
          .post(Api.repayDetail(), params: params,mul: true);
      if (resultData.success) {
        Map<String, dynamic> map = resultData.data;
        if(map.isNotEmpty){
          map[Api.easyPayFlag] = ep_visible;
          map[Api.jazzCashFlag] = jc_visible;
          RouteUtil.push(context, Routes.deferred,
              checkLogin: true, params: map);
        }
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }
}
