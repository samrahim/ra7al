import 'package:ra7al/services/dio_client.dart';
import 'package:ra7al/services/location_service.dart';

class AdhanRepository {
  final DioClient dioClient;
  final LocationService locationService;

  AdhanRepository({required this.dioClient, required this.locationService});

  Future<CityAndAdhan> getAdhanTiming() async {
    final position = await locationService.determinePosition();
    final city = await locationService.getCityFromPosition(position);
    final time = DateTime.now().toString();
    final datePart = time.split(' ')[0];
    print("current city is --------$city");
    print("current date  is --------$datePart");

    final response = await dioClient.get('$datePart?address=$city');
    CityAndAdhan cityAndAdhan = CityAndAdhan(
      model: AdhanModel.fromJson(response.data['data']['timings']),
      city: city,
    );
    return cityAndAdhan;
  }
}

class CityAndAdhan {
  final AdhanModel model;
  final String city;

  CityAndAdhan({required this.model, required this.city});
  CityAndAdhan copyWith({String? city, AdhanModel? model}) {
    return CityAndAdhan(model: model ?? this.model, city: city ?? this.city);
  }
}

class AdhanModel {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  AdhanModel({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory AdhanModel.fromJson(Map<String, dynamic> mp) {
    return AdhanModel(
      fajr: mp['Fajr'],
      dhuhr: mp['Dhuhr'],
      asr: mp['Asr'],
      maghrib: mp['Maghrib'],
      isha: mp['Isha'],
    );
  }
}
