import 'package:flutter/material.dart';

class MapFuncButtons extends StatelessWidget {
  const MapFuncButtons({
    super.key,
    required this.changeMapType,
    required this.addMarker,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: "mapType",
            onPressed: changeMapType,
            child: const Icon(Icons.map),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "marker",
            onPressed: () {
              addMarker();
            },
            child: const Icon(Icons.games_outlined),
          ),
        ],
      ),
    );
  }

  final VoidCallback changeMapType;
  final VoidCallback addMarker;
}
