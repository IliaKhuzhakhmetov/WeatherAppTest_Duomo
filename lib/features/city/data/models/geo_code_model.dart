class GeoCodeModel {
  final double latitude;
  final double longitude;

  const GeoCodeModel({required this.latitude, required this.longitude});

  factory GeoCodeModel.fromMap(Map<String, dynamic> map) {
    return GeoCodeModel(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }
}
