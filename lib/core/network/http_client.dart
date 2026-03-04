import 'package:dio/dio.dart';

abstract class HttpClient {
  Future<dynamic> get(String url);
}

class DioHttpClient implements HttpClient {
  final Dio dio;

  DioHttpClient(this.dio);

  @override
  Future get(String url) async {
    final response = await dio.get(url);
    return response.data;
  }
}