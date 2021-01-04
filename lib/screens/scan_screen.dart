import 'package:flutter/material.dart';
import 'package:menuyo/screens/categories_screen.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../widgets/main_drawer.dart';
import '../models/category.dart';
import '../models/item.dart';
import '../models/meal.dart';

class ScanScreen extends StatefulWidget {
  static const routName = '/scan-screen';
  List<Meal> mealList;

  ScanScreen(this.mealList);

  @override
  _ScanScreenState createState() => _ScanScreenState(this.mealList);
}

class _ScanScreenState extends State<ScanScreen> {
  TextEditingController _outputController;
  bool isLoading = false;
  List<Meal> mealList;
  List<Category> categoryList = new List<Category>();

  _ScanScreenState(this.mealList);

  _fetchData(String barCode) async {
    setState(() {
      this.isLoading = true;
    });
    //var newBarcode = barCode.replaceAll('localhost', Platform.isIOS ? '169.254.159.35:8000' : '10.0.2.2:8000');
    var newBarcode = barCode.replaceAll('localhost', '192.168.42.86:8000');
    //final response = await http.get("http://10.0.2.2:8000/restaurant/leukapizza", headers: {'safemenu': "1"},);
    final response = await http.get(newBarcode, headers: {'digitalmenu': "1"},);

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);
      List categories = jsonBody["categories"];
      for (var category in categories) {
        List items = category['items'];
        List<Item> itemList = new List<Item>();
        for (var item in items) {
          itemList.add(new Item(
              id: item['id'].toString(),
              name: item['name'],
              description: item['description'],
              price: item['price'],
              available: item['available'] == 0 ? false : true,
              imageUrl: item['image']
          ));
          print(item['image']);
        }
        this.categoryList.add(new Category(id: category['id'].toString(), name: category['name'], items: itemList));
      }

      setState(() {
        this.mealList.add(new Meal(
            id: jsonBody['id'].toString(),
            categories: this.categoryList,
            name: jsonBody['name'],
            description: jsonBody['description'],
            address: jsonBody['address']
        ));
        isLoading = false;
      });
      Navigator.of(context).pushNamed(CategoriesScreen.routName,);
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Builder(
          builder: (BuildContext context) {
            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Text(
                        this._outputController.text,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      this._buttonGroup(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scan,
              child: Card(
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/scanner.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan [Camera]")),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 120,
            child: InkWell(
              onTap: _scanPhoto,
              child: Card(
                elevation: 5,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/images/albums.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text("Scan [Photo]")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    this._fetchData(barcode);
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this._fetchData(barcode);
  }
}
