class RegionEntity {
  String? hardworkingSuccessfulPleasureScholar;
  int? holyMonumentPlainTailorTrip;
  int? undividedEffortAnxiousSalesgirlStory;
  int? chemicalManagerBank;

  RegionEntity(
      {this.hardworkingSuccessfulPleasureScholar,
        this.holyMonumentPlainTailorTrip,
        this.undividedEffortAnxiousSalesgirlStory,
        this.chemicalManagerBank});

  RegionEntity.fromJson(Map<String, dynamic> json) {
    hardworkingSuccessfulPleasureScholar =
    json['hardworkingSuccessfulPleasureScholar'];
    holyMonumentPlainTailorTrip = json['holyMonumentPlainTailorTrip'];
    undividedEffortAnxiousSalesgirlStory =
    json['undividedEffortAnxiousSalesgirlStory'];
    chemicalManagerBank = json['chemicalManagerBank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hardworkingSuccessfulPleasureScholar'] =
        this.hardworkingSuccessfulPleasureScholar;
    data['holyMonumentPlainTailorTrip'] = this.holyMonumentPlainTailorTrip;
    data['undividedEffortAnxiousSalesgirlStory'] =
        this.undividedEffortAnxiousSalesgirlStory;
    data['chemicalManagerBank'] = this.chemicalManagerBank;
    return data;
  }
}