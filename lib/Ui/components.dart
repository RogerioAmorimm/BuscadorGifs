import 'dart:convert';
import 'dart:js';
import 'package:buscador_gif/Ui/gif_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String search;
int offSet = 0;

Future<Map> getGifs() async {
  http.Response response;
  if (search == null || search == "") {
    response = await http.get(
        "https://api.giphy.com/v1/gifs/trending?api_key=HSORc1g2DUen462ILMqW3FvNZRKVM3ls&limit=20&rating=G");
  } else {
    response = await http.get(
        "https://api.giphy.com/v1/gifs/search?api_key=HSORc1g2DUen462ILMqW3FvNZRKVM3ls&q=$search&limit=19&offset=$offSet&rating=G&lang=en");
  }

  return json.decode(response.body);
}

Widget gradeDeGifs({Future futureFunction}) {
  return FutureBuilder(
      future: futureFunction,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Container(
              width: 200.0,
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 5.0,
              ),
            );
          default:
            if (snapshot.hasError)
              return Container();
            else
              return _creatGifTable(context, snapshot);
        }
      });
}

int _getCount(List data) {
  if (search == null) {
    return data.length;
  } else {
    return data.length + 1;
  }
}

Widget _creatGifTable(BuildContext context, AsyncSnapshot snapshot) {
  return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10.0, mainAxisSpacing: 10.0),
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        if (search == null || index < snapshot.data["data"].lenght) {
          return GestureDetector(
            child: Image.network(
                snapshot.data["data"][index]["images"]["fixed_height"]["url"],
                height: 300.0,
                fit: BoxFit.cover),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GifPage(snapshot.data["data"][index])));
            },
          );
        } else {
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70.0),
                  Text("Carregar mais...",
                      style: TextStyle(color: Colors.white, fontSize: 22.0))
                ],
              ),
              onTap: () {
                offSet += 19;
              },
            ),
          );
        }
      });
}
