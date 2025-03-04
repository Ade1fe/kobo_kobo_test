import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/core/data/model/db_logger.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:dio/dio.dart';

enum RequestType { get, post, put, patch, delete, download }

const successCodes = [200, 201, 203, 204];

class HttpManager {
  HttpManager({
    Dio? dio1,
    required ILocalCache cache,
    required String baseUrl,
    required this.enableLogging,
  }) {
    _dio1 = dio1 ?? Dio();
    // _dio1.options.baseUrl = '$baseUrl/api';
    _dio1.options.connectTimeout = 30000.milliseconds;
    _dio1.options.receiveTimeout = 30000.milliseconds;
    _dio1.interceptors.add(
      AuthAndRefreshTokenInterceptor(cache: cache, baseUrl: baseUrl),
    );
  }
  late Dio _dio1;
  bool enableLogging;

  Future download(String endpoint, [dynamic savePath]) async {
    return _makeRequest(
      RequestType.download,
      endpoint,
      {},
      savePath: savePath,
    );
  }

  Future get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    return _makeRequest(
      RequestType.get,
      endpoint,
      {},
      queryParameters: queryParameters,
    );
  }

  Future post(
    String endpoint,
    // Map<String, dynamic> data,
    dynamic data, [
    Options? options,
  ]) {
    return _makeRequest(
      RequestType.post,
      endpoint,
      data,
      options: options,
    );
  }

  Future patch(
    String endpoint,
    dynamic data,
  ) {
    return _makeRequest(
      RequestType.patch,
      endpoint,
      data,
    );
  }

  Future put(
    String endpoint,
    Map<String, dynamic> data,
  ) {
    return _makeRequest(
      RequestType.put,
      endpoint,
      data,
    );
  }

  Future delete(String endpoint) {
    return _makeRequest(
      RequestType.delete,
      endpoint,
      {},
    );
  }

  //Data parameter should be dynamic because it may accept
  //other variables other than map
  Future _makeRequest(
    RequestType type,
    String endpoint,
    dynamic data, {
    Options? options,
    dynamic savePath,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      late Response response;
      switch (type) {
        case RequestType.get:
          response = await _dio1.get(
            endpoint,
            queryParameters: queryParameters,
          );

          break;
        case RequestType.post:
          response = await _dio1.post(
            endpoint,
            data: data,
            options: options,
          );
          break;
        case RequestType.put:
          response = await _dio1.put(endpoint, data: data);
          break;
        case RequestType.patch:
          response = await _dio1.patch(endpoint, data: data);
          break;
        case RequestType.delete:
          response = await _dio1.delete(endpoint);
          break;

        case RequestType.download:
          response = await _dio1.download(endpoint, savePath);
          return response;
        // ignore: no_default_cases
        default:
          throw InvalidArgOrDataException();
      }

      if (successCodes.contains(response.statusCode)) {
        if (enableLogging) {
          Log().jsonLog(
            '$endpoint JSON res ',
            response.data as Map<String, dynamic>,
          );
        }
        return response.data;
      }
      throw AfrServerException(
        _handleException(
          response.data,
          'from App $endpoint',
          type.name,
          request: data,
        ),
      );
    } catch (e) {
      Log().debug(
        'the _dio exception caught $endpoint ${e.runtimeType} $data ',
        e.toString(),
      );
      if (e is ServerException) {
        rethrow;
      }
      if (e is DioException) {
        if (e.response?.statusCode != null) {
          if (e.response!.statusCode! >= 400 || e.response!.statusCode! < 500) {
            if (e.response!.statusCode! == 401) {
              Log().debug(
                'the _dio exception caught SessionExpiredServerException DioException $endpoint ${e.runtimeType}  ',
                e.response,
              );
              if (e.response!.data != null) {
                throw SessionExpiredServerException(
                  // ignore: avoid_dynamic_calls
                  msg: e.response?.data['message'],
                );
              } else {
                throw SessionExpiredServerException();
              }
            }

            throw AfrServerException(
              _handleException(
                e.response?.data,
                endpoint,
                type.name,
                request: data,
              ),
            );
          }
        }
        if (e.error is SessionExpiredServerException) {
          Log().debug(
            'the _dio exception caught SessionExpiredServerException $endpoint ${e.runtimeType}  ',
            e.error,
          );
          throw SessionExpiredServerException();
        }

        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          throw TimeoutServerException();
        }
        if (e is FormatException) {
          throw InvalidArgOrDataException();
        }
      }
      Log().debug(
        'the _makeRequest exception caught ${AppConfig.baseUrl}/api$endpoint',
        (e as DioException).response?.statusCode,
      );
      throw UnexpectedServerException(e.toString());
    }
  }

  String _handleException(
    dynamic err,
    String url,
    String requestType, {
    Map<dynamic, dynamic>? request,
  }) {
    if (err != null && err.toString().isNotEmpty) {
      Log().error('Exception handler logger $url', err.toString());
      var dbReq = DBLoggerRequest.empty();
      dbReq = dbReq.copyWith(
        request: request,
        tag: requestType,
        url: url,
        response: err,
      );

      // ignore: avoid_dynamic_calls
      if (err['message'] != null) {
        // ignore: avoid_dynamic_calls
        return err['message'].toString();
      }
      // ignore: avoid_dynamic_calls
      if (err['error'] != null) {
        // ignore: avoid_dynamic_calls
        return err['error'].toString();
      }
    }
    // this colon at the end of the string is used to identify the error in the logs which means that
    // the server returned an error but we couldn't parse it.
    return 'An unexpected error occurred:';
  }
}
