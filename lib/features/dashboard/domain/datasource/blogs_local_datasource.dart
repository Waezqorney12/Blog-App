import '../../data/model/blog_model.dart';

abstract interface class BlogLocalDatasource {
  void uploadLocalBlog(List<BlogModel> blogModel);
  List<BlogModel> loadBlog();
}
