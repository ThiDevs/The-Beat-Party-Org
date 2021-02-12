import 'package:flutter/material.dart';
import 'package:tbp_app/Class/Person.dart';
import 'package:tbp_app/Screens/Home/index.dart';
import 'package:tbp_app/Screens/Login/index.dart';

class Lista extends StatefulWidget {
  var args = new List<TableRow>();

  Lista({Key key, @required this.args}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  List<Person> persons = new List<Person>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/footer.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text("lista"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
            drawer: AdministrativeUvit(),
            key: _scaffoldkey,
            body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                    border: TableBorder.all(
                        color: Colors.black26,
                        width: 1,
                        style: BorderStyle.none),
                    children: [
                      TableRow(children: [
                        TableCell(child: Center(child: Text('Nome'))),
                        TableCell(
                          child: Center(child: Text('CPF/RG')),
                        ),
                        TableCell(child: Center(child: Text('Sexo'))),
                        TableCell(
                            child: Center(child: Text('Tipo do Ingresso'))),
                      ]),
                      TableRow(children: [
                        TableCell(child: Center(child: Text(''))),
                        TableCell(
                          child: Center(child: Text('')),
                        ),
                        TableCell(child: Center(child: Text(''))),
                        TableCell(child: Center(child: Text(''))),
                      ]),
                      for (var item in widget.args) item

                      // new Padding(
                      //     padding: const EdgeInsets.only(top: 12.0),
                      //     child: Table(columnWidths: {
                      //       1: FractionColumnWidth(.4),
                      //     }, children: [
                      //       TableRow(children: [
                      //         TableCell(
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //             children: [
                      //               Text('Nome'),
                      //               Text('CPF/RG'),
                      //               Text('Sexo'),
                      //               Text('Tipo do Ingresso')
                      //             ],
                      //           ),
                      //         ),
                      //       ]),
                      //       TableRow(children: [
                      //         TableCell(
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //             children: [Text('')],
                      //           ),
                      //         ),
                      //       ]),
                      //     ]))
                    ])))
      ],
    );
  }
}
