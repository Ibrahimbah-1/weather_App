import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

@GenerateMocks([Dio])
import 'weather_service_test.mocks.dart';

class MockGeolocatorPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements GeolocatorPlatform {
  @override
  Future<bool> isLocationServiceEnabled() async {
    return super.noSuchMethod(
      Invocation.method(#isLocationServiceEnabled, []),
      returnValue: true,
      returnValueForMissingStub: true,
    );
  }

  @override
  Future<LocationPermission> checkPermission() async {
    return super.noSuchMethod(
      Invocation.method(#checkPermission, []),
      returnValue: LocationPermission.whileInUse,
      returnValueForMissingStub: LocationPermission.whileInUse,
    );
  }

  @override
  Future<LocationPermission> requestPermission() async {
    return super.noSuchMethod(
      Invocation.method(#requestPermission, []),
      returnValue: LocationPermission.whileInUse,
      returnValueForMissingStub: LocationPermission.whileInUse,
    );
  }

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    return super.noSuchMethod(
      Invocation.method(#getCurrentPosition, [], {#locationSettings: locationSettings}),
      returnValue: Position(
        latitude: 37.422,
        longitude: -122.084,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      ),
      returnValueForMissingStub: Position(
        latitude: 37.422,
        longitude: -122.084,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
        altitudeAccuracy: 0.0,
        headingAccuracy: 0.0,
      ),
    );
  }
}

void main() {
  late MockDio mockDio;
  late MockGeolocatorPlatform mockGeolocator;
  late WeatherService weatherService;

  setUp(() {
    mockDio = MockDio();
    mockGeolocator = MockGeolocatorPlatform();
    weatherService = WeatherService(dio: mockDio);
    
    GeolocatorPlatform.instance = mockGeolocator;
  });

  test('should return complete weather data', () async {
    // COMPLETE mock response matching ALL model fields
    final mockResponse = {
      'name': 'Test City',
      'main': {
        'temp': 25.0,
        'humidity': 60,
      },
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01d'
        }
      ],
      'wind': {
        'speed': 5.5
      },
      'coord': {
        'lat': 37.422,
        'lon': -122.084
      }
    };

    when(mockDio.get(
      any,
      queryParameters: anyNamed('queryParameters'),
    )).thenAnswer((_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ));

    final weather = await weatherService.getWeather();

    // Verify ALL model fields
    expect(weather, isA<Weather>());
    expect(weather.cityName, 'Test City');
    expect(weather.temperature, 25.0);
    expect(weather.condition, 'Clear');
    expect(weather.description, 'clear sky');
    expect(weather.humidity, 60);
    expect(weather.windSpeed, 5.5);
  });
}