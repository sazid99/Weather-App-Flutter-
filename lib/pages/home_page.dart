import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather/themes/theme.dart';
import 'package:weather/widgets/additional_info_widget.dart';
import 'package:weather/widgets/hourly_forecast_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? temperature;
  String cityName = "Jamalpur";

  Future fetchData() async {
    try {
      final url = Uri.parse(
          "https://api.weatherapi.com/v1/current.json?key=77cad40d91db4ffa94b162015250501&q=$cityName&aqi=no");
      final response = await http.get(url);

      if (response.statusCode != 200) {
        debugPrint('HTTP Error: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['current']['temp_c'] != null) {
          setState(() {
            temperature = data['current']['temp_c'];
          });
        } else {
          throw Exception('Invalid data format in response');
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: Icon(themeProvider.updateTheme == ThemeMode.dark
                ? Icons.light_mode
                : Icons.dark_mode)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.refresh),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: temperature == null
          ? Center(child: const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        cityName,
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.location_on)
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "$temperature °C",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.cloud,
                              size: 80,
                            ),
                            Text(
                              "Rain",
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyForecastWidget(
                          time: "9:00",
                          icon: Icons.cloud,
                          temp: "18° C",
                        ),
                        HourlyForecastWidget(
                          time: "10:00",
                          icon: Icons.water_drop,
                          temp: "19° C",
                        ),
                        HourlyForecastWidget(
                          time: "11:00",
                          icon: Icons.sunny,
                          temp: "20° C",
                        ),
                        HourlyForecastWidget(
                          time: "12:00",
                          icon: Icons.cloud,
                          temp: "21° C",
                        ),
                        HourlyForecastWidget(
                          time: "1:00",
                          icon: Icons.sunny,
                          temp: "22° C",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Additionnal Information",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoWidget(
                        icon: Icons.water_drop,
                        label: "Humadity",
                        value: "94",
                      ),
                      AdditionalInfoWidget(
                        icon: Icons.umbrella,
                        label: "Pressure",
                        value: "80",
                      ),
                      AdditionalInfoWidget(
                        icon: Icons.air,
                        label: "Wind Speed",
                        value: "75",
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
