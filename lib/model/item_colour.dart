import 'dart:core';

class ItemColour {
  final int skcolr;

  ItemColour({required this.skcolr});

  factory ItemColour.fromJson(Map<int, dynamic> json) {
    return ItemColour(
      skcolr: json["skcolr"],
    );
  }
}
