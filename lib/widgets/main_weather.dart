import 'package:flutter/material.dart';

class MainWeather extends StatelessWidget {
  final String title;
  final String image;
  final String leading;

  MainWeather(
      {Key? key,
      required this.title,
      required this.leading,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        image,
        width: 50,
        height: 50,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      trailing: Text(
        leading,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
