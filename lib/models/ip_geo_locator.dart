class IPGeoLocator {
  String? country;
  String? state;
  String? timezone;
  String? date;
  String? dateTime;
  String? dateTimeTxt;
  String? dateTimeWti;

  IPGeoLocator(
      {this.country,
      this.state,
      this.timezone,
      this.date,
      this.dateTime,
      this.dateTimeTxt,
      this.dateTimeWti});

  IPGeoLocator.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    timezone = json['timezone'];
    date = json['date'];
    dateTime = json['date_time'];
    dateTimeTxt = json['date_time_txt'];
    dateTimeWti = json['date_time_wti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['timezone'] = this.timezone;
    data['date'] = this.date;
    data['date_time'] = this.dateTime;
    data['date_time_txt'] = this.dateTimeTxt;
    data['date_time_wti'] = this.dateTimeWti;
    return data;
  }
}
