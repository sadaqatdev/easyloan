/// mexicanTermCartoonBlueHusband : "http://192.168.20.201:9996/static/miniloan01.png"
/// popularEmpireTortoiseUnfortunateLab : "https://www.csdn.net/?spm=1001.2101.3001.4476"
/// rectangleSelfRainbowTomato : "LoanClub"

class VipProduct {
  VipProduct({
      this.mexicanTermCartoonBlueHusband, 
      this.popularEmpireTortoiseUnfortunateLab, 
      this.rectangleSelfRainbowTomato,});

  VipProduct.fromJson(dynamic json) {
    mexicanTermCartoonBlueHusband = json['mexicanTermCartoonBlueHusband'];
    popularEmpireTortoiseUnfortunateLab = json['popularEmpireTortoiseUnfortunateLab'];
    rectangleSelfRainbowTomato = json['rectangleSelfRainbowTomato'];
  }
  String? mexicanTermCartoonBlueHusband;
  String? popularEmpireTortoiseUnfortunateLab;
  String? rectangleSelfRainbowTomato;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mexicanTermCartoonBlueHusband'] = mexicanTermCartoonBlueHusband;
    map['popularEmpireTortoiseUnfortunateLab'] = popularEmpireTortoiseUnfortunateLab;
    map['rectangleSelfRainbowTomato'] = rectangleSelfRainbowTomato;
    return map;
  }

}