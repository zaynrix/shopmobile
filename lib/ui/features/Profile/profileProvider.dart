import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shopmobile/data/auth_repo.dart';
import 'package:shopmobile/data/local_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/models/aboutUsModel.dart';
import 'package:shopmobile/models/addressModel.dart';
import 'package:shopmobile/models/contactUsModel.dart';
import 'package:shopmobile/models/customeSettingItemModel.dart';
import 'package:shopmobile/models/faqModel.dart';
import 'package:shopmobile/models/user.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/routing/navigation.dart';
import 'package:shopmobile/routing/routes.dart' as rote;
import 'package:shopmobile/routing/routes.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:shopmobile/ui/features/favorite/favoriteProvider.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeBottomSheet.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:shopmobile/utils/enums.dart';
import 'package:shopmobile/utils/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmobile/data/profile_repo.dart';
import 'package:shopmobile/utils/validator.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileProvider extends ChangeNotifier {
  final Locale? locale = Locale("en");

  File? image;
  bool loading = false;
  bool? changed;

  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> productDetailsScaffoldKey = GlobalKey();
  int languageval = 0;
  int addressValue = -1;
  int val = 0;
  double? long;
  double? lat;

  final user = sl<SharedLocal>().getUser();
  AboutUsData? aboutus;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<CustomeSettingItemModel> SettingItemsGet = [];
  List<Addres> address = [];
  List<Faqs> faq = [];
  List<ContactUsData> contactUsData = [];
  TextEditingController currentPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController nameControllers = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController addressName = TextEditingController();
  TextEditingController addressDetails = TextEditingController();
  TextEditingController addressCity = TextEditingController();
  TextEditingController addressRegion = TextEditingController();

  // TextEditingController addressLang = TextEditingController();
  // TextEditingController addressLong = TextEditingController();
  TextEditingController addressNotes = TextEditingController();
  TextEditingController holderController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController mmyyController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController promoCodeController = TextEditingController();

  // String name;
  CardType cardType = CardType.Invalid;
  String? holderName;
  String? cardNumber;
  String? mAndy;
  String? cvv;

