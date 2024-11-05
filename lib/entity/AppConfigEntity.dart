
class AppConfigEntity {
  String? personalProperHallPark;
  String? mobileFistLowJuly;

  AppConfigEntity({this.personalProperHallPark, this.mobileFistLowJuly});

  AppConfigEntity.fromJson(Map<String, dynamic> json) {
    personalProperHallPark = json['personalProperHallPark'];
    mobileFistLowJuly = json['mobileFistLowJuly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personalProperHallPark'] = this.personalProperHallPark;
    data['mobileFistLowJuly'] = this.mobileFistLowJuly;
    return data;
  }
}


