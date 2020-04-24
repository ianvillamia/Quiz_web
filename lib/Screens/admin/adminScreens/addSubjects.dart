import 'package:Quiz_web/Screens/admin/admin-widgets/admin-dialogs.dart';
import 'package:flutter/material.dart';

class AddSubjects extends StatelessWidget {
  const AddSubjects({Key key}) : super(key: key);

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
                    // Container(
                    //   height: size.height * .2,
                    //   width: size.width,
                    //   color: Colors.grey,
                    // ),

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
                  child: DataTable(columns: [
                    DataColumn(label: Text('')),
                  ], rows: [
                    DataRow(cells: [
                      DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[Text('Math'), Text('details')],
                          ), onTap: () {
                        print('dash is clicked');
                      }),
                    ]),
                  ]),
                ),
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
                        'Subjects',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
              Positioned(
                  right: 10,
                  child: ButtonTheme(
                    minWidth: 50,
                    buttonColor: Color.fromRGBO(40, 179, 81, 1),
                    child: RaisedButton.icon(
                        onPressed: () {
                          //show dialog for adding
                          AdminAlertDialogs().showAlertDialog(context);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: Container()),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
