import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 20,
      right: 90,
      child: SizedBox(
        height: 50,
        child: TextField(
          onSubmitted: onSubmitted,
          decoration: const InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  final ValueChanged<String> onSubmitted;
}
