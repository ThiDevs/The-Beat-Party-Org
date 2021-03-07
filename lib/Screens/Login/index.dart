import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'styles.dart';
import 'loginAnimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import '../../Components/SignUpLink.dart';
import '../../Components/SignInButton.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => new LoginScreenState();
}

String testDevice = 'YOUR_DEVICE_ID';

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus = 0;
  // VideoPlayerController _controller;
  final text = TextEditingController();

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

    super.initState();
    // _controller = VideoPlayerController.asset(
    //     'assets/video_login2.mp4')
    //   ..initialize().then((_) {
    //     _controller.play();
    //     _controller.setLooping(true);
    //     _controller.setVolume(0.0);

    //     // Ensure the first frame is shown after the video is initialized
    //     setState(() {});
    //   });
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
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
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, "/login"),
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return (new WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            body: new Container(
          decoration: new BoxDecoration(
            image: backgroundImage,
            gradient: new LinearGradient(
              colors: <Color>[
                const Color.fromRGBO(162, 146, 199, 0.8),
                const Color.fromRGBO(0, 0, 0, 0),
              ],
              stops: [0.2, 1.0],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
            ),
          ),
          child: Stack(children: <Widget>[
            new Container(
              // width: 20,
              // height: 20
              decoration: new BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/backgroud.jpg"),
                  fit: BoxFit.cover,
                ),
              ),

              // child: SizedBox.expand(
              //         child: FittedBox(
              //           fit: BoxFit.cover,
              //           child: SizedBox(
              //             width: _controller.value.size?.width ?? 0,
              //             height: _controller.value.size?.height ?? 0,
              //             child: VideoPlayer(_controller),
              //           ),
              //         ),)
            ),
            new Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(1),
                        Colors.black.withOpacity(0),
                      ])),
            ),
            new Container(
                child: new ListView(
              padding: const EdgeInsets.all(0.0),
              children: <Widget>[
                new Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 50),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: Image.asset(
                              'assets/logotipo.png',
                              fit: BoxFit.fill,
                              height: 150,
                            ),
                          ),
                        ),
                        // new FormContainer(),
                        Container(
                          margin: new EdgeInsets.symmetric(horizontal: 20.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Form(
                                  child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    decoration: new BoxDecoration(
                                      border: new Border(
                                        bottom: new BorderSide(
                                          width: 0.5,
                                          color: Colors.white24,
                                        ),
                                      ),
                                    ),
                                    child: new TextFormField(
                                      controller: text,
                                      obscureText: false,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      decoration: new InputDecoration(
                                        icon: new Icon(
                                          Icons.person_outline,
                                          color: Colors.white,
                                        ),
                                        border: InputBorder.none,
                                        hintText: "Login",
                                        hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.0),
                                        contentPadding: const EdgeInsets.only(
                                            top: 30.0,
                                            right: 30.0,
                                            bottom: 30.0,
                                            left: 5.0),
                                      ),
                                    ),
                                  ),
                                  // new InputFieldArea(
                                  //     hint: "Login",
                                  //     obscure: false,
                                  //     icon: Icons.person_outline,
                                  //     text: text),
                                  // new InputFieldArea(
                                  //   hint: "Senha",
                                  //   obscure: true,
                                  //   icon: Icons.lock_outline,
                                  // ),
                                ],
                              )),
                            ],
                          ),
                        ),
                        new SignUp()
                      ],
                    ),
                    animationStatus == 0
                        ? new Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: new InkWell(
                                onTap: () async {
                                  FirebaseFirestore firestore;
                                  await Firebase.initializeApp();
                                  firestore = FirebaseFirestore.instance;
                                  firestore
                                      .collection("Comissarios")
                                      .get()
                                      .then((QuerySnapshot querySnapshot) => {
                                            querySnapshot.docs.forEach((doc) {
                                              var a = doc['Logins'];

                                              a.forEach((login) async {
                                                if (login
                                                        .toString()
                                                        .toLowerCase() ==
                                                    text.text.toLowerCase()) {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  await prefs.remove('login');

                                                  prefs.setString('login',
                                                      text.text.toLowerCase());
                                                  setState(() {
                                                    animationStatus = 1;
                                                  });
                                                  _playAnimation();
                                                } else {
                                                  animationStatus = 0;
                                                }
                                              });
                                            })
                                          });
                                },
                                child: new SignIn()),
                          )
                        : new StaggerAnimation(
                            buttonController: _loginButtonController.view),
                  ],
                ),
              ],
            )),
          ]),
        ))));
  }
}
