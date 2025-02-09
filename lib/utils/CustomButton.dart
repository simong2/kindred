import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 2,
      height: MediaQuery.sizeOf(context).height * .06,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFA3B899), // Button background color
          foregroundColor: const Color(0xFF667B68), // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side:
                const BorderSide(color: Color(0xFF667B68), width: 2), // Border
          ),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
