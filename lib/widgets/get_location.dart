import 'package:flutter/material.dart';
import 'package:weather/pages/home_page.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({super.key});

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  TextEditingController textEditingController = TextEditingController();
  String changeCityName = "Jamalpur";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Location"),
      actions: [
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: "Enter city name",
            border: OutlineInputBorder(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                fixedSize: Size.fromWidth(100),
              ),
              onPressed: () {
                setState(() {
                  changeCityName = textEditingController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomePage(cityName: changeCityName)),
                  );
                });
              },
              child: Text("Ok"),
            ),
          ],
        ),
      ],
    );
  }
}
