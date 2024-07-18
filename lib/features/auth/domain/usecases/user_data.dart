import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:blog_application/core/common/entities/user_entities.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/failure/failure_message.dart';
import '../repository/auth_repository.dart';

class UserData implements UserCase<UserEntities, NoParams> {
  final AuthRepository authRepository;
  UserData(this.authRepository);
  @override
  Future<Either<FailureMessage, UserEntities>> call(NoParams params) async {
    return await authRepository.getUser();
  }
}
