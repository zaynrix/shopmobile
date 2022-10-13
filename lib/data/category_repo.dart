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


  // -------------------- Get Categories ----------------

  Future<Categories> getCategoreisData() async {
    Response response = await client!.get(
      '${ApiConstant.categories}',
    );
    Categories categories = Categories.fromJson(response.data);
    return categories;
  }


  // -------------------- Get Sub Categories ----------------

  Future<CategoriesDetails> getSubCategoreisData({int? id}) async {
    Response response = await client!.get('${ApiConstant.categories}/$id',
    );
    CategoriesDetails categoriesDetails =
        CategoriesDetails.fromJson(response.data);
    return categoriesDetails;
  }
}
