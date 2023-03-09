import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Cata_Products.dart';

void main() {
  runApp(const Catagory ());
}

class Catagory  extends StatelessWidget {
  const Catagory ({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catagory',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const CatagoryPage(title: 'Catagory'),
      routes:{
        "/Product":(BuildContext context)=> new CataProductsPage(title: "Product"),

      },
    );
  }
}

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {

  Future<List<Category>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_view_category"));
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<Category> clist = [];
    for (var nn in jsonData["data"]) {
      Category newname =
      Category(nn["category-id"].toString(), nn['category'].toString());
      clist.add(newname);
    }
    return clist;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(5.0),
          child: FutureBuilder(
              future: _getNames(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print("snapshot" + snapshot.toString());
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("Loading..."),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    // padding: EdgeInsets.all(5.0),
                    // shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap: () async {
                          String cid_s=snapshot.data[index].category_id;
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("cid_s", cid_s);
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) =>  new CataProductsPage(title: "Product"),
                            ),
                          );
                        },
                        onLongPress: () {
                          print("long press" + index.toString());
                        },
                        title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                // Text(snapshot.data[index].image),

                                Container(
                                  child: Row(
                                    children: [

                                     Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Text(snapshot.data[index].category,
                                       ),
                                     )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      );
                    },
                  );
                }
              }),
        ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Category {
  late final String category_id;
  late final String category;

  Category(this.category_id, this.category);
}