// ignore_for_file: public_member_api_docs

class CurrentUserLocationEntity {
  const CurrentUserLocationEntity({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;

  static const empty = CurrentUserLocationEntity(latitude: 0, longitude: 0);
}
