import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decimal a Binario',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
          primary: Colors.deepOrange,
          secondary: Colors.amber,
        ),
        scaffoldBackgroundColor: Colors.orange[50],
        useMaterial3: true,
      ),
      home: const DecimalToBinaryPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DecimalToBinaryPage extends StatefulWidget {
  const DecimalToBinaryPage({super.key});
  @override
  State<DecimalToBinaryPage> createState() => _DecimalToBinaryPageState();
}

class _DecimalToBinaryPageState extends State<DecimalToBinaryPage> {
  final TextEditingController _controller = TextEditingController();
  String _binaryResult = '';
  String _errorMsg = '';

  void _convert() {
    setState(() {
      _errorMsg = '';
      _binaryResult = '';
      final input = _controller.text.trim();
      if (input.isEmpty) {
        _errorMsg = 'Por favor ingresa un número.';
        return;
      }
      final number = int.tryParse(input);
      if (number == null || number < 0) {
        _errorMsg = 'Solo se permiten enteros positivos.';
        return;
      }
      _binaryResult = number.toRadixString(2);
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _binaryResult = '';
      _errorMsg = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Decimal a Binario'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número decimal',
                labelStyle: const TextStyle(color: Colors.deepOrange),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(color: Colors.deepOrange, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.calculate),
                    label: const Text(
                      'Convertir',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: _convert,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.clear),
                    label: const Text(
                      'Limpiar',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: _clear,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_errorMsg.isNotEmpty)
              Text(
                _errorMsg,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            if (_binaryResult.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.code, color: Colors.deepOrange),
                    const SizedBox(width: 10),
                    Text(
                      'Binario: $_binaryResult',
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
