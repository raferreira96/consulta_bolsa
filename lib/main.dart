import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Bolsa",
    home: Home(),
  ));
}

TextEditingController txtTitulo = TextEditingController();
String symbol = "";
String request = "";
String titulo = "";
double price = 0;

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void getData() async {
  try {
    symbol = txtTitulo.text;
    request = "https://api.hgbrasil.com/finance/stock_price?key=c34f4333&symbol="+symbol;
    http.Response response = await http.get(Uri.parse(request));
    var json = jsonDecode(response.body);

    setState(() {
      titulo = json!['results'][symbol]['symbol'];
      price = json!['results'][symbol]['price'];
    });
  } catch(err) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consulta Bolsa"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Icon(Icons.attach_money, size: 100, color: Colors.amber),
                TextField(
                  controller: txtTitulo,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.amber
                      )
                    ),
                    labelText: "Título",
                    labelStyle: TextStyle(
                      color: Colors.amber
                    )
                    
                  ),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.characters,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Título: $titulo"),
                    Text("Valor: $price")
                  ]
                ),
                Divider(),
                ElevatedButton(
                  child: Text("Consultar Valor"),
                  onPressed: getData,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    onPrimary: Colors.white
                  ),
                )
              ]
            )
          ),
        ),
      )
    );
  }
}