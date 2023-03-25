class UpdateLocationRequest {
  final double lat;
  final double lng;

  UpdateLocationRequest({required this.lat, required this.lng});

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}
