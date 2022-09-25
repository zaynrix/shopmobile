import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shopmobile/data/apiConstant.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/aboutUsModel.dart';
import 'package:shopmobile/models/addressModel.dart';
import 'package:shopmobile/models/contactUsModel.dart';
import 'package:shopmobile/models/faqModel.dart';
import 'package:shopmobile/models/user.dart';
import 'package:shopmobile/utils/storage.dart';

class ProfileRepo {
  final Dio? client;

  ProfileRepo({this.client});

  Future<LoginResponse> editProfile(
      {String? name, String? phone, String? email, String? image}) async {
    // print
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    Response response = await client!.put(
      '${ApiConstant.updateProfile}',
      data: {
        "name": "$name",
        "phone": "059$phone",
        "email": "$email",
        "image": "$image",
      },
      // options: Options(
      //   headers: <String, String>{
      //     "Authorization": "$token",
      //     "lang": "${sl<SharedLocal>().getLanguage}",
      //   },
      // ),
    );
    print("This is  resps ${response.data}");
    print("This is  respsBod ${response.statusCode}");

    LoginResponse users = LoginResponse.fromJson(response.data);
    return users;
  }

  Future<AddressModel> getAddress() async {
    var token =
        await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    print("This is ${token}");

    Response response = await client!.get('${ApiConstant.adress}',
        // options: Options(
        //   headers: <String, String>{
        //     "lang": "${sl<SharedLocal>().getLanguage}",
        //     "Authorization": "$token"
        //   },
        // )
    );
    AddressModel addressModel = AddressModel.fromJson(response.data);
    return addressModel;
  }

  Future<AboutUs> getAboutUs() async {
    // var token =
    //     await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // print("This is ${token}");

    Response response = await client!.get('${ApiConstant.aboutUs}',
        // options: Options(
        //   headers: <String, String>{"lang": "${sl<SharedLocal>().getLanguage}"},
        // )
    );
    AboutUs aboutUs = AboutUs.fromJson(response.data);
    return aboutUs;
  }
  Future<FAQModel> getFAQ() async {
    // var token =
    // await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // print("This is ${token}");

    Response response = await client!.get('${ApiConstant.faqs}',
        // options: Options(
        //   headers: <String, String>{"lang": "${sl<SharedLocal>().getLanguage}"},
        // )
    );
    FAQModel faqModel = FAQModel.fromJson(response.data);
    return faqModel;
  }

  Future<ContactUs> getContactUs() async {
    final response = '''

{
    "status": true,
    "message": "null",
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 1,
                "type": 3,
                "value": "https://www.facebook.com/zaynrix/",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Facebook.png"
            },
            {
                "id": 2,
                "type": 3,
                "value": "https://www.instagram.com/yahya.m.abunada/",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Instagram.png"
            },
            {
                "id": 3,
                "type": 3,
                "value": "https://twitter.com/UxuiYahya",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Twitter.png"
            },
            {
                "id": 4,
                "type": 2,
                "value": "mailto:yahya.m.abunada@gmail.com",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Email.png"
            },
            {
                "id": 5,
                "type": 1,
                "value": "tel://+970592487533",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Phone.png"
            },
            {
                "id": 6,
                "type": 3,
                "value": "http://wa.me/970592487533",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Whatsapp.png"
            },
            {
                "id": 7,
                "type": 3,
                "value": "https://snapchat.com",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Snapchat.png"
            },
            {
                "id": 8,
                "type": 3,
                "value": "https://youtube.com",
                "image": "https://student.valuxapps.com/storage/uploads/contacts/Youtube.png"
            }
           
        ],
        "first_page_url": "https://student.valuxapps.com/api/contacts?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "https://student.valuxapps.com/api/contacts?page=1",
        "next_page_url": null,
        "path": "https://student.valuxapps.com/api/contacts",
        "per_page": 35,
        "prev_page_url": null,
        "to": 9,
        "total": 9
    }
}
''';
    Map<String, dynamic> jsonList = jsonDecode(response);

    ContactUs aboutUs = ContactUs.fromJson(jsonList);
    return aboutUs;
  }

  Future<AddressModel> addAddressRepo({Addres? addres}) async {
    // var token =
    //     await sl<Storage>().secureStorage.read(key: SharedPrefsConstant.TOKEN);
    // print("This is ${token}");

    Response response = await client!.post('${ApiConstant.adress}',
        data: {
          "name": addres!.name,
          "city": addres.city,
          "region": addres.region,
          "details": addres.details,
          "latitude": addres.latitude,
          "longitude": addres.longitude,
          "notes": addres.notes
        },
        // options: Options(
        //   headers: <String, String>{
        //     "lang": "${sl<SharedLocal>().getLanguage}",
        //     "Authorization": "$token"
        //   },
        // ),
    );
    // print("This is  resps ${response.data}");
    // print("This is  respsBod ${response.statusCode}");

    AddressModel users = AddressModel.fromJson(response.data);
    return users;
  }
}
