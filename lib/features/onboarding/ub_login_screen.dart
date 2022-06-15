import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ubenwa_cart/components/ub_button.dart';
import 'package:ubenwa_cart/components/ub_form.dart';
import 'package:ubenwa_cart/components/ub_scaffold.dart';
import 'package:ubenwa_cart/data/controllers/login_controller.dart';
import 'package:ubenwa_cart/data/models/login_response.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/navigation/app_routes.dart';
import 'package:ubenwa_cart/navigation/navigation_service.dart';
import 'package:ubenwa_cart/utils/constants.dart';

class UBLoginScreen extends StatefulWidget {
  const UBLoginScreen({Key? key}) : super(key: key);

  @override
  State<UBLoginScreen> createState() => _UBLoginScreenState();
}

class _UBLoginScreenState extends State<UBLoginScreen> {
  late LoginController _authController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _authController = Provider.of<LoginController>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _authController.loginResourceState,
        builder: (context, snapshot) {
          if (snapshot.data is Success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if ((snapshot.data as Success).data is LoginResponse) {
                GetIt.I.get<NavigationService>().clearAllTo(
                      routeName: AppRoutes.home,
                    );
              }
            });
          }
          return UBScaffold(
            key: _scaffoldKey,
            disablePointer: snapshot.data is Loading,
            builder: (context) => SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Test App",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: deepDarkBlueColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: kExtraFullPadding),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: kRegularPadding,
                            vertical: kRegularPadding),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(kExtraMediumPadding)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(
                                      color: deepDarkBlueColor,
                                      fontWeight: FontWeight.bold),
                            ),
                            UBForm(
                              hintText: 'Email',
                              controller: _emailController,
                              onChange: (String email) {
                                _authController.setLoginEmail = email;
                              },
                            ),
                            UBForm(
                              hintText: 'Password',
                              controller: _passwordController,
                              onChange: (String password) {
                                _authController.setLoginPassword = password;
                              },
                              forPassword: true,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text("Forgot Password?",
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ubPrimaryColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w500)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: kExtraMediumPadding,
                                  bottom: kExtraFullPadding),
                              child: UBButton(
                                title: "Login",
                                loadingStream:
                                    _authController.loginResourceState,
                                callback: () =>
                                    _authController.initiateUserLogin(),
                              ),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "Don't have an account? ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: gray3Color,
                                        )),
                                TextSpan(
                                    text: "SignUp",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          GetIt.I.get<NavigationService>().to(
                                                routeName: AppRoutes.register,
                                              ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: ubPrimaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w500)),
                              ]),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: ubBackgroundColor,
          );
        });
  }
}
