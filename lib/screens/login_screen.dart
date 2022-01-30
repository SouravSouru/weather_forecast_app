import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/screens/screen_home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/loginBGI.jpg"),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Enter Your City Name",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
            ),
          ),
          OutlinedButton(
            style: ButtonStyle(
                side: MaterialStateProperty.all(const BorderSide(
              color: Colors.white,
              width: 2,
            ))),
            onPressed: () async {
              if (_controller.text.isNotEmpty) {
                await saveCityToStore();
                setState(() {
                  cityName = _controller.text;
                  // defaultCity = cityName.toString();
                });

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => ScreenHome()));
              }
            },
            child: const Text(
              "Get Weather",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> saveCityToStore() async {
    final _sharedPref = await SharedPreferences.getInstance();
    await _sharedPref.setString("defaultCityNameKey", _controller.text);
  }
}
