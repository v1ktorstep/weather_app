import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/di/injectable.dart';
import 'package:weather_app/features/weather/application/weather_cubit.dart';
import 'package:weather_app/features/weather/domain/forecast.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<WeatherCubit>()..loadForecast(),
      child: Scaffold(
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return state.when(
              initial: () => Container(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loaded: (forecast) => _Forecast(forecast: forecast),
              error: (errorMessage) => Container(),
            );
          },
        ),
      ),
    );
  }
}

class _Forecast extends StatelessWidget {
  final Forecast forecast;

  final _jsonEncoder = const JsonEncoder.withIndent(' ');

  const _Forecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('latitude: ${forecast.latitude}'),
          Text('longitude: ${forecast.longitude}'),
          Text(
              'generation time: ${forecast.generationTimeMs.toStringAsFixed(2)}ms'),
          Text('utc_offset_seconds: ${forecast.utcOffsetSeconds}'),
          Text('timezone: ${forecast.timezone}'),
          Text('timezone_abbreviation: ${forecast.timezoneAbbreviation}'),
          Text('elevation: ${forecast.elevation}'),
          Text(
              'currentWeather: ${_jsonEncoder.convert(forecast.currentWeather)}')
        ],
      ),
    );
  }
}
