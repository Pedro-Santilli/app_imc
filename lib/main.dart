import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
    });
  }

  void calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    if (imc < 18.6) {
      _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 24.9 && imc < 29.9) {
      _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 29.9 && imc < 34.9) {
      _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 34.9 && imc < 39.9) {
      _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 40) {
      _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
            color: Colors.white,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline, size: 120, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: weightController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  controller: heightController,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "Insira sua altura!";
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          calculate();
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                    ),
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                Text(
                  _infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
