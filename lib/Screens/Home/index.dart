import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbp_app/Components/CardIngresso.dart';
import 'package:tbp_app/Screens/Funcionalidades/VerLista.dart';
import 'package:tbp_app/Screens/Login/index.dart';

class AdministrativeUvit extends StatefulWidget {
  @override
  _AdministrativeUvitState createState() => _AdministrativeUvitState();
}

class _AdministrativeUvitState extends State<AdministrativeUvit> {
  @override
  void initState() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      keywords: <String>['foo', 'bar'],
      contentUrl: 'http://foo.com/bar.html',
      childDirected: true,
      nonPersonalizedAds: true,
    );

    BannerAd myBanner = BannerAd(
      // adUnitId: BannerAd.testAdUnitId,
      adUnitId: 'ca-app-pub-4653575622321119/4338056837',
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4653575622321119~7316763338");

    myBanner
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
      );
  }

  var _scaffoldkey = GlobalKey<ScaffoldState>();
  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 0.5),
    const StaggeredTile.count(2, 0.5),
  ];
  List<Widget> _tiles = const <Widget>[
    _CardDash(Colors.green, Icons.attach_money, "Cadastrar", ''),
  ];
  Future<void> _getList() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login') ?? "";
    var admins = ['jhoni.blu', 'gabe.red', 'jubsricardo', 'a'];
    _tiles = <Widget>[
      _CardDash(Colors.green, Icons.attach_money, "Cadastrar", login),
    ];

    setState(() {
      if (!admins.contains(login)) {
        _tiles.add(_CardDash(
            Colors.lightBlue, Icons.remove_red_eye_outlined, 'Lista', login));
      } else {
        _tiles.add(_CardDash(Colors.lightBlue, Icons.remove_red_eye_outlined,
            "Ver Lista", login));
      }
    });
  }

  Future<void> _resetVariables() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('login');
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<bool> _onWillPop() async {
    return showDialog(
          context: context,
          builder: (_) => new AlertDialog(
            title: new Text('Você tem certeza que quer sair?'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              new TextButton(
                onPressed: () async => _resetVariables(),
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
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
        (new WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.red,
                  title: const Text("Dashboard"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        // RestartWidget.restartApp(context);
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
                    )))))
      ],
    );
  }
}

class _CardDash extends StatelessWidget {
  const _CardDash(this.backgroundColor, this.iconData, this.title, this._login);

  final Color backgroundColor;
  final IconData iconData;
  final String title;
  final String _login;

  Future<void> _goLista(context) async {
    var lista = new List<TableRow>();
    var lista2 = new List<CardIngresso>();

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
    var admins = ['jhoni.blu', 'gabe.red', 'jubsricardo', 'a'];
    var admin = false;
    if (admins.contains(_login)) admin = true;
    var preco = 0.00;
    var count = 0;
    col.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
            preco += doc['TipoIngresso'] == 3
                ? 15
                : (doc['TipoIngresso'] == 2 ? 30 : 20);
            count += 1;

            var entry = false;
            try {
              entry = doc["entry"];
            } catch (Exception) {
              entry = false;
            }

            lista2.add(CardIngresso(
                Id: doc.id,
                entry: false,
                NomeCompleto: doc['Nome'],
                Cpf: doc['Cpf'].toString().length > 10
                    ? '${doc['Cpf'].toString().substring(0, 3)}.${doc['Cpf'].substring(3, 6)}.${doc['Cpf'].substring(6, 9)}-${doc['Cpf'].substring(9, 11)}'
                    : doc['Cpf'],
                Sexo: doc['Sexo'] == 1 ? "Feminino" : "Masculino",
                TipoIngresso: doc['TipoIngresso'],
                Title: this.title));
          }),
          Navigator.pushNamed(
              context,
              "/" +
                  (title == "Cadastrar"
                      ? "Cadastrar"
                      : admin
                          ? title
                          : "Lista"),
              arguments: new ListaInfo(preco, count, lista2, _login)),
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
                // this._login,
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

// class _CardDash extends StatelessWidget {
//   const _CardDash(this.backgroundColor, this.iconData, this.title);

//   final Color backgroundColor;
//   final IconData iconData;
//   final String title;

//   Future<void> _goLista(context) async {
//     List<TableRow> lista = [];
//     FirebaseFirestore firestore;
//     await Firebase.initializeApp();
//     firestore = FirebaseFirestore.instance;
//     final prefs = await SharedPreferences.getInstance();
//     final login = prefs.getString('login') ?? "";
//     var admins = ['jhoni.blu', 'gabe.red', 'jubsricardo', 'a'];
//     var admin = false;
//     if (admins.contains(login)) admin = true;
//     Query col;
//     if (login.contains("Todos"))
//       col = firestore.collection("User").orderBy("Nome");
//     else
//       col = firestore
//           .collection("User")
//           .where('Login', isEqualTo: login.toLowerCase())
//           .orderBy("Nome");

//     var preco = 0.00;
//     var count = 0;
//     col.get().then((QuerySnapshot querySnapshot) => {
//           querySnapshot.docs.forEach((doc) {
//             preco += doc['TipoIngresso'] == 3
//                 ? 15
//                 : (doc['TipoIngresso'] == 2 ? 30 : 20);
//             count += 1;
//             lista.add(TableRow(children: [
//               TableCell(child: Center(child: Text(doc['Nome']))),
//               TableCell(
//                 child: Center(
//                     child: Text(doc['Cpf'].toString().length > 10
//                         ? '${doc['Cpf'].toString().substring(0, 3)}.${doc['Cpf'].substring(3, 6)}.${doc['Cpf'].substring(6, 9)}-${doc['Cpf'].substring(9, 11)}'
//                         : doc['Cpf'])),
//               ),
//               TableCell(
//                   child: Center(
//                       child:
//                           Text(doc['Sexo'] == 1 ? "Feminino" : "Masculino"))),
//               TableCell(
//                   child: Center(
//                       child: Text((doc['TipoIngresso'] == 3
//                           ? "Combo"
//                           : (doc['TipoIngresso'] == 2
//                               ? "Normal"
//                               : "Pré-Venda"))))),
//             ]));
//           }),
//           Navigator.pushNamed(
//               context,
//               "/" +
//                   (title == "Cadastrar"
//                       ? "Cadastrar"
//                       : admin
//                           ? title
//                           : "Lista"),
//               arguments: new ListaInfo(preco, count, null, login)),
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Card(
//       color: backgroundColor,
//       child: new InkWell(
//         onTap: () {
//           _goLista(context);
//           // Navigator.pushNamed(context, "/" + this.title);
//         },
//         child: Stack(
//           children: <Widget>[
//             new Container(
//               child: new Padding(
//                 padding: const EdgeInsets.all(2.0),
//                 child: new Icon(
//                   iconData,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             new Center(
//                 child: new Container(
//               child: new Text(
//                 this.title,
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
