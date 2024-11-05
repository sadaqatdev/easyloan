import 'package:flutter/material.dart';
import 'package:homecredit/res/colors.dart';

import '../generated/l10n.dart';
import '../utils/dialog.dart';

class GridViewItem extends StatefulWidget {
  String? title;
  bool selected;
  int index;
  int selectIndex;
  Function? onTapCallback;
  String? stepMoney;
  int lastPosition;
  bool enable;
  bool isSingle;

  GridViewItem(
      {Key? key,
      this.stepMoney,
      this.title,
      this.selected = false,
      this.enable = false,
        this.isSingle = false,
      this.index = 0,
      this.selectIndex = 0,
      this.lastPosition = 0,
      this.onTapCallback})
      : super(key: key);

  @override
  State<GridViewItem> createState() => _GridViewItemState();
}

class _GridViewItemState extends State<GridViewItem> {
  @override
  Widget build(BuildContext context) {
    String imgUrl = "";
    BoxDecoration boxDecoration = BoxDecoration();
    Color color;
    Color descColor;
    bool isShow = false;

    if(widget.index == 0 || (!widget.enable)){
      isShow = true;
      if(widget.index == 0 && widget.isSingle){
        isShow = false;
      }
    }


    if (widget.enable) {
      if (widget.selected) {
        imgUrl = "images/ic_item_sel.png";
        color = HcColors.white;
        descColor = HcColors.white;
        boxDecoration = BoxDecoration(
            color: HcColors.color_02B17B,
            borderRadius: BorderRadius.all(Radius.circular(8.0)));
      } else {
        imgUrl = "images/ic_item_nor.png";
        color = HcColors.color_02B17B;
        descColor = HcColors.color_02B17B;
        boxDecoration = BoxDecoration(
            color: HcColors.white,
            border: Border.all(width: 1, color: HcColors.color_02B17B),
            borderRadius: BorderRadius.all(Radius.circular(8.0)));
      }
    } else {
      imgUrl = "images/ic_item_lock.png";
      color = HcColors.white;
      descColor = HcColors.white;
      boxDecoration = BoxDecoration(
          color: HcColors.color_D5D5D5,
          borderRadius: BorderRadius.all(Radius.circular(8.0)));
    }

    return InkWell(
      child: Container(
        padding: EdgeInsets.only(right: 8),
        height: 60,
        child: Row(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 3,
                    decoration: BoxDecoration(
                      color: widget.index == 0
                          ? HcColors.color_000000
                          : HcColors.color_DBF2EB,
                    ),
                  ),
                ),
                Image(
                  width: 25,
                  height: 25,
                  image: AssetImage(imgUrl),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: 3,
                    decoration: BoxDecoration(
                      color: widget.index == widget.lastPosition
                          ? HcColors.color_000000
                          : HcColors.color_DBF2EB,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text('PKR',
                          style: TextStyle(
                              color: color,
                              fontSize: 16.0)),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(widget.title ?? '',
                          style: TextStyle(
                              color: color,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500)),
                      Spacer(),
                      Visibility(
                          visible: isShow,
                          child: Row(
                            children: [
                              Text( widget.index == 0 ? S.of(context).successful_withdrawal : S.of(context).item_next_loan,
                                  style: TextStyle(
                                      color: descColor,
                                      fontSize: 10.0)),
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                width: 36,
                                height: 40,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    Text("+PKR",
                                        style: TextStyle(
                                            color: HcColors.white,
                                            fontSize: 10.0)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(widget.stepMoney ?? '',
                                        style: TextStyle(
                                            color: HcColors.white,
                                            fontSize: 10.0)),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: widget.index == 0 ? AssetImage('images/redb_a.png') : AssetImage('images/redb_b.png'),
                                    fit: BoxFit.fill, // 
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                    // mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  width: double.infinity,
                  height: 50,
                  decoration: boxDecoration,
                ))
          ],
        ),
      ),
      onTap: widget.enable
          ? () {
              if (widget.index == widget.selectIndex) {
                return;
              }
              widget.onTapCallback!(widget.index, widget.title);
            }
          : () {
        HDailog.showDataDialog(context);
      },
    );
  }
}
