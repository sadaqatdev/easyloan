/// uglyImpressionArcticParkingPlayer : "13"
/// probableStandardNervousThe : 14
/// everydayEnemyHotThinking : 402935
/// submitTime : "15-04-2022 14:38:59"
/// strictSheepSomeone : "08-05-2022"
/// classicalGasSmellyRice : "2"
/// mexicanTermCartoonBlueHusband : "testlogo"
/// rectangleSelfRainbowTomato : "HomeCredit"
/// australianShoppingTin : 401587
/// hillyAmericanCoolDifference : "-"

class OrderItem {
  OrderItem({
    this.uglyImpressionArcticParkingPlayer,
    this.probableStandardNervousThe,
    this.fastPartnerRareLemonade,
    this.everydayEnemyHotThinking,
    this.submitTime,
    this.strictSheepSomeone,
    this.classicalGasSmellyRice,
    this.mexicanTermCartoonBlueHusband,
    this.japaneseInitialSafeJustice,
    this.rectangleSelfRainbowTomato,
    this.australianShoppingTin,
    this.cottonSomethingExpensiveSheetCoal,
    this.interestingHeavenVocabularyEveryList
  });

  OrderItem.fromJson(dynamic json) {
    uglyImpressionArcticParkingPlayer =
        json['uglyImpressionArcticParkingPlayer'];
    probableStandardNervousThe = json['probableStandardNervousThe'];
    fastPartnerRareLemonade = json['fastPartnerRareLemonade'];
    everydayEnemyHotThinking = json['everydayEnemyHotThinking'];
    submitTime = json['submitTime'];
    strictSheepSomeone = json['strictSheepSomeone'];
    classicalGasSmellyRice = json['classicalGasSmellyRice'];
    mexicanTermCartoonBlueHusband = json['mexicanTermCartoonBlueHusband'];
    japaneseInitialSafeJustice = json['japaneseInitialSafeJustice'];
    rectangleSelfRainbowTomato = json['rectangleSelfRainbowTomato'];
    australianShoppingTin = json['australianShoppingTin'];
    cottonSomethingExpensiveSheetCoal = json['cottonSomethingExpensiveSheetCoal'];
    interestingHeavenVocabularyEveryList = json['interestingHeavenVocabularyEveryList'];
  }

  String? uglyImpressionArcticParkingPlayer;
  int? probableStandardNervousThe;
  double? fastPartnerRareLemonade;
  double? interestingHeavenVocabularyEveryList;
  int? everydayEnemyHotThinking;
  String? submitTime;
  String? strictSheepSomeone;
  String? classicalGasSmellyRice;
  String? mexicanTermCartoonBlueHusband;
  String? japaneseInitialSafeJustice;
  String? rectangleSelfRainbowTomato;
  int? australianShoppingTin;
  int? cottonSomethingExpensiveSheetCoal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uglyImpressionArcticParkingPlayer'] =
        uglyImpressionArcticParkingPlayer;
    map['probableStandardNervousThe'] = probableStandardNervousThe;
    map['fastPartnerRareLemonade'] = fastPartnerRareLemonade;
    map['everydayEnemyHotThinking'] = everydayEnemyHotThinking;
    map['submitTime'] = submitTime;
    map['strictSheepSomeone'] = strictSheepSomeone;
    map['classicalGasSmellyRice'] = classicalGasSmellyRice;
    map['mexicanTermCartoonBlueHusband'] = mexicanTermCartoonBlueHusband;
    map['japaneseInitialSafeJustice'] = japaneseInitialSafeJustice;
    map['rectangleSelfRainbowTomato'] = rectangleSelfRainbowTomato;
    map['australianShoppingTin'] = australianShoppingTin;
    map['cottonSomethingExpensiveSheetCoal'] = cottonSomethingExpensiveSheetCoal;
    map['interestingHeavenVocabularyEveryList'] = interestingHeavenVocabularyEveryList;
    return map;
  }
}
