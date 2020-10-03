import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;//location name for the UI
  String time;//time in the location for the UI
  String flag;//URL to an Asset: flag icon
  String url;//location URL for API endpoint
  bool isDayTime; //True is day, false if night

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async {
    try {
      //make the request for JSON file
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      // get the required properties from data
      String datetime = data['datetime'];
      String offsetHours = data['utc_offset'].substring(1,3);
      String offsetMinutes = data['utc_offset'].substring(4,6);

      //create a datetime object
      DateTime now = DateTime.parse(datetime); //converting the datetime string into datetime object
      now = now.add(Duration(hours: int.parse(offsetHours),minutes: int.parse(offsetMinutes)));

      //set the time property
      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('Caught Error:  $e');
      time = 'could not get time data!';
    }

  }

}