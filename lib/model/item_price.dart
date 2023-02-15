import 'dart:core';

class ItemPrice {
  final String pcsprc;

  ItemPrice({required this.pcsprc});

  factory ItemPrice.fromJson(Map<String, dynamic> json) {
    return ItemPrice(
      pcsprc: json["pcsprc"] as String,
    );
  }
}
