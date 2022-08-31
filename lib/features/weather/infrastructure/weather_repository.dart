import 'package:injectable/injectable.dart';
import 'package:weather_app/features/weather/domain/forecast.dart';
import 'package:weather_app/features/weather/domain/i_weather_repository.dart';
import 'package:weather_app/features/weather/infrastructure/weather_service.dart';

@LazySingleton(as: IWeatherRepository)
class WeatherRepository implements IWeatherRepository {
  final WeatherService _service;

  WeatherRepository(this._service);

  @override
  Future<Forecast> loadForecast(double latitude, double longitude) {
    return _service.getForecast(latitude, longitude);
  }
}
