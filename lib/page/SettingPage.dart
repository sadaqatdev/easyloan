import 'package:flutter/material.dart';
import 'package:homecredit/res/colors.dart';
import '../generated/l10n.dart';
import '../widget/SubTopBar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubTopBar(S.of(context).change_language_hori),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: HcColors.color_DBF2EB),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
              child: Row(
                children: [
                  Image(
                    image: AssetImage('images/ic_lan.png'),
                    width: 31,
                    height: 31,
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                      child: Text(
                    S.of(context).change_language_hori,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  )),
                  Container(
                    child: TextButton(
                        style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: MaterialStateProperty.all(Size(0, 0)),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {},
                        child: Text(S.of(context).english,
                            style: TextStyle(
                                color: Colors.white, fontSize: 14.0))),
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 12.0, right: 12.0),
                    decoration: BoxDecoration(
                        color: Color(0xFFFF5545),
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: HcColors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: HcColors.white,
              ),
            ))
          ],
        ),
      ),
    );
  }
}
