import 'package:flutter/material.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/ui/features/Profile/addressScreen.dart';
import 'package:shopmobile/ui/features/Profile/myPurchessScreen.dart';
import 'package:shopmobile/ui/features/Profile/orderTrackingScreen.dart';
import 'package:shopmobile/ui/features/Profile/paymentDetailsScreen.dart';
import 'package:shopmobile/ui/features/Profile/paymentMethodScreen.dart';
import 'package:shopmobile/ui/features/Profile/profileEditingScreen.dart';
import 'package:shopmobile/ui/features/Profile/profileProvider.dart';
import 'package:shopmobile/ui/features/Profile/profileScreen.dart';
import 'package:shopmobile/ui/features/Profile/subSettings/aboutUsScreen.dart';
import 'package:shopmobile/ui/features/Profile/subSettings/contactUsScreen.dart';
import 'package:shopmobile/ui/features/Profile/subSettings/helpCenterScreen.dart';
import 'package:shopmobile/ui/features/Profile/subSettings/privacyScreen.dart';
import 'package:shopmobile/ui/features/Profile/subSettings/settingScreen.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/features/cart/cartProvider.dart';
import 'package:shopmobile/ui/features/cart/cartScreen.dart';
import 'package:shopmobile/ui/features/category/categoryProvider.dart';
import 'package:shopmobile/ui/features/category/categoryScreen.dart';
import 'package:shopmobile/ui/features/category/subCategoryScreen.dart';
import 'package:shopmobile/ui/features/explor/explorProvider.dart';
import 'package:shopmobile/ui/features/explor/explorScreen.dart';
import 'package:shopmobile/ui/features/favorite/favoriteProvider.dart';
import 'package:shopmobile/ui/features/favorite/favoriteScreen.dart';
import 'package:shopmobile/ui/features/home.dart';
import 'package:shopmobile/ui/features/home/homeProvider.dart';
import 'package:shopmobile/ui/features/home/homeScreen.dart';
import 'package:shopmobile/ui/features/home/notificationScreen.dart';
import 'package:shopmobile/ui/features/home/productDetailsScreen.dart';
import 'package:shopmobile/ui/features/home/searchScreen.dart';
import 'package:shopmobile/ui/features/registration/checkYourMailScreen.dart';
import 'package:shopmobile/ui/features/registration/createNewPasswordScreen.dart';
import 'package:shopmobile/ui/features/registration/forgetPasswordScreen.dart';
import 'package:shopmobile/ui/features/registration/loginScreen.dart';
import 'package:shopmobile/ui/features/registration/onBoardingScreen.dart';
import 'package:shopmobile/ui/features/registration/otpScreen.dart';
import 'package:shopmobile/ui/features/registration/signUpScreen.dart';
import 'package:shopmobile/ui/features/registration/splashScreen.dart';
import 'package:shopmobile/utils/appConfig.dart';
import 'package:provider/provider.dart';
import '../ui/features/chat/screens/home_screen.dart';
import '../ui/features/chat/screens/select_user_screen.dart';
import 'routes.dart';

class RouterX {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AppConfig(),
            child: SplashScreen(),
          ),
        );
      case intro:
        return MaterialPageRoute(
          builder: (context) => const Introduction(),
        );
      case orderTrackingScreen:
        return MaterialPageRoute(
          builder: (context) => const OrderTrackingScreen(),
        );
      case myPurchessScreen:
        return MaterialPageRoute(
          builder: (context) => const MyPurchessScreen(),
        );
      case terms:
        return MaterialPageRoute(
          builder: (context) => PrivacyScreen(),
        );
      case helpCenter:
        return MaterialPageRoute(
          builder: (context) => HelpCenterScreen(),
        );
      case contactus:
        return MaterialPageRoute(
          builder: (context) => ContactUsScreen(),
        );
      case aboutus:
        return MaterialPageRoute(
          builder: (context) => AboutUsScreen(),
        );
      case pagesEnd:
        return MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => HomeProvider(),
              ),
              ChangeNotifierProvider(
                create: (context) => FavouriteProvider(),
              ),
            ],
            child: PagesTestWidget(currentTab: settings.arguments as int),
          ),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: LoginScreen(),
          ),
        );

      case signUp:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: Signup(),
          ),
        );

      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: ForgetPassword(),
          ),
        );

      case cheackYourMail:
        return MaterialPageRoute(
          builder: (context) => const CheackYourEmail(),
        );
      case chat:
        return MaterialPageRoute(
          builder: (context) =>  HomeScreen(),
        );

      case createNewPassword:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: CreateNewPassword(),
          ),
        );

      case otp:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => AuthProvider(),
            child: OTP(),
          ),
        );
      case productDetilas:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<HomeProvider>(),
            child: ProductDetails(id: (settings.arguments as List)[0]),
          ),
        );

      case home:
        return MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider.value(
                value: sl<HomeProvider>(),
                child: Home(),
              ),
              ChangeNotifierProvider.value(
                value: sl<FavouriteProvider>(),
                child: FavoriteScreen(),
              ),
              ChangeNotifierProvider.value(
                value: sl<CartProvider>(),
                child: Cart(),
              ),
              ChangeNotifierProvider.value(
                value: sl<ExploreProvider>(),
                child: Explore(),
              ),
              ChangeNotifierProvider.value(
                value: sl<ProfileProvider>(),
                child: Profile(),
              ),
            ],
            child: PagesTestWidget(
              currentTab: 0,
            ),
          ),
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<ProfileProvider>(),
            child: ProfileEditing(),
          ),
        );
      case address:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<ProfileProvider>(),
            child: AddressScreen(),
          ),
        );
      case cart:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<CartProvider>(),
            child: Cart(show: true),
          ),
        );
      case categoryScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<CategoryProvider>(),
            child: CategoryScreen(),
          ),
        );

      case subCategoryScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<CategoryProvider>(),
            child: SubCategoryScreen(),
          ),
        );

      case setting:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<ProfileProvider>(),
            child: Setting(),
          ),
        );
      case paymentMethodScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<ProfileProvider>(),
            child: PaymentMethodScreen(),
          ),
        );
      case paymentDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<ProfileProvider>(),
            child: PaymentDetailsScreen(),
          ),
        );

      case searchScreen:
        return MaterialPageRoute(
          builder: (_) => SearchScreen(),
        );

      case notifications:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: sl<HomeProvider>(),
            child: NotificationScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
