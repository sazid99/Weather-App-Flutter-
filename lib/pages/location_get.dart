import 'package:flutter/material.dart';
import 'package:weather/pages/home_page.dart';

class LocationGet extends StatefulWidget {
  const LocationGet({super.key});

  @override
  State<LocationGet> createState() => _LocationGetState();
}

class _LocationGetState extends State<LocationGet> {
  TextEditingController textEditingController = TextEditingController();
  String cityName = "Jamalpur";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Location"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 15,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal, fixedSize: Size.fromWidth(200)),
              onPressed: () {
                setState(() {
                  cityName = textEditingController.text;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(cityName: cityName)),
                );
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
