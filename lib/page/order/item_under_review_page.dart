import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../entity/OrderItem.dart';
import '../../entity/ProductItem.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';
import '../../utils/toast.dart';
import '../../utils/money.dart';
import 'order.dart';

class OrderUnderReviewPage extends StatefulWidget {
  final OrderItem item;

  const OrderUnderReviewPage({Key? key, required this.item})
      : super(key: key);

  @override
  State<OrderUnderReviewPage> createState() => _OrderUnderReviewPageState();
}

class _OrderUnderReviewPageState extends State<OrderUnderReviewPage> {
  double? repayAmount;

  _initDate(){
    try{
      repayAmount = widget.item.interestingHeavenVocabularyEveryList;
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
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )),
            child:Row(
              children: [
                Image(image: AssetImage('images/sjx_gre.png'),
                  width: 11,height: 11,),
                SizedBox(width: 5,),
                Text(S.of(context).under_review,
                    style: TextStyle(color: HcColors.color_02B17B, fontSize: 14.0)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: HcColors.color_DCFCEF,
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
                                  S.of(context).loan_amount,
                                  style: TextStyle(
                                    color:
                                    HcColors.color_1CBC7A,
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
                                  S.of(context).date_of_application,
                                  style: TextStyle(
                                    color:
                                    HcColors.color_1CBC7A,
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
                            RouteUtil.push(context, Routes.under_review,
                                checkLogin: true);
                          }
                        },
                        child: Text(S.of(context).please_wait,
                            style: TextStyle(
                                color: HcColors.color_007D7A, fontSize: 14.0))),
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 24.0, right: 24.0),
                    decoration: BoxDecoration(
                        color: HcColors.color_D7E6E1,
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
