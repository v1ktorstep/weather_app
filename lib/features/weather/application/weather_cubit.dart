import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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

    try {
      final forecast = await _repository.loadForecast(0, 0);
      emit(WeatherState.loaded(forecast));
    } on DioError catch (e) {
      emit(WeatherState.error(e.message));
    } catch (e) {
      // Do nothing.
    }
  }
}
