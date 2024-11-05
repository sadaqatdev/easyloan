
import 'package:flutter/cupertino.dart';

class ClickableModel extends ChangeNotifier {
  final List<TextEditingController> _textEditingController;
  bool _canClick = false;

  bool get isClickable => _canClick;

  ClickableModel(this._textEditingController) {
    _textEditingController.map((e) {
      e.addListener(() {
        var strList = [];
        for (var item in _textEditingController) {
          strList.add(item.text.toString());
        }
        _canClick = strList.contains('') ? false : true;
        //
        notifyListeners();
      });
    }).toList();
  }
}

