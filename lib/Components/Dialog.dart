import 'package:flutter/material.dart';

TextEditingController name = new TextEditingController();
TextEditingController cpf = new TextEditingController();

TextEditingController name2 = new TextEditingController();
TextEditingController cpf2 = new TextEditingController();

TextEditingController name3 = new TextEditingController();
TextEditingController cpf3 = new TextEditingController();

showAlertDialog2(BuildContext context) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {},
  );
  Widget continuaButton = FlatButton(
    child: Text("Continuar"),
    onPressed: () {
      Navigator.pop(context, "teste");
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content: ListView(
      children: [
        TextField(
          controller: name,
          autofocus: true,
          decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.person),
              hintText: 'Nome - 1'),
        ),
        TextField(
          controller: cpf,
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
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
