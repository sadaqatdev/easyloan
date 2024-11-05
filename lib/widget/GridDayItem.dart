import 'package:flutter/material.dart';
import 'package:homecredit/res/colors.dart';

import '../utils/dialog.dart';

class GridDayItem extends StatefulWidget {
  String? title;
  bool selected;
  int index;
  int selectIndex;
  Function? onTapCallback;
  int lastPosition;
  bool enable; //

  GridDayItem(
      {Key? key,
      this.title,
      this.lastPosition = 0,
      this.selected = false,
      this.index = 0,
      this.selectIndex = 0,
      this.onTapCallback,
      this.enable = true})
      : super(key: key);

  @override
  State<GridDayItem> createState() => _GridDayItemState();
}

class _GridDayItemState extends State<GridDayItem> {
  @override
  Widget build(BuildContext context) {
    String imgUrl = "";
    BoxDecoration boxDecoration = BoxDecoration();
    Color color;
    String text = "";
    Color descColor;

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
                            : HcColors.white,
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
                            : HcColors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 1,
                child: Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.center,
                    child: Text(widget.title ?? '',
                        style: TextStyle(
                          color: color,
                          fontSize: 14.0,
                        )),
                    width: double.infinity,
                    decoration: boxDecoration),
              )
            ],
          )),
      onTap: widget.enable
          ? () {
              if (widget.index == widget.selectIndex) {
                return;
              }
              widget.onTapCallback!(widget.index, widget.title);
            }
          : (){
        HDailog.showDataDialog(context);
      },
    );
  }
}
