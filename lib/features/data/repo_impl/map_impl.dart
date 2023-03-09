import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import '../../../core/resource/datastate.dart';
import '../../domain/repository/map_repository.dart';
import '../model/directions_model.dart';
import '../model/geocoding_model.dart';
import '../model/goong_auto_complete_model.dart';
import '../model/place_detail_model.dart';
import '../resource/remote/goong_service.dart';

class MapRepoImpl implements MapRepository {
  // final GoogleService _googleService;
  final GoongService _goongService;

  MapRepoImpl(this._goongService);

  @override
  Future<DataState<AutoCompleteGoong>> getAutoComplete(
      String searchText, LatLng location) async {
    try {
      final httpResponse = await _goongService.getAutocomplete(
          "hhTstgFQTkJhwqmcNggaq2uaswz1370PsKuP1cke",
          searchText,
          '${location.latitude},${location.longitude}');
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioError catch (e) {
      print(e.response);
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<PlaceDetailModel>> getPlaceDetailById(String placeId) async {
    final httpResponse = await _goongService.getPlaceDetailById(
        "hhTstgFQTkJhwqmcNggaq2uaswz1370PsKuP1cke", placeId);
    try {
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<DirectionsModel>> getDirection(
      String origin, String destination, String vehicle) async {
    final httpResponse = await _goongService.getDirection(
        "hhTstgFQTkJhwqmcNggaq2uaswz1370PsKuP1cke", origin, destination, "car");
    try {
      var logger = Logger();
      logger.v(httpResponse.response.realUri);
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(httpResponse.data);
      }
      return DataFailed(
        DioError(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<ReverseGeocodingModel>> getAddressFromLatLn(
      LatLng latln) async {
    print('${latln.latitude},${latln.longitude}');

    /*  try { */
    final url = Uri.encodeFull(
        "${latln.latitude.toString()},${latln.longitude.toString()}");
    final httpResponse = await _goongService.getAddressFromLatLn(
      "hhTstgFQTkJhwqmcNggaq2uaswz1370PsKuP1cke",
      url,
    );

    if (httpResponse.response.statusCode == 200) {
      return DataSuccess(httpResponse.data);
    }
    return DataFailed(
      DioError(
        error: httpResponse.response.statusMessage,
        response: httpResponse.response,
        requestOptions: httpResponse.response.requestOptions,
      ),
    );
    /*  } on DioError catch (e) {
      print(e.response);
      return DataFailed(e);
    } */
  }
}
