import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tbp_app/Class/Person.dart';
import 'package:tbp_app/Screens/Home/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class VerLista extends StatefulWidget {
  @override
  _VerListaState createState() => _VerListaState();
}

class _VerListaState extends State<VerLista> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  List<Person> persons = [];

  FirebaseFirestore firestore;

  void inicialize() async {
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
  }

  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
  ];

  List<Widget> _tiles = const <Widget>[
    const _CardDash(Colors.blue, Icons.person, "Lista", "jhoni.blu"),
    const _CardDash(Colors.red, Icons.person, "Lista", "gabe.red"),
    const _CardDash(Colors.green, Icons.person, "Lista", "Flay"),
    const _CardDash(Colors.orange, Icons.person, "Lista", "bxtrz_honorato"),
    const _CardDash(Colors.yellow, Icons.person, "Lista", "Mary.Janne"),
    const _CardDash(Colors.purple, Icons.person, "Lista", "Dhaay"),
    const _CardDash(Colors.black, Icons.person, "Lista", "Todos"),
  ];
  @override
  Widget build(BuildContext context) {
    inicialize();
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
              title: const Text("Ver lista"),
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
            body: new Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: new StaggeredGridView.count(
                  crossAxisCount: 2,
                  staggeredTiles: _staggeredTiles,
                  children: _tiles,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  padding: const EdgeInsets.all(4.0),
                )))
      ],
    );
  }
}

class ListaInfo {
  ListaInfo(this.precoTotal, this.length, this.lista, this.login);
  final double precoTotal;
  final int length;
  final List<TableRow> lista;
  final String login;
}

class _CardDash extends StatelessWidget {
  const _CardDash(this.backgroundColor, this.iconData, this.title, this._login);

  final Color backgroundColor;
  final IconData iconData;
  final String title;
  final String _login;

  Future<void> _goLista(context) async {
    var lista = new List<TableRow>();

    FirebaseFirestore firestore;
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
    Query col;
    if (_login.contains("Todos"))
      col = firestore.collection("User").orderBy("Nome");
    else
      col = firestore
          .collection("User")
          .where('Login', isEqualTo: _login.toLowerCase())
          .orderBy("Nome");

    var preco = 0.00;
    var count = 0;
    col.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            preco += doc['TipoIngresso'] == 3
                ? 15
                : (doc['TipoIngresso'] == 2 ? 30 : 20);
            count += 1;
            lista.add(TableRow(children: [
              TableCell(child: Center(child: Text(doc['Nome']))),
              TableCell(
                child: Center(
                    child: Text(doc['Cpf'].toString().length > 10
                        ? '${doc['Cpf'].toString().substring(0, 3)}.${doc['Cpf'].substring(3, 6)}.${doc['Cpf'].substring(6, 9)}-${doc['Cpf'].substring(9, 11)}'
                        : doc['Cpf'])),
              ),
              TableCell(
                  child: Center(
                      child:
                          Text(doc['Sexo'] == 1 ? "Feminino" : "Masculino"))),
              TableCell(
                  child: Center(
                      child: Text((doc['TipoIngresso'] == 3
                          ? "Combo"
                          : (doc['TipoIngresso'] == 2
                              ? "Normal"
                              : "Pré-Venda"))))),
            ]));
          }),
          Navigator.pushNamed(context, "/" + this.title,
              arguments: new ListaInfo(preco, count, lista, _login)),
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {
          _goLista(context);
        },
        child: Stack(
          children: <Widget>[
            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(25.0),
                child: new Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
            new Center(
                child: new Container(
              child: new Text(
                this._login,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
