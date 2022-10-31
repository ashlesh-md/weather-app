class FavouriteRecentSearchData {
  List<String>? favorites;
  List<String>? recentSearch;

  FavouriteRecentSearchData({this.favorites, this.recentSearch});

  FavouriteRecentSearchData.fromJson(Map<String, dynamic> json) {
    favorites = json['favorites'].cast<String>();
    recentSearch = json['recent_search'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['favorites'] = this.favorites;
    data['recent_search'] = this.recentSearch;
    return data;
  }
}
