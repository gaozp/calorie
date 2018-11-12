
import 'package:calculateurcalorie/utils/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:calculateurcalorie/ui/page_calculate.dart';
import 'package:calculateurcalorie/ui/page_personinfo.dart';
import 'package:calculateurcalorie/ui/page_addfood.dart';
import 'package:calculateurcalorie/ui/page_foodlist.dart';
import 'package:calculateurcalorie/model/person.dart';
import 'package:calculateurcalorie/ui/page_settings.dart';
import 'package:calculateurcalorie/utils/localization_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:redux/redux.dart';
import 'package:calculateurcalorie/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:calculateurcalorie/ui/page_welcome.dart';

void main() => runApp(new MyApp(
));


final ThemeData defaultTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryIconTheme: new IconThemeData(
    color: Colors.blue,
  ),
  primaryTextTheme: new TextTheme(
    title: new TextStyle(color: Colors.blue),
  ),
);

class MyApp extends StatelessWidget {
  UserProvider userprovider;

  final store = new Store<MainState>(
    appReducer,
    initialState: new MainState(
      user: User.empty(),
    )
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    userprovider = new UserProvider();
    return new StoreProvider<MainState>(
      store: store,
      child:  new MaterialApp(
          //国际化多语言相关
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              LocalizationDelegate.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('zh', 'CH'), // Chinese
              // ... other locales the app supports
            ],

            routes:{
              RoutesName.routesHomePage: (context)=> new HomePage(this.userprovider),
              RoutesName.routesWelcomePage: (context)=> new WelcomePage(),
              RoutesName.routesAddFoodPage: (BuildContext context) => new AddFoodPage(),
              RoutesName.routesFoodListPage: (BuildContext context) => new FoodListPage(),
              RoutesName.routesPersonPage: (BuildContext context) => new PersonInfoPage(),
            },

//      theme: defaultTheme,
            theme: ThemeData.dark().copyWith(primaryTextTheme: new TextTheme(
              title: new TextStyle(
                  fontFamily: 'Ubuntu'
              ),
            )),
//            home: new HomePage(this.userprovider)

        )
    );
  }
}

class HomePage extends StatelessWidget{

  User u;
  UserProvider userprovider;

  HomePage(this.userprovider);

  void _routetoPerson(BuildContext context){
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext){
      return new PersonInfoPage();
    }));
  }

  void _routetoCalculate(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext){
      return new CalculatePage(u);
    }));
  }

  void _routetoSettings(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext){
      return new SettingsPage();
    }));
  }

  void _routetoFood(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext){
      return new FoodListPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    _getUserInfo(context);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(LocalizationUtils.of(context).appName),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Info"),
              trailing: new Icon(Icons.people, color: Colors.blue),
              onTap: () {
                Navigator.of(context).pop();
                _routetoPerson(context);
              },
            ),
            new ListTile(
              title: new Text("Calculate"),
              trailing: new Icon(Icons.calendar_today, color: Colors.blue),
              onTap: () {
                Navigator.of(context).pop();
                _routetoCalculate(context);
              },
            ),
            new ListTile(
              title: new Text("Foodlist"),
              trailing: new Icon(Icons.fastfood, color: Colors.blue),
              onTap: () {
                Navigator.of(context).pop();
                _routetoFood(context);
              },
            ),
            new ListTile(
              title: new Text("Settings"),
              trailing: new Icon(Icons.settings,color: Colors.blue,),
              onTap: (){
                Navigator.of(context).pop();
                _routetoSettings(context);
              },
            )
          ],
        ),
      ),
      body: new GestureDetector(
        child: new Text("hello world"),
//        onTap: _showTip(context),
      ),
    );
  }

  _getUserInfo(BuildContext context) async {
    var list = await userprovider.query();
    if(list.length!=0)
      u = User.fromMap(list[0]);
  }
}
