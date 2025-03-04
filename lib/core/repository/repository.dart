import 'package:kobo_kobo/core/core.dart';
import 'package:kobo_kobo/di/dependency_injection_container.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:dartz/dartz.dart';

// ignore: one_member_abstracts
abstract class Repository {
  Future<Either<Failure, T>> runGuard<T>(Future<T> Function() call);
}

class RepositoryImpl extends Repository with LogoutMixin {
  RepositoryImpl({NetworkManager? networkNotifier})
      : _networkNotifier = networkNotifier ?? sl<NetworkManager>();
  final NetworkManager _networkNotifier;

  Future<bool> get hasNetwork async {
    return _networkNotifier.hasNetwork();
  }

  @override
  Future<Either<Failure, T>> runGuard<T>(
    Future<T> Function() call,
  ) async {
    if (await hasNetwork) {
      try {
        final result = await call();
        return Right(result);
      } catch (e, stack) {
        Log().debug('From the repository $stack', e.toString());

        // Handle all exceptions here
        if (e is SessionExpiredServerException) {
          sessionExpiredLogout();
          return Left(SessionFailure(e.message));
        }
        if (e is AfrException) {
          return Left(ServerFailure(e.message));
        }
        if (e is InvalidArgOrDataException) {
          return Left(InvalidArgOrDataFailure());
        }
        return Left(UnexpectedFailure());
      }
    }
    showErrorNotification('Network unavailable');
    return Left(NetworkFailure());
  }
}
