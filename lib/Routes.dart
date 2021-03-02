import 'package:flutter/material.dart';
import 'package:tbp_app/Screens/Funcionalidades/NovoPagador.dart';
import 'package:tbp_app/Screens/Funcionalidades/VerLista.dart';
import 'package:tbp_app/Screens/Login/index.dart';
import 'package:tbp_app/Screens/Home/index.dart';

import 'Screens/Funcionalidades/Lista.dart';

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: "The Beat Party Org",
      debugShowCheckedModeBanner: false,
      home: new LoginScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (_) => new AdministrativeUvit(),
              settings: settings,
            );

          case '/Cadastrar':
            return new MyCustomRoute(
              builder: (_) => new NovoPagador(),
              settings: settings,
            );

          case '/Ver Lista':
            return new MyCustomRoute(
              builder: (_) => new VerLista(),
              settings: settings,
            );

          case '/Lista':
            return new MyCustomRoute(
              builder: (_) => new Lista(args: settings.arguments),
              settings: settings,
            );
          default:
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/') return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
