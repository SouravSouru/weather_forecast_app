import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/models/weather_responses.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/splash_screen.dart';
import 'package:weather_app/widgets/main_weather.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _locationController = TextEditingController();

  late Future<WeatherRespones> weather;

  String cloud = "0";
  String humidity = "0";
  String windSpeed = "0";
  String mainWeather = "0";

  @override
  void initState() {
    weather = getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade400,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.exit_to_app_sharp,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          signOut();
                        },
                      ),
                      title: const Text(
                        "Enter Your Location",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Container(
                        height: 30,
                        child: TextFormField(
                          controller: _locationController,
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                cityName = defaultCity;
                              } else {
                                cityName = value;
                              }
                              weather = getWeather();
                            });
                          },
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 10),
                            hintText: "City...",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            )),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FutureBuilder<WeatherRespones>(
                          future: weather,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Failed To load"),
                              );
                            }
                            SchedulerBinding
                                .instance //use schedulerBinding, is to use setstate
                                ?.addPostFrameCallback((timeStamp) {
                              setState(() {
                                humidity = snapshot.data!.humidity.toString();
                                cloud = snapshot.data!.cloud.toString();
                                windSpeed = snapshot.data!.windspeed.toString();
                                mainWeather = snapshot.data!.weather.toString();
                                // getWeather();
                              });
                            });

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(mainWeather == "Rain"
                                          ? "assets/rainy.png"
                                          : mainWeather == "Clear"
                                              ? "assets/sun.png"
                                              : mainWeather == "Haze"
                                                  ? "assets/thunderStrom.png"
                                                  : "assets/defaultWeather.png"),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data!.temperature.toString() +
                                      '\u00B0C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data?.description,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Location : ${snapshot.data?.location}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  MainWeather(
                    title: "Weather",
                    leading: mainWeather,
                    image: "assets/weather.png",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MainWeather(
                    title: "Cloud",
                    leading: "$cloud%",
                    image: "assets/clouds.png",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MainWeather(
                    title: "Humidity",
                    leading: "$humidity%",
                    image: "assets/humidity.png",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MainWeather(
                    title: "Wind Speed",
                    leading: "$windSpeed Km/H",
                    image: "assets/wind.png",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  

  signOut() async {
    final _sharepref = await SharedPreferences.getInstance();
    await _sharepref.clear();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx1) => LoginScreen()), (route) => false);
  }
}