// void getNewSettingList() {
//   SettingItemsGet= SettingItems;
//   notifyListeners();
// }
  //
  // setname(String holder) {
  //   name = holder;
  //   notifyListeners();
  // }
  @override
  void dispose() {
    cardNumberController.dispose();
    holderController.dispose();
    mmyyController.dispose();
    cvvController.dispose();
    // dispose your stuff here
    super.dispose();
  }

  ProfileProvider() {
    getFAQProvider();
    getAboutUsProvider();
    getContactUsProvider();
    checkGPSEnabeld();
    checkLocationPermission();
    listenController();
  }

  void listenController() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
        cardNumber = cardNumberController.text;
        notifyListeners();
      },
    );
    holderController.addListener(() {
      holderName = holderController.text;
      notifyListeners();
    });
    mmyyController.addListener(() {
      mAndy = mmyyController.text;
      notifyListeners();
    });
    cvvController.addListener(() {
      cvv = cvvController.text;
      notifyListeners();
    });
  }

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        // setState(() {
        cardType = type;
        notifyListeners();
        // });
      }
    }
  }

  String base64Encode(List<int> bytes) => base64.encode(bytes);

  changeRadio(value) {
    val = value;
    (val);
    notifyListeners();
  }

  changeRadio2(value) {
    languageval = value;
    (languageval);
    notifyListeners();
  }

  changeAddressValue(value) {
    if (value == -1) {
      changed = false;
      notifyListeners();
    } else {
      changed = true;
      notifyListeners();
    }
    addressValue = value;
    (addressValue);
    notifyListeners();
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      final bytes = File(pickedImage.path).readAsBytesSync();
      imageController.text = base64Encode(bytes);
      notifyListeners();
    }
  }

  void getLocationAttitude() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    long = position.longitude;
    lat = position.latitude;
    notifyListeners();

    // ("This is long :$long - lat:$lat");
  }

  void getAddressProvider() async {
    ("Added Data");
    AddressModel response = await sl<ProfileRepo>().getAddress();
    ("This is response ${response.hashCode}");

    (response.status);
    if (response.status == true) {
      address = response.data!.addres!;
      notifyListeners();
    } else {
      ("There is no data");
    }
  }

  void getAboutUsProvider() async {
    // ("Added Data");
    AboutUs response = await sl<ProfileRepo>().getAboutUs();
    // ("This is response ${response.hashCode}");

    (response.status);
    if (response.status == true) {
      if (aboutus != null) {
        aboutus = null;
        notifyListeners();
      }
      aboutus = response.data;
      notifyListeners();
    } else {
      // ("There is no data");
    }
  }

  void getFAQProvider() async {
    // ("Added Data");
    FAQModel response = await sl<ProfileRepo>().getFAQ();
    // ("This is response ${response.hashCode}");

    (response.status);
    if (response.status == true) {
      faq = response.data!.faqs!;
      notifyListeners();
    } else {
      // ("There is no data");
    }
  }

  void getContactUsProvider() async {
    ("Added Data");
    ContactUs response = await sl<ProfileRepo>().getContactUs();
    ("This is response ${response.hashCode}");

    (response.status);
    if (response.status == true) {
      contactUsData = response.data!.contactUsData!;
      (contactUsData);
      contactUsData
          .forEach((element) => ("${element.id} -${element.value}"));
      // address = response.data!.addres!;
      notifyListeners();
    } else {
      ("There is no data");
    }
  }

  Future<void> launchUrlw(url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  void addAddressProvider() async {
    loading = true;
    notifyListeners();
    // debugPrint("Added Data");
    Addres? addres = Addres(
        name: addressName.text,
        city: addressCity.text,
        details: addressDetails.text,
        region: addressRegion.text,
        notes: addressNotes.text,
        latitude: lat ?? 000000,
        longitude: long ?? 000000);
    AddressModel response =
        await sl<ProfileRepo>().addAddressRepo(addres: addres);
    // ("This is response ${response.hashCode}");

    (response.status);
    if (response.status == true) {
      updateAdresss();
      loading = false;
      sl<NavigationService>().pop();
      // address = response.data!.addres!;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
      // ("There is no data");
    }
  }

  void updateAdresss() async {
    address.toSet();
    getAddressProvider();
    notifyListeners();
  }

  void editProfile() async {
    // if (formKey.currentState!.validate()) {
    loading = true;
    notifyListeners();
    LoginResponse response = await sl<ProfileRepo>().editProfile(
        name: nameControllers.text == "" ? user!.name : nameControllers.text,
        email: emailController.text == "" ? user!.email : emailController.text,
        phone: phoneController.text == "" ? user!.phone : phoneController.text,
        image: imageController.text == "" ? user!.image : imageController.text);

    ("This is response ${response.hashCode}");

    (response.status);
    if (response.status == true) {
      AppConfig.showSnakBar("${response.message}");
      loading = false;
      notifyListeners();
      sl<SharedLocal>().setUser(response.user!);
      notifyListeners();

      // Save Token
      sl<Storage>()
          .secureStorage
          .write(key: SharedPrefsConstant.TOKEN, value: response.user!.token);
      notifyListeners();
      sl<NavigationService>().pop();
    } else {
      AppConfig.showSnakBar("${response.message}");
      loading = false;
      notifyListeners();
      ("There is no data");
    }
  }

  Future<void> openCameraPicker() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      notifyListeners();
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'.tr()),
                    onTap: () {
                      openImagePicker();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'.tr()),
                  onTap: () {
                    openCameraPicker();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  clearUserData() async {
    sl<SharedLocal>().removeUser();
    // await  Restart.restartApp();

    await sl<Storage>().secureStorage.delete(key: SharedPrefsConstant.TOKEN);
    await sl<AppConfig>().deleteAppDir();
    await sl<AppConfig>().deleteCacheDir();
    // await  sl<AppConfig>().c();
    sl<CartProvider>().cartList.clear();
    sl<CartProvider>().ext = 0;
    sl<CartProvider>().implemnt = false;
    sl<CartProvider>().cartModelList = null;

    sl<CategoryProvider>().category.clear();
    sl<CategoryProvider>().subCategory.clear();
    sl<ExploreProvider>().topPrice.clear();
    sl<ExploreProvider>().mostViews.clear();
    sl<FavouriteProvider>().favoriteDataProvider!.clear();
    sl<HomeProvider>().banners.clear();
    sl<ProfileProvider>().address.clear();
    sl<ProfileProvider>().reAssignSetting();
    sl<HomeProvider>().products.clear();
    sl<HomeProvider>().searchList.clear();
    sl<HomeProvider>().controller.dispose();
    sl<HomeProvider>().searchController.dispose();
    sl<HomeProvider>().productDetails = null;
    sl<HomeProvider>().productDetails = null;
    // sl<HomeProvider>().se= null;

    notifyListeners();

    // List<cartModel.CartItems> cartList = [];
    // cartModel.CartModel? cartModelList;

    // is_logged_in.value = false;
    // access_token.value = "";
    // user_id.value = 0;
    // user_name.value = "";
    // user_email.value = "";
    // user_phone.value = "";
    // avatar_original.value = "";
  }

  void changePasswordProvider() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      LoginResponse response = await sl<HttpAuth>().changePassword(
          currentPassword: currentPass.text, newPassword: newPass.text);
      if (response.status == true) {
        AppConfig.showSnakBar("${response.message}");
        loading = false;
        notifyListeners();
        sl<NavigationService>().pop();
      } else {
        AppConfig.showSnakBar("${response.message}");
        loading = false;
        notifyListeners();
        ("There is no data");
      }
    }
  }

  void languageSheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.backgroundColor2,
      context: productDetailsScaffoldKey.currentContext!,
      builder: (context) => BottomSheetLanguage(),
    );
  }

  voidConfirmMethod() {

    if (formKey.currentState!.validate()) {

      show();
    } else {
      debugPrint("No");
    }
  }

  void reAssignSetting() {
    // SettingItems.clear();
    SettingItems;
    notifyListeners();
    // SettingItems
  }

  void show() {
    showDialog(
      context: productDetailsScaffoldKey.currentContext!,
      builder: (context) {
        FocusScope.of(context).unfocus();

        return AlertDialog(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              FittedBox(
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundColor: ColorManager.primaryGreen,
                  child: Icon(
                    Icons.check,
                    color: ColorManager.white,
                    size: 50.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Thank you!'.tr(),
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your order is completed. Please check the delivery status at order tracking page.'
                      .tr(),
                  maxLines: 7,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomeCTAButton(
                trigger: false,
                primary: ColorManager.primaryGreen.withOpacity(1),
                title: "Ok",
                textColor: ColorManager.white,
                onPressed: () {
                  sl<NavigationService>().navigateToAndRemove(rote.home);
                },
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        );
      },
    );
  }

  void checkGPSEnabeld() async {
    bool servicestatus = await Geolocator.isLocationServiceEnabled();

    if (servicestatus) {
      ("GPS service is enabled");
    } else {
      ("GPS service is disabled.");
    }
  }

  void checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ('Location permissions are denied');
      } else if (permission == LocationPermission.deniedForever) {
        ("'Location permissions are permanently denied");
      } else {
        ("GPS Location service is granted");
      }
    } else {
      ("GPS Location permission granted.");
    }
  }

  void AddressSheet() {
    showModalBottomSheet(
      isScrollControlled: true,


      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: ColorManager.backgroundColor2,
      context: productDetailsScaffoldKey.currentContext!,
      builder: (context) => BottomSheetAddress(),
    );
  }

  List<CustomeSettingItemModel> subSettingItems = [
    CustomeSettingItemModel(
      onPressed: () {
        sl<NavigationService>().navigateTo(rote.notifications);
      },
      path: CustomSvgAssets(
        path: IconAssets.notification,
        color: ColorManager.primaryGreen,
      ),
      title: "Notification",
    ),
    CustomeSettingItemModel(
        onPressed: () {
          sl<ProfileProvider>().languageSheet();
// sl<ProfileProvider>(). getAddressProvider();
        },
        path: CustomSvgAssets(
          path: IconAssets.language,
          color: ColorManager.primaryGreen,
        ),
        title: "Language"),
    CustomeSettingItemModel(
        onPressed: () {},
        path: CustomSvgAssets(
          path: IconAssets.Scan,
          color: ColorManager.primaryGreen,
        ),
        title: "Scanner"),
    CustomeSettingItemModel(
        onPressed: () {
          sl<NavigationService>().navigateTo(rote.helpCenter);
        },
        path: CustomSvgAssets(
          path: IconAssets.help,
          color: ColorManager.primaryGreen,
        ),
        title: "Help center"),
    CustomeSettingItemModel(
        onPressed: () {
          sl<NavigationService>().navigateTo(rote.contactus);
        },
        path: CustomSvgAssets(
          path: IconAssets.profile,
          color: ColorManager.primaryGreen,
        ),
        title: "Contact Us"
        // Text(
        //   "About us".tr(),
        //   style: getRegularStyle(color: ColorManager.black, fontSize: 16),
        // ),
        ),
    CustomeSettingItemModel(
        onPressed: () {
          sl<NavigationService>().navigateTo(rote.aboutus);
        },
        path: CustomSvgAssets(
          path: IconAssets.dangerCircle,
          color: ColorManager.primaryGreen,
        ),
        title: "Abouts"
        // Text(
        //   "About us".tr(),
        //   style: getRegularStyle(color: ColorManager.black, fontSize: 16),
        // ),
        ),
  ];

  List<CustomeSettingItemModel> SettingItems = [
    CustomeSettingItemModel(
        onPressed: () {
          sl<NavigationService>().navigateTo(rote.setting);
        },
        path: CustomSvgAssets(
          path: IconAssets.setting,
          color: ColorManager.primaryGreen,
        ),
        title: "Setting"

        ),
    if (sl<SharedLocal>().getUser()!.token != "")
      CustomeSettingItemModel(
          onPressed: () {
            sl<NavigationService>().navigateTo(rote.paymentMethodScreen);
            sl<ProfileProvider>().getAddressProvider();
          },
          path: CustomSvgAssets(
            path: IconAssets.payment,
            color: ColorManager.primaryGreen,
          ),
          title: "Payment Method"

          ),
    if (sl<SharedLocal>().getUser()!.token != "")
      CustomeSettingItemModel(
          onPressed: () {
            sl<NavigationService>().navigateTo(rote.myPurchessScreen);
          },
          path: CustomSvgAssets(
            path: IconAssets.wallet,
            color: ColorManager.primaryGreen,
          ),
          title: "My Purchase"

          ),
    if (sl<SharedLocal>().getUser()!.token != "")
      CustomeSettingItemModel(
        title: "Address",
          onPressed: () {
            sl<NavigationService>().navigateTo(rote.address);
          },
          path: CustomSvgAssets(
            path: IconAssets.location,
            color: ColorManager.primaryGreen,
          ),

          ),
    CustomeSettingItemModel(
        onPressed: () {
          sl<NavigationService>().navigateTo(terms);
        },
        path: CustomSvgAssets(
          path: IconAssets.privacy,
          color: ColorManager.primaryGreen,
        ),
        title: "Privacy"

        ),
    CustomeSettingItemModel(
      redColor: sl<SharedLocal>().getUser()!.token != "" ? true: false,
      onPressed: () {
        if (sl<SharedLocal>().getUser()!.token == "") {
          sl<NavigationService>().navigateTo(rote.login);
        } else {
          sl<AuthProvider>().logoutProvider();
          // showDialog(
          //   context:
          //       sl<ProfileProvider>().productDetailsScaffoldKey.currentContext!,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: Text('Logout'.tr()),
          //       actions: <Widget>[
          //         TextButton(
          //           onPressed: () {
          //             sl<NavigationService>().pop();
          //           },
          //           child: Text(
          //             'No'.tr(),
          //             style: TextStyle(color: ColorManager.lightGrey),
          //           ),
          //         ),
          //         TextButton(
          //           onPressed: () {
          //             sl<AuthProvider>().logoutProvider();
          //           },
          //           child: Text(
          //             'Logout'.tr(),
          //             style: TextStyle(
          //                 color: sl<SharedLocal>().getUser()!.token != ""
          //                     ? ColorManager.red
          //                     : ColorManager.primaryGreen),
          //           ),
          //         ),
          //       ],
          //     );
          //   },
          // );
        }
      },
      path: CustomSvgAssets(
        path: IconAssets.logout,
        color: sl<SharedLocal>().getUser()!.token != ""
            ? ColorManager.red
            : ColorManager.primaryGreen,
      ),
      title: sl<SharedLocal>().getUser()!.token != "" ? 'Logout' : 'Login',
    ),
  ];

  void checkSelected() {
    if (addressValue == -1) {
      ("This is lang value ");
      AppConfig.showSnakBar("You should Select an Address".tr());
    } else {
      sl<NavigationService>().navigateTo(paymentDetailsScreen);
    }
  }
}
