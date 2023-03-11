import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Reply ());
}

class Reply  extends StatelessWidget {
  const Reply ({super.key});






  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reply',
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
        primarySwatch: Colors.teal,
      ),
      home: const ReplyPage(title: 'Reply'),
    );
  }
}

class ReplyPage extends StatefulWidget {
  const ReplyPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ReplyPage> createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {

  Future<List<replyies>> _getNames() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    String uid=pref.getString("lid").toString();
    var data = await http.post(Uri.parse("http://" + ip + ":5000/and_view_reply"),body: {"user":uid});

    print(data);
    var jsonData = json.decode(data.body);

    print(jsonData);
    List<replyies> clist = [];
    for (var nn in jsonData["data"]) {
      print(nn);
      replyies newreply = replyies(nn["replay"].toString(),nn["complaint"].toString(),nn["date"].toString());
      clist.add(newreply);
      print("okayyyy");
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
          // Here we take the value from the ReplyPage object that was created by
          // the App.build method, and use it to set our appbar title.
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
                        onLongPress: () {
                          print("long press" + index.toString());
                        },
                        title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                    Container(
                                      child: Column(
                                        children: [
                                        Row( children:[
                                          Icon(
                                            Icons.label_important_rounded,
                                            size: 25,
                                            color: Colors.teal,
                                          ),
                                      Padding(padding: const EdgeInsets.all(3.0),
                                        child: Text("Date :"),
                                      ),
                                        Padding(padding: const EdgeInsets.all(3.0),
                                          child: Text(snapshot.data[index].date_),
                                        ),
                                       ]
                                      ),
                                    Row(
                                      children: [
                                        Padding(padding: const EdgeInsets.all(8.0),
                                        child:
                                        Text("Complaint :"),
                                        ),
                                        Padding(padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data[index].complaint_),
                                        ),
                                      ],
                                    ),
                                  Row(
                                      children: [
                                      Padding(padding: const EdgeInsets.all(8.0),
                                        child: Text("Reply :"),
                                      ),
                                      Padding(padding: const EdgeInsets.all(8.0),
                                          child: Text(snapshot.data[index].replay_),
                                        ),
                                      ]),

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
    );
  }
}


class replyies{
  late final String replay_;
  late final String complaint_;
  late final String date_;
  replyies(this.replay_,this.complaint_,this.date_);
}