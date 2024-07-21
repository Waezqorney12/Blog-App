import 'package:blog_application/core/usecases/usecase_interface.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/failure/failure_message.dart';
import '../entities/blog_entities.dart';
import '../repository/blog_repository.dart';

class GetBlog implements UserCase<List<BlogEntities>, NoParams> {
  final BlogRepository blogRepository;
  GetBlog(this.blogRepository);
  @override
  Future<Either<FailureMessage, List<BlogEntities>>> call(NoParams params) async {
    return await blogRepository.getBlogs();
  }
}
