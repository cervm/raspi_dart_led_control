# Raspberry Pi Dart LED Control

A minimal command-line application demonstrating GPIO control on a Raspberry Pi using Dart's FFI (Foreign Function Interface) to interact with `libgpiod` v2. This project provides an example of controlling an LED with a push button.

## System Requirements

- **Hardware**: Raspberry Pi 5 (other versions should work but are not tested)
- **Operating System**: Raspberry Pi OS (64-bit)
- **libgpiod**: Version 2.x installed on your Raspberry Pi

### Limitations

- **64-bit OS Only**: The application is currently tested and supported only on the 64-bit version of Raspberry Pi OS.
- **Hard-Coded Chip Name**: The GPIO chip name is hard-coded as `'gpiochip4'` in `lib/gpio_manager.dart`. If your setup uses a different chip name, you will need to modify this value.

## Components

- **LED**: Used as an output indicator.
- **Resistor**: Used to limit current to the LED.
- **Push Button**: Used as an input to control the LED state.

## Project Structure

- **`bin/`**: Contains the main entry point of the application.
- **`lib/`**: Contains the library code, including FFI bindings and GPIO management logic.

## Running the Application

1. **Connect the Components:**
   - Connect the LED and resistor to the appropriate GPIO pin.
   - Connect the push button to another GPIO pin.

2. **Run the Application:**
   ```bash
   dart run bin/main.dart
   ```

   The LED will blink while the button is not pressed, and it will stay on when the button is pressed.

## References

- [Dart FFI Documentation](https://dart.dev/guides/libraries/c-interop)
- [libgpiod Documentation](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/)
- [Raspberry Pi GPIO Documentation](https://www.raspberrypi.org/documentation/usage/gpio/)
