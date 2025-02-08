import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/core/constants/app_constants.dart';

void main() {
  group('BaseUrl Test', () {
    test('should have the correct base URL', () {
      expect(
        baseUrl,
        equals('https://api.themoviedb.org/3'),
        reason: 'The base URL should match the expected value.',
      );
    });

    test('should not be empty', () {
      expect(
        baseUrl.isNotEmpty,
        isTrue,
        reason: 'The base URL should not be empty.',
      );
    });

    test('should start with "https"', () {
      expect(
        baseUrl.startsWith('https'),
        isTrue,
        reason:
            'The base URL should start with "https" for secure connections.',
      );
    });
  });
}
