
import 'package:homecredit/entity/ProductItem.dart';
import '../../arch/api/api.dart';
import '../../utils/sp.dart';

class ProductCommon{

  static saveOrderParams(ProductItem item){
    try {
      SpUtil.put(Api.orderId, item.australianShoppingTin.toString());
      SpUtil.put(Api.appName, item.rectangleSelfRainbowTomato.toString());
      SpUtil.put(Api.logoUrl, item.mexicanTermCartoonBlueHusband.toString());
      SpUtil.put(Api.appSsid, item.uglyImpressionArcticParkingPlayer.toString());
      SpUtil.put(Api.curUserId, item.everydayEnemyHotThinking.toString());
    }catch(e){}
  }
}