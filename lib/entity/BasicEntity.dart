class BasicEntity {
  String? primaryVcdJourneyBritain;
  String? suchTonightLamb;
  String? smellySignatureDriving;
  String? rightBeautyGreetingGuiltyPassage;
  String? hardworkingSmoothPlainStadium;
  String? russianCaptainLoudStream;
  String? mercifulNeitherTechnologyBookcase;
  String? youngBeltLadyHillside;
  String? dizzyTokyoBroadIncidentAbovePlayer;
  String? splendidAshamedGrammar;
  String? coldNearCoolBookstore;
  String? loudDecisionFreshBlouse;
  String? luckyCrossNovelist;

  BasicEntity(
      {this.primaryVcdJourneyBritain,
        this.suchTonightLamb,
        this.smellySignatureDriving,
        this.rightBeautyGreetingGuiltyPassage,
        this.hardworkingSmoothPlainStadium,
        this.russianCaptainLoudStream,
        this.mercifulNeitherTechnologyBookcase,
        this.youngBeltLadyHillside,
        this.dizzyTokyoBroadIncidentAbovePlayer,
        this.splendidAshamedGrammar,
        this.coldNearCoolBookstore,
        this.loudDecisionFreshBlouse,
        this.luckyCrossNovelist});

  BasicEntity.fromJson(Map<String, dynamic> json) {
    primaryVcdJourneyBritain = json['primaryVcdJourneyBritain'];
    suchTonightLamb = json['suchTonightLamb'];
    smellySignatureDriving = json['smellySignatureDriving'];
    rightBeautyGreetingGuiltyPassage = json['rightBeautyGreetingGuiltyPassage'];
    hardworkingSmoothPlainStadium = json['hardworkingSmoothPlainStadium'];
    russianCaptainLoudStream = json['russianCaptainLoudStream'];
    mercifulNeitherTechnologyBookcase =
    json['mercifulNeitherTechnologyBookcase'];
    youngBeltLadyHillside = json['youngBeltLadyHillside'];
    dizzyTokyoBroadIncidentAbovePlayer =
    json['dizzyTokyoBroadIncidentAbovePlayer'];
    splendidAshamedGrammar = json['splendidAshamedGrammar'];
    coldNearCoolBookstore = json['coldNearCoolBookstore'];
    loudDecisionFreshBlouse = json['loudDecisionFreshBlouse'];
    luckyCrossNovelist = json['luckyCrossNovelist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primaryVcdJourneyBritain'] = this.primaryVcdJourneyBritain;
    data['suchTonightLamb'] = this.suchTonightLamb;
    data['smellySignatureDriving'] = this.smellySignatureDriving;
    data['rightBeautyGreetingGuiltyPassage'] =
        this.rightBeautyGreetingGuiltyPassage;
    data['hardworkingSmoothPlainStadium'] = this.hardworkingSmoothPlainStadium;
    data['russianCaptainLoudStream'] = this.russianCaptainLoudStream;
    data['mercifulNeitherTechnologyBookcase'] =
        this.mercifulNeitherTechnologyBookcase;
    data['youngBeltLadyHillside'] = this.youngBeltLadyHillside;
    data['dizzyTokyoBroadIncidentAbovePlayer'] =
        this.dizzyTokyoBroadIncidentAbovePlayer;
    data['splendidAshamedGrammar'] = this.splendidAshamedGrammar;
    data['coldNearCoolBookstore'] = this.coldNearCoolBookstore;
    data['loudDecisionFreshBlouse'] = this.loudDecisionFreshBlouse;
    data['luckyCrossNovelist'] = this.luckyCrossNovelist;
    return data;
  }
}
