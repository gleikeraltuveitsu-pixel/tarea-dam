import 'dart:io';

const _rojo = '\u001b[31m';
const _verde = '\u001b[32m';
const _amarillo = '\u001b[33m';
const _magenta = '\u001b[35m';
const _cian = '\u001b[36m';
const _blanco = '\u001b[37m';
const _reset = '\u001b[0m';
const _negrita = '\u001b[1m';

double? _leerNumero(String mensaje) {
  while (true) {
    stdout.write(mensaje);
    final entrada = stdin.readLineSync()?.trim();
    if (entrada != null && entrada.toLowerCase() == 'salir') {
      return null;
    }
    final numero = double.tryParse(entrada ?? '');
    if (numero != null) {
      return numero;
    }
    print('${_rojo}Entrada no valida. Ingresa un numero.$_reset');
  }
}

String _leerOpcion() {
  while (true) {
    stdout.write('${_amarillo}Operacion (+, -, *, /): $_reset');
    final opcion = stdin.readLineSync()?.trim();
    if (opcion != null &&
        (opcion == '+' || opcion == '-' || opcion == '*' || opcion == '/')) {
      return opcion;
    }
    print('${_rojo}Operacion no valida. Usa +, -, * o /.$_reset');
  }
}

String _formatearNumero(double numero) {
  if (numero == numero.roundToDouble()) {
    return numero.toInt().toString();
  }
  return numero.toString();
}

void _mostrarBannerPersonalizado() {
  print(_cian + _negrita + r'''
  ██████  ▄▄▄      ██   ██ ██    ██ ██       █████  ██████   ██████  ██████   █████
  ██      ████     ██   ██ ██    ██ ██      ██   ██ ██   ██ ██    ██ ██   ██ ██   ██
  ███████ ██ ██    ███████ ██    ██ ██      ███████ ██   ██ ██    ██ ██████  ███████
  ██   ██ ██  ██   ██   ██ ██    ██ ██      ██   ██ ██   ██ ██    ██ ██      ██   ██
  ██████  ██   ██  ██   ██  ██████  ███████ ██   ██ ██████   ██████  ██      ██   ██
	''' + _reset);
}

void main() {
  _mostrarBannerPersonalizado();
  print('$_verde${_negrita}Bienvenido a la Calculadora Terminal$_reset');
  print('${_blanco}Operaciones: suma (+), resta (-), multiplicacion (*), division (/)$_reset');
  print('${_blanco}Escribe "salir" para terminar.$_reset');
  print('');

  var ejecutando = true;

  while (ejecutando) {
    print('$_magenta$_negrita--- Nueva operacion ---$_reset');
    final numero1 = _leerNumero('Ingresa el primer numero: ');
    if (numero1 == null) {
      ejecutando = false;
      continue;
    }
    final numero2 = _leerNumero('Ingresa el segundo numero: ');
    if (numero2 == null) {
      ejecutando = false;
      continue;
    }
    final operacion = _leerOpcion();

    double resultado;
    String simbolo;
    String nombreOperacion;

    switch (operacion) {
      case '+':
        resultado = numero1 + numero2;
        simbolo = '+';
        nombreOperacion = 'suma';
        break;
      case '-':
        resultado = numero1 - numero2;
        simbolo = '-';
        nombreOperacion = 'resta';
        break;
      case '*':
        resultado = numero1 * numero2;
        simbolo = '*';
        nombreOperacion = 'multiplicacion';
        break;
      case '/':
        if (numero2 == 0) {
          print('${_rojo}Error: No se puede dividir entre cero.$_reset');
          continue;
        }
        resultado = numero1 / numero2;
        simbolo = '/';
        nombreOperacion = 'division';
        break;
      default:
        continue;
    }

    print('');
    print(
        '$_cian$nombreOperacion:$_reset $_blanco${_formatearNumero(numero1)} $simbolo ${_formatearNumero(numero2)} = $_verde$_negrita${_formatearNumero(resultado)}$_reset');
    print('');
  }
}