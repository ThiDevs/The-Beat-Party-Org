import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbp_app/Components/CardIngresso.dart';
import 'package:tbp_app/Screens/Home/index.dart';

import 'VerLista.dart';

class Lista2 extends StatefulWidget {
  final ListaInfo args;

  Lista2({Key key, @required this.args}) : super(key: key);

  @override
  _Lista2State createState() => _Lista2State();
}

class _Lista2State extends State<Lista2> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  List<CardIngresso> _searchResult = [];

  TextEditingController controller = new TextEditingController();
  Future<void> getLogin() async {
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
    getLogin();
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
              title: Text(
                  "${widget.args.login}: ${widget.args.length} Ingressos ${(show ? ", " + widget.args.precoTotal.toString() + " Reais" : "")}"),
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
                child: Column(children: [
                  new Container(
                    color: Theme.of(context).primaryColor,
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                        child: new ListTile(
                          leading: new Icon(Icons.search),
                          title: new TextField(
                            controller: controller,
                            decoration: new InputDecoration(
                                hintText: 'Procurar', border: InputBorder.none),
                            onChanged: onSearchTextChanged,
                          ),
                          trailing: new IconButton(
                            icon: new Icon(Icons.cancel),
                            onPressed: () {
                              controller.clear();
                              onSearchTextChanged('');
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                      child: _searchResult.length != 0 ||
                              controller.text.isNotEmpty
                          ? ListView.builder(
                              itemCount: _searchResult.length,
                              itemBuilder: (context, index) {
                                return _searchResult[index];
                              },
                            )
                          : ListView.builder(
                              itemCount: widget.args.lista.length,
                              itemBuilder: (context, index) {
                                return widget.args.lista[index];
                              },
                            ))
                ])

                // [for (var item in widget.args.lista) item],
                ))
      ],
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    widget.args.lista.forEach((userDetail) {
      if (userDetail.NomeCompleto.toLowerCase().contains(text.toLowerCase()) ||
          userDetail.NomeCompleto == "" ||
          userDetail.Cpf.replaceAll(".", "").contains(text) ||
          userDetail.Cpf.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }
}
