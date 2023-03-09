import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

import '../../model/directions_model.dart';
import '../../model/geocoding_model.dart';
import '../../model/goong_auto_complete_model.dart';
import '../../model/place_detail_model.dart';

part 'goong_service.g.dart';

@RestApi(baseUrl: 'https://rsapi.goong.io')
abstract class GoongService {
  factory GoongService(Dio dio, {String baseUrl}) = _GoongService;

  @GET("/Place/AutoComplete")
  Future<HttpResponse<AutoCompleteGoong>> getAutocomplete(
    @Query("api_key") String key,
    @Query("input") String input,
    @Query("location") String location,
  );

  @GET("/Place/Detail")
  Future<HttpResponse<PlaceDetailModel>> getPlaceDetailById(
    @Query("api_key") String key,
    @Query("place_id") String placeId,
  );

  @GET("/Geocode")
  @Headers(
      <String, dynamic>{"Content-Type": "application/json", 'Charset': 'utf-8'})
  Future<HttpResponse<ReverseGeocodingModel>> getAddressFromLatLn(
    @Query("api_key") String key,
    @Query("latlng") String input,
  );

  @GET("/Direction")
  Future<HttpResponse<DirectionsModel>> getDirection(
    @Query("api_key") String key,
    @Query("origin") String origin,
    @Query("destination") String destination,
    @Query("vehicle") String vehicle,
  );
}
