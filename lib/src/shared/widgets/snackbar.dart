import 'package:flutter/material.dart';

abstract class SnackBarHelper {
  static void showSuccess(BuildContext context, String message) {
    context.showSnackBar(
      _createSnackBar(
        message: message,
        icon: Icons.check_circle_rounded,
        color: Colors.green.shade700,
      ),
    );
  }

  static void showInfo(BuildContext context, String message) {
    context.showSnackBar(
      _createSnackBar(
        message: message,
        icon: Icons.info_rounded,
        color: Colors.blue.shade700,
      ),
    );
  }

  static void showWarning(BuildContext context, String message) {
    context.showSnackBar(
      _createSnackBar(
        message: message,
        icon: Icons.warning_rounded,
        color: Colors.orange.shade700,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    context.showSnackBar(
      _createSnackBar(
        message: message,
        icon: Icons.error,
        color: Theme.of(context).colorScheme.error,
      ),
    );
  }

  static SnackBar _createSnackBar({
    required String message,
    required IconData icon,
    required Color color,
  }) {
    return SnackBar(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.grey.shade900,
      behavior: SnackBarBehavior.floating,
      content: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              width: 6,
              color: color,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 8.0),
                child: Icon(icon, color: color),
              ),
              Text(
                message,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension _X on BuildContext {
  void showSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
