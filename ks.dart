import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounFeit(),
    );
  }
}

class CounFeit extends StatefulWidget {
  @override
  _CounFeitState createState() => _CounFeitState();
}

class _CounFeitState extends State<CounFeit> {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

      controller!.pauseCamera();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 3,


            child: Card(
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.network(photo),
                    title: Text(pname),
                    subtitle: Text(description),
                  ),
                ],
              ),
            ),


            // child: Center(
            //   child: (result != null)
            //       ? Text(
            //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //       : Text('Scan a code'),
            // ),
          )
        ],
      ),
    );
  }

  String pname='';
  String price='';
  String description='';
  String photo='';

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      if (result!=null){
        describeEnum(result!.format);
        // print(result!.code);

        final pref = await SharedPreferences.getInstance();
        String ip = "192.168.29.66";
        // String ip = pref.getString("ip").toString();
        var data = await http.post(Uri.parse("http://" + ip + ":5000/and_ProductCheck_post"),body: {'pid':'19'} ,);
        print("------------------------------hoiiiiiii---------------");
        // print(data);
        var jsonData = json.decode(data.body);
        print(jsonData);
        if(jsonData["status"]=='ok'){
          pname = jsonData["Name"].toString();
          price = jsonData["Price"].toString();
          price = jsonData["Price"].toString();
          description = jsonData["description"].toString();
          photo ="http://"+ip +":5000"+jsonData["photo"].toString();

          setState(() {

            pname=pname;
            price=price;
            description=description;
            photo=photo;
          });

        }else{
          setState(() {
            pname='Counterfeit';
            description='Product';
            photo='https://images.livemint.com/img/2022/10/08/600x338/fake_1665222806466_1665222812701_1665222812701.jpg';
          });
        }



      }

    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

