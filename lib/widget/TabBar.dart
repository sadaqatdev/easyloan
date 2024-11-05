import 'package:flutter/material.dart';
import 'package:homecredit/page/HomePage.dart';
import 'package:homecredit/page/MinePage.dart';
import 'package:homecredit/page/OrderPage.dart';
import 'package:homecredit/res/colors.dart';
import 'package:homecredit/routes/route_util.dart';
import 'package:homecredit/routes/routes.dart';

import '../arch/api/api.dart';
import '../page/status/first_page.dart';
import '../page/status/main_page.dart';
import '../utils/sp.dart';

class HCTabbar extends StatefulWidget {
  HCTabbar({Key? key}) : super(key: key);

  @override
  _HCTabbarState createState() => _HCTabbarState();
}

class _HCTabbarState extends State<HCTabbar> {
  int currentIndex = 0;
  final pages = [
    HomePage(),
    OrderPage(),
    MinePage()
  ];

  List normalImgUrls = [
    "images/ic_home_nor.png",
    "images/ic_list_nor.png",
    "images/ic_mine_nor.png"
  ];
  List selectedImgUrls = [
    "images/ic_home_sel.png",
    "images/ic_list_sel.png",
    "images/ic_mine_sel.png"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: Container(
          height: 52.0,
          child: Row(
            children: <Widget>[
              Expanded(child: tabbar(0, 47.0, 16.0)),
              Expanded(child: tabbar(1, 40.0, 16.0)),
              Expanded(child: tabbar(2, 65.0, 16.0))
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 0.5, //
                  spreadRadius: 0.5, //
                  color: Colors.grey, //
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
        ),
        // color: HcColors.color_DBF2EB,
      ),
      body: pages[currentIndex],
      backgroundColor: HcColors.white,
    );
  }

  // tabbaritem
  Widget tabbar(int index, double width, double height) {
    Color color = Colors.white;
    //
    String imgUrl = normalImgUrls[index];
    if (currentIndex == index) {
      //
      imgUrl = selectedImgUrls[index];
      color = HcColors.color_DBF2EB;
    }

    //Widget
    Widget item = Container(
      // color: color,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(left: 20.0, right: 20.0, top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(14.5))),
              child: Image(
                  image: AssetImage(imgUrl), width: width, height: height),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        onTap: () async {

          if (currentIndex != index) {
            if(index == 1 || index == 2){
              String token = await SpUtil.getString(Api.token,"");
              if(token.isEmpty){
                RouteUtil.push(context, Routes.login);
                return;
              }
            }
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
    return item;
  }
}
