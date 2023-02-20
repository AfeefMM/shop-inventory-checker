import 'dart:core';

class ClothItem {
  final String ivskun;

//  final String ivonhd;

  ClothItem({
    required this.ivskun,
    //required this.ivonhd,
  });

  factory ClothItem.fromJSON(Map<String, dynamic> json) {
    return ClothItem(ivskun: json['ivskun']
        //, ivonhd: json['ivonhd']
        );
  }
}
