

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import 'package:calculateurcalorie/redux/app_state.dart';
import 'package:calculateurcalorie/model/person.dart';
import 'package:calculateurcalorie/utils/routes_name.dart';
import 'package:calculateurcalorie/redux/app_state.dart';

class WelcomePage extends StatefulWidget{

  static final String sName = "/";

  @override
  State<StatefulWidget> createState() {
    return new _WelcomePageState();
  }

}



class _WelcomePageState extends State<WelcomePage>{

  UserProvider userprovider = new UserProvider();

  Future<User> _getUserInfo(BuildContext context) async {
    var list = await userprovider.query();
    if(list.length!=0)
       return User.fromMap(list[0]);
    return User.empty();
  }

  bool hasInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(hasInit) return;
    hasInit = false;

    Store<MainState> store = StoreProvider.of<MainState>(context);
    new Future.delayed(const Duration(seconds: 2),(){
      var userInfo = _getUserInfo(context);
      if(userInfo==null){
        Navigator.pushReplacementNamed(context, RoutesName.routesHomePage);
      } else
        Navigator.pushReplacementNamed(context, RoutesName.routesPersonPage);
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainState>(
      builder: (context,store){
        return Container(
          color: ThemeData.dark().primaryColor,
          child: new Center(
            //TODO change a new welcome page
            child: new Image.asset('assets/images/welcome.png'),
          ),
        );
      },
    );
  }

}