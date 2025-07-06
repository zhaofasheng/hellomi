import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class KeyboardDoneOverlay {
  static KeyboardDoneOverlay? _instance;
  OverlayEntry? _overlayEntry;
  final KeyboardVisibilityController _keyboardVisibilityController = KeyboardVisibilityController();

  factory KeyboardDoneOverlay() => _instance ??= KeyboardDoneOverlay._internal();

  KeyboardDoneOverlay._internal();

  void attach(BuildContext context) {
    _keyboardVisibilityController.onChange.listen((visible) {
      if (visible) {
        _showDoneButton(context);
      } else {
        _removeDoneButton();
      }
    });
  }

  void _showDoneButton(BuildContext context) {
    if (_overlayEntry != null) return;

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    _overlayEntry = OverlayEntry(builder: (_) {
      return Positioned(
        right: 16,
        bottom: bottomInset + 10,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '完成',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeDoneButton() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void dispose() {
    _removeDoneButton();
  }
}