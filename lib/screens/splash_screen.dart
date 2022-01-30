import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/screen_home.dart';

String? defaultCity;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 168,
              ),
              Image.asset(
                "assets/splashScreenCloud.png",
                width: 200,
                height: 200,
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                "WeatherApp",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              const SizedBox(
                height: 5,
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> splashDuration() async {
    await Future.delayed(Duration(seconds: 3));
    await isLoggedIn();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
  }

  Future<void> isLoggedIn() async {
    final _sharepref = await SharedPreferences.getInstance();
    defaultCity = _sharepref.getString("defaultCityNameKey");
    if (defaultCity == null || defaultCity!.isEmpty) {
      splashDuration();
    } else {
      cityName = defaultCity;
      await Future.delayed(Duration(milliseconds: 600));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => ScreenHome()));
    }
  }
}
