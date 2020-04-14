import 'dart:js';

import 'package:Quiz_web/Models/userState.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:Quiz_web/Services/Providers/loginListener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
class Dialogs {
  final AuthenticationService _auth = AuthenticationService();
  loginDialog(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    var size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
          TextEditingController emailController = TextEditingController(),
              passwordController = TextEditingController();

          return AlertDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(20),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Container(
                height: 50,
                color: Color.fromRGBO(66, 87, 178, 1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )),
            content: FormBuilder(
              autovalidate: true,
              key: _fbKey,
              child: Container(
                  width: 500,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/google.png'))),
                                ),
                                SizedBox(width: 10),
                                Text('Log in with Google',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FormBuilderTextField(
                        attribute: "name",
                        controller: emailController,
                        decoration: InputDecoration(labelText: "Email"),
                        validators: [
                          FormBuilderValidators.email(
                              errorText:
                                  'Wrong Format please use proper email'),
                          FormBuilderValidators.required()
                        ],
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password', hintText: '******'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        hoverColor: Colors.amber,
                        color: Color.fromRGBO(60, 206, 206, 1),
                        minWidth: size.width,
                        onPressed: () async {
                          if (_fbKey.currentState.saveAndValidate()) {
                            print(_fbKey.currentState.value);
                            await _auth
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text)
                                .then((value) {
                                  final _loginListener = Provider.of<LoginListener>(context,listen: false);
                                _loginListener.updateStatus(
                                  state: UserState.Authenticated
                                );   Navigator.pop(context);
                                })
                                .catchError((error, stackTrace) {
                              print("outer: $error");
                              errorDialog(context, error.toString());
                              _fbKey.currentState.reset();
                            });
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )),
            ),
          );
        });
  }

  signUpDialog(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    TextEditingController userNameController = TextEditingController(),
        password1Controller = TextEditingController(),
        password2Controller = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return Scrollbar(
            child: AlertDialog(
              scrollable: true,
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(20),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              title: Container(
                  height: 50,
                  color: Color.fromRGBO(66, 87, 178, 1),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              content: FormBuilder(
                autovalidate: true,
                key: _fbKey,
                child: Container(
                    width: 500,
                    height: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/google.png'))),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Sign up with Google',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                          ),
                        ),
                        FormBuilderTextField(
                          attribute: "name",
                          controller: emailController,
                          decoration: InputDecoration(labelText: "Email"),
                          validators: [
                            FormBuilderValidators.email(
                                errorText:
                                    'Wrong Format please use proper email'),
                            FormBuilderValidators.required()
                          ],
                        ),
                        FormBuilderTextField(
                          attribute: "name",
                          controller: userNameController,
                          decoration: InputDecoration(labelText: "User Name"),
                          validators: [
                            FormBuilderValidators.minLength(5),
                            FormBuilderValidators.required()
                          ],
                        ),
                        TextFormField(
                          controller: password1Controller,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password', hintText: '******'),
                          validator: (value) => _passwordValidator(
                              value, password1Controller, password2Controller),
                        ),
                        TextFormField(
                          controller: password2Controller,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: '******'),
                          validator: (value) => _passwordValidator(
                              value, password1Controller, password2Controller),
                        ),
                        MaterialButton(
                          hoverColor: Colors.amber,
                          color: Color.fromRGBO(60, 206, 206, 1),
                          minWidth: size.width,
                          onPressed: () async {
                            print('jejedog');
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                              await _auth
                                  .registerWithEmailAndPassword(
                                      email: emailController.text,
                                      password: password1Controller.text)
                                  .then((value) {
                                      _fbKey.currentState.reset(); Navigator.pop(context);
                                      successDialog(context,message: 'Please proceed to Login');
                                       
                                  } )
                                  .catchError((error, stackTrace) {
                                print("outer: $error");
                                errorDialog(context, error.toString());
                                _fbKey.currentState.reset();
                              });
                            }
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )),
              ),
            ),
          );
        });
  }

  _passwordValidator(value, password1Controller, password2Controller) {
    String errorText = '';

    if (password1Controller.text != password2Controller.text) {
      errorText += 'Passwords dont match';
    }
    if (value.length < 8) {
      errorText += '| Password must have atleast 8 characters';
    }
    if (errorText != '') {
      return errorText;
    } else
      return null;
  }

  errorDialog(BuildContext context, errorMessage) {
    var msg = errorMessage
        .contains('email address is already in use by another account');
    var mm = errorMessage
        .contains('no user record corresponding to this identifier');
    String error = '';
    if (msg) {
      error += 'Email already in Use';
    }
    if (mm) {
      error += 'User does not Exist please sign up';
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(error),
          );
        });
  }

  successDialog(BuildContext context,{String message}) {
 
 
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text(message),
          );
        });
  }
}
