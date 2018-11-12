import 'package:flutter/material.dart';
import 'package:calculateurcalorie/model/food.dart';
import 'package:flutter/services.dart';

class AddFoodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "add new food to ur detail",
        ),
      ),
      body: new AddFood(),
    );
  }
}

class AddFood extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AddFoodState();
  }
}

class AddFoodState extends State<AddFood> {
  Food f = new Food("",0.0,0.0,.0);
  FoodProvider provider = new FoodProvider();

  void _saveToDatabase() {
    provider.insert(f);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            child: new TextField(
              decoration: new InputDecoration(labelText: "请输入名称"),
              onChanged: (str) {
                setState(() {
                  f.name = str;
                });
              },
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            child: new TextField(
              decoration: new InputDecoration(labelText: "蛋白质含量/100g"),
              onChanged: (str) {
                setState(() {
                  f.protein = double.parse(str);
                });
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            child: new TextField(
              decoration: new InputDecoration(labelText: "脂肪含量/100g"),
              onChanged: (str) {
                f.fat = double.parse(str);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            child: new TextField(
              decoration: new InputDecoration(labelText: "碳水/100g"),
              onChanged: (str) {
                f.carbohydrate = double.parse(str);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
//                WhitelistingTextInputFormatter.digitsOnly,
              ],
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
            child: new RaisedButton(
              onPressed: () {
                _saveToDatabase();
              },
              child: new Text(
                "提交",
                style: new TextStyle(fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
