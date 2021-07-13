import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../lib/data/api/api_service.dart';
import './widget_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  String dummyData = 'asd123456';
  String id = 'rqdv5juczeskfw1e867';
  MockClient? client;
  ApiService? apiService;
  setUp(() {
    client = MockClient();
    apiService = ApiService();
  });

  test('Should return success for restaurant list', () async {
    when(client!.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((_) async => http.Response(dummyData, 200));

    final result = await apiService?.getRestaurants();

    expect(result?.message, 'success');
  });
  test('Should return success for restaurant details', () async {
    when(client!
            .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
        .thenAnswer((_) async => http.Response(dummyData, 200));

    final result = await apiService?.getRestaurantDetail(id);

    expect(result?.message, 'success');
  });
}
