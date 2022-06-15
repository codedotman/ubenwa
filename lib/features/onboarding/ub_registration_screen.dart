import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:ubenwa_cart/components/ub_button.dart';
import 'package:ubenwa_cart/components/ub_form.dart';
import 'package:ubenwa_cart/components/ub_scaffold.dart';
import 'package:ubenwa_cart/data/controllers/registration_controller.dart';
import 'package:ubenwa_cart/data/models/user_registration_response.dart';
import 'package:ubenwa_cart/data/resource.dart';
import 'package:ubenwa_cart/navigation/app_routes.dart';
import 'package:ubenwa_cart/navigation/navigation_service.dart';
import 'package:ubenwa_cart/utils/constants.dart';

class UBRegistrationScreen extends StatefulWidget {
  const UBRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<UBRegistrationScreen> createState() => _UBRegistrationScreenState();
}

class _UBRegistrationScreenState extends State<UBRegistrationScreen> {
  late final RegistrationController _authController;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _authController =
        Provider.of<RegistrationController>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: _authController.userRegistrationResourceState,
        builder: (context, snapshot) {
          if (snapshot.data is Success) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if ((snapshot.data as Success).data is UserRegistrationResponse) {
                GetIt.I.get<NavigationService>().clearAllTo(
                      routeName: AppRoutes.home,
                    );
              }
            });
          }
          return UBScaffold(
            scaffoldKey: _scaffoldKey,
            disablePointer: snapshot.data is Loading,
            appBar: AppBar(
              backgroundColor: ubBackgroundColor,
            ),
            builder: (context) => ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Test App",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: deepDarkBlueColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: kExtraFullPadding),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: kRegularPadding,
                          vertical: kRegularPadding),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Text(
                            "SignUp",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    color: deepDarkBlueColor,
                                    fontWeight: FontWeight.bold),
                          ),
                          UBForm(
                            hintText: 'First Name',
                            controller: _firstNameController,
                            onChange: (String fistName) {
                              _authController.setRegistrationFirstName =
                                  fistName;
                            },
                          ),
                          UBForm(
                            hintText: 'Last Name',
                            controller: _lastNameController,
                            onChange: (String lastName) {
                              _authController.setRegistrationLastName =
                                  lastName;
                            },
                          ),
                          UBForm(
                              hintText: 'Email',
                              controller: _emailController,
                              onChange: (String email) {
                                _authController.setRegistrationEmail = email;
                              }),
                          UBForm(
                              hintText: 'Password',
                              forPassword: true,
                              controller: _passwordController,
                              onChange: (password) {
                                _authController.setRegistrationPassword =
                                    password;
                              }),
                          SizedBox(height: kRegularPadding),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "By entering your details, your are agreeing to our  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: gray3Color,
                                      )),
                              TextSpan(
                                  text: "Terms of Service ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ubPrimaryColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: "and  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: gray3Color,
                                      )),
                              TextSpan(
                                  text: "Privacy Policy.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ubPrimaryColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400)),
                              TextSpan(
                                  text: "Thanks!  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        color: gray3Color,
                                      )),
                            ]),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: kExtraMediumPadding),
                            child: UBButton(
                              title: "Sign up",
                              callback: () =>
                                  _authController.initiateUserRegistration(),
                              loadingStream:
                                  _authController.userRegistrationResourceState,
                            ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Already have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: gray3Color,
                                      )),
                              TextSpan(
                                  text: "Login",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pop(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(
                                          color: ubPrimaryColor,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w400)),
                            ]),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
              ],
            ),
            backgroundColor: ubBackgroundColor,
          );
        });
  }
}
