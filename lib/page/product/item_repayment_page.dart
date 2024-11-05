import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/page/product/product.dart';
import '../../arch/api/api.dart';
import '../../entity/ProductItem.dart';
import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../utils/debounce.dart';

class ProductRepaymentPage extends StatefulWidget {
  final ProductItem item;

  const ProductRepaymentPage({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductRepaymentPage> createState() => _ProductRepaymentPageState();
}

class _ProductRepaymentPageState extends State<ProductRepaymentPage> {
  @override
  Widget build(BuildContext context) {
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
            child: Row(
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
                  top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Row(
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
                  Expanded(
                      child: Text(
                    widget.item.rectangleSelfRainbowTomato ?? '',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )),
                  Container(
                    // width: 120.0,
                    // height: 45.0,
                    child: TextButton(
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          if (Debounce.checkClick()) {
                            ProductCommon.saveOrderParams(widget.item);
                            String extendDuration = widget.item.probableStandardNervousThe
                                .toString();
                            Map<String, dynamic> map = {
                              Api.extendDuration: extendDuration
                            };
                            RouteUtil.push(context, Routes.repayment,
                                checkLogin: true, params: map);
                          }
                        },
                        child: Text(S.of(context).repay,
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.0))),
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                        color: HcColors.color_02B17B,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
