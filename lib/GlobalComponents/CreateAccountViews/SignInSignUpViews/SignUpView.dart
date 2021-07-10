import 'package:flutter/material.dart';
import 'package:fonz_music_flutter/GlobalComponents/FrontEnd/FrontEndConstants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

final _signUpKey = GlobalKey<FormState>();

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  bool agreedToEmail = false;
  bool agreedToPolicy = false;
  String _email;
  String _displayName;
  String _password;
  String _confirmPassword;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpKey,
      child: Column(
        children: [
          ShowUserNameInputSignUp(),
          ShowEmailInputSignUp(),
          ShowPasswordInputSignUp(),
          ShowConfirmPasswordInputSignUp(),
          OrAppleOrGoogle(),
          AgreeToPolicies(),
          ShowSignUpButton(),
        ],
      ),
    );
  }

  Widget ShowUserNameInputSignUp() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 50,
      child: Neumorphic(
        style: NeumorphicStyle(
            color: determineColorThemeBackground(),
            shadowDarkColor: determineColorThemeTextInverse()
        ),
        child: TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGFIVE,
            color: determineColorThemeTextInverse(),
          ),
          decoration: InputDecoration(
            hintText: "display name",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          onChanged: (value) {
            setState(() {
              _displayName = value;
            });
//            print(_email);
          },
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) => _displayName = value.trim(),
        ),
      ),
    );
  }

  Widget ShowEmailInputSignUp() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        height: 50,
        child: Neumorphic(
          style: NeumorphicStyle(
            color: determineColorThemeBackground(),
              shadowDarkColor: determineColorThemeTextInverse()
          ),
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            style: TextStyle(
              fontFamily: FONZFONTTWO,
              fontSize: HEADINGFIVE,
              color: determineColorThemeTextInverse(),
            ),
            decoration: InputDecoration(
              hintText: "email",
              border: InputBorder.none,
              contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            onChanged: (value) {
              setState(() {
                _email = value;
              });
//            print(_email);
            },
            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _email = value.trim(),
          ),
        ),
    );
  }



  Widget ShowPasswordInputSignUp() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 50,
      child: Neumorphic(
        style: NeumorphicStyle(
          color: determineColorThemeBackground(),
            shadowDarkColor: determineColorThemeTextInverse()
        ),
        child: TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGFIVE,
            color: determineColorThemeTextInverse(),
          ),
          decoration: InputDecoration(
            hintText: "password",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          onChanged: (value) {
            setState(() {
              _password = value;
            });
            print(_password);
          },
          validator: (value) =>
          value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _password = value.trim(),
        ),
      ),
    );
  }

  Widget ShowConfirmPasswordInputSignUp() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 50,
      child: Neumorphic(
        style: NeumorphicStyle(
          color: determineColorThemeBackground(),
          shadowDarkColor: determineColorThemeTextInverse()
        ),
        child: TextFormField(
          maxLines: 1,
          obscureText: true,
          autofocus: false,
          style: TextStyle(
            fontFamily: FONZFONTTWO,
            fontSize: HEADINGFIVE,
            color: determineColorThemeTextInverse(),
          ),
          decoration: InputDecoration(
            hintText: "confirm password",
            border: InputBorder.none,
            contentPadding:
            EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          ),
          onChanged: (value) {
            setState(() {
              _confirmPassword = value;
            });
            print(_confirmPassword);
          },
          validator: (value) =>
          value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) => _confirmPassword = value.trim(),
        ),
      ),
    );
  }

  Widget ShowSignUpButton() {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return new Padding(
      padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        width: width * 0.7,
        child: NeumorphicButton(
          // shape: new RoundedRectangleBorder(
          //   borderRadius: new BorderRadius.circular(10.0),
          // ),
          style: NeumorphicStyle(
            color: AMBER,
          ),
          child: Center(
            child: new Text(
              'sign up',
              style: TextStyle(
                fontFamily: FONZFONTTWO,
                fontSize: HEADINGFIVE,
                color: Colors.white,
              ),
            ),
          ),
          onPressed: () async {
//            log("email input" + _email);
//            log("pass input" + _password);
//             await signUpUser(_email, _password, _signUpKey);
          },
        ),
      ),
    );
  }

  Widget OrAppleOrGoogle() {

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Center(
              child: Text(
                'or',
                style: TextStyle(
                  fontFamily: FONZFONTTWO,
                  fontSize: HEADINGFIVE,
                  color: determineColorThemeTextInverse(),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Spacer(),
              Neumorphic(
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.black,
                    shadowDarkColor: determineColorThemeTextInverse()

                ),
                child: MaterialButton(
                  child: Container(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage("assets/thirdParties/appleLogoWhite.png"),
                    ),
                  ),
                ),

              ),
              Neumorphic(
                style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.circle(),
                    color: Colors.white,
                    shadowDarkColor: determineColorThemeTextInverse()

                ),
                child: MaterialButton(
                  child: Container(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage("assets/thirdParties/googleLogo.png"),
                    ),
                  ),
                ),
                  
              ),

              Spacer()
            ],
          )
        ],
      ),
    );
  }

  Widget AgreeToPolicies() {

    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Column(
          children: [
            Container(
              height: 25,
              padding: EdgeInsets.all(0),
              child: Row(
                  children: [
                    Checkbox(
                      value: agreedToEmail,
                      onChanged: (value) {
                        setState(() {
                          agreedToEmail = !agreedToEmail;
                        });

                      },
                      activeColor: AMBER,
                    ),
                    Text(
                      "i agree to Fonz Music's email policy",
                      style: TextStyle(
                          fontFamily: FONZFONTONE,
                          fontSize: 12,
                          color: determineColorThemeTextInverse()),
                    ),
                  ]
              ),
            ),
            Container(
              height: 25,
              padding: EdgeInsets.all(0),
              child: Row(
                  children: [
                    Checkbox(
                      value: agreedToPolicy,
                      onChanged: (value) {
                        setState(() {
                          agreedToPolicy = !agreedToPolicy;
                        });
                      },
                      activeColor: AMBER,
                    ),
                    Text(
                      "i agree to Fonz Music's privacy policy",
                      style: TextStyle(
                          fontFamily: FONZFONTONE,
                          fontSize: 12,
                          color: determineColorThemeTextInverse()),
                    ),
                  ]
              ),
            ),
          ],
        ),
      );
  }

}