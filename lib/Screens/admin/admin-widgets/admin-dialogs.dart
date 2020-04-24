import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AdminAlertDialogs {
  final _formKey = GlobalKey<FormState>();
  showAlertDialog(BuildContext context) {
    // set up the button


    // set up the AlertDialog

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add a Subject",
          ),
          content: Form(
            key: _formKey,
          //  autovalidate: true,
            child: TextFormField(
              controller: null,
              decoration: InputDecoration(labelText: "Subject"),
            //  autovalidate: true,
              onChanged: (val) {
                //run validator here
  
              },
              validator: (val) {
                if(val==null)
                //check in firebase here if firebasequery ==null
                return null;
                else
                return 'nono';
              },
            ),
          ),
          actions: [
          FlatButton(
      child: Text("OK"),
      onPressed: () {
      if (_formKey.currentState.validate()) {
      //croo
    }
      //  Navigator.pop(context);
      
      },
    )
          ],
        );
      },
    );
  }
}
