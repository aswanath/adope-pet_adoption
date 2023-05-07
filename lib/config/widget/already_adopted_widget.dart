import 'package:flutter/material.dart';

class AlreadyAdoptedWidget extends StatelessWidget {
  final String? text;

  const AlreadyAdoptedWidget({
    Key? key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).focusColor,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).focusColor,
            blurRadius: 10,
            spreadRadius: 10,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Center(
        child: Transform.rotate(
          angle: 6,
          child: Text(
            text ?? "Already\nAdopted",
            style: Theme.of(context).primaryTextTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
