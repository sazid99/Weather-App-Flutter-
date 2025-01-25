import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weather/pages/location_get.dart';
import 'package:weather/themes/theme.dart';
import 'package:weather/widgets/additional_info_widget.dart';

class HomePage extends StatefulWidget {
  final String cityName;

  const HomePage({
    super.key,
    this.cityName = "Jamalpur",
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? temperature;
  String? weatherIcon;
  int? isDay;
  String? updates;
  double? wind;
  int? currentHumadity;
  double? currentPressure;

  Future fetchData() async {
    try {
      final url = Uri.parse(
          "https://api.weatherapi.com/v1/current.json?key=77cad40d91db4ffa94b162015250501&q=${widget.cityName}&aqi=no");
      final response = await http.get(url);

      if (response.statusCode != 200) {
        debugPrint('HTTP Error: ${response.statusCode}');
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['current']['temp_c'] != null) {
          setState(() {
            temperature = data['current']['temp_c'];
            weatherIcon = "https:${data['current']['condition']['icon']}";
            isDay = data['current']['is_day'];
            updates = data['current']['condition']['text'];
            wind = data['current']['wind_kph'];
            currentHumadity = data['current']['humidity'];
            currentPressure = data['current']['pressure_mb'];
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
            onPressed: () {
              showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(100, 100, 0, 0),
                items: [
                  PopupMenuItem<String>(
                    value: 'Change Location',
                    child: Text('Change Location'),
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationGet()),
                        );
                      });
                    },
                  ),
                ],
              );
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: temperature == null
          ? Center(child: const CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isDay == 1 ? "Day" : "Night",
                          style: TextStyle(fontSize: 18),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.cityName,
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LocationGet();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.location_on),
                            ),
                          ],
                        ),
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
                              weatherIcon != null
                                  ? Image.network(
                                      weatherIcon!,
                                      height: 80,
                                    )
                                  : SizedBox.shrink(),
                              Text(
                                "$updates",
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
                      "Additional Information",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                          value: "$currentHumadity",
                        ),
                        AdditionalInfoWidget(
                          icon: Icons.umbrella,
                          label: "Pressure",
                          value: "$currentPressure",
                        ),
                        AdditionalInfoWidget(
                          icon: Icons.air,
                          label: "Wind Kph",
                          value: "$wind",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
