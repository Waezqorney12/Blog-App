import 'package:blog_application/core/config/exception.dart';
import 'package:blog_application/core/utils/log_utils.dart';
import 'package:blog_application/features/dashboard/data/model/blog_model.dart';
import 'package:blog_application/features/dashboard/domain/datasource/blogs_local_datasource.dart';
import 'package:hive/hive.dart';

// class BlogLocalDatasourceImpl implements BlogLocalDatasource {
//   final Box box;
//   BlogLocalDatasourceImpl(this.box);
//   @override
//   List<BlogModel> loadBlog() {
//     // TODO: implement loadBlog
//     throw UnimplementedError();
//   }

//   @override
//   void uploadLocalBlog(List<BlogModel> blogModel) {
//     try {
//       box.write(() {
//         for(final data in blogModel.indexed){
//           box.put(data.$1.toString(), data.$2);
//         }
//       });
//     } on ServerException catch (e) {
//       Log.loggerFatal(e.message);
//       throw ServerException(message: "Failure on the server datasource: ${e.message}");
//     }
//   }
// }
