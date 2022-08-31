import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @LazySingleton()
  Dio getDio() => Dio();
}
