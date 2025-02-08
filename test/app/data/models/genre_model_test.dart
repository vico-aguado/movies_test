import 'package:flutter_test/flutter_test.dart';
import 'package:movies_test/app/data/models/genre_model.dart';

void main() {
  group('GenreModel Tests', () {
    test('fromJson constructs GenreModel correctly', () {
      const id = 1;
      const name = 'Action';
      final json = {'id': id, 'name': name};

      final genreModel = GenreModel.fromJson(json);

      expect(genreModel.id, id);
      expect(genreModel.name, name);
    });

    test('GenreModel constructor assigns values correctly', () {
      const id = 2;
      const name = 'Drama';

      final genreModel = GenreModel(id: id, name: name);

      expect(genreModel.id, id);
      expect(genreModel.name, name);
    });
  });
}
