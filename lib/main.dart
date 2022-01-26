import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_map_app/map_widget.dart';
import 'package:task_map_app/marker_class.dart';
import 'geolocation_services.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget{
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}


class _MapScreenState extends State<MapScreen>{

  Future<List<PointOnMap>> fetchPointOnMapFromJson(http.Client client, String URL) async {
    List<PointOnMap> markers = [];
    final response = await client.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      var parsed =
      json.decode(response.body)["features"].cast<Map<String, dynamic>>();
      return parsed
          .map<PointOnMap>((json) => PointOnMap.fromJson(json))
          .toList();
    } else {
      return markers;
    }
  }
TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String? text;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () async{
          text = textEditingController.text;
          FocusManager.instance.primaryFocus?.unfocus();
          List<PointOnMap> points = await fetchPointOnMapFromJson(http.Client(), text!);
          setState(() {
            markers = drawMarkers(points, context);
          });
            log(markers.length.toString(), name: "Markers before future");
        },
          icon: Icon(Icons.search), iconSize: 40, color: Color.fromRGBO(48, 229, 142, 1)),
        actions: [
          IconButton(onPressed: (){
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
            textEditingController.clear();
            text = null;
          });}, icon: Icon(Icons.cancel_outlined, color: Color.fromRGBO(48, 229, 142, 1)), iconSize: 40)
        ],
        title: TextField(controller: textEditingController,cursorColor: Color.fromRGBO(48, 229, 142, 1), decoration: const InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)), focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(48, 229, 142, 1))),hintText: "Paste your URL here",hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.white),),
        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: InkWell(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: FutureBuilder(
          future: getCurrentPosition(),
          builder: (context, snapshot){
            log(snapshot.data.toString(), name: "Location");
            log(markers.length.toString(), name: "Markers in future");
            if(snapshot.hasData){
              Position center = snapshot.data as Position;
                  return drawMapWithCenterWithMarkers(LatLng(center.latitude, center.longitude), markers);

            }
            else{
             return Center(child: CircularProgressIndicator());
            }
          },

        ),
      ),
    );
  }


}
