import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tbp_app/Components/Dialog.dart';

class CardIngresso extends StatelessWidget {
  String NomeCompleto;
  String Cpf;
  String Sexo;
  int TipoIngresso;
  String Id;
  bool entry;
  String Title;

  CardIngresso(
      {this.NomeCompleto,
      this.Cpf,
      this.Sexo,
      this.TipoIngresso,
      this.Id,
      this.entry,
      this.Title});

  Future<bool> getLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final login = prefs.getString('login') ?? "";
    var admins = ['jhoni.blu', 'gabe.red', 'a'];
    return admins.contains(login);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Confirmação"),
                  content:
                      new Text("Deseja confirmar entrada do " + NomeCompleto),
                  actions: <Widget>[
                    new TextButton(
                      child: new Text("SIM!"),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('User')
                            .doc(this.Id)
                            .update({"entry": true});
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, "/home");
                      },
                    ),
                  ],
                );
              });
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
              elevation: 18.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/backIngresso.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: EdgeInsets.only(right: 12.0),
                          decoration: new BoxDecoration(
                              border: new Border(
                                  right: new BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: Image.asset(
                            "assets/icons/" +
                                (TipoIngresso == 3
                                    ? "combo"
                                    : (TipoIngresso == 2
                                        ? "ingresso"
                                        : "megafone")) +
                                ".png",
                            width: 35,
                          ),
                        ),
                        title: Text(
                          NomeCompleto,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            Icon(Icons.person,
                                color: Sexo == "Masculino"
                                    ? Colors.blue
                                    : Colors.pink),
                            Text(" " + Cpf,
                                style: TextStyle(color: Colors.white))
                          ],
                        ),
                        trailing: new GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Excluir?"),
                                    content: new Text(
                                        "Deseja excluir " + NomeCompleto),
                                    actions: <Widget>[
                                      new TextButton(
                                        child: new Text("Cancelar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      new TextButton(
                                        child: new Text("Excluir!"),
                                        onPressed: () async {
                                          var admin = await getLogin();
                                          if (admin)
                                            FirebaseFirestore.instance
                                                .collection('User')
                                                .doc(this.Id)
                                                .delete()
                                                .then((value) => showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: new Text(
                                                            "Sucesso?"),
                                                        content: new Text(
                                                            "Excluido: " +
                                                                NomeCompleto),
                                                        actions: <Widget>[
                                                          new TextButton(
                                                            child:
                                                                new Text("OK!"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    }));

                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.keyboard_arrow_right,
                                color: Colors.white, size: 30.0))),
                  ),

                  // AnimationLimiter(
                  //   child: ListView.builder(
                  //     itemCount: 5,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return AnimationConfiguration.staggeredList(
                  //         position: index,
                  //         duration: const Duration(milliseconds: 375),
                  //         child: SlideAnimation(
                  //           verticalOffset: 50.0,
                  //           child: FadeInAnimation(
                  //             child: Icon(Icons.check),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                  if (!this.entry)
                    Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.red,
                    )
                  else
                    Icon(
                      Icons.check,
                      color: Colors.green,
                    )

//                   CheckboxListTile(
//   // title: Text("title text"),
//   value: this.entry,
//   onChanged: (newValue) {
//     setState(() {
//       checkedValue = newValue;
//     });
//   },
//   controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
// )
                ],
              )),
        ));
  }
}
