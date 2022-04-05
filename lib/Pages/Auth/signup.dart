import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/src/Widget/bezierContainer.dart';
import 'package:truthsoko/src/Widget/textfield_widget.dart';
import 'package:truthsoko/Pages/Auth/loginPage.dart';
import 'package:page_transition/page_transition.dart';

import 'package:truthsoko/src/Widget/color.dart';
import 'package:truthsoko/src/models/textview_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController? _username = TextEditingController();
  final TextEditingController? _email = TextEditingController();
  final TextEditingController? _passwordController = TextEditingController();
  final TextEditingController? _confirmpasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  /*Widget _submitButton(context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
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
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: const Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        if (!await context
            .read<UserRepository>()
            .signIn(_email!.text, _passwordController!.text)) {
          print("Registered");
        }
      },
    );
  }*/

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            curve: Curves.linear,
            reverseDuration: const Duration(milliseconds: 600),
            duration: const Duration(milliseconds: 600),
            type: PageTransitionType.leftToRightWithFade,
            child: const LoginPage(),
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
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
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
              color: Color.fromARGB(255, 54, 148, 31)),
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
    void dispose() {
      super.dispose();
    }

    return Scaffold(
      key: _key,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Stack(children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            _loginAccountLabel(),
            Form(
              key: _formKey,
              child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (context) => TextviewModel()),
                    ChangeNotifierProvider.value(
                        value: UserRepository.instance())
                  ],
                  child: Consumer<UserRepository>(
                      builder: (context, UserRepository user, child) {
                    final provider =
                        Provider.of<UserRepository>(context, listen: false);
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: height * .2),
                            _title(),
                            const SizedBox(
                              height: 50,
                            ),
                            Consumer<TextviewModel>(
                                builder: (context, TextviewModel model, child) {
                              return Column(
                                children: <Widget>[
                                  TextFieldWidget(
                                    controller: _email,
                                    hintText: "Email",
                                    prefixIconData: Icons.email,
                                    suffixIconData: null,
                                    obscureText: false,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFieldWidget(
                                    controller: _passwordController,
                                    hintText: "Password",
                                    prefixIconData: Icons.lock_outline,
                                    suffixIconData: model.isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    obscureText: model.isVisible,
                                    onChanged: (value) {},
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  TextFieldWidget(
                                    controller: _confirmpasswordController,
                                    hintText: "Confirm Password",
                                    prefixIconData: Icons.lock_outline_sharp,
                                    suffixIconData: null,
                                    obscureText: true,
                                    onChanged: (value) {},
                                  )
                                ],
                              );
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            // _submitButton(context),
                            provider.status == Status.Authenticating
                                ? const Padding(
                                    padding: EdgeInsets.all(64),
                                    child: LoadingIndicator(
                                      strokeWidth: 5,
                                      indicatorType: Indicator.ballGridPulse,
                                      colors: [
                                        Global.orange,
                                        Global.green,
                                        Global.yellow
                                      ],
                                    ),
                                  )
                                : GestureDetector(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
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
                                                Color(0xfff7892b)
                                              ])),
                                      child: const Text(
                                        'Register Now',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                    onTap: () async {
                                      _formKey.currentState!.validate();

                                      if (_confirmpasswordController!.text ==
                                          _passwordController!.text) {
                                        if (!await provider.signUp(
                                            context,
                                            _email!.text.trim(),
                                            _passwordController!.text.trim())) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      "Something Went Wrong")));
                                        } else {
                                          Navigator.of(context).pop();
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Passwords do not match")));
                                      }
                                    }),
                            SizedBox(height: height * .14),
                            SignInButton(
                              Buttons.Google,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 10,
                              padding: const EdgeInsets.only(
                                  left: 40, right: 40, top: 5, bottom: 5),
                              text: "Sign up with Google",
                              onPressed: () async {
                                final provider = Provider.of<UserRepository>(
                                    context,
                                    listen: false);
                                provider.signInWithGoogle().catchError((e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())));
                                });
                              },
                            ),
                            SizedBox(height: height * .14),
                          ],
                        ),
                      ),
                    );
                  })),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ]),
        ),
      ),
    );
  }
}
