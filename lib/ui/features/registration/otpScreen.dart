import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopmobile/resources/assets_manager.dart';
import 'package:shopmobile/resources/color_manager.dart';
import 'package:shopmobile/resources/font_manager.dart';
import 'package:shopmobile/ui/features/auth_provider.dart';
import 'package:shopmobile/ui/shared/widgets/CustomCTAButton.dart';
import 'package:shopmobile/ui/shared/widgets/CustomeSvg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var onTapRecognizer;
  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, _) => Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 1,
                ),
                CustomSvgAssets(
                  // color: Colors.tr,
                  path: ImageAssets.phoneVerification,
                ),
                SizedBox(
                  height: 44.h,
                ),
                Text('Phone Verification',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: FontSize.s22.sp)),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                    'We need to register your phone number before getting srated!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        color: ColorManager.lightGrey,
                        fontSize: FontSize.s14.sp)),
                GestureDetector(
                  onTap: () {},
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      Form(
                        key: provider.formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              appContext: context,
                              length: 4,
                              obscureText: true,
                              obscuringCharacter: '*',
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 3) {
                                  return "";
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                selectedColor: ColorManager.primaryGreen,
                                shape: PinCodeFieldShape.box,
                                inactiveFillColor: ColorManager.parent,
                                selectedFillColor: ColorManager.white,
                                borderRadius: BorderRadius.circular(12.r),
                                fieldHeight: 56.h,
                                fieldWidth: 56.w,
                                activeFillColor: ColorManager.white,
                                inactiveColor: ColorManager.strokSuger,
                                activeColor: ColorManager.primaryGreen,
                              ),
                              cursorColor: ColorManager.lightGrey,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              textStyle:
                                  const TextStyle(fontSize: 20, height: 1.6),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: provider.pinController,
                              keyboardType: TextInputType.number,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  provider.currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                return true;
                              },
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomeCTAButton(
                  ProgressColor: ColorManager.white,
                  title: "Verify phone number",
                  trigger: provider.loading,
                  primary: ColorManager.primaryGreen,
                  onPressed: () {
                    provider.otpProvider();
                  },

                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  "Edit phone number?",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: ColorManager.secondryBlack),
                ),
                SizedBox(
                  height: 32.h,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    primary: ColorManager.seconderyGreen.withOpacity(1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: () {
                    provider.reSendProvider();
                  },
                  child: Text(
                    "Send again",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: ColorManager.primaryGreen),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
