import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homecredit/page/product/product.dart';
import 'package:homecredit/res/colors.dart';

import '../../generated/l10n.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../entity/ProductItem.dart';
import '../../utils/debounce.dart';

class ProductFailedPage extends StatefulWidget {
  final ProductItem item;

  const ProductFailedPage({Key? key, required this.item}) : super(key: key);

  @override
  State<ProductFailedPage> createState() => _ProductFailedPageState();
}

class _ProductFailedPageState extends State<ProductFailedPage> {
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
            child:
            Row(
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
                            RouteUtil.push(context, Routes.failed,
                                checkLogin: true);
                          }
                        },
                        child: Text(S.of(context).update,
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
