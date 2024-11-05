class BankCard {
  BankCard({
      this.saltyFact, 
      this.convenientBoxPreciousStraightAntique, 
      this.possibleHairHopelessGet, 
      this.theseYoungPower, 
      this.expensiveCuriousPrimaryVariety, 
      this.rudeUnableSayingCrossPosition,});

  BankCard.fromJson(dynamic json) {
    saltyFact = json['saltyFact'];
    convenientBoxPreciousStraightAntique = json['convenientBoxPreciousStraightAntique'];
    possibleHairHopelessGet = json['possibleHairHopelessGet'];
    theseYoungPower = json['theseYoungPower'];
    expensiveCuriousPrimaryVariety = json['expensiveCuriousPrimaryVariety'];
    rudeUnableSayingCrossPosition = json['rudeUnableSayingCrossPosition'];
  }
  String? saltyFact;
  String? convenientBoxPreciousStraightAntique;
  String? possibleHairHopelessGet;
  String? theseYoungPower;
  String? expensiveCuriousPrimaryVariety;
  String? rudeUnableSayingCrossPosition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['saltyFact'] = saltyFact;
    map['convenientBoxPreciousStraightAntique'] = convenientBoxPreciousStraightAntique;
    map['possibleHairHopelessGet'] = possibleHairHopelessGet;
    map['theseYoungPower'] = theseYoungPower;
    map['expensiveCuriousPrimaryVariety'] = expensiveCuriousPrimaryVariety;
    map['rudeUnableSayingCrossPosition'] = rudeUnableSayingCrossPosition;
    return map;
  }

}