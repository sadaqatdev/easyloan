import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../res/colors.dart';
import '../../routes/route_util.dart';
import '../../routes/routes.dart';
import '../../entity/ProductItem.dart';
import '../../utils/debounce.dart';

class DefaultLoanablePage extends StatefulWidget {
  const DefaultLoanablePage({Key? key}) : super(key: key);

  @override
  State<DefaultLoanablePage> createState() => _DefaultLoanablePageState();
}

class _DefaultLoanablePageState extends State<DefaultLoanablePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15.0),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.all(Radius.circular(15.0))),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 20.0),
              child: Row(
                children: [
                  Image(
                    image:
                    AssetImage('images/ic_logo_small.png'),
                    width: 27.0,
                    height: 27.0,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                      child: Text(
                        S.of(context).app_name,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                    // width: 120.0,
                    // height: 45.0,
                    child: TextButton(
                        style: ButtonStyle(
                          tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          minimumSize:
                          MaterialStateProperty.all(
                              Size(0, 0)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.zero),
                        ),
                        onPressed: () {
                          if(Debounce.checkClick()) {
                            RouteUtil.push(context, Routes.basic,
                                checkLogin: true);
                          }
                        },
                        child: Text(
                            S.of(context).apply_now,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0))),
                    padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: 12.0,
                        right: 12.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFFF5545),
                        borderRadius: BorderRadius.all(
                            Radius.circular(15.0))),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 286.0,
            height: 30.0,
            decoration: BoxDecoration(
                color: HcColors.color_02B17B,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                )),
            child: Text(
                S.of(context).loanable,
                style: TextStyle(
                    color: Colors.white, fontSize: 14.0)),
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
