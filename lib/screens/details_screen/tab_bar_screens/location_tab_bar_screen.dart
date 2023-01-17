import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationTabBarScreen extends StatefulWidget {
  final double lat;
  final double lng;
  final String state;
  final String city;

  LocationTabBarScreen(
      {required this.lat,
      required this.lng,
      required this.city,
      required this.state});

  @override
  State<LocationTabBarScreen> createState() => _LocationTabBarScreenState();
}

class _LocationTabBarScreenState extends State<LocationTabBarScreen> {
  final Set<Marker> _marker = {};

  void _setMarker() {
    setState(() {
      _marker.add(Marker(
          markerId: const MarkerId('value'),
          position: LatLng(widget.lat, widget.lng),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: widget.state, snippet: widget.city)));
    });
  }

  @override
  void initState() {
    super.initState();
    _setMarker();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GoogleMap(
            
              markers: _marker,
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.lng), zoom: 15)),
        ),
      ),
    );
  }
}
