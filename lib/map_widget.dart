import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rive/rive.dart';
import 'package:task_map_app/bottom_sheet.dart';
import 'strings.dart';
double minZoom = 3;
double maxZoom = 18;
double zoom = 10;
FlutterMap drawMapWithCenterWithMarkers(LatLng center, List<Marker> markers){
  return FlutterMap(
    options: MapOptions(
      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      center: center,
      minZoom: minZoom,
      maxZoom: maxZoom,
      zoom: zoom,
    ),

    layers:[
      TileLayerOptions(
        backgroundColor: const Color.fromRGBO(52, 52, 52, 1),
        retinaMode: true,
        urlTemplate: MAP_API_URL,
        additionalOptions: {
          'accessToken' : MAP_API_KEY,
          'id' : MAP_API_STYLE
        }
      ),
      MarkerLayerOptions(
        rotate: true,
        markers: markers..add(Marker(
            width: 50.0,
            height: 50.0,
            builder: (ctx) =>
            GestureDetector(
                child: const RiveAnimation.asset('lib/assets/location_animation.riv'),
            onTap:(){
                  showCurrentLocationInfo(ctx, center);
            },),
            point: center,
          ),
        )

      ),
    ],
  );
}

FlutterMap drawMapWithoutCenterWithMarkers(List<Marker> markers){
  return FlutterMap(
    options: MapOptions(
      interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      minZoom: minZoom,
      maxZoom: maxZoom,
      zoom: zoom,
      center: LatLng(59.938946, 30.314982)
    ),

    layers:[
      TileLayerOptions(
          backgroundColor: const Color.fromRGBO(52, 52, 52, 1),
          retinaMode: true,
          urlTemplate: MAP_API_URL,
          additionalOptions: {
            'accessToken' : MAP_API_KEY,
            'id' : MAP_API_STYLE
          }
      ),
      MarkerLayerOptions(
          rotate: true,
          markers: markers
          ),
  ]
  );
}

FlutterMap drawMapWithCenterWithoutMarkers(LatLng center){
  return FlutterMap(
      options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          minZoom: minZoom,
          maxZoom: maxZoom,
          zoom: zoom,
          center: center
      ),

      layers:[
        TileLayerOptions(
            backgroundColor: const Color.fromRGBO(52, 52, 52, 1),
            retinaMode: true,
            urlTemplate: MAP_API_URL,
            additionalOptions: {
              'accessToken' : MAP_API_KEY,
              'id' : MAP_API_STYLE
            }
        ),
        MarkerLayerOptions(
            rotate: true,
            markers: [
              Marker(
                width: 50.0,
                height: 50.0,
                builder: (ctx) =>
                GestureDetector(
                    child: const RiveAnimation.asset("lib/assets/location_animation.riv"),
                onTap:(){showCurrentLocationInfo(ctx, center);},),
                point: center,
              ),
            ]
        ),
      ]
  );
}

FlutterMap drawMapWithoutCenterWithoutMarkers(){
  return FlutterMap(
      options: MapOptions(
          interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
          minZoom: minZoom,
          maxZoom: maxZoom,
          zoom: zoom,
          center: LatLng(59.938946, 30.314982)
      ),

      layers:[
        TileLayerOptions(
            backgroundColor: const Color.fromRGBO(52, 52, 52, 1),
            retinaMode: true,
            urlTemplate: MAP_API_URL,
            additionalOptions: {
              'accessToken' : MAP_API_KEY,
              'id' : MAP_API_STYLE
            }
        ),
      ]
  );
}