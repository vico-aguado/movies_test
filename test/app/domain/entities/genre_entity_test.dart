import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/domain/entities/genre_entity.dart';

void main() {
  group('GenreEntity Tests', () {
    test('GenreEntity constructor assigns values correctly', () {
      const id = 1;
      const name = 'Action';

      final genreEntity = GenreEntity(id: id, name: name);

      expect(genreEntity.id, id);
      expect(genreEntity.name, name);
    });

    test('GenreEntity equality works correctly', () {
      const id = 2;
      const name = 'Drama';

      final genreEntity1 = GenreEntity(id: id, name: name);
      final genreEntity2 = GenreEntity(id: id, name: name);

      expect(genreEntity1, equals(genreEntity2));
    });

    test('GenreEntity hashCode is consistent with equality', () {
      const id = 3;
      const name = 'Comedy';

      final genreEntity1 = GenreEntity(id: id, name: name);
      final genreEntity2 = GenreEntity(id: id, name: name);

      expect(genreEntity1.hashCode, equals(genreEntity2.hashCode));
    });
  });
}
