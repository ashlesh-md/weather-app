getImage(String data) {
  if (data.toLowerCase().contains('night')) {
    return 'assets/climates/icon_clear_night.png';
  } else if (data.toLowerCase().contains('mostly') &&
      data.toLowerCase().contains('cloudy')) {
    return 'assets/climates/icon_mostly_cloudy_big.png';
  } else if (data.toLowerCase().contains('mostly') &&
      data.toLowerCase().contains('partially')) {
    return 'assets/climates/icon_partially_cloudy_big.png';
  } else if (data.toLowerCase().contains('mostly') &&
      data.toLowerCase().contains('partially')) {
    return 'assets/climates/icon_partially_cloudy_big.png';
  } else if (data.toLowerCase().contains('mostly') &&
      data.toLowerCase().contains('partially')) {
    return 'assets/climates/icon_partially_cloudy_big.png';
  } else if (data.toLowerCase().contains('rain') &&
      data.toLowerCase().contains('big')) {
    return 'assets/climates/icon_rain_big.png';
  } else {
    return 'assets/climates/icon_thunderstorm_big.png';
  }
}
