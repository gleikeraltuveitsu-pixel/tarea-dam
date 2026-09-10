import 'dart:math';
import 'entities.dart';
import 'game_config.dart';
import 'menu.dart';

class IAController {
  final Dificultad dificultad;
  final Random _random = Random();
  int _contador = 0;

  IAController({required this.dificultad});

  void actualizar(Paleta paleta, Pelota pelota) {
    _contador++;

    switch (dificultad) {
      case Dificultad.facil:
        _facil(paleta, pelota);
        break;
      case Dificultad.media:
        _media(paleta, pelota);
        break;
      case Dificultad.dificil:
        _dificil(paleta, pelota);
        break;
    }
  }

  void _facil(Paleta paleta, Pelota pelota) {
    if (_contador % 6 != 0) return;

    if (pelota.dx > 0) {
      if (paleta.y + paleta.alto ~/ 2 < pelota.y) {
        paleta.moverAbajo(GameConfig.alto);
      } else if (paleta.y + paleta.alto ~/ 2 > pelota.y) {
        paleta.moverArriba();
      }
    } else {
      if (_random.nextDouble() < 0.3) {
        if (_random.nextBool()) {
          paleta.moverArriba();
        } else {
          paleta.moverAbajo(GameConfig.alto);
        }
      }
    }
  }

  void _media(Paleta paleta, Pelota pelota) {
    if (_contador % 3 != 0) return;

    int objetivo = pelota.y;
    if (pelota.dx > 0) {
      objetivo = _predecirY(pelota);
    }

    if (_random.nextDouble() < 0.15) {
      objetivo += _random.nextInt(3) - 1;
    }

    int centro = paleta.y + paleta.alto ~/ 2;
    if (centro < objetivo - 1) {
      paleta.moverAbajo(GameConfig.alto);
    } else if (centro > objetivo + 1) {
      paleta.moverArriba();
    }
  }

  void _dificil(Paleta paleta, Pelota pelota) {
    if (_contador % 2 != 0) return;

    int objetivo = pelota.y;
    if (pelota.dx > 0) {
      objetivo = _predecirY(pelota);
    }

    int centro = paleta.y + paleta.alto ~/ 2;
    if (centro < objetivo) {
      paleta.moverAbajo(GameConfig.alto);
    } else if (centro > objetivo) {
      paleta.moverArriba();
    }
  }

  int _predecirY(Pelota pelota) {
    int y = pelota.y;
    int dy = pelota.dy;
    int x = pelota.x;
    int pasos = 0;

    while (x < GameConfig.ancho - 3 && pasos < 100) {
      x++;
      y += dy;
      if (y <= 0 || y >= GameConfig.alto - 1) {
        dy = -dy;
        y = y.clamp(0, GameConfig.alto - 1);
      }
      pasos++;
    }

    return y;
  }
}
