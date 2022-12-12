import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constant.dart';
import '../services/weather_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _loading = false;
  String cityName = "None";
  String date = "Date";
  String time = "Time";
  String? icon;

  double temp = 0.0, minTemp = 0.0, maxTemp = 0.0, feelsLike = 0.0;
  String description = "---", main = "---";
  int humidity = 0, pressure = 0;
  double lat = 0, lon = 0;
  int visibility = 0;
  double? speed=0.0,gust=0.0;
  int? degree =0;
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
                              print("tapped");
                              FocusScope.of(context).unfocus();

                              if (cityTextField.text.isEmpty) {
                                showSnackBar("Please, Enter City..");
                              } else {
                                _loading = true;
                                updateUi();
                                setState(() {});
                              }
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
                      getListViewContainer('Pressure', "$pressure hPa"),
                      getListViewContainer('Feels alike', "$feelsLike°C"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "More Info:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(8),
                  decoration: moreInfoBD,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Latitude: ${lat.toString()}",style: moreInfoTS,),
                      SizedBox(height: 5,),
                      Text("Longitude: ${lon.toString()}",style: moreInfoTS,),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(8),
                  decoration: moreInfoBD,
                  child: Text("Visibility: ${visibility.toString()} m",style: moreInfoTS,),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  padding: EdgeInsets.all(8),
                  decoration: moreInfoBD,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wind:",style: moreInfoTS.copyWith(fontWeight: FontWeight.bold),),
                      Divider(color: Colors.blueGrey,),
                      Text("Speed:    ${speed.toString()} m/sec",style: moreInfoTS,),
                      Text("Degree:  ${degree.toString() }°",style: moreInfoTS,),
                      Text("Gust:      ${gust.toString()} m/sec",style: moreInfoTS,),
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

  // horizontal scrollable listview component (container)
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

  Widget getContainer(String name, dynamic value) {
    return Container(
      height: 65,
      margin: const EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: listViewContainerBoxDecoration.copyWith(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getText(name, 17),
          getText(value.toString(), 26, bold: true),
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

  void showSnackBar(String msg) {
    var height = MediaQuery.of(context).size.height;
    final snackBar = SnackBar(
      content: Text(
        msg,
        style: TextStyle(fontSize: 17),
      ),
      margin: EdgeInsets.only(bottom: height - 150, left: 10, right: 10),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void updateUi() async {
    final result = await WeatherService.getWeatherDetails(
        cityTextField.text.toString().trim());
    if (result == false) {
      _loading = false;

      showSnackBar("Please, check the city name..");
      setState(() {});
    } else {
      setState(() {
        _loading = false;
        print("----------------------${result.main!.temp!}");
        print(result.coord.lat);
        temp = result.main!.temp!;
        minTemp = result.main!.tempMin!;
        maxTemp = result.main!.tempMax!;
        cityName = result.name!;
        humidity = result.main.humidity;
        pressure = result.main.pressure;
        feelsLike = result.main.feelsLike;

        description = result.weather[0].description;
        main = result.weather[0].main;
        icon =
            "http://openweathermap.org/img/wn/${result.weather[0].icon}@2x.png";
        print("value of icon ..................");
        print(icon);
        getDateTime();
        visibility = result.visibility;
        lat = result.coord.lat;
        lon = result.coord.lon;
        speed= result.wind.speed;
        degree = result.wind.deg;
        gust= result.wind.gust;
      });
    }
  }
}
