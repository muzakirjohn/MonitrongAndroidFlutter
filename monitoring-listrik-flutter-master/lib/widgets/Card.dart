import 'package:flutter/material.dart';

class CardNormal extends StatelessWidget {
  final Widget childCard;

  const CardNormal({
    Key? key,
    required this.childCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: this.childCard);
  }
}
