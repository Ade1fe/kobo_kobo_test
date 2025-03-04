import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:dio/dio.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

final unauthenticatedUrls = [
  authEndpoints.login,
  authEndpoints.signUp,
  authEndpoints.getPhoneOtp,
  authEndpoints.forgotPassword,
];

class AuthAndRefreshTokenInterceptor extends Interceptor {
  AuthAndRefreshTokenInterceptor({
    required this.cache,
    required this.baseUrl,
  });
  final ILocalCache cache;
  final String baseUrl;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await cache.get<String>(CacheKeys.token);
    var isExpired = false;
    Log().debug('The token cached.. $token');
    if (token != null) {
      isExpired = Jwt.isExpired(token);

      if (isExpired) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: SessionExpiredServerException(),
          ),
        );
      } else {
        /// token is valid continue with request
        handler.next(
          options.copyWith(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      }
    } else {
      Log().debug(
        'The token cached is null and ${options.uri.path}',
        unauthenticatedUrls.contains(options.uri.path.split('/').last),
      );

      /// token is not available continue with request only if request url is not an authorized url
      handler.next(
        options.copyWith(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    }
  }
}
