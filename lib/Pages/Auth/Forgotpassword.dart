import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/src/Widget/bezierContainer.dart';
import 'package:truthsoko/src/Widget/textfield_widget.dart';
import 'package:truthsoko/src/models/textview_model.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPassword();
}

class ForgotPassword extends State<Forgot> {
  final _forgotPassword = TextEditingController();
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

  Widget _resetButton() {
    return Consumer<UserRepository>(
        builder: (context, UserRepository user, child) {
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
            await user.resetPassword(context, _forgotPassword.text.trim());
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            height: height,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: TextviewModel()),
                ChangeNotifierProvider.value(value: UserRepository.instance())
              ],
              child: Stack(children: <Widget>[
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
                          Consumer<TextviewModel>(
                              builder: (context, TextviewModel model, child) {
                            return TextFieldWidget(
                              controller: _forgotPassword,
                              hintText: 'Enter valid Email',
                              obscureText: false,
                              prefixIconData: Icons.mail_outline,
                              suffixIconData:
                                  model.isValid ? Icons.check : null,
                              onChanged: (value) {},
                            );
                          }),
                          const SizedBox(
                            height: 10.0,
                          ),
                          _resetButton()
                        ]),
                  ),
                )
              ]),
            )),
      ),
    );
  }
}
