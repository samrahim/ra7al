// network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:ra7al/consts/consts.dart';

class DioClient {
  final Dio dio;

  DioClient({required this.dio});

  Future<Response> get(String path) async {
    return dio.get(path);
  }
}

// network/dio_config.dart
DioClient createAdhanDioClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: adhanBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
    ),
  );

  return DioClient(dio: dio);
}
