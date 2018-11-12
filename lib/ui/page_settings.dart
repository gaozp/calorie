import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new SettingsPageState();
  }
}

class SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Settings"),
      ),
      body: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text("About"),
            trailing: new Icon(Icons.info_outline),
            onTap: (){
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (BuildContext) {
                    return new AboutPage();
                  }));
            },
          )
        ],
      )

    );
  }
}

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Material(
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("About"),

          ),
          body: new Text('''I am a individual APP developer , if you like this app , donate here:
      img:
      
      or if you have any question or suggesstion about this app , please feel free to Contact with me: ihsan.gaozp@gmail.com
      '''),
        )
    );
  }
}

