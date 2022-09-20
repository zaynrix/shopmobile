import 'package:flutter/cupertino.dart';
import 'package:shopmobile/data/category_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/categoreysModel.dart';
import 'package:shopmobile/models/subCategoryModel.dart';

class CategoryProvider extends ChangeNotifier {
  bool cateInit = true;
  List<Category> category = [];
  List<Sub> subCategory = [];
  String title = "";

  CategoryProvider() {

  }

  void getCategoriesProvider() async {
    notifyListeners();
    Categories res = await sl<CategoryRepo>().getCategoreisData();
    if (res.status == true) {
      category = res.data!.category!;
      cateInit = false;
      notifyListeners();
    } else {
      print("There is no data");
    }
  }

  void getSubCategoriesProvider({int? id}) async {
    subCategory.clear();
    notifyListeners();
    category.forEach(
      (element) {
        element.id == id ? title = element.name! : "";
      },
    );
    notifyListeners();
    CategoriesDetails res =
        await sl<CategoryRepo>().getSubCategoreisData(id: id);
    if (res.status == true) {
      subCategory = res.data!.sub!;
      cateInit = false;
      notifyListeners();
    } else {
      print("There is no data");
    }
  }
}
