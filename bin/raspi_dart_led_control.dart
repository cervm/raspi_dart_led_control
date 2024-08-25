import 'package:raspi_dart_led_control/gpio_input_device.dart';
import 'package:raspi_dart_led_control/gpio_output_device.dart';

const _buttonPin = 21; // GPIO 21 (BCM)
const _ledPin = 3; // GPIO 3 (BCM)

Future<void> main(List<String> arguments) async {
  final button = Button(pin: _buttonPin);
  final led = LED(pin: _ledPin, initialValue: false);

  while (true) {
    await Future.delayed(Duration(milliseconds: 200));

    if (button.isPressed) {
      led.on();
      print('🟢 Button pressed');
    } else {
      led.toggle();
      print("🔴 Button NOT pressed");
    }
  }
}
