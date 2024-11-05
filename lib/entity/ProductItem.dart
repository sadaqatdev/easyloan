/// uglyImpressionArcticParkingPlayer : "13"
/// probableStandardNervousThe : 7
/// everydayEnemyHotThinking : 402935
/// classicalGasSmellyRice : "3"
/// mexicanTermCartoonBlueHusband : "testlogo"
/// rectangleSelfRainbowTomato : "HomeCredit"
/// australianShoppingTin : 401587

class ProductItem {
  ProductItem({
      this.uglyImpressionArcticParkingPlayer, 
      this.probableStandardNervousThe, 
      this.everydayEnemyHotThinking, 
      this.classicalGasSmellyRice, 
      this.mexicanTermCartoonBlueHusband, 
      this.rectangleSelfRainbowTomato, 
      this.australianShoppingTin,
      this.blueTinNervousThe,
      this.everyListBlueTermThe,
  });

  ProductItem.fromJson(dynamic json) {
    uglyImpressionArcticParkingPlayer = json['uglyImpressionArcticParkingPlayer'];
    probableStandardNervousThe = json['probableStandardNervousThe'];
    everydayEnemyHotThinking = json['everydayEnemyHotThinking'];
    classicalGasSmellyRice = json['classicalGasSmellyRice'];
    mexicanTermCartoonBlueHusband = json['mexicanTermCartoonBlueHusband'];
    rectangleSelfRainbowTomato = json['rectangleSelfRainbowTomato'];
    australianShoppingTin = json['australianShoppingTin'];
    blueTinNervousThe = json['blueTinNervousThe'];
    everyListBlueTermThe = json['everyListBlueTermThe'];
  }
  String? uglyImpressionArcticParkingPlayer;
  int? probableStandardNervousThe;
  int? everydayEnemyHotThinking;
  String? classicalGasSmellyRice;
  String? mexicanTermCartoonBlueHusband;
  String? rectangleSelfRainbowTomato;
  int? australianShoppingTin;
  String? blueTinNervousThe;
  String? everyListBlueTermThe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uglyImpressionArcticParkingPlayer'] = uglyImpressionArcticParkingPlayer;
    map['probableStandardNervousThe'] = probableStandardNervousThe;
    map['everydayEnemyHotThinking'] = everydayEnemyHotThinking;
    map['classicalGasSmellyRice'] = classicalGasSmellyRice;
    map['mexicanTermCartoonBlueHusband'] = mexicanTermCartoonBlueHusband;
    map['rectangleSelfRainbowTomato'] = rectangleSelfRainbowTomato;
    map['australianShoppingTin'] = australianShoppingTin;
    map['blueTinNervousThe'] = blueTinNervousThe;
    map['everyListBlueTermThe'] = everyListBlueTermThe;
    return map;
  }

}