import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Dialogs {
  loginDialog(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return showDialog(
        context: context,
        builder: (context) {
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
            content: Container(
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
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Username', hintText: 'example@gmail.com'),
                    ),
                    TextFormField(
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
                      onPressed: () {},
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
          );
        });
  }

  signUpDialog(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final AuthenticationService _auth = AuthenticationService();
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
                              password1Controller, password2Controller),
                        ),
                        TextFormField(
                          controller: password2Controller,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: '******'),
                          validator: (value) => _passwordValidator(
                              password1Controller, password2Controller),
                        ),
                        MaterialButton(
                          hoverColor: Colors.amber,
                          color: Color.fromRGBO(60, 206, 206, 1),
                          minWidth: size.width,
                          onPressed: () {
                            print('jejedog');
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                              _auth.registerWithEmailAndPassword(email: emailController.text, password: password1Controller.text);
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

  _passwordValidator(passwordController1, passwordController2) {
    var pass1 = passwordController1.text;
    var pass2 = passwordController2.text;
    String errorText='';
    if (pass1 == pass2 && (pass1 != '' || pass2 != '')) {
      print('matches');
      return null;
    } else {
      errorText +='Passwords dont match';
      if (pass1.length < 8 || pass2.length < 8) {
        errorText += '| Must have alteast 8 characters';
      }
       
    }
    return errorText;
  }
}
