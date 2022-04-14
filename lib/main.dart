import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heighController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    weightController.text = '';
    heighController.text = '';
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
   setState(() {
     double weight = double.parse(weightController.text);
     double height = double.parse(heighController.text) / 100;
     double imc = weight / (height * height);

     if (imc < 18.6) {
       _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
     } else if (imc >= 18.6 && imc < 24.9) {
       _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
     } else if (imc >= 24.9 && imc < 29.9) {
       _infoText = "Levemente acima do Peso (${imc.toStringAsPrecision(4)})";
     } else if (imc >= 29.9 && imc < 34.9) {
       _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
     } else if (imc >= 34.9 && imc < 39.9) {
       _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
     } else if (imc >= 40) {
       _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
     }
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person_outline, size: 120, color: Colors.green),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25),
                controller: weightController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira seu Peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25),
                controller: heighController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Insira seu Altura!";
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.green, fontSize: 25),
              )
            ],
          ),
        ),
      ),
    );
  }
}
