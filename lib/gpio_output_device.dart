import 'gpio_manager.dart';

class GpioOutputDevice {
  GpioOutputDevice({required this.pin, bool initialValue = false})
      : _isOn = initialValue {
    GpioManager().allocateOutput(pin, initialValue ? 1 : 0);
  }

  final int pin;
  late bool _isOn;

  void on() {
    _isOn = true;
    GpioManager().setValue(pin, 1);
  }

  void off() {
    _isOn = false;
    GpioManager().setValue(pin, 0);
  }
}

final class LED extends GpioOutputDevice {
  LED({required super.pin, super.initialValue});

  void toggle() {
    _isOn = !_isOn;
    GpioManager().setValue(pin, _isOn ? 1 : 0);
  }
}
