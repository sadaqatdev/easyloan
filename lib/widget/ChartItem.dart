import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  const ChartItem(
      String this._data,
      Color this._color,
      double this.height,
      {Key? key}) : super(key: key);

  final String? _data;
  final Color? _color;
  final double? height;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 120,
      decoration: BoxDecoration(
          // color: Colors.yellow
      ),
      child: Column(
        children: [
          Container(
            width: 12.0,
            height: height,
            decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.all(Radius.circular(6.0))
            ),
          ),
          Text(
            _data!,
            style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF999999)
            ),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      ),
      alignment: Alignment(0,1),
    );
  }
}
