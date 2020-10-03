import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final _baseUrl = 'https://onematch-server.herokuapp.com/api/';

final Dio dio = new Dio(BaseOptions(
  baseUrl: _baseUrl,
  connectTimeout: 10000,
  sendTimeout: 10000,
  receiveTimeout: 10000,
))
  ..interceptors.add(TokenInterceptor())
  ..interceptors.add(
    PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100),
  );

class TokenInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final auth = FirebaseAuth.instance;
    final user = await auth.currentUser();
    if (user == null) return super.onRequest(options);
    final token = (await user.getIdToken()).token;
    options.headers['Authorization'] = 'Bearer $token';
    return options; //continue
  }
}