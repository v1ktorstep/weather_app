import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/features/weather/domain/forecast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/weather/domain/i_weather_repository.dart';

part 'weather_state.dart';

part 'weather_cubit.freezed.dart';

@Injectable()
class WeatherCubit extends Cubit<WeatherState> {
  final IWeatherRepository _repository;

  WeatherCubit(this._repository) : super(const WeatherState.initial());

  void loadForecast() async {
    emit(const WeatherState.loading());

    if (!await _hasInternetConnection()) {
      emit(const WeatherState.error('No internet connection.'));
      return;
    }

    try {
      final position = await _determinePosition();
      final forecast = await _repository.loadForecast(
        position.latitude,
        position.longitude,
      );
      emit(WeatherState.loaded(forecast));
    } on DioError catch (e) {
      emit(WeatherState.error(e.message));
    } on String catch (e) {
      emit(WeatherState.error(e));
    } catch (e) {
      // Do nothing.
    }
  }

  Future<bool> _hasInternetConnection() async {
    final result = await (Connectivity().checkConnectivity());
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
