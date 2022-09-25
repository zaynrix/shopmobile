class ApiConstant {
  static bool SoftTagi = false;

  static String url = SoftTagi
      ? "https://backend-shop-apps.herokuapp.com/api/"
      : "https://student.valuxapps.com/api/";

  static String authLogin = SoftTagi
      ? 'auth/login' : "login";

  static String authSignup = SoftTagi
      ? '/auth/signup': "/register";

  static String otpCode = SoftTagi
      ? 'auth/verify-mobile':"verify-code";

  static String resendCode = SoftTagi
      ? 'auth/resend-code' :"";

  static String forgetPassword = SoftTagi
      ? 'auth/forget':"reset-password";

  static String confirmCodePassword = SoftTagi
      ? 'auth/confirm':"change-password";


  static String home = SoftTagi
      ? 'auth/confirm':"/home";


  static String favorites = "/favorites";
  static String categories = "/categories";
  static String carts = "/carts";
  static String logout = "/logout";
  static String changePassword = "/change-password";
  static String updateProfile = "/update-profile";
  static String products = "/products";
  static String search = "/products/search";
  static String notifications = "/notifications";
  static String adress = "/addresses";
  static String aboutUs = "/settings";
  static String contactUs = "/contacts";
  static String faqs = "/faqs";
}
