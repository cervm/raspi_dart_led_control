import 'dart:io';

import 'libgpiod_ffi.dart';

const _chipName = 'gpiochip4';

class GpioManager {
  GpioManager._() {
    try {
      // Open the GPIO chip
      _chip = Libgpiod().openChip(_chipName);

      // Set up signal handlers for graceful termination
      ProcessSignal.sigint.watch().listen(_onSignal);
      ProcessSignal.sigterm.watch().listen(_onSignal);
    } catch (e) {
      _onError(e);
      exit(1);
    }
  }

  static final GpioManager _instance = GpioManager._();

  factory GpioManager() => _instance;

  late final Chip _chip;
  final _allocatedPins = <int, Line>{};

  void allocateInput(int pin) {
    try {
      final line = _allocatePin(pin);
      if (Libgpiod().requestInput(line, 'dart_in_$pin') != 0) {
        throw Exception('Failed to request input line $pin');
      }
    } catch (e) {
      _onError(e);
      exit(1);
    }
  }

  void allocateOutput(int pin, int initialValue) {
    try {
      final line = _allocatePin(pin);
      if (Libgpiod().requestOutput(line, 'dart_out_$pin', initialValue) != 0) {
        throw Exception('Failed to request output line $pin');
      }
    } catch (e) {
      _onError(e);
      exit(1);
    }
  }

  int getValue(int pin) {
    try {
      final line = _getLine(pin);
      return Libgpiod().getValue(line);
    } catch (e) {
      _onError(e);
      exit(1);
    }
  }

  void setValue(int pin, int value) {
    try {
      final line = _getLine(pin);
      Libgpiod().setValue(line, value);
    } catch (e) {
      _onError(e);
      exit(1);
    }
  }

  Line _allocatePin(int pin) {
    if (_allocatedPins.keys.contains(pin)) {
      throw StateError('GPIO pin $pin already allocated');
    }
    final line = Libgpiod().getLine(_chip, pin);
    _allocatedPins[pin] = line;
    return line;
  }

  Line _getLine(int pin) {
    final line = _allocatedPins[pin];
    if (line == null) {
      throw StateError('GPIO pin $pin not allocated');
    }
    return line;
  }

  void _onError(Object error) {
    print('ERROR: $error');
    _dispose();
  }

  void _onSignal(ProcessSignal signal) {
    print('🔌 Received ${signal.toString()}, cleaning up...');
    _dispose();
    exit(0);
  }

  void _dispose() {
    Libgpiod().closeChip(_chip);
  }
}
