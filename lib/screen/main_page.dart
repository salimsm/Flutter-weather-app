import 'package:flutter/material.dart';

import '../constants/constant.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _loading = true;
  String cityName = "None";
  String date = "Date";
  String time = "Time";
  String? icon;

  double temp = 0.0, minTemp = 0.0, maxTemp = 0.0, feelsLike = 0.0;
  String description = "---", main = "---";
  int humidity = 0, pressure = 0;

  TextEditingController cityTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: mainScreenDecoration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Center(
                      child: TextField(
                        style: textFieldStyle,
                        controller: cityTextField,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter City Name..",
                          hintStyle: textFieldStyle,
                          prefixIcon: const Icon(
                            Icons.cloud,
                            color: Colors.blue,
                          ),
                          suffixIcon: GestureDetector(
                            child: Container(
                              color: Colors.blue.shade300,
                              child: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              //TODO implement search button click functionality
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                (_loading)
                    ? Center(
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            height: 40,
                            width: 40,
                            child: const CircularProgressIndicator()))
                    : SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(
                      width: 5,
                    ),
                    getText(cityName, 20),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Last Updated on",
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      size: 14,
                    ),
                    getText(date, 14),
                    SizedBox(
                      width: 14,
                    ),
                    Icon(Icons.access_time_rounded, size: 14),
                    getText(time, 14),
                  ],
                ),
                SizedBox(
                  child: (icon == null)
                      ? Container()
                      : Image.network(
                          icon!,
                          height: 90,
                          width: 90,
                        ),
                ),
                Container(
                    alignment: Alignment.center,
                    child: getText("$temp°C", screenHeight * 0.12, bold: true)),
                Column(
                  children: [
                    getText(main, screenHeight * 0.04),
                    getText("Description: $description", 17),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                SizedBox(
                  height: 180,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      getListViewContainer('Min.', '$minTemp°C'),
                      getListViewContainer('Max.', '$maxTemp°C'),
                      getListViewContainer('Humidity', '$humidity %'),
                      getListViewContainer('Pressure', "$pressure"),
                      getListViewContainer('Feels alike', "$feelsLike"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getText(String text, double size, {bool bold = false}) {
    if (bold) {
      return Text(
        text,
        style: TextStyle(
            fontFamily: 'Laila', fontSize: size, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        text,
        style: TextStyle(
            fontFamily: 'Laila', fontSize: size, fontWeight: FontWeight.w300),
      );
    }
  }

  Widget getListViewContainer(String name, dynamic value) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 125,
      decoration: listViewContainerBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 3,
          ),
          getText(name, 17),
          const Divider(),
          getText(value.toString(), 26, bold: true),
          const SizedBox(
            height: 3,
          )
        ],
      ),
    );
  }

  void getDateTime() {
    final dateTime = DateTime.now();
    String month = getMonthName(dateTime.month);
    date = "$month ${dateTime.day}";
    time = "${dateTime.hour}:${dateTime.minute}";
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "Error";
    }
  }
}
