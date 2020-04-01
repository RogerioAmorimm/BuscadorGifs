import 'package:buscador_gif/Ui/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  

  @override
  void initState() {
    super.initState();
    getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network("https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif"),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise Aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18.0),
              textAlign: TextAlign.center,
              onChanged: (text){
                setState(() {
                search = text;
                offSet = 0;
                });
              },
            ),
          ),
          Expanded(
            child: gradeDeGifs(futureFunction: getGifs())
          )
        ],
      ),
    );
  }
}
