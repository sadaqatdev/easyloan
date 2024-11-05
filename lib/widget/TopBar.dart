import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      // color: ,
      child: Row(
        children: [
          Image(
            image: AssetImage('images/ic_logo_small.png'),
            width: 31.0,
            height: 31.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
              child: Text(
                S.of(context).app_name,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              ),
          )),
          Image(
              image: AssetImage('images/ic_kefu.png'),
              width: 31.0,
              height: 31.0),
        ],
      ),
    );
  }
}
