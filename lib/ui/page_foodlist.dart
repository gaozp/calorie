import 'dart:async';

import 'package:flutter/material.dart';
import 'package:calculateurcalorie/ui/page_addfood.dart';
import 'package:calculateurcalorie/model/food.dart';

class FoodListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new FoodListState();
  }

}
class FoodListState extends State<FoodListPage>{
  FoodProvider provider;
  var foods = new List<Map>();

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
    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new InkWell(
              child: new Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text(
                    "添加",
                    style: new TextStyle(
                        fontSize: 16.0, color: Colors.white),
                  )),
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext) {
                      return new AddFoodPage();
                    }));
              },
            ),
          ],
        ),
      ),
      body: foods.length == 0
          ? new CircularProgressIndicator()
          : _buildListview(),
    );
  }


  Widget _buildListview() {
    return new ListView.builder(
        itemCount: foods.length,
        itemBuilder: _buildItem
    );
  }

  Widget _buildItem(BuildContext context,int i) {
    return new Column(
      children: <Widget>[
        new Text(Food.fromMap(foods[i]).name),
        new Text(Food.fromMap(foods[i]).protein.toString()),
        new Text(Food.fromMap(foods[i]).fat.toString()),
        new Text(Food.fromMap(foods[i]).carbohydrate.toString()),
        new Divider(
          color: Colors.black,
          height: 2.0,
        )
      ],
    );
  }
}