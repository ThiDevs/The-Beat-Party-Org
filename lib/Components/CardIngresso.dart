import 'package:flutter/material.dart';
import 'package:tbp_app/Components/Dialog.dart';

class CardIngresso extends StatelessWidget {
  String NomeCompleto;
  String Cpf;
  String Sexo;
  int TipoIngresso;
  CardIngresso({this.NomeCompleto, this.Cpf, this.Sexo, this.TipoIngresso});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 18.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backIngresso.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          // decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
          child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right:
                            new BorderSide(width: 1.0, color: Colors.white24))),
                child:

                    // new Image.asset(
                    //   "assets/icons/combo.png",
                    //   width: 50,
                    // ),
                    Image.asset(
                  "assets/icons/" +
                      (TipoIngresso == 0
                          ? "megafone"
                          : (TipoIngresso == 1 ? "ingresso" : "combo")) +
                      ".png",
                  width: 35,
                ),

                //     new Image.asset(
                //   "assets/icons/megafone.png",
                //   width: 35,
                // ),
              ),
              title: Text(
                NomeCompleto,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(Icons.person,
                      color: Sexo == "Masculino" ? Colors.blue : Colors.pink),
                  Text(" " + Cpf, style: TextStyle(color: Colors.white))
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.white, size: 30.0)),
        ),
      ),
    );
  }
}
