import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast.freezed.dart';

part 'forecast.g.dart';

@freezed
class Forecast with _$Forecast {
  const factory Forecast(
    @JsonKey(name: 'latitude') double latitude,
    @JsonKey(name: 'longitude') double longitude,
    @JsonKey(name: 'generationtime_ms') double generationTimeMs,
    @JsonKey(name: 'utc_offset_seconds') int utcOffsetSeconds,
    @JsonKey(name: 'timezone') String timezone,
    @JsonKey(name: 'timezone_abbreviation') String timezoneAbbreviation,
    @JsonKey(name: 'elevation') double elevation,
    @JsonKey(name: 'hourly_units') HourlyUnits hourlyUnits,
    @JsonKey(name: 'hourly') Hourly hourly,
  ) = _Forecast;

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
}

@freezed
class HourlyUnits with _$HourlyUnits {
  const factory HourlyUnits(
    @JsonKey(name: 'time') String time,
    @JsonKey(name: 'temperature_2m') String temperature_2m,
  ) = _HourlyUnits;

  factory HourlyUnits.fromJson(Map<String, dynamic> json) =>
      _$HourlyUnitsFromJson(json);
}

@freezed
class Hourly with _$Hourly {
  const factory Hourly(
    @JsonKey(name: 'time') List<String> time,
    @JsonKey(name: 'temperature_2m') List<double> temperature_2m,
  ) = _Hourly;

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);
}
