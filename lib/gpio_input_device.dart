import 'gpio_manager.dart';

class GpioInputDevice {
  GpioInputDevice({required this.pin}) {
    GpioManager().allocateInput(pin);
  }

  final int pin;

  int get value => GpioManager().getValue(pin);
}

final class Button extends GpioInputDevice {
  Button({required super.pin});

  bool get isPressed => value == 0;
}
