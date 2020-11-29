import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Bmicalc(),
    );
  }
}

//first widget
class Bmicalc extends StatefulWidget {
  Bmicalc({Key key}) : super(key: key);

  @override
  _BmicalcState createState() => _BmicalcState();
}

class _BmicalcState extends State<Bmicalc> {
  //radio buttons
  int currentindex = 0;
  String finalresult;
  double h;
  double w;
  // controllers
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: (AppBar(
          title: Text(
            "Calculator IMC",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Color(0xfffafafa),
          actions: [],
        )),
        //body
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton("Male", Colors.black, 0),
                  radioButton("Female", Colors.pink, 1),
                ],
              ),
              SizedBox(
                height: 120.0,
              ),
              Text(
                "Votre Taille en Cm : ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Votre Taille en Cm",
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Votre Poids en Kg : ",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Votre Poids en Kg",
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 220.0,
              ),
              Container(
                width: double.infinity,
                height: 50.0,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      h = double.parse(heightController.value.text);
                      w = double.parse(weightController.value.text);
                    });

                    calculerBMI(h, w);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Result(bmi: finalresult)),
                    );
                  },
                  color: Colors.red[300],
                  child: Text(
                    "Calculer",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        )),
      ),
    );
  }

  //index change
  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  String calculerBMI(double height, double weight) {
    double result = (weight / (height * height / 10000));
    setState(() {
      finalresult = result.toStringAsFixed(2);
    });
    return finalresult;
  }

  //custom widget
  Widget radioButton(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 40.0,
        child: FlatButton(
          //if
          color: currentindex == index ? color : Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(value,
              style: TextStyle(
                color: currentindex == index ? Colors.white : color,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
            changeIndex(index);
          },
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final String bmi;
  String message;
  Result({Key key, @required this.bmi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (double.parse(bmi) < 18.5) {
      message = "Insuffisance pondérale";
    } else if (double.parse(bmi) >= 18.5 && double.parse(bmi) < 25) {
      message = "Corpulence normale";
    } else if (double.parse(bmi) >= 25 && double.parse(bmi) < 30) {
      message = "Surpoids";
    } else if (double.parse(bmi) >= 30 && double.parse(bmi) < 35) {
      message = "Obésité modérée";
    } else if (double.parse(bmi) >= 35 && double.parse(bmi) < 40) {
      message = "Obésité sévère";
    } else if (double.parse(bmi) >= 40) {
      message = "Obésité morbide ou massive";
    } else {
      message = "Erreur";
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Resultat : ",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
          elevation: 0.0,
          backgroundColor: Colors.amber[100],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 280.0,
              ),
              Container(
                width: double.infinity,
                child: Text("Votre IMC est  : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: Text("$bmi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: Text("$message",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    )),
              )
            ],
          ),
        )));
  }
}
/*

*/
