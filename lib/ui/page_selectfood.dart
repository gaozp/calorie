import 'dart:async';

import 'package:flutter/material.dart';
import 'package:calculateurcalorie/model/food.dart';

class SelectFood extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new SelectFoodState();
  }

}

class SelectFoodState extends State<SelectFood> {

  var saved = new List<int>();

  FoodProvider provider;
  var foods= new List<Map>();

  Future<Widget> _getFoods() async{
    foods = await provider.query();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    provider = new FoodProvider();
    _getFoods();
  }


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: new Scaffold(
            appBar: new AppBar(
              title: new Text("Select specific food to add",
              ),
            ),
            body: foods.length == 0 ? new CircularProgressIndicator(): createListview(context),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop(){
    List<Food> result = new List();
    saved.forEach((f)=>result.add(Food.fromMap(foods[f])));
    Navigator.pop(context,result);
    return new Future.value(false);
  }




  Widget createListview(BuildContext context) {
    return new ListView.builder(
      itemCount: foods.length,
      itemBuilder: (BuildContext, index) {
        Food tmp = Food.fromMap(foods[index]);
        final alreadySaved = saved.contains(index);
        return new ListTile(
            title: new Text(tmp.name),
            trailing: new Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.blue : null,
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  saved.remove(index);
                } else {
                  saved.add(index);
                }
              });
            });
      },
    );
  }
}
