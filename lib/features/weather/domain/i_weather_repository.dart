import 'package:weather_app/features/weather/domain/forecast.dart';

abstract class IWeatherRepository {
  Future<Forecast> loadForecast(double latitude, double longitude);
}
