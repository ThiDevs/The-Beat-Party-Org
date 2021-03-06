import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbp_app/Class/Person.dart';
import 'package:tbp_app/Screens/Home/index.dart';
import 'package:tbp_app/Screens/Login/index.dart';

import 'VerLista.dart';

class Lista extends StatefulWidget {
  final ListaInfo args;

  Lista({Key key, @required this.args}) : super(key: key);

  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  Future<void> _GetLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login') ?? "";
    var admins = ['jhoni.blu', 'gabe.red', 'a'];
    setState(() {
      show = admins.contains(login);
    });
  }

  var show = false;

  @override
  Widget build(BuildContext context) {
    var admins = ['jhoni.blu', 'gabe.red', 'a'];
    _GetLogin();
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
              title: Text("${widget.args.login}"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => AdministrativeUvit(),
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
                        TableCell(
                            child: Center(
                                child: Text(
                                    'Quantidade: ${widget.args.Length} ingressos.'))),
                        TableCell(child: Center(child: Text(''))),
                        TableCell(child: Center(child: Text(''))),
                        TableCell(
                            child: Center(
                                child: show
                                    ? Text(
                                        'Total: R\$ ${widget.args.PrecoTotal}')
                                    : null)),
                      ]),
                      TableRow(children: [
                        TableCell(child: Center(child: Text(''))),
                        TableCell(
                          child: Center(child: Text('')),
                        ),
                        TableCell(child: Center(child: Text(''))),
                        TableCell(child: Center(child: Text(''))),
                      ]),
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
                      for (var item in widget.args.lista) item
                    ])))
      ],
    );
  }
}
