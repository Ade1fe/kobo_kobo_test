// ignore_for_file: one_member_abstracts

import 'package:kobo_kobo/core/core.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
