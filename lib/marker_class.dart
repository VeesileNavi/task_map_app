import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:task_map_app/bottom_sheet.dart';

List<Marker> drawMarkers(List<PointOnMap> points, ctx){
  List<Marker> markers = [];
  for (var point in points) {
    if(point.geometry!.coordinates![0] != null && point.geometry!.coordinates![1] != null){
      markers.add(
          Marker(
              height: 15.0,
              width: 15.0,
              point: LatLng(point.geometry!.coordinates![0], point.geometry!.coordinates![1]),
              builder: (BuildContext context){
                return GestureDetector(
                  onTap: (){showMarkerInfo(ctx, point);},
                    child: Icon(Icons.location_on_rounded, color: const Color.fromRGBO(48, 229, 142, 1),));
              }));
    }
  }
return markers;
}

class PointOnMap{
  Geometry? _geometry;
  Properties? _properties;

  Geometry? get geometry => _geometry;
  Properties? get properties => _properties;

  PointOnMap(this._geometry, this._properties);

  factory PointOnMap.fromJson(Map<String, dynamic> parsedJson) {
    return PointOnMap(
      Geometry.fromJson(parsedJson['geometry']),
      Properties.fromJson(parsedJson['properties']),

    );
  }

  @override
  String toString() {
    return 'PointOnMap{geometry: ${_geometry.toString()}, properties:  ${_properties.toString()}}';
  }

}

class Geometry{
  List<double>? _coordinates;
  List<double>? get coordinates => _coordinates;

  Geometry(this._coordinates);

  factory Geometry.fromJson(Map<String, dynamic> parsedJson) {
    return Geometry(
      parsedJson['coordinates'].cast<double>(),
    );
  }

  @override
  String toString() {
    return 'Geometry{coordinates: $_coordinates}';
  }
}


class Properties{
  String? _description;
  String? _address;

  String? get description => _description;
  String? get address => _address;

  Properties(this._description, this._address);

  factory Properties.fromJson(Map<String, dynamic> parsedJson) {
    return Properties(
      parsedJson['description'] as String,
      parsedJson['address'] as String,
    );
  }

  @override
  String toString() {
    return 'Properties{description: $_description, address: $_address}';
  }


}

