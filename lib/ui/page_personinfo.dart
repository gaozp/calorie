import 'dart:async';

import 'package:flutter/material.dart';
import 'package:calculateurcalorie/model/person.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:calculateurcalorie/redux/app_state.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class PersonInfoPage extends StatefulWidget{

  User u;

  PersonInfoPage();

  @override
  State<StatefulWidget> createState() {
    return new PersonInfoState(u);
  }
}
enum Gender {
  male,
  female,
}

class PersonInfoState extends State<PersonInfoPage>{

  PersonInfoState(this.info);

  PageController _pageController = new PageController(initialPage: 0);

  User info = new User();
  UserProvider provider ;

  double _currentPage = 0.0;

  @override
  Future initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("add your person info"),
        ),
        body: _buildBody(),
      ),
    );

  }

  Widget _getNameWidget(index,double parallaxOffset){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Icon(Icons.person,semanticLabel: "haha",size: 50.0,),
        new Transform(
          transform: new Matrix4.translationValues(parallaxOffset, 0.0, 0.0),
          child: new TextField(
            decoration: new InputDecoration(
              labelText: "name",
            ),
            onChanged: (str) {
              info.name = str;
            },
          ),
        ),

      ],
    );
  }

  Widget _getHeightWightWidget(index,parallaxOffset){
    return new Column(
     children: <Widget>[
       new Padding(
         padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
         child: new TextField(
           decoration: new InputDecoration(
               labelText: "height"
           ),
           onChanged: (str) {
             setState(() {
               info.height = int.parse(str);
             });
           },
           keyboardType: TextInputType.phone,
           inputFormatters: <TextInputFormatter>[
             WhitelistingTextInputFormatter.digitsOnly,
           ],
         ),
       ),
       new Padding(
         padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
         child: new TextField(
           decoration: new InputDecoration(
               labelText: "weight"
           ),
           onChanged: (str) {
             setState(() {
               info.weight = int.parse(str);
             });
           },
           keyboardType: TextInputType.phone,
           inputFormatters: <TextInputFormatter>[
             WhitelistingTextInputFormatter.digitsOnly,
           ],
         ),
       ),
       new Padding(
         padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
         child: new TextField(
           decoration: new InputDecoration(
               labelText: "age"
           ),
           onChanged: (str) {
             info.age = int.parse(str);
           },
           keyboardType: TextInputType.phone,
           inputFormatters: <TextInputFormatter>[
             WhitelistingTextInputFormatter.digitsOnly,
           ],
         ),
       ),
     ],
    );
  }

  Widget _getGender(int index,double parallaxOffset){
    int gender_groupvalue = info.male == true ? 0:1;
   return new Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
        child: new Row(
          children: <Widget>[
            new Text("性别：男"),
            new Radio(value: 0, groupValue: gender_groupvalue,onChanged: (int value){
              setState(() {
                info.male = value == 0?true:false;
              });
            }),
            new Text("女"),
            new Radio(value: 1, groupValue: gender_groupvalue, onChanged: (int value){
              setState(() {
                info.male = value == 0?true:false;
              });
            }),
          ],
        )
    );
  }

  Widget _getGoal(int index,double parallaxOffset){
    int goal_groupvalue = info.goal == true?0:1;
    return new Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
        child: new Row(
          children: <Widget>[
            new Text("目标：减脂"),
            new Radio(value: 0, groupValue: goal_groupvalue,onChanged: (int value){
              setState(() {
                info.goal = value == 0?true:false;
              });
            }),
            new Text("增肌"),
            new Radio(value: 1, groupValue: goal_groupvalue, onChanged: (int value){
              setState(() {
                info.goal = value == 0?true:false;
              });
            }),
          ],
        )
    );
  }

  Widget _getExcerise(index,parallaxOffset){
    return new Text("exterise");
  }

  Widget _getDone(int index,double parallaxOffset,Store<MainState> store){
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      child: new RaisedButton(
        onPressed: () {
          _saveToDatabase();
          store.dispatch(new UpdateUserAction(info));
        },
        child: new Text(
          "提交",
          style: new TextStyle(fontSize: 16.0),),
      ),
    );
  }

  Widget _getBody(int index,double constraints,store){
    double parallaxOffset = constraints/2.0*(index-_currentPage);
    switch(index){
      case 0:
        return _getNameWidget(index,parallaxOffset);
        break;
      case 1:
        return _getHeightWightWidget(index,parallaxOffset);
        break;
      case 2:
        return _getGender(index,parallaxOffset);
        break;
      case 3:
        return _getGoal(index,parallaxOffset);
        break;
      case 4:
        return _getExcerise(index,parallaxOffset);
        break;
      case 5:
        return _getDone(index,parallaxOffset,store);
        break;
      default:
        return null;
    }
  }

  Widget _buildBody() {
    if(info == null) info = new User();
    return new StoreBuilder<MainState>(builder: (context,store){
      return new GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: ()=>FocusScope.of(context).requestFocus(new FocusNode()),
        child: new Container(
          color: Theme
              .of(context)
              .primaryColor,
          child:
// new Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              mainAxisSize: MainAxisSize.min,
//              children: <Widget>[
                new Card(
                  elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              color: Colors.white70,
              margin: EdgeInsets.all(30.0),
              child: new Padding(
                padding: new EdgeInsets.only(
                    left: 30.0, top: 40.0, right: 30.0, bottom: 80.0),
                child: new LayoutBuilder(
                    builder: (context, constrains) =>
                    new NotificationListener(
                        onNotification: (ScrollNotification note) {
                          setState(() {
                            _currentPage = _pageController.page;
                          });
                        },
                        child: new PageView.custom(
                          physics: const PageScrollPhysics(
                              parent: const BouncingScrollPhysics()),
                          controller: _pageController,
                          childrenDelegate: new SliverChildBuilderDelegate((
                              context, index) =>
                              _getBody(index, constrains.maxWidth, store),
                            childCount: 6,
                          ),

                        ))),
//                  child:,
              ),
            ),
//              new PageIndicator(
//                layout: PageIndicatorLayout.WARM,
//                size: 20.0,
//                controller: _pageController,
//                space: 5.0,
//                count: 4,
//              )
//          ]

//          ),
        ),
      );
    });
  }

  void _saveToDatabase() async{
    _calculateCalorie();
    provider = new UserProvider();
    await provider.insert(info);
  }

  void _calculateCalorie() {
    int prefix = 0;
    double calorie = 0.0;
    if(info.male) {
      prefix = 90;
      calorie = prefix + 4.8*info.height + 13.4*info.weight -5.7*info.age;
    } else {
      prefix=450;
      calorie = prefix + 3.1*info.height + 9.2*info.weight - 4.3*info.age;
    }

    calorie = calorie * 1.375;
    calorie = calorie -800;
    info.calorie = calorie.toInt();
  }
}