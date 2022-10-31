class SearchAutoGenerate {
  String? name;
  String? region;
  String? country;

  SearchAutoGenerate({
    this.name,
    this.region,
    this.country,
  });

  SearchAutoGenerate.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['name'] = name;
    data['region'] = region;
    data['country'] = country;

    return data;
  }
}
