import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/favoritesModel.dart';
import 'package:shopmobile/models/favouriteModel.dart';
import 'package:shopmobile/utils/storage.dart';

class FavouriteRepo {
  final Dio? client;

  FavouriteRepo({this.client});

  Future<Favorite> getFavoriteData() async {
    // var token =
    //     await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // var token = sl<SharedLocal>().getUser();
    // print(token);
    Response response = await client!.get('${ApiConstant.favorites}',
        // options: Options(headers: <String, String>{
        //   "Authorization": "$token",
        //   "lang": "${sl<SharedLocal>().getLanguage}",
        // })
    );
    Favorite favorite = Favorite.fromJson(response.data);

    return favorite;
  }

  Future<FavoriteCheck> removeFavoriteData(int? id) async {
    // print("THIS ID $id");
    // var token =
    //     await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client!.post(
      '${ApiConstant.favorites}',
      data: {
        "product_id": id,
      },
      // options: Options(
      //   headers: <String, String>{
      //     "Authorization": "$token",
      //     "lang": "${sl<SharedLocal>().getLanguage}",
      //   },
      // ),
    );
    FavoriteCheck favorite = FavoriteCheck.fromJson(response.data);
    return favorite;
  }
}
