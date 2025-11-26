import 'dart:convert';
import '../models/mars_photos_response.dart';

class NasaApi {
  static Future<MarsPhotosResponse> getMarsPhotos({
    required String rover,
    required int sol,
  }) async {
    return getDemoData(rover, sol);
  }

  static MarsPhotosResponse getDemoData(String rover, int sol) {
    // Используем разные надежные источники изображений
    final imageUrls = [
      "https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?w=300&h=200&fit=crop", // космос 1
      "https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=300&h=200&fit=crop", // космос 2
      "https://images.unsplash.com/photo-1502136969935-8d8eef54d77b?w=300&h=200&fit=crop", // космос 3
      "https://images.unsplash.com/photo-1465101162946-4377e57745c3?w=300&h=200&fit=crop", // космос 4
      "https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=300&h=200&fit=crop", // космос 5
    ];

    return MarsPhotosResponse.fromJson({
      "photos": [
        {
          "id": 102693,
          "sol": sol,
          "camera": {
            "id": 20,
            "name": "FHAZ",
            "rover_id": 5,
            "full_name": "Front Hazard Avoidance Camera"
          },
          "img_src": imageUrls[0],
          "earth_date": "2015-05-30",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        {
          "id": 102694,
          "sol": sol,
          "camera": {
            "id": 21,
            "name": "RHAZ",
            "rover_id": 5,
            "full_name": "Rear Hazard Avoidance Camera"
          },
          "img_src": imageUrls[1],
          "earth_date": "2015-05-30",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        {
          "id": 102695,
          "sol": sol,
          "camera": {
            "id": 22,
            "name": "MAST",
            "rover_id": 5,
            "full_name": "Mast Camera"
          },
          "img_src": imageUrls[2],
          "earth_date": "2015-05-30",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        {
          "id": 102696,
          "sol": sol,
          "camera": {
            "id": 23,
            "name": "CHEMCAM",
            "rover_id": 5,
            "full_name": "Chemistry and Camera Complex"
          },
          "img_src": imageUrls[3],
          "earth_date": "2015-05-30",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        {
          "id": 102697,
          "sol": sol,
          "camera": {
            "id": 24,
            "name": "MAHLI",
            "rover_id": 5,
            "full_name": "Mars Hand Lens Imager"
          },
          "img_src": imageUrls[4],
          "earth_date": "2015-05-30",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
      ]
    });
  }
}