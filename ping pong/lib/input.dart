// input.dart
import 'dart:io';

void configurarTeclado(Function(String) onTecla) {
  try {
    stdin.lineMode = false;
    stdin.echoMode = false;
  } catch (_) {}

  stdin.listen((List<int> codigos) {
    for (var code in codigos) {
      final char = String.fromCharCode(code).toLowerCase();
      onTecla(char);
    }
  });
}