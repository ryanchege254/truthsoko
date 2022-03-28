import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/Widget/bezierContainer.dart';
import '../src/Widget/textfield_widget.dart';
import '../src/models/textview_model.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPassword();
}

class ForgotPassword extends State<Forgot> {
  TextEditingController? _forgotPassword;
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

  Widget _resetButton(BuildContext context) {
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
                  colors: [
                    Color(0xfffbb448),
                    Color.fromARGB(255, 186, 247, 43)
                  ])),
          child: const Text(
            'Reset Password',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        onTap: () async {
          await context
              .read<UserRepository>()
              .verifyEmail(context, _forgotPassword);
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        height: height,
        child: ChangeNotifierProvider(
          create: (newContext) => TextviewModel(),
          child: Builder(builder: (context) {
            return Stack(children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        const SizedBox(height: 50),
                        // _emailPasswordWidget(),
                        TextFieldWidget(
                          controller: _forgotPassword,
                          hintText: 'Enter valid Email',
                          obscureText: false,
                          prefixIconData: Icons.mail_outline,
                          suffixIconData: context.read<TextviewModel>().isValid
                              ? Icons.check
                              : null,
                          onChanged: (value) {
                            /*context
                                .read<TextviewModel>()
                                .isValid
                                .isValidEmail(value);*/
                          },
                          matchPassword: false,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _resetButton(context)
                      ]),
                ),
              )
            ]);
          }),
        ),
      ),
    );
  }
}
