# Raspberry Pi Dart LED Control

A minimal command-line application demonstrating GPIO control on a Raspberry Pi using Dart's FFI (Foreign Function Interface) to interact with `libgpiod` v2. This project provides an example of controlling an LED with a push button.

Tested on **Raspberry Pi 5** running **Raspberry Pi OS (64-bit)**.

## Components

- LED
- 220Ω Resistor
- Push Button

## Prerequisites
- Dart SDK installed on your Raspberry Pi.
- `libgpiod` v2 pre-installed on your Raspberry Pi (needed for GPIO access).

## Limitations

- Only compatible with 64-bit OS.
- Chip name is hard-coded to `gpiochip4` in `gpio_manager.dart`.

## Running the Application

1. **Connect the Components:**
   - Connect the LED to a GPIO pin (set to 03 (BCM) in `main.dart`).
   - Connect the push button to another GPIO pin (set to 21 (BCM) in `main.dart`).

2. **Run the Application:**
   ```bash
   dart run bin/main.dart
   ```

## Usage
- The LED will blink continuously when the button is not pressed.
- When the button is pressed, the LED remains lit continuously.

## Project Structure

- **`bin/`**: Contains the main entry point of the application.
- **`lib/`**: Contains the library code, including FFI bindings and GPIO management logic.

## References

- [Dart FFI Documentation](https://dart.dev/guides/libraries/c-interop)
- [libgpiod Documentation](https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/)
- [Raspberry Pi GPIO Documentation](https://www.raspberrypi.com/documentation/computers/os.html#use-gpio-from-python)
- [Raspberry Pi Flutter Installer](https://github.com/Snapp-X/snapp_installer)
- [libgpiod Example](https://github.com/starnight/libgpiod-example)
