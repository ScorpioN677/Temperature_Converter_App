import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFB2EBF2),
          title: const Text(
            'Temperature Converter App',
            style: TextStyle(
              color: Color(0xFF004D40),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
        ),
        body: TemperatureConverter(),
      ),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];
  String? _fromUnit = 'Celsius';
  String? _toUnit = 'Fahrenheit';
  final TextEditingController _inputController = TextEditingController();
  String _result = '';

  void _convertTemperature() {
    if (_inputController.text.isEmpty) {
      setState(() {
        _result = 'Enter a value';
      });
      return;
    }

    double inputValue = double.tryParse(_inputController.text) ?? 0;
    double convertedValue;

    if (_fromUnit == _toUnit) {
      convertedValue = inputValue;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      convertedValue = (inputValue * 9 / 5) + 32;
    } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
      convertedValue = inputValue + 273.15;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      convertedValue = (inputValue - 32) * 5 / 9;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
      convertedValue = ((inputValue - 32) * 5 / 9) + 273.15;
    } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
      convertedValue = inputValue - 273.15;
    } else {
      convertedValue =
          ((inputValue - 273.15) * 9 / 5) + 32; // Kelvin to Fahrenheit
    }

    setState(() {
      _result = convertedValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Input Dropdown
          DropdownButton<String>(
            value: _fromUnit,
            hint: const Text('Select input unit'),
            items: _units.map((String unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _fromUnit = value;
              });
            },
          ),
          const SizedBox(height: 16),

          // Output Dropdown
          DropdownButton<String>(
            value: _toUnit,
            hint: const Text('Select output unit'),
            items: _units.map((String unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _toUnit = value;
              });
            },
          ),
          const SizedBox(height: 16),

          // Input Field
          TextField(
            controller: _inputController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter value',
            ),
          ),
          const SizedBox(height: 16),

          // Convert Button
          ElevatedButton(
            onPressed: _convertTemperature,
            child: const Text('Convert'),
          ),
          const SizedBox(height: 16),

          // Result Display
          Text(
            _result.isNotEmpty ? 'Result: $_result' : '',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
