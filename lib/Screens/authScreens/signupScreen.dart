import 'package:Quiz_web/Models/animationTypes.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:Quiz_web/Widgets/Animations/loader.dart';
import 'package:Quiz_web/Widgets/Animations/translate_on_hover.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/Extensions/hover_extensions.dart';
import 'package:Quiz_web/Widgets/dialogs.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:Quiz_web/Widgets/dialogs.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AuthenticationService auth = AuthenticationService();
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    TextEditingController userNameController = TextEditingController(),
        password1Controller = TextEditingController(),
        password2Controller = TextEditingController(),
        emailController = TextEditingController(),
        passwordController = TextEditingController();

    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  child: Container(
                    width: size.width * .6,
                    height: size.height,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(252,163,11,1),
                        image: DecorationImage(
                            image: AssetImage("assets/edited.jpg"),
                            fit: BoxFit.contain)),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    height: size.height,
                    width: size.width * .4,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(size.height * .1),
                      child: FormBuilder(
                        autovalidate: true,
                        key: _fbKey,
                        child: Scrollbar(
                          child: Container(
                              child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(
                                  height: size.height * .1,
                                ),
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                                FormBuilderTextField(
                                  attribute: "name",
                                  controller: emailController,
                                  decoration:
                                      InputDecoration(labelText: "Email"),
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
                                  decoration:
                                      InputDecoration(labelText: "User Name"),
                                  validators: [
                                    FormBuilderValidators.minLength(5),
                                    FormBuilderValidators.required()
                                  ],
                                ),
                                TextFormField(
                                  controller: password1Controller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: '******'),
                                  validator: (value) => _passwordValidator(
                                      value,
                                      password1Controller,
                                      password2Controller),
                                ),
                                TextFormField(
                                  controller: password2Controller,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      hintText: '******'),
                                  validator: (value) => _passwordValidator(
                                      value,
                                      password1Controller,
                                      password2Controller),
                                ),
                                MaterialButton(
                                  hoverColor: Colors.amber,
                                  color: Color.fromRGBO(60, 206, 206, 1),
                                  minWidth: size.width,
                                  onPressed: () async {
                                    print('jejedog');
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      setState(() => loading = true);

                                      await auth
                                          .registerWithEmailAndPassword(
                                              email: emailController.text,
                                              password:
                                                  password1Controller.text)
                                          .then((value) async {
                                        print('SUCCEESSS IN SIGNUP');
                                        Dialogs().successDialog(context, message: "success in signing up");
                                        setState(() {
                                          loading = false;
                                        });
                                      }).catchError((error, stackTrace) {
                                        _fbKey.currentState.reset();
                                        setState(() {
                                          loading = false;
                                        });
                                        print("outer: $error");
                                        Dialogs().errorDialog(context, error);
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
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Material(
                                        child: InkWell(
                                          onTap: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                      fontWeight:
                                                          FontWeight.w600))
                                            ],
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                                TranslateOnHover(
                                        animationType: AnimationType.moveUp,
                                        child: Container(
                                          child: MaterialButton(
                                              hoverColor: Colors.transparent,
                                              splashColor: Colors.transparent,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/login');
                                              },
                                              child: Text(
                                                'Proceed to Login',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline),
                                              )),
                                        )),
                              ],
                            ),
                          )),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
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

  Future popLog(context) async {
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }
}
