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
    // РЕАЛЬНЫЕ ФОТО SPIRIT SOL 100 (локальные файлы)
    return MarsPhotosResponse.fromJson({
      "photos": [
        {
          "id": 1,
          "sol": sol,
          "camera": {
            "id": 20,
            "name": "PANCAM",  // Изменено!
            "rover_id": 5,
            "full_name": "Panoramic Camera"  // Изменено!
          },
          "img_src": "assets/images/spirit_sol100/pancam.jpg",  // Локальный файл
          "earth_date": "2004-04-10",  // Реальная дата Sol 100
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        {
          "id": 2,
          "sol": sol,
          "camera": {
            "id": 21,
            "name": "NAVCAM",  // Изменено!
            "rover_id": 5,
            "full_name": "Navigation Camera"  // Изменено!
          },
          "img_src": "assets/images/spirit_sol100/navcam.jpg",  // Локальный файл
          "earth_date": "2004-04-10",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        {
          "id": 3,
          "sol": sol,
          "camera": {
            "id": 22,
            "name": "FHAZ",
            "rover_id": 5,
            "full_name": "Front Hazard Avoidance Camera"
          },
          "img_src": "assets/images/spirit_sol100/hazcam.jpg",  // Локальный файл
          "earth_date": "2004-04-10",
          "rover": {
            "id": 5,
            "name": rover,
            "landing_date": "2004-01-04",
            "launch_date": "2003-06-10",
            "status": "complete"
          }
        },
        // Можно добавить еще фото если скачали
      ]
    });
  }
}