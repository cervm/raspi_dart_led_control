import 'dart:ffi';

import 'package:ffi/ffi.dart';

sealed class GpiodChip extends Opaque {}

sealed class GpiodLine extends Opaque {}

typedef Chip = Pointer<GpiodChip>;
typedef Line = Pointer<GpiodLine>;

typedef GpiodChipOpenByNameC = Pointer<GpiodChip> Function(Pointer<Utf8>);
typedef GpiodChipOpenByName = Pointer<GpiodChip> Function(Pointer<Utf8>);

typedef GpiodChipGetLineC = Pointer<GpiodLine> Function(
    Pointer<GpiodChip>, Int64);
typedef GpiodChipGetLine = Pointer<GpiodLine> Function(Pointer<GpiodChip>, int);

typedef GpiodLineRequestInputC = Int64 Function(
    Pointer<GpiodLine>, Pointer<Utf8>);
typedef GpiodLineRequestInput = int Function(Pointer<GpiodLine>, Pointer<Utf8>);

typedef GpiodLineRequestOutputC = Int64 Function(
    Pointer<GpiodLine>, Pointer<Utf8>, Int64);
typedef GpiodLineRequestOutput = int Function(
    Pointer<GpiodLine>, Pointer<Utf8>, int);

typedef GpiodLineGetValueC = Int64 Function(Pointer<GpiodLine>);
typedef GpiodLineGetValue = int Function(Pointer<GpiodLine>);

typedef GpiodLineSetValueC = Int64 Function(Pointer<GpiodLine>, Int64);
typedef GpiodLineSetValue = int Function(Pointer<GpiodLine>, int);

typedef GpiodChipCloseC = Void Function(Pointer<GpiodChip>);
typedef GpiodChipClose = void Function(Pointer<GpiodChip>);

final _libgpiod = DynamicLibrary.open('libgpiod.so.2');

class Libgpiod {
  Libgpiod._();

  static final _instance = Libgpiod._();

  factory Libgpiod() => _instance;

  final _gpiodChipOpenByName = _libgpiod
      .lookup<NativeFunction<GpiodChipOpenByNameC>>('gpiod_chip_open_by_name')
      .asFunction<GpiodChipOpenByName>();

  final _gpiodChipGetLine = _libgpiod
      .lookup<NativeFunction<GpiodChipGetLineC>>('gpiod_chip_get_line')
      .asFunction<GpiodChipGetLine>();

  final _gpiodLineRequestInput = _libgpiod
      .lookup<NativeFunction<GpiodLineRequestInputC>>(
          'gpiod_line_request_input')
      .asFunction<GpiodLineRequestInput>();

  final _gpiodLineRequestOutput = _libgpiod
      .lookup<NativeFunction<GpiodLineRequestOutputC>>(
          'gpiod_line_request_output')
      .asFunction<GpiodLineRequestOutput>();

  final _gpiodLineGetValue = _libgpiod
      .lookup<NativeFunction<GpiodLineGetValueC>>('gpiod_line_get_value')
      .asFunction<GpiodLineGetValue>();

  final _gpiodLineSetValue = _libgpiod
      .lookup<NativeFunction<GpiodLineSetValueC>>('gpiod_line_set_value')
      .asFunction<GpiodLineSetValue>();

  final _gpiodChipClose = _libgpiod
      .lookup<NativeFunction<GpiodChipCloseC>>('gpiod_chip_close')
      .asFunction<GpiodChipClose>();

  Chip openChip(String name) {
    final chip = _gpiodChipOpenByName(name.toNativeUtf8());
    if (chip == nullptr) {
      throw Exception('Failed to open GPIO chip: $name');
    }
    return chip;
  }

  Line getLine(Chip chip, int offset) {
    final line = _gpiodChipGetLine(chip, offset);
    if (line == nullptr) {
      throw Exception('Failed to get line: $offset');
    }
    return line;
  }

  int requestInput(Line line, String consumer) =>
      _gpiodLineRequestInput(line, consumer.toNativeUtf8());

  int requestOutput(Line line, String consumer, int defaultVal) =>
      _gpiodLineRequestOutput(line, consumer.toNativeUtf8(), defaultVal);

  int getValue(Line line) => _gpiodLineGetValue(line);

  int setValue(Line line, int value) => _gpiodLineSetValue(line, value);

  void closeChip(Chip chip) => _gpiodChipClose(chip);
}
