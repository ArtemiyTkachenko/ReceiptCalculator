import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:receipt_spliterator/bloc/detail_bloc.dart';
import 'package:receipt_spliterator/bloc/main_bloc.dart';
import 'package:receipt_spliterator/data/merged_recipe_details.dart';
import 'package:receipt_spliterator/data/receipt_header.dart';
import 'package:receipt_spliterator/interceptor.dart';
import 'file:///C:/Users/artka/receipt_spliterator/lib/data/receipt_descriptor.dart';
import 'package:receipt_spliterator/ui/detail.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'ReceiptSpliterator',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainBloc _bloc = MainBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ReceiptSpliterator'),
      ),
      body: StreamBuilder(
        stream: _bloc.receiptHeaderObservable,
        builder: (BuildContext context, AsyncSnapshot<MainState> snapshot) {
          final data = snapshot.data;
          if (data is BaseState) {
            return _BasePage(_bloc);
          } else if (data is SuccessState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              moveToDetails(context, data.value);
            });
            return _BasePage(_bloc);
          } else {
            String errorText;
            if (data is ErrorState) {
              errorText = (data).msg;
            } else {
              errorText = "Something went wrong, please try again";
            }
            return _ErrorPage(_bloc, errorText);
          }
        },
      ),
    );
  }

  Future moveToDetails(BuildContext context, ReceiptHeader header) async {
    try {
      final productList = header.products.products;
      final itemList = header.data.document.receipt.items.reversed.toList();
      List<MergedRecipeDetails> mergedList = [];

      for (var i = 0; i < productList.length; i++) {
        mergedList.add(MergedRecipeDetails(productList[i], itemList[i]));
      }

      final bloc = DetailBloc(mergedList);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(bloc),
          ));
    } catch (e) {
      print(e);
    }
  }
}

class _ErrorPage extends StatelessWidget {
  final String _errorText;
  final MainBloc _bloc;

  _ErrorPage(this._bloc, this._errorText);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_errorText, style: TextStyle(fontSize: 20, color: Colors.red.shade500),),
        Container(
          color: Colors.blue,
          child: ElevatedButton(
            child: Text(
              _errorText,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => _bloc.resetState(),
          ),
        )
      ],
    );
  }
}

class _BasePage extends StatelessWidget {

  final MainBloc _bloc;
  String scanResult = '';

  _BasePage(this._bloc);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          scanResult == ''
              ? Text('Нажмите, чтобы отсканить QR-код')
              : CircularProgressIndicator(),
          SizedBox(height: 20),
          Container(
            color: Colors.blue,
            child: ElevatedButton(
              child: Text(
                'Сканировать',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => checkForPermissions(context),
            ),
          )
        ],
      ),
    );
  }

  Future scanQRCode(BuildContext context) async {
    String cameraScanResult = await scanner.scan();
    _bloc.getQrCode(cameraScanResult.trim());
  }

  Future checkForPermissions(BuildContext context) async {
    var cameraStatus = await Permission.camera.status;
    var storageStatus = await Permission.storage.status;
    if (cameraStatus.isGranted && storageStatus.isGranted) {
      scanQRCode(context);
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();

      var allPermissionsGiven = true;

      statuses.forEach((key, value) {
        if (!value.isGranted) allPermissionsGiven = false;
      });

      if (allPermissionsGiven) scanQRCode(context);
    }
  }
}
