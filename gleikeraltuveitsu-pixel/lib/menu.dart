import 'dart:io';

enum ModoJuego { vsJugador, vsIA }

enum Dificultad { facil, media, dificil }

class MenuResultado {
  final ModoJuego modo;
  final Dificultad? dificultad;

  MenuResultado({required this.modo, this.dificultad});
}

MenuResultado mostrarMenu() {
  stdout.write('\x1B[2J\x1B[H');
  stdout.writeln('========================================');
  stdout.writeln('           PIN PON  v1.0');
  stdout.writeln('========================================');
  stdout.writeln();
  stdout.writeln('  Selecciona el modo de juego:');
  stdout.writeln();
  stdout.writeln('  [1]  Jugador vs Jugador');
  stdout.writeln('  [2]  Jugador vs IA');
  stdout.writeln();
  stdout.write('  Opcion: ');

  String? modo;
  while (modo == null || (modo != '1' && modo != '2')) {
    modo = stdin.readLineSync()?.trim();
    if (modo != '1' && modo != '2') {
      stdout.write('  Opcion invalida. Intenta de nuevo: ');
    }
  }

  if (modo == '1') {
    return MenuResultado(modo: ModoJuego.vsJugador);
  }

  stdout.writeln();
  stdout.writeln('  Selecciona la dificultad de la IA:');
  stdout.writeln();
  stdout.writeln('  [1]  Facil');
  stdout.writeln('  [2]  Media');
  stdout.writeln('  [3]  Dificil');
  stdout.writeln();
  stdout.write('  Dificultad: ');

  String? dif;
  while (dif == null || (dif != '1' && dif != '2' && dif != '3')) {
    dif = stdin.readLineSync()?.trim();
    if (dif != '1' && dif != '2' && dif != '3') {
      stdout.write('  Opcion invalida. Intenta de nuevo: ');
    }
  }

  Dificultad dificultad;
  switch (dif) {
    case '1':
      dificultad = Dificultad.facil;
      break;
    case '2':
      dificultad = Dificultad.media;
      break;
    default:
      dificultad = Dificultad.dificil;
  }

  return MenuResultado(modo: ModoJuego.vsIA, dificultad: dificultad);
}
