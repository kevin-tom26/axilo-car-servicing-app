import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:axilo/core/services/base_service/base_service.dart';

class MapServices extends BaseService {
  Future<double?> getRouteFromOSRM(double startLat, double startLng, double endLat, double endLng) async {
    final url = 'https://router.project-osrm.org/route/v1/driving/$startLng,$startLat;$endLng,$endLat?overview=full';

    try {
      final response = await dio.get(url);

      if (response.statusCode != 200) {
        log('OSRM response error: ${response.statusCode}');
        return null;
      }

      final data = response.data;

      if (data == null || data['routes'] == null || data['routes'] is! List) {
        log('OSRM data missing or malformed: $data');
        return null;
      }

      final routes = data['routes'];

      if (routes.isNotEmpty) {
        final route = routes[0];
        final distance = route['distance']; // meters
        log('Distance: $distance meters');
        return distance;
      }
      return null;
    } catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future<List<PointLatLng>> fetchRouteFromOSRM(double startLat, double startLng, double endLat, double endLng) async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/$startLng,$startLat;$endLng,$endLat?overview=full&geometries=polyline';

    try {
      final response = await dio.get(url);

      if (response.statusCode != 200) {
        log('OSRM response error: ${response.statusCode}');
        return [];
      }

      final data = response.data;

      if (data == null || data['routes'] == null || data['routes'] is! List) {
        log('OSRM data missing or malformed: $data');
        return [];
      }

      final routes = data['routes'];

      if (routes.isNotEmpty) {
        final route = routes[0];
        final encodedPolyline = route['geometry'];

        // Decode polyline
        PolylinePoints polylinePoints = PolylinePoints();
        List<PointLatLng> points = polylinePoints.decodePolyline(encodedPolyline);

        return points;
      }
      return [];
    } catch (e) {
      log('Error: $e');
      return [];
    }
  }

  Future<String> getPlaceNameFromCoordinates(double lat, double lon) async {
    final String apiKey = dotenv.env['LOCATIONIQ_API_KEY']!;

    try {
      final response = await dio.get(
        'https://us1.locationiq.com/v1/reverse',
        queryParameters: {
          'key': apiKey,
          'lat': lat,
          'lon': lon,
          'format': 'json',
        },
      );

      final data = response.data;
      if (data == null || data['address'] == null) {
        log('LocationIQ data missing or malformed: $data');
        return 'Unknown Location';
      }
      final address = data['address'];

      // Priority: village > city > state_district > state
      final placeName = address['village'] ?? address['city'] ?? address['state_district'] ?? address['state'];

      return placeName ?? 'Unknown Location';
    } catch (e) {
      log('Error in reverse geocoding: $e');
      return 'Unknown Location';
    }
  }
}
