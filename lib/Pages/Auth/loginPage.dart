// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/src/models/textview_model.dart';
import 'package:truthsoko/Pages/Auth/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:truthsoko/src/Widget/bezierContainer.dart';
import 'package:truthsoko/src/Widget/constants.dart';
import 'package:truthsoko/src/Widget/textfield_widget.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'Forgotpassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController? _email = TextEditingController();
  final TextEditingController? _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ScaffoldMessengerState _scaffold;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            reverseDuration: const Duration(milliseconds: 600),
            duration: const Duration(milliseconds: 600),
            type: PageTransitionType.rightToLeftWithFade,
            child: const SignUpPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color.fromARGB(255, 52, 146, 34),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Tru',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 69, 148, 23)),
          children: [
            TextSpan(
              text: 'th',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'Soko',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    @override
    // ignore: unused_element
    void initState() {
      _email!.text = "";
      _password!.text = '';
      super.initState();
    }

    return Scaffold(
      body: SizedBox(
        height: height,
        child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => TextviewModel()),
              ChangeNotifierProvider.value(value: UserRepository.instance())
            ],
            child: Consumer<UserRepository>(
                builder: (context, UserRepository user, child) {
              return SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: -height * .15,
                        right: -MediaQuery.of(context).size.width * .4,
                        child: const BezierContainer()),
                    Form(
                      key: _formKey,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Consumer<TextviewModel>(
                              builder: (context, TextviewModel model, child) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: height * .2),
                                _title(),
                                const SizedBox(height: 50),
                                // _emailPasswordWidget(),
                                TextFieldWidget(
                                  controller: _email,
                                  hintText: 'Email',
                                  obscureText: false,
                                  prefixIconData: Icons.mail_outline,
                                  suffixIconData:
                                      context.read<TextviewModel>().isValid
                                          ? Icons.check
                                          : null,
                                  onChanged: (value) {
                                    /*context
                                          .read<TextviewModel>()
                                          .isValid
                                          .isValidEmail(value);*/
                                  },
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      TextFieldWidget(
                                        controller: _password,
                                        hintText: 'Password',
                                        obscureText: context
                                                .read<TextviewModel>()
                                                .isVisible
                                            ? false
                                            : true,
                                        prefixIconData: Icons.lock_outline,
                                        suffixIconData: context
                                                .read<TextviewModel>()
                                                .isVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        onChanged: (String) {},
                                      ),
                                    ]),
                                const SizedBox(height: 20),
                                context.read<UserRepository>().status ==
                                        Status.Authenticating
                                    ? const Padding(
                                        padding: EdgeInsets.all(80),
                                        child: LoadingIndicator(
                                          indicatorType:
                                              Indicator.ballGridPulse,
                                          colors: [
                                            Global.orange,
                                            Global.green,
                                            Global.yellow
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                    color: Colors.grey.shade200,
                                                    offset: const Offset(2, 4),
                                                    blurRadius: 5,
                                                    spreadRadius: 2)
                                              ],
                                              gradient: const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Color(0xfffbb448),
                                                    Color.fromARGB(
                                                        255, 186, 247, 43)
                                                  ])),
                                          child: const Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onTap: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (!await context
                                                .read<UserRepository>()
                                                .signIn(
                                                    context,
                                                    _email!.text.trim(),
                                                    _password!.text.trim())) {
                                              print(
                                                  "///////////////////Something went wrong...........:  ");
                                            } else {
                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                      ),
                                GestureDetector(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    alignment: Alignment.centerRight,
                                    child: const Text('Forgot Password ?',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Forgot()));
                                  },
                                ),
                                _divider(),
                                SizedBox(height: height * .055),
                                SignInButton(
                                  Buttons.Google,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  elevation: 10,
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 5, bottom: 5),
                                  text: "Sign In with Google",
                                  onPressed: () async {
                                    final provider =
                                        Provider.of<UserRepository>(context,
                                            listen: false);
                                    await provider.signInWithGoogle();
                                  },
                                ),
                                SizedBox(height: height * .055),
                                _createAccountLabel(),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    Positioned(top: 40, left: 0, child: _backButton()),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
