import 'package:dicoding_mengengah_1/data/model/restaurant_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import '../lib/data/api/api_service.dart';
import 'module_restaurant_service_test.mocks.dart';

var apiResponse = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description":
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {"name": "Italia"},
      {"name": "Modern"}
    ],
    "menus": {
      "foods": [
        {"name": "Paket rosemary"},
        {"name": "Toastie salmon"},
        {"name": "Bebek crepes"},
        {"name": "Salad lengkeng"}
      ],
      "drinks": [
        {"name": "Es krim"},
        {"name": "Sirup"},
        {"name": "Jus apel"},
        {"name": "Jus jeruk"},
        {"name": "Coklat panas"},
        {"name": "Air"},
        {"name": "Es kopi"},
        {"name": "Jus alpukat"},
        {"name": "Jus mangga"},
        {"name": "Teh manis"},
        {"name": "Kopi espresso"},
        {"name": "Minuman soda"},
        {"name": "Jus tomat"}
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {"name": "a", "review": "a", "date": "11 Juli 2021"},
      {"name": "Jennie", "review": "nice!", "date": "11 Juli 2021"},
      {"name": "Jennie", "review": "nice", "date": "11 Juli 2021"},
      {"name": "b", "review": "a", "date": "11 Juli 2021"},
      {
        "name": "Khaidir Fahram",
        "review": "Testing E2E",
        "date": "11 Juli 2021"
      },
      {
        "name": "Submission 3 E2E Test",
        "review": "Ini Komentar dari E2E Test",
        "date": "12 Juli 2021"
      },
      {"name": "Ahmad", "review": "Baguss cuy", "date": "12 Juli 2021"},
      {"name": "yudi", "review": "bagus ini", "date": "12 Juli 2021"},
      {
        "name": "Andrew",
        "review": "Review from e2e testing",
        "date": "12 Juli 2021"
      },
      {
        "name": "Andrew",
        "review": "Review from e2e testing",
        "date": "12 Juli 2021"
      },
      {
        "name": "Andrew",
        "review": "Review from e2e testing hehe",
        "date": "12 Juli 2021"
      },
      {
        "name": "Andrew",
        "review": "Review from e2e testing heh",
        "date": "12 Juli 2021"
      },
      {
        "name": "Gunawan",
        "review": "Ini Test Komentar",
        "date": "12 Juli 2021"
      },
      {
        "name": "Firasat Mematikan",
        "review": "Makananannya di restaurant ini sangat buruk",
        "date": "12 Juli 2021"
      },
      {
        "name": "pasryd",
        "review": "[276-98] Melting Pot e2e review",
        "date": "12 Juli 2021"
      },
      {"name": "Syamsul", "review": "Andai ku tau", "date": "12 Juli 2021"},
      {
        "name": "pasryd",
        "review": "[160-95] Melting Pot e2e review",
        "date": "12 Juli 2021"
      },
      {"name": "asdasd", "review": "asdasd", "date": "12 Juli 2021"},
      {"name": "Sam Parker", "review": "YNTKTS", "date": "12 Juli 2021"},
      {"name": "Sam Parker", "review": "YNTKTS", "date": "12 Juli 2021"},
      {
        "name": "E2E testing",
        "review": "Automated reviewww",
        "date": "12 Juli 2021"
      },
      {"name": "E2e", "review": "asd", "date": "12 Juli 2021"},
      {"name": "Testing", "review": "Recomended", "date": "12 Juli 2021"},
      {"name": "John", "review": "Wow! Amajing", "date": "12 Juli 2021"},
      {"name": "John", "review": "Wow! Amajing", "date": "12 Juli 2021"},
      {"name": "EagleSlow", "review": "Hooray", "date": "12 Juli 2021"},
      {"name": "Hai", "review": "Yeay italy juara", "date": "12 Juli 2021"},
      {"name": "John", "review": "Wow! Amajing", "date": "12 Juli 2021"},
      {"name": "John", "review": "Wow! Amajing", "date": "12 Juli 2021"},
      {
        "name": "Testing",
        "review": "Ini hanya testing",
        "date": "12 Juli 2021"
      },
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "Optimis", "review": "Haiii", "date": "12 Juli 2021"},
      {"name": "user", "review": "e2e testing", "date": "12 Juli 2021"},
      {"name": "Hanif", "review": "Okey mantap!", "date": "12 Juli 2021"},
      {"name": "John", "review": "Wow! Amajing", "date": "12 Juli 2021"},
      {"name": "Sam Parker", "review": "YNTKTS", "date": "12 Juli 2021"},
      {"name": "Syamsul Zaman", "review": "YNTKTS", "date": "12 Juli 2021"},
      {"name": "Syamsul Zaman", "review": "kajsdf", "date": "12 Juli 2021"},
      {
        "name": "E2E testing",
        "review": "Automated RIPiew",
        "date": "12 Juli 2021"
      },
      {"name": "EagleSlow", "review": "Hooray", "date": "12 Juli 2021"},
      {"name": "EagleSlow", "review": "Hooray", "date": "12 Juli 2021"},
      {"name": "Th", "review": "Zcs", "date": "12 Juli 2021"},
      {
        "name": "Thor son of Odin",
        "review": "Asgard is under Attack",
        "date": "12 Juli 2021"
      },
      {"name": "aldi", "review": "gokills", "date": "12 Juli 2021"},
      {
        "name": "Muhammad Lutfi",
        "review": "Sangat luar biasa",
        "date": "12 Juli 2021"
      },
      {
        "name": "E2E Tester",
        "review": "Some reviews from E2E Tester",
        "date": "12 Juli 2021"
      },
      {
        "name": "JOKOWI",
        "review": "RASANYA SEPERTI VAKSIN",
        "date": "12 Juli 2021"
      },
      {"name": "Jennie", "review": "nice!", "date": "12 Juli 2021"},
      {
        "name": "JOKOWI",
        "review": "RASANYA SEPERTI VAKSIN",
        "date": "12 Juli 2021"
      },
      {
        "name": "testing e2e",
        "review": "Lagi coba testing e2e",
        "date": "12 Juli 2021"
      },
      {"name": "Jennie", "review": "nice!", "date": "12 Juli 2021"},
      {
        "name": "AMIR MA'RUF",
        "review": "TOLONG TAMBAHKAN MINUMAN COVID DELTA",
        "date": "12 Juli 2021"
      },
      {"name": "Jennie", "review": "nice!", "date": "12 Juli 2021"},
      {
        "name": "Promosi",
        "review": "SUBSCRIBE YOUTUBE Programmer Beneran Guys",
        "date": "12 Juli 2021"
      },
      {
        "name": "Andrew",
        "review": "Review from e2e testing",
        "date": "12 Juli 2021"
      },
      {
        "name": "Andrew",
        "review": "Review from e2e testing",
        "date": "12 Juli 2021"
      },
      {
        "name": "Andrew",
        "review": "Review from e2e testing",
        "date": "12 Juli 2021"
      },
      {"name": "Ahmad", "review": "Baguss cuy", "date": "12 Juli 2021"},
      {"name": "Ahmad", "review": "Baguss cuy", "date": "12 Juli 2021"},
      {"name": "Ahmad", "review": "Baguss cuy", "date": "12 Juli 2021"},
      {"name": "username", "review": "e2etesting", "date": "12 Juli 2021"},
      {"name": "username", "review": "e2etesting", "date": "12 Juli 2021"},
      {
        "name": "Doni",
        "review": "Aku Bisa Kita Bisa Semua Bisa",
        "date": "12 Juli 2021"
      }
    ]
  }
};

@GenerateMocks([http.Client])
void main() {
  test('Should return RestaurantDetailResult', () async {
    String id = 'rqdv5juczeskfw1e867';
    final client = MockClient();

    when(client
            .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id')))
        .thenAnswer((_) async => http.Response(apiResponse.toString(), 200));

    expect(await ApiService().getRestaurantDetail(id),
        isA<RestaurantDetailResult>());
  });
}
