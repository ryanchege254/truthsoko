import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/src/Widget/bezierContainer.dart';
import 'package:truthsoko/src/Widget/textfield_widget.dart';
import 'package:truthsoko/Pages/loginPage.dart';
import 'package:page_transition/page_transition.dart';

import '../src/models/textview_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController? _username;
  TextEditingController? _email;
  TextEditingController? _passwordController;

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

  Widget _submitButton() {
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
  }

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

  Widget _emailPasswordWidget() {
    late bool revealPassword;

    return Column(
      children: <Widget>[
        TextFieldWidget(
          controller: _username,
          hintText: "Username",
          prefixIconData: Icons.person,
          suffixIconData: null,
          obscureText: false,
          onChanged: (value) {},
          matchPassword: false,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFieldWidget(
          controller: _email,
          hintText: "Email",
          prefixIconData: Icons.email,
          suffixIconData: null,
          obscureText: false,
          onChanged: (value) {},
          matchPassword: false,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFieldWidget(
          controller: _passwordController,
          hintText: "Password",
          prefixIconData: Icons.lock_outline,
          suffixIconData: context.read<TextviewModel>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          obscureText: true,
          onChanged: (value) {},
          matchPassword: false,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFieldWidget(
          controller: _passwordController,
          hintText: "Confirm Password",
          prefixIconData: Icons.lock_outline_sharp,
          suffixIconData: context.read<TextviewModel>().isVisible
              ? Icons.visibility
              : Icons.visibility_off,
          obscureText: true,
          onChanged: (value) {
            /* if (value != _password) {
                // ignore: avoid_print
                print("matching");
                const SnackBar(
                  content: Text("Passwords do not match, Try again"),
                  duration: Duration(seconds: 2),
                );
              }*/
          },
          matchPassword: true,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    @override
    void dispose() {
      Navigator.of(context).pop();
      super.dispose();
    }

    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Builder(builder: (context) {
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
                      _emailPasswordWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      _submitButton(),
                      SizedBox(height: height * .14),
                      SignInButton(
                        Buttons.Google,
                        text: "Sign up with Google",
                        onPressed: () async {
                          await context
                              .read<UserRepository>()
                              .signInWithGoogle();
                          print("Logged in");
                        },
                      ),
                      SizedBox(height: height * .14),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              );
            }),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
