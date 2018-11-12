import 'package:calculateurcalorie/model/food.dart';
import 'package:calculateurcalorie/model/person.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:calculateurcalorie/ui/page_selectfood.dart';


class Goal{
  double protein;
  double proteinK;
  double fat;
  double fatK;
  double carbohydrate;
  double carbohydrateK;

  @override
  String toString() {
    return 'Goal{protein: $protein, proteinK: $proteinK, fat: $fat, fatK: $fatK, carbohydrate: $carbohydrate, carbohydrateK: $carbohydrateK}';
  }

}

class CalculatePage extends StatefulWidget {

  User u;

  CalculatePage(this.u);

  @override
  State<StatefulWidget> createState() {
    return new CalculatePageState(this.u);
  }
}
double _remainProtein = .0;
double _remainFat = .0;
double _remainCar = .0;
//List<Food> _foods = List.generate(10, (i)=>new Food("egg"+i.toString(),50.0,1.0,1.0));
List<Food> _foods = new List();
Goal goal;
List<double> _foodCards = new List();

class CalculatePageState extends State<CalculatePage> {
  double calorie;
  User u;
  CalculatePageState(this.u);
  double innerProtein;
  double innerFat;
  double innerCar;
  List<Food> innerFoods;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      innerProtein = _remainProtein;
      innerFat = _remainFat;
      innerCar = _remainCar;
      innerFoods = _foods;
    });
  }
  @override
  void initState() {
    goal = new Goal();
    if(checkUserValidate()) {
      _calculateThreeTypes();
      innerProtein = goal.protein;
      innerFat = goal.fat;
      innerCar = goal.carbohydrate;
    }
    super.initState();
  }

  bool checkUserValidate(){
    if(u==null){
      return false;
    }
    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    if(!checkUserValidate()){
      return new AlertDialog(
        title: new Text("Error"),
        content: new Text("you must add person info first"),
      );
    }
    innerFoods = _foods;
    this.calorie = double.parse(u.calorie.toString());
    _foodCards = [];
    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          children: <Widget>[
            new Text("ur goal:"),
            new Text(calorie.toString()),
          ],
        ),
      ),
      body: new ListView.builder(itemBuilder: (context, index) {
        Food tmp = _foods[index];
        _foodCards.add(0.0);
        FoodCard card = new FoodCard(
          index:index,
          f: tmp,
          g: goal,
          onChanged: _handleTapboxChanged,);
        return card;
      },
        itemCount: innerFoods.length,
      ),
      bottomSheet: new Container(
        height: 60.0,
        child: new Card(
          child: new Padding(
            padding: new EdgeInsets.only(
                left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(child: new Center(
                  child: new Text("protein:${innerProtein.ceil()}"),
                ), flex: 1,),
                new Expanded(child: new Center(
                  child: new Text('fat:${innerFat.ceil()}'),
                ), flex: 1,),
                new Expanded(child: new Center(
                  child: new Text('car:${innerCar.ceil()}'),
                ),
                  flex: 1,),
              ],
            ),
          ),
        ),
      ),
//      new Row(
//        children: <Widget>[
////      new Text("protein:${innerProtein.ceil()}"),

//        ],
//      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _addFood,
        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget getRemainText(int number){
    return new Expanded(
      flex: 1,
        child: new Center(

        ));
  }


  void _calculateThreeTypes() {
    goal.protein = 1.16 * u.weight;
    goal.proteinK = goal.protein * 4;
    if(u.goal)
      goal.fat = 0.2 * u.weight;
    else
      goal.fat = 0.25 * u.weight;
    goal.fatK = goal.fat*9;
    goal.carbohydrateK = u.calorie-goal.proteinK-goal.fatK;
    goal.carbohydrate = goal.carbohydrateK/4;
//  goal.protein=100.0;
//  goal.proteinK=100.0;
//  goal.fat = 100.0;
//  goal.fatK = 100.0;
//  goal.carbohydrate=100.0;
//  goal.carbohydrateK=100.0;
  }


  void routeToSelectFood(BuildContext context){
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext){
      return new SelectFood();
    })).then((result){
      _foods.addAll(result);
    });
  }

  void _addFood() {
    routeToSelectFood(context);
  }
}

void initRemain(){
  _remainProtein = goal.protein;
  _remainFat = goal.fat;
  _remainCar = goal.carbohydrate;
}

class FoodCard extends StatefulWidget{
  int index;
  Food f;
  Goal g;
  double widget_value=.0;

  final ValueChanged<bool> onChanged;
  FoodCard({int index,Food f,Goal g,@required this.onChanged}):this.index = index,this.f = f,this.g = g,super(){
  }

  @override
  State<StatefulWidget> createState() {
    FoodCardState fc = new FoodCardState();
    return fc;
  }
}

class FoodCardState extends State<FoodCard>{


  double value = .0;

  Text finalValue = new Text("");

  FoodCardState():super(){

  }

  @override
  Widget build(BuildContext context) {
    double _max = calculateMax(widget.f);
    _foodCards[widget.index] = value;
    return new Row(
      children: <Widget>[
        new Text(widget.f.name),
        new Slider(
          min: .0,
            max: _max,
            value: value,
            label: '$value',
            onChanged: (value){
              setState(() {
                this.value = value;
                _foodCards[widget.index] = value;
                _calculateRemain();
              });
            },
        ),
        new Text("${value.ceil()}"),
        new GestureDetector(
          child: new Icon(Icons.delete),
          onTap: (){
            _foods.removeAt(widget.index);
            _foodCards.removeAt(widget.index);
            _calculateRemain();
          },
    ),
    ]
    );
  }

  double calculateMax(Food food) {
    double p = widget.g.protein/food.protein;
    double f = widget.g.fat/food.fat;
    double c = widget.g.carbohydrate/food.carbohydrate;
    double result = min(p, f);
    result = min(result,c);
    return result*100;
  }

  void _calculateRemain() {
    initRemain();
    for(int i = 0;i<_foods.length;i++){
      _remainProtein = _remainProtein - _foodCards[i]/100*_foods[i].protein;
      _remainFat = _remainFat - _foodCards[i]/100*_foods[i].fat;
      _remainCar = _remainCar - _foodCards[i]/100*_foods[i].carbohydrate;
    }
    widget.onChanged(true);
  }
}