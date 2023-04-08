import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const StaffViewRating());
}

class StaffViewRating extends StatelessWidget {
  const StaffViewRating({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StaffViewRating',
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
      home: const StaffViewRatingPage_(title: 'StaffViewRating'),
    );
  }
}

class StaffViewRatingPage_ extends StatefulWidget {
  const StaffViewRatingPage_({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<StaffViewRatingPage_> createState() => _StaffViewRatingPageState();
}

class _StaffViewRatingPageState extends State<StaffViewRatingPage_> {
  Future<List<StaffViewRatingPage>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    String lid=pref.getString("lid").toString();
    String asid=pref.getString("asid").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/View_rating"),body: {"asid":asid,"lid":lid});
    print("------------------------------hoiiiiiii---------------");
    print(data);
    var jsonData = json.decode(data.body);
    setState(() {
      // ips=ip.toString();
    });

    print(jsonData);
    List<StaffViewRatingPage> clist = [];
    for (var nn in jsonData["data"]) {
      StaffViewRatingPage newname_ =
      StaffViewRatingPage(nn["rating"].toString(),nn["date"].toString(),nn["review"].toString());
      clist.add(newname_);
    }
    return clist;
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been
    // optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the StaffViewRatingPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: FutureBuilder(
            future: _getNames(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print("snapshot" + snapshot.toString());
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
                        onLongPress: () {
                          print("long press" + index.toString());
                        },
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(snapshot.data[index].date,
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300
                                        ),
                                      ),
                                    ),

                                 Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(snapshot.data[index].review,
                              textAlign:TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                            RatingBar.builder(
                              initialRating: double.parse(snapshot.data[index].rate) ,
                              minRating: double.parse(snapshot.data[index].rate),
                              maxRating:double.parse(snapshot.data[index].rate) ,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (double value) {},
                            ),

                                  ],
                                ),
                              ),
                            ],
                          ),

                        )
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
class StaffViewRatingPage {
  late final rate ;
  late final date ;
  late final review ;
  StaffViewRatingPage(this.rate,this.date,this.review);
}
