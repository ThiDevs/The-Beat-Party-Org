import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbp_app/Class/Person.dart';
import 'package:tbp_app/Screens/Home/index.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class NovoPagador extends StatefulWidget {
  @override
  _NovoPagadorState createState() => _NovoPagadorState();
}

class _NovoPagadorState extends State<NovoPagador> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  TextEditingController name1 = new TextEditingController();
  TextEditingController cpf1 = new TextEditingController();

  TextEditingController name2 = new TextEditingController();
  TextEditingController cpf2 = new TextEditingController();

  TextEditingController name3 = new TextEditingController();
  TextEditingController cpf3 = new TextEditingController();

  TextEditingController name = new TextEditingController();
  TextEditingController cpf = new TextEditingController();
  TextEditingController number = new TextEditingController();

  List<Person> persons = [];

  int _radioValue = 0;
  int _tipoIngresso = 0;

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue = value;
    });
  }

  FirebaseFirestore firestore;

  void inicialize() async {
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
  }

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
              backgroundColor: Colors.deepPurple,
              title: const Text("Cadastro"),
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
            body: Center(
                child: new Padding(
              padding: const EdgeInsets.all(30),
              child: ListView(children: [
                TextField(
                  controller: name,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.person),
                      hintText: 'Nome'),
                ),
                TextField(
                  controller: cpf,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.person),
                      hintText: 'CPF/RG'),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      'Masculino',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                    new Radio(
                      value: 1,
                      groupValue: _radioValue,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      'Feminino',
                      style: new TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _tipoIngresso = 1;
                    });
                  },
                  child: new Container(
                    height: 75.0,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                      color: _tipoIngresso == 1 ? Colors.black : Colors.black87,
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(30.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        new Tab(
                          icon: new Image.asset(
                            "assets/icons/megafone.png",
                            width: 35,
                          ),
                          child: Text(
                            'PRÉ VENDA',
                            style: new TextStyle(
                              fontFamily: GoogleFonts.lato().fontFamily,
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _tipoIngresso = 2;
                    });
                  },
                  child: new Container(
                    height: 75.0,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                      color: _tipoIngresso == 2
                          ? Colors.lightBlue[900]
                          : Colors.lightBlue,
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(30.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        new Tab(
                          icon: new Image.asset(
                            "assets/icons/ingresso.png",
                            width: 35,
                          ),
                          child: Text(
                            'Normal',
                            style: new TextStyle(
                              fontFamily: GoogleFonts.lato().fontFamily,
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                new GestureDetector(
                  onTap: () {
                    setState(() {
                      _tipoIngresso = 3;
                    });

                    if (_radioValue == 1) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Combo"),
                            content: ListView(
                              children: [
                                TextField(
                                  controller: name1,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'Nome - 1'),
                                ),
                                TextField(
                                  controller: cpf1,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'CPF/RG - 1'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: name2,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'Nome - 2'),
                                ),
                                TextField(
                                  controller: cpf2,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'CPF/RG - 2'),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  controller: name3,
                                  autofocus: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'Nome - 3'),
                                ),
                                TextField(
                                  controller: cpf3,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.person),
                                      hintText: 'CPF/RG - 3'),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  var person1 = new Person();
                                  person1.name = name1.text;
                                  person1.cpf = cpf1.text;
                                  person1.tipoIngresso = 3;
                                  person1.sexo = 1;

                                  persons.add(person1);

                                  var person2 = new Person();
                                  person2.name = name2.text;
                                  person2.cpf = cpf2.text;
                                  person2.tipoIngresso = 3;
                                  person2.sexo = 1;

                                  persons.add(person2);

                                  var person3 = new Person();
                                  person3.name = name3.text;
                                  person3.cpf = cpf3.text;
                                  person3.tipoIngresso = 3;
                                  person3.sexo = 1;

                                  persons.add(person3);

                                  Navigator.pop(context, name1.text);
                                },
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: new Container(
                    height: 75.0,
                    alignment: FractionalOffset.center,
                    decoration: new BoxDecoration(
                      color: _tipoIngresso == 3
                          ? Colors.green[800]
                          : Colors.green[400],
                      borderRadius:
                          new BorderRadius.all(const Radius.circular(30.0)),
                    ),
                    child: Column(
                      children: <Widget>[
                        new Tab(
                          icon: new Image.asset(
                            "assets/icons/combo.png",
                            width: 50,
                          ),
                          child: Text(
                            'Combo',
                            style: new TextStyle(
                              fontFamily: GoogleFonts.lato().fontFamily,
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                new GestureDetector(
                  onTap: () {
                    var person = new Person();
                    person.name = name.text;
                    person.cpf = cpf.text;

                    person.tipoIngresso = _tipoIngresso;
                    person.sexo = _radioValue;

                    persons.add(person);

                    _salvar();
                  },
                  child: new Text(
                    "Salvar",
                    style: new TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ]),
            )))
      ],
    );
  }

  _salvar() {
    setState(() async {
      var users = firestore.collection("User");
      final prefs = await SharedPreferences.getInstance();
      final login = prefs.getString('login') ?? "";
      persons.forEach((val) {
        users
            .add({
              'Nome': val.name,
              'Cpf': val.cpf,
              'Sexo': val.sexo,
              'TipoIngresso': val.tipoIngresso,
              'Login': login,
            })
            .then((value) => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: new Text("Salvo com Sucesso"),
                      content: new Text("Sucesso"),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "/home");
                          },
                        ),
                      ],
                    );
                  },
                ))
            .catchError((error) => print("Failed to add user: $error"));
      });
    });
  }
}
