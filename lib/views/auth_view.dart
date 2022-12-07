// ignore_for_file: use_build_context_synchronously

import 'package:expense_trackr/components/buttons.dart';
import 'package:expense_trackr/components/text_form_field.dart';
import 'package:expense_trackr/providers/auth_provider.dart';
import 'package:expense_trackr/shared/app_colors.dart';
import 'package:expense_trackr/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../components/icon_button.dart';
import '../service/auth_service.dart';
import '../shared/app_toasts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '848644210356-jp1j5o7d39vsbb5fdlns2bot8j4tr89u.apps.googleusercontent.com',
    // scopes: [
    //   'email',
    //   'https://www.googleapis.com/auth/contacts.readonly',
    // ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppImages.logoIcon),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputFormField(
                        label: 'Email',
                        prefixIcon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                        controller: emailController,
                        errorMessage: 'Email Required',
                        isSpecialField: false,
                      ),
                      Consumer<AuthProvider>(
                          builder: ((context, provider, child) {
                        return InputFormField(
                          label: 'Password',
                          prefixIcon: Icons.lock_outline,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.visiblePassword,
                          iconChangeValue: provider.iconVal,
                          obsecureTextVal: provider.iconVal,
                          pressToChangeSuffexIcon: () {
                            provider.setIconValue(!provider.iconVal);
                          },
                          controller: passController,
                          errorMessage: 'Password Required',
                          isSpecialField: true,
                          suffixIcon1: Icons.visibility_off_outlined,
                          suffixIcon2: Icons.visibility_outlined,
                        );
                      })),

                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                          return provider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  title: 'SignIn',
                                  pressButton: () async {
                                    validateForm(provider, context);

                                    // final GoogleSignIn googleSignIn = GoogleSignIn(
                                    //     clientId:
                                    //         '848644210356-jp1j5o7d39vsbb5fdlns2bot8j4tr89u.apps.googleusercontent.com');
                                    // final GoogleSignInAccount?
                                    //     googleSignInAccount =
                                    //     await googleSignIn.signIn();
                                  },
                                  textColor: AppColors.whiteColor,
                                  buttonBg: AppColors.secondaryColor);
                        },
                      ),

                      // CustomButton(
                      //     title: 'sigin with google',
                      //     pressButton: () {},
                      //     textColor: Colors.white,
                      //     buttonBg: AppColors.primaryColor)

                      //  )

                      CustomIconButton(
                          title: 'sigin with google',
                          pressButton: () async {
                            AuthService.signInWithGoogle();

                            // GoogleSignIn _googleSignIn = GoogleSignIn(
                            //   scopes: [
                            //     'email',
                            //   ],
                            // );
                            // try {
                            //   // await _googleSignIn.signIn();

                            //   // print(_googleSignIn.isSignedIn());

                            //   GoogleSignInAccount? googleSignInAccount =
                            //       await _googleSignIn.signIn();
                            //   GoogleSignInAuthentication
                            //       googleSignInAuthentication =
                            //       await googleSignInAccount!.authentication;

                            //       print(googleSignInAuthentication.accessToken);
                            // } catch (error) {
                            //   print(error);
                            // }
                          },
                          textColor: Colors.white,
                          buttonBg: AppColors.primaryColor)
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  validateForm(AuthProvider authProvider, BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      formKey.currentState!.save();

      authProvider.setLoading(true);
      String res = await AuthService.signInUser(
          emailController.text, passController.text);

      if (res == 'ok') {
        //  AppToasts.showToast(message: '');
        authProvider.setLoading(true);
        emailController.clear();
        passController.clear();
        context.go("/home");
      } else {
        AppToasts.showToast(message: res);
        authProvider.setLoading(false);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.clear();
    passController.clear();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }
}
