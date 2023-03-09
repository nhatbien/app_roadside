import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:roadside_assistance/core/helper/pref_manager.dart';
import 'package:roadside_assistance/features/data/repo_impl/map_impl.dart';
import 'package:roadside_assistance/features/data/resource/remote/goong_service.dart';
import 'package:roadside_assistance/features/domain/repository/map_repository.dart';
import 'package:roadside_assistance/features/presentation/blocs/location/location_bloc.dart';
import 'package:roadside_assistance/service/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/data/repo_impl/auth_impl.dart';
import '../features/data/resource/remote/client_api.dart';
import '../features/domain/repository/auth_repository.dart';
import '../features/presentation/blocs/auth/auth_bloc.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  injector.registerSingleton<Dio>(
    Dio()
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
      ),
  );

  injector.registerSingleton<GeolocatorPlatform>(GeolocatorPlatform.instance);
//////////////repository////////////////////
  ///
  ///
  ///
  initPrefManager();
  service();
  repository();
  bloc();
}

void initPrefManager() {
  injector.registerLazySingleton<PrefManager>(() => PrefManager(injector()));
}

void repository() {
  injector.registerSingleton<AuthRepository>(AuthImpl(
    injector(),
  ));
  injector.registerSingleton<MapRepository>(MapRepoImpl(injector()));

  /* injector.registerSingleton<OrderRepository>(OrderImpl(injector()));
  injector.registerSingleton<SettingRepository>(SettingImpl(injector()));
  injector.registerSingleton<AuthRepository>(AuthImpl(injector(), injector()));
  injector.registerSingleton<MoneyRepository>(MoneyImpl(injector()));
  injector.registerSingleton<MSWRepository>(MSWImpl(injector()));
  injector.registerSingleton<RankRepository>(RankImpl(injector()));

  injector.registerSingleton<DeviceLocationRepository>(DeviceLocationImpl());
  injector.registerSingleton<ShipperDiligenceRepository>(
      ShipperDiligenceImpl(injector())); */
}

void service() {
  injector.registerSingleton<LocationService>(LocationService(injector()));
  injector.registerSingleton<GoongService>(GoongService(injector()));

  injector.registerSingleton<AppHttpClient>(ClientDio(
    injector(),
  ));

  injector.registerSingleton<ClientDio>(ClientDio(
    injector(),
  ));
  /*  injector.registerSingleton<OrderService>(OrderService(injector()));
  injector.registerSingleton<RankService>(RankService(injector()));
  injector.registerSingleton<AuthService>(AuthService(injector()));
  injector.registerSingleton<MoneyService>(MoneyService(injector()));
  injector.registerSingleton<SettingService>(SettingService(injector()));
  injector.registerSingleton<MSWService>(MSWService(injector()));
  injector.registerSingleton<ShipperDiligenceService>(
      ShipperDiligenceService(injector())); */
}

void bloc() {
  injector.registerFactory<LocationBloc>(
    () => LocationBloc(
      injector(),
      injector(),
    ),
  );
  injector.registerFactory<AuthBloc>(
    () => AuthBloc(injector()),
  );
}
