import 'package:Quiz_web/Screens/admin/admin-providers/adminProvider.dart';
import 'package:Quiz_web/Screens/admin/admin-widgets/admin-dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:provider/provider.dart';

class AdminQuizzes extends StatelessWidget {
  const AdminQuizzes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: <Widget>[
          //sidebar
          Container(
            width: size.width * .2,
            height: size.height,
            color: Color.fromRGBO(24, 24, 24, 1),
            child: Center(
                child: Text('Sidebar', style: TextStyle(color: Colors.white))),
          ),
          //body
          Container(
              width: size.width * .8,
              height: size.height,
              color: Color.fromRGBO(235, 236, 240, 1),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    /**buttons and stuff */

                    //*data table *//
                    dataTable(size: size, context: context)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  dataTable({size, context}) {
    return Container(
      height: size.height * .9,
      color: Colors.transparent,
      child: Card(
        child: Scrollbar(
          child: Stack(
            children: <Widget>[
              Positioned(
                child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('quizList')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();

                          return DataTable(
                              columns: [
                                DataColumn(label: Text('')),
                              ],
                              rows: snapshot.data.documents
                                  .map((doc) => DataRow(cells: [
                                        DataCell(
                                            Text(StringUtils.capitalize(
                                                doc.data['title'].toString())),
                                            onTap: () {
                                            final _adminProvider = Provider.of<AdminProvider>(context,listen: false);
                                        _adminProvider.changeCurrentQuiz(quiz: doc.data['title'].toString());
                                          //show dialog preview? for quiz not interactable
                                          AdminAlertDialogs().showQuiz(context,
                                              doc.data['title'].toString());
                                        })
                                      ]))
                                  .toList());
                        })),
              ),
              Positioned(
                  top: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1))),
                    width: size.width * .8,
                    height: size.height * .1,
                    child: Center(
                      child: Text(
                        'Quizzes',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Positioned(
                  right: 10,
                  child: FlatButton.icon(
                      color: Colors.green,
                      onPressed: () {
                        //show dialog for adding
                        // AdminAlertDialogs().addSubjectDialog(context);
                        //show dialog for create quiz so..create a dialog then navigator push after ok..

                        AdminAlertDialogs().createQuizDialog(context);
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      label: Text(
                        'NEW Quiz',
                        style: TextStyle(color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
