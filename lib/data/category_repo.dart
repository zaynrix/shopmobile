import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/categoreysModel.dart';
import 'package:shopmobile/models/subCategoryModel.dart';
import 'package:shopmobile/utils/storage.dart';

class CategoryRepo {
  final Dio? client;

  CategoryRepo({this.client});

  Future<Categories> getCategoreisData() async {
    // var token =
    // await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // var token = sl<SharedLocal>().getUser();
    Response response = await client!.get(
      '${ApiConstant.categories}',
      // options: Options(
      //   headers: <String, String>{
      //     "lang": "${sl<SharedLocal>().getLanguage}",},
      // ),
    );
    Categories categories = Categories.fromJson(response.data);
    print(categories.status);
    return categories;
  }

  Future<CategoriesDetails> getSubCategoreisData({int? id}) async {
    // var token =
    //     await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // var token = sl<SharedLocal>().getUser();
    Response response = await client!.get('${ApiConstant.categories}/$id',
        // options: Options(headers: <String, String>{
        //   "lang": "${sl<SharedLocal>().getLanguage}",
        //   "Authorization": "$token"
        // }
        // )
    );

    CategoriesDetails categoriesDetails =
        CategoriesDetails.fromJson(response.data);

    print(categoriesDetails.status);

    return categoriesDetails;
  }
}
