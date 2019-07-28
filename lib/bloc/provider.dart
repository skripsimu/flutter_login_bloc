import 'package:flutter/material.dart';
import 'bloc_pattern.dart';

class Provider extends InheritedWidget {

  final bloc = new BlocPattern();

  Provider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static BlocPattern of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }

}