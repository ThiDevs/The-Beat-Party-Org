import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbp_app/Screens/Login/index.dart';

class AdministrativeUvit extends StatefulWidget {
  @override
  _AdministrativeUvitState createState() => _AdministrativeUvitState();
}

class _AdministrativeUvitState extends State<AdministrativeUvit> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1),
    const StaggeredTile.count(1, 1.5),
    const StaggeredTile.count(1, 1.5),
  ];
  List<Widget> _tiles = <Widget>[
    _CardDash(Colors.green, Icons.attach_money, "Cadastrar"),
  ];
  Future<void> _getList() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login') ?? "";
    var admins = ['jhoni.blu', 'gabe.red', 'jubsricardo', 'a'];
    _tiles = <Widget>[
      _CardDash(Colors.green, Icons.attach_money, "Cadastrar"),
    ];

    setState(() {
      if (!admins.contains(login)) {
        _tiles.add(
            _CardDash(Colors.lightBlue, Icons.remove_red_eye_outlined, login));
      } else {
        _tiles.add(_CardDash(
            Colors.lightBlue, Icons.remove_red_eye_outlined, "Ver Lista"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _getList();
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
              backgroundColor: Colors.red,
              title: const Text("Dashboard"),
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
            drawer: LoginScreen(),
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

class _CardDash extends StatelessWidget {
  _CardDash(this.backgroundColor, this.iconData, this.title);

  final Color backgroundColor;
  final IconData iconData;
  final String title;

  FirebaseFirestore firestore;

  Future<void> _goLista(context) async {
    var lista = new List<TableRow>();
    FirebaseFirestore firestore;
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login') ?? "";
    var admins = ['jhoni.blu', 'gabe.red', 'jubsricardo', 'a'];
    var admin = false;
    if (admins.contains(login)) admin = true;
    firestore
        .collection("User")
        .where('Login', isEqualTo: login)
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                lista.add(TableRow(children: [
                  TableCell(child: Center(child: Text(doc['Nome']))),
                  TableCell(
                    child: Center(child: Text(doc['Cpf'])),
                  ),
                  TableCell(child: Center(child: Text(doc['Sexo'].toString()))),
                  TableCell(
                      child:
                          Center(child: Text(doc['TipoIngresso'].toString()))),
                ]));
              }),
              Navigator.pushNamed(context, "/" + (admin ? title : "Lista"),
                  arguments: lista)
            });
  }

  // void inicialize() async {
  //   await Firebase.initializeApp();
  //   firestore = FirebaseFirestore.instance;
  //   final prefs = await SharedPreferences.getInstance();
  //   final login = prefs.getString('login') ?? "";
  //   var admins = ['jhoni.blu', 'gabe.red', 'jubsricardo', 'a'];
  //   if (!admins.contains(login)) {
  //     _CardDash(null, null, "Lista", login)._goLista(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {
          _goLista(context);
          // Navigator.pushNamed(context, "/" + this.title);
        },
        child: Stack(
          children: <Widget>[
            new Container(
              child: new Padding(
                padding: const EdgeInsets.all(2.0),
                child: new Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
            new Center(
                child: new Container(
              child: new Text(
                this.title,
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
