import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
      ),
      home: const Home(
        title: "Konversi Suhu",
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double _inputUser = 0;
  double _value = 6;
  // double _kelvin = 0;
  // double _reamur = 0;
  // int _count = 0;

  final inputController = TextEditingController();
  String _newValue = "Kelvin";
  double _result = 0;
  double _currentSliderValue = 20;

  var listItem = ["Kelvin", "Reamur"];

  List<String> listViewItem = <
      String>[]; //https://stackoverflow.com/questions/63451506/the-default-list-constructor-isnt-available-when-null-safety-is-enabled-try

  // TextEditingController myController = TextEditingController();

  void _conversionState() {
    setState(() {
      // _value = double.parse(inputController.text);
      if (_newValue == "Kelvin") {
        _result = _value + 273;
        listViewItem.add("$_value Celcius = $_result Kelvin");
      } else {
        _result = (4 / 5) * _value;
        listViewItem.add("$_value Celcius = $_result Reamur");
      }
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextFormField(
            //   controller: inputController,
            //   keyboardType: TextInputType.number,
            //   decoration: const InputDecoration(
            //       hintText: "Masukkan Suhu dalam Celcius",
            //       contentPadding: EdgeInsets.all(8)),
            // ),
            Slider(
              value: _value.toDouble(),
              min: 1.0,
              max: 100.0,
              divisions: 10,
              activeColor: Colors.blue,
              inactiveColor: Colors.black,
              label: _value.round().toString(),
              onChanged: (double newValue) {
                setState(() {
                  _value = newValue;
                });
              },
            ),
            DropdownButton<String>(
              items: listItem.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: _newValue,
              onChanged: (String? changeValue) {
                setState(() {
                  _newValue = changeValue.toString();
                });
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hasil",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    _result.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 30),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _conversionState,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              child: const Text("Konversi Suhu"),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: const Text(
                "Riwayat Konversi",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: listViewItem.map((String value) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 20),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
