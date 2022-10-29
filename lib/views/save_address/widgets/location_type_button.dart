import 'package:flutter/material.dart';

class LocationTypeButton extends StatelessWidget {
  const LocationTypeButton(
      {super.key,
      required this.onPressed,
      required this.isSelected,
      required this.title,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.3),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? Colors.red : Colors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(iconData),
            Text(title),
          ],
        ),
      ),
    );
  }

  final VoidCallback onPressed;
  final bool isSelected;
  final String title;
  final IconData iconData;
}
