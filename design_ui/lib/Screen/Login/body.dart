import 'package:design_ui/Components/password_container.dart';
import 'package:design_ui/Components/rounded_button.dart';
import 'package:design_ui/Components/text_filed_contaier.dart';
import 'package:design_ui/Screen/Login/background.dart';
import 'package:design_ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              TextFiledContainer(
                  hintText: "Your email",
                  iconData: Icons.email,
                  onChanged: (value) {}),
              PasswordContainer(
                onChanged: (value) {},
              ),
              RoundedButton(
                  text: "Login",
                  textColor: Colors.white,
                  press: () {},
                  color: kPrimaryColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      color: kPrimaryColor
                    )),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
