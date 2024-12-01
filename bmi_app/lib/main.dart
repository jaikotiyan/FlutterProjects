import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var bgColor = Color.fromARGB(255, 166, 145, 203);
  var weightController = TextEditingController();
  var heightfootController = TextEditingController();
  var heightinchController = TextEditingController();
  var result = "";
  var msg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('BMI App'),
      ),
      body: Container(
        color: bgColor,
        child: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'BMI APP',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: weightController,
                  decoration: InputDecoration(
                      label: Text('Enter your weight in KG'),
                      prefixIcon: Icon(Icons.line_weight)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: heightfootController,
                  decoration: InputDecoration(
                      label: Text('Enter your Height in Feet'),
                      prefixIcon: Icon(Icons.height)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: heightinchController,
                  decoration: InputDecoration(
                      label: Text('Enter your height in Inches'),
                      prefixIcon: Icon(Icons.height)),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var wgt = weightController.text.toString();
                      var hgtf = heightfootController.text.toString();
                      var hgti = heightinchController.text.toString();
                      if (wgt != "" && hgti != "" && hgtf != "") {
                        var wgtn = int.parse(wgt);
                        var hgtfn = int.parse(hgtf);
                        var hgtin = int.parse(hgti);

                        var fhgti = (hgtfn * 12) + hgtin;
                        var fhgtCm = fhgti * 2.54;
                        var fhgtM = fhgtCm / 100;
                        var bmi = wgtn / fhgtM;

                        if (bmi > 25) {
                          msg = "You are overweight";
                          bgColor = const Color.fromARGB(255, 230, 118, 110);
                        } else if (bmi < 18) {
                          msg = "You are underweight";
                          bgColor = const Color.fromARGB(255, 230, 118, 110);
                        } else if (18 <= bmi && bmi <= 25) {
                          msg = "You are Fit";
                          bgColor = Color.fromARGB(255, 116, 230, 110);
                        }
                        setState(() {
                          result =
                              "$msg \n Your BMI is ${bmi.toStringAsFixed(4)}";
                        });
                      } else {
                        result =
                            "Data give is not sufficient to calculate BMI.";
                        setState(() {});
                      }
                    },
                    child: Text('Click here to get your BMI')),
                SizedBox(
                  height: 20,
                ),
                Text(
                  result,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}