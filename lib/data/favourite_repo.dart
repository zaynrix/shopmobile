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

  // -------------------- Get Favourite ----------------

  Future<Favorite> getFavoriteData() async {
    Response response = await client!.get('${ApiConstant.favorites}',
    );
    Favorite favorite = Favorite.fromJson(response.data);

    return favorite;
  }

  // -------------------- Remove Favourite ----------------

  Future<FavoriteCheck> removeFavoriteData(int? id) async {
    Response response = await client!.post(
      '${ApiConstant.favorites}',
      data: {
        "product_id": id,
      },
    );
    FavoriteCheck favorite = FavoriteCheck.fromJson(response.data);
    return favorite;
  }
}
