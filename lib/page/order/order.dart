
import 'package:homecredit/entity/OrderItem.dart';

import '../../arch/api/api.dart';
import '../../utils/sp.dart';

class OrderCommon{

  static saveOrderParams(OrderItem item){
    try {
      SpUtil.put(Api.appName, item.rectangleSelfRainbowTomato.toString());
      SpUtil.put(Api.logoUrl, item.mexicanTermCartoonBlueHusband.toString());
      SpUtil.put(Api.curUserId, item.everydayEnemyHotThinking.toString());
      SpUtil.put(Api.appSsid, item.uglyImpressionArcticParkingPlayer.toString());
      SpUtil.put(Api.orderId, item.australianShoppingTin.toString());
    }catch(e){ }
  }
}