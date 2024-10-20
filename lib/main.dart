import 'package:flutter/material.dart';
import 'api_service.dart';
import 'cat_fact.dart';

void main() => runApp(CatFactsApp());

class CatFactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Facts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatFactsHomePage(),
    );
  }
}

class CatFactsHomePage extends StatefulWidget {
  @override
  _CatFactsHomePageState createState() => _CatFactsHomePageState();
}

class _CatFactsHomePageState extends State<CatFactsHomePage> {
  late Future<CatFact> futureCatFact;

  @override
  void initState() {
    super.initState();
    futureCatFact = ApiService().fetchCatFact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Facts'),
      ),
      body: Center(
        child: FutureBuilder<CatFact>(
          future: futureCatFact,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  snapshot.data!.fact,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            futureCatFact = ApiService().fetchCatFact();
          });
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}