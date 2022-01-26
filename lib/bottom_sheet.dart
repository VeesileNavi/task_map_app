import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:task_map_app/geolocation_services.dart';
import 'marker_class.dart';

void showMarkerInfo(ctx, PointOnMap point){
  showModalBottomSheet<void>(
    backgroundColor: Colors.transparent,
    context: ctx,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(25)), color: Color.fromRGBO(59, 56, 56, 1),),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:16.0, bottom: 24.0),
                child: Container(
                  height: 3,
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromRGBO(48, 229, 142, 1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(point.properties!.description!, style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color.fromRGBO(
                    243, 243, 243, 1))),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(point.properties!.address!,textAlign: TextAlign.center, style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(
                    182, 182, 182, 1))),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text("${point.geometry!.coordinates![0].toString()}° ${point.geometry!.coordinates![1].toString()}°", style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(
                    182, 182, 182, 1))),),
              )
            ],
          ),
        ),
      );
    },
  );
}

void showCurrentLocationInfo(ctx, LatLng center){
  showModalBottomSheet<void>(
    backgroundColor: Colors.transparent,
    context: ctx,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(25)), color: Color.fromRGBO(59, 56, 56, 1),),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:16.0, bottom: 24.0),
                child: Container(
                  height: 3,
                  width: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color.fromRGBO(48, 229, 142, 1),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text("Your location", style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color.fromRGBO(
                        243, 243, 243, 1))),),
                  ),
                  Text("${center.latitude.toString()}° ${center.longitude.toString()}°", style: GoogleFonts.montserrat(textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(
                      182, 182, 182, 1))),)
                ],
              )

            ],
          ),
        ),
      );
    },
  );
}