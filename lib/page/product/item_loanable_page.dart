import 'package:alog/alog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/page/product/product.dart';
import 'package:homecredit/utils/money.dart';

import '../../arch/api/api.dart';
import '../../arch/api/log.dart';
import '../../arch/api/log_util.dart';
import '../../arch/net/http.dart';
import '../../arch/net/params.dart';
import '../../arch/net/result_data.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../entity/ProductItem.dart';
import '../../utils/debounce.dart';
import '../../utils/sp.dart';
import '../../utils/toast.dart';

class ProductLoanablePage extends StatefulWidget {
  final ProductItem item;
  final int position;

  const ProductLoanablePage({Key? key, required this.item, required this.position}) : super(key: key);

  @override
  State<ProductLoanablePage> createState() => _ProductLoanablePageState();
}

class _ProductLoanablePageState extends State<ProductLoanablePage> {

  String? amount;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      double temp = double.parse(widget.item.everyListBlueTermThe.toString());
      amount = temp.moneyFormat;
    }catch(e){}
    Color _amountColor = HcColors.color_02B17B;
    Color _color = HcColors.color_DCFCEF;
    int style = widget.position % 6;
    try {
      if (style == 0) {
        _color = HcColors.color_DCFCEF;
        _amountColor = HcColors.color_02B17B;
      }else if (style == 1) {
        _color = HcColors.color_DDEFFB;
        _amountColor = HcColors.color_469BE7;
      }else if (style == 2) {
        _color = HcColors.color_FDF1DD;
        _amountColor = HcColors.color_FF8E4E;
      }else if (style == 3) {
        _color = HcColors.color_E6E8FF;
        _amountColor = HcColors.color_7579E7;
      }else if (style == 4) {
        _color = HcColors.color_FFE9E9;
        _amountColor = HcColors.color_FF5545;
      }
    }catch(e){}

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(15.0),
          //         topRight: Radius.circular(15.0),
          //         bottomRight: Radius.circular(15.0),
          //       )),
          //   child:
          //   Row(
          //     children: [
          //       Image(image: AssetImage('images/sjx_pur.png'),
          //         width: 11,height: 11,),
          //       SizedBox(width: 5,),
          //       Text(S.of(context).loanable,
          //           style: TextStyle(color: HcColors.color_7579E7, fontSize: 14.0)),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.item.mexicanTermCartoonBlueHusband ?? '',
                        width: 39.0,
                        height: 39.0,
                        placeholder: (context, url) => CircularProgressIndicator(
                          color: HcColors.color_02B17B,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                          child: Text(
                            widget.item.rectangleSelfRainbowTomato ?? '',
                            style:
                            TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                          )),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                          text: 'PKR',
                          style: TextStyle(
                              color: _amountColor,
                              fontSize: 14.0),
                        ),
                        TextSpan(
                          text: amount ?? '',
                          style: TextStyle(
                              color: _amountColor,
                              fontSize: 18.0),
                        ),
                      ])),
                    ],
                  ),
                  //
                  Container(
                    margin: EdgeInsets.only(top:10),
                    width: double.infinity,
                    height: 40.0,
                    child: TextButton(
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          if (Debounce.checkClick()) {
                            ProductCommon.saveOrderParams(widget.item);
                            _copyCustInfo();
                          }
                        },
                        child: Text(S.of(context).apply_now,
                            style: TextStyle(
                                color: Colors.white, fontSize: 16.0))),
                    // padding: EdgeInsets.only(
                    //     top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                        color: HcColors.color_02B17B,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  )
                ],
              )
            ),
          ),
        ],
      ),
    );
  }

  _copyCustInfo() async {
    try {
      if (widget.item.uglyImpressionArcticParkingPlayer == NetConfig.APP_SSID) {
        LogUtil.platformLog(optType: PointLog.CLICK_INDEX_APPLY());
        RouteUtil.push(context, Routes.basic, checkLogin: true);
        return;
      }

      Map<String, String> params = await CommonParams.addParams();
      params[Api.ogAppssid] = NetConfig.APP_SSID ;
      params[Api.appssid] = widget.item.uglyImpressionArcticParkingPlayer ?? '';
      ResultData resultData = await HttpManager.instance()
          .post(Api.copyCustInfo(), params: params);
      if (resultData.success) {
        SpUtil.put(Api.curUserId, resultData.data[Api.newUserId].toString());
        LogUtil.platformLog(optType: PointLog.CLICK_INDEX_APPLY());
        RouteUtil.push(context, Routes.basic, checkLogin: true);
      } else {
        ToastUtil.show(resultData.msg);
      }
    } catch (e) {}
  }
}
