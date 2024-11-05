import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/res/colors.dart';

import '../../entity/OrderItem.dart';
import '../../generated/l10n.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../entity/ProductItem.dart';
import '../../utils/debounce.dart';
import 'order.dart';

class OrderFailedPage extends StatefulWidget {
  final OrderItem item;

  const OrderFailedPage({Key? key, required this.item}) : super(key: key);

  @override
  State<OrderFailedPage> createState() => _OrderFailedPageState();
}

class _OrderFailedPageState extends State<OrderFailedPage> {
  @override
  Widget build(BuildContext context) {
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
            child:Row(
              children: [
                Image(image: AssetImage('images/sjx_pur.png'),
                  width: 11,height: 11,),
                SizedBox(width: 5,),
                Text(S.of(context).loan_failed,
                    style: TextStyle(color: HcColors.color_7579E7, fontSize: 14.0)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: HcColors.color_E6E8FF,
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
                    child: Row(
                      children: [
                        Image(image: AssetImage('images/ic_reject_ts.png'),
                          width: 32,height: 32,),

                        SizedBox(width: 5,),

                        Expanded(child: Text(
                          S.of(context).order_item_failed_hint,
                          style:
                          TextStyle(fontSize: 14.0,
                              color: HcColors.color_7579E7
                          ),
                        ),),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    padding: EdgeInsets.only(
                        top: 12.0, bottom: 20.0, left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                        color: HcColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),

                  Container(
                    width: double.infinity,
                    height: 46.0,
                    child: TextButton(
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          if (Debounce.checkClick()) {
                            OrderCommon.saveOrderParams(widget.item);
                            RouteUtil.push(context, Routes.failed,
                                checkLogin: true);
                          }
                        },
                        child: Text(S.of(context).update_bank_card,
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.0))),
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 24.0, right: 24.0),
                    decoration: BoxDecoration(
                        color: HcColors.color_02B17B,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}