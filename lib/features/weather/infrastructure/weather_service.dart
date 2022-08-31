import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:weather_app/features/weather/domain/forecast.dart';

part 'weather_service.g.dart';

@LazySingleton()
@RestApi(baseUrl: 'https://api.open-meteo.com/v1/')
abstract class WeatherService {
  @factoryMethod
  factory WeatherService(Dio dio) = _WeatherService;

  @GET('/forecast?hourly=temperature_2m')
  Future<Forecast> getForecast(
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
  );
}
