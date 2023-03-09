import 'package:latlong2/latlong.dart';

import '../../../core/resource/datastate.dart';
import '../../data/model/directions_model.dart';
import '../../data/model/geocoding_model.dart';
import '../../data/model/goong_auto_complete_model.dart';
import '../../data/model/place_detail_model.dart';

abstract class MapRepository {
  Future<DataState<AutoCompleteGoong>> getAutoComplete(
      String searchText, LatLng location);
  Future<DataState<ReverseGeocodingModel>> getAddressFromLatLn(LatLng latln);
  Future<DataState<PlaceDetailModel>> getPlaceDetailById(String placeId);
  Future<DataState<DirectionsModel>> getDirection(
      String origin, String destination, String vehicle);
}
