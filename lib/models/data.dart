class DataModel {
  String? place;
  String? state;
  String? description;
  String? temperature;
  String? tempMinimum;
  String? tempMaximum;
  String? humidity;
  String? feelsLike;

  DataModel(
      {this.place,
      this.state,
      this.description,
      this.temperature,
      this.tempMinimum,
      this.tempMaximum,
      this.humidity,
      this.feelsLike});

  DataModel.fromJson(Map<String, dynamic> json) {
    place = json['place'].toString();
    state = json['state'].toString();
    description = json['description'].toString();
    temperature = json['temperature'].toString();
    tempMinimum = json['tempMinimum'].toString();
    tempMaximum = json['tempMaximum'].toString();
    humidity = json['humidity'].toString();
    feelsLike = json['feelsLike'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place'] = this.place;
    data['state'] = this.state;
    data['description'] = this.description;
    data['temperature'] = this.temperature;
    data['tempMinimum'] = this.tempMinimum;
    data['tempMaximum'] = this.tempMaximum;
    data['humidity'] = this.humidity;
    data['feelsLike'] = this.feelsLike;
    return data;
  }
}
