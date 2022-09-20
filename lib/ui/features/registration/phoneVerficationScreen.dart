// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile_shop/di.dart';
// import 'package:mobile_shop/resources/assets_manager.dart';
// import 'package:mobile_shop/resources/color_manager.dart';
// import 'package:mobile_shop/resources/font_manager.dart';
// import 'package:mobile_shop/resources/styles_manager.dart';
// import 'package:mobile_shop/routing/navigation.dart';
// import 'package:mobile_shop/routing/routes.dart';
// import 'package:mobile_shop/ui/features/auth_provider.dart';
// import 'package:mobile_shop/ui/shared/widgets/CustomCTAButton.dart';
// import 'package:mobile_shop/ui/shared/widgets/CustomeSvg.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:provider/provider.dart';
//
// class PhoneVerfications extends StatelessWidget {
//   const PhoneVerfications({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AuthProvider>(
//       builder: (context, provider, _) => Scaffold(
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 25.w),
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Spacer(
//                   flex: 1,
//                 ),
//                 CustomeSvgAssets(
//                   // color: Colors.tr,
//                   path: ImageAssets.phoneVerification,
//                 ),
//                 SizedBox(
//                   height: 44.h,
//                 ),
//                 Text('Phone Verification',
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline1!
//                         .copyWith(fontSize: FontSize.s22.sp)),
//                 SizedBox(
//                   height: 16.h,
//                 ),
//                 Text(
//                     'We need to register your phone number before getting srated!',
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.subtitle2!.copyWith(
//                         color: ColorManager.lightGrey,
//                         fontSize: FontSize.s14.sp)),
//                 SizedBox(
//                   height: 33.h,
//                 ),
//                 Material(
//                   color: Colors.white,
//                   elevation: 2,
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: InternationalPhoneNumberInput(
//                       onInputChanged: (PhoneNumber number) {
//                         print(number.phoneNumber);
//                       },
//                       onInputValidated: (bool value) {
//                         print(value);
//                       },
//                       selectorConfig: SelectorConfig(
//                         selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                       ),
//                       ignoreBlank: false,
//                       autoValidateMode: AutovalidateMode.disabled,
//                       selectorTextStyle: TextStyle(color: Colors.black),
//                       initialValue: provider.number,
//                       textFieldController: provider.phoneVerficationController,
//                       formatInput: false,
//                       keyboardType: TextInputType.numberWithOptions(
//                           signed: true, decimal: true),
//                       inputDecoration: InputDecoration(
//                         filled: true,
//                         errorStyle: const TextStyle(
//                             height: 0, color: Colors.transparent),
//                         hintStyle: getRegularStyle(
//                             color: ColorManager.lightGrey,
//                             fontSize: FontSize.s16.sp),
//                         fillColor: Colors.white70,
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide:
//                               BorderSide(color: Colors.transparent, width: 3),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                           borderSide: BorderSide(color: Colors.transparent),
//                         ),
//                       ),
//                       onSaved: (PhoneNumber number) {
//                         print('On Saved: $number');
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 24.h,
//                 ),
//                 CustomeCTAButton(
//                   primary: ColorManager.primaryGreen,
//                   onPressed: () {
//                     sl<NavigationService>().navigateTo(otp);
//                   },
//                   title: "Send OTP",
//                 ),
//                 SizedBox(
//                   height: 24.h,
//                 ),
//
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     provider.formKey.currentState?.validate();
//                 //   },
//                 //   child: Text('Validate'),
//                 // ),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     provider.getPhoneNumber('+972592487533');
//                 //   },
//                 //   child: Text('Update'),
//                 // ),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     provider.formKey.currentState?.save();
//                 //     print("Done");
//                 //   },
//                 //   child: Text('Save'),
//                 // ),
//                 Spacer(
//                   flex: 2,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
