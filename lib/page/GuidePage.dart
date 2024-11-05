import 'package:flutter/material.dart';
import 'package:homecredit/arch/net/config.dart';
import 'package:homecredit/generated/l10n.dart';
import 'package:homecredit/res/colors.dart';
import 'package:homecredit/routes/route_util.dart';
import 'package:homecredit/utils/toast.dart';

import '../routes/routes.dart';
import '../utils/sp.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage>
    with SingleTickerProviderStateMixin {

  late PageController _pageController;
  bool isVisible = true;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    
    SpUtil.getBool(NetConfig.GUIDE).then((value) {
      if(value){
        RouteUtil.push(context, Routes.index,clearStack: true);
        return;
      }
    });

    _pageController = new PageController();
    _tabController = new TabController(initialIndex: 0, length: 3, vsync: this);
    _tabController?.addListener(() {
      if (_tabController?.index == 2) {
        setState(() {
          isVisible = false;
        });
      } else {
        setState(() {
          isVisible = true;
        });
      }
    });
  }

  final List<Widget> listImage = [
    Image.asset(
      "images/guide_a.png",
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    ),
    Image.asset(
      "images/guide_b.png",
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    ),
    Image.asset(
      "images/guide_c.png",
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _tabController,
            children: [
              Stack(
                children: [
                  Container(
                    child: listImage[0],
                    decoration: BoxDecoration(
                        color: HcColors.color_02B17B
                    ),
                  ),

                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 80),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image(image: AssetImage('images/guide_a_0.png'),
                            width: 299,height: 32,)
                      ),
                    ),
                    onTap: (){
                      try {
                        _tabController?.animateTo(1);
                      }catch(e){}
                    },
                  ),

                ],
              ),

              Stack(
                children: [
                  Container(
                    child: listImage[1],
                    decoration: BoxDecoration(
                        color: HcColors.color_02B17B
                    ),
                  ),
                  InkWell(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 80),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image(image: AssetImage('images/guide_b_0.png'),
                            width: 299,height: 32,)
                      ),
                    ),
                    onTap: (){
                      try {
                        _tabController?.animateTo(2);
                      }catch(e){}
                    },
                  ),

                ],
              ),

              Stack(
                children: [
                  Container(
                    child: listImage[2],
                    decoration: BoxDecoration(
                        color: HcColors.color_02B17B
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 80),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                            children: [

                              InkWell(
                                onTap: () {
                                   SpUtil.put(NetConfig.GUIDE, true);
                                   RouteUtil.push(context, Routes.index,clearStack: true);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 23,right: 23,bottom: 30),
                                  padding: EdgeInsets.only(top:7,bottom: 7),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: HcColors.color_02B17B,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(S.of(context).apply_now,
                                    style: TextStyle(
                                      color: HcColors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),

                              Image(image: AssetImage('images/guide_c_0.png'),
                                width: 299,height: 32,)
                            ],
                          mainAxisAlignment: MainAxisAlignment.end,
                        ),
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.yellow
                    ),
                  ),

                ],
              ),
            ],
          ),
          // Visibility(
          //     visible: isVisible,
          //     child: Container(
          //       margin: EdgeInsets.only(bottom: 40),
          //       child: Align(
          //         alignment: Alignment.bottomCenter,
          //         child: TabPageSelector(
          //           controller: _tabController,
          //           selectedColor: Colors.amberAccent,
          //           indicatorSize: 17,
          //           color: Colors.black12,
          //         ),
          //       ),
          //     ))
        ],
      ),
    );
  }
}
