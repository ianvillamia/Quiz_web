import 'package:Quiz_web/Models/animationTypes.dart';
import 'package:Quiz_web/Services/Firebase/authenticationService.dart';
import 'package:Quiz_web/Widgets/Animations/loader.dart';
import 'package:Quiz_web/Widgets/Animations/translate_on_hover.dart';
import 'package:flutter/material.dart';
import 'package:Quiz_web/Widgets/Animations/hover_extensions.dart';
import 'package:Quiz_web/Widgets/dialogs.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController(),
        passwordController = TextEditingController();

    AuthenticationService auth = AuthenticationService();
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blueAccent,
            body: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: Container(
                    width: size.width * .6,
                    height: size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/java.jpg"),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                  
                  right: 0,
                  child: SingleChildScrollView(
                    child: Container(
                      height: size.height,
                      width: size.width * .4,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                                              child: FormBuilder(
                          key: _formKey,
                          child: Scrollbar(
                                                        child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: size.height*.30,),
                                Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: size.height * .05,
                                      fontWeight: FontWeight.w600),
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
                                    FormBuilderValidators.required(
                                        errorText: 'Must not be null')
                                  ],
                                ),
                                TextFormField(
                                  obscureText: true,
                                  controller: passwordController,
                                  validator: (val) => val.isEmpty
                                      ? 'Enter an password'
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: '*********',
                                    labelText: 'Password',
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                MaterialButton(
                                    onPressed: () async {
                                      if (_formKey.currentState
                                          .saveAndValidate()) {
                                        setState(() => loading = true);

                                        dynamic result = await auth
                                            .signInWithEmailAndPassword(
                                                email:
                                                    emailController.text,
                                                password:
                                                    passwordController
                                                        .text)
                                            .then((value) =>
                                                Navigator.pushNamed(
                                                    context, '/home'))
                                            .catchError(
                                                (error, stackTrace) {
                                          setState(() {
                                            loading = false;
                                          });
                                          print("outer: $error");
                                          Dialogs().errorDialog(
                                              context, error);
                                        });
                                      }
                                    },
                                    color: Color.fromRGBO(75, 85, 95, 1),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )).showCursorOnHover,
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      'Not a user yet?',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    TranslateOnHover(
                                        animationType:
                                            AnimationType.moveUp,
                                        child: Container(
                                          width: 80,
                                          child: MaterialButton(
                                              hoverColor:
                                                  Colors.transparent,
                                              splashColor:
                                                  Colors.transparent,
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, '/signup');
                                              },
                                              child: Text(
                                                'Sign up',
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    decoration:
                                                        TextDecoration
                                                            .underline),
                                              )),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
