import 'package:flutter_test/flutter_test.dart';

import 'package:letters/services/letters_service.dart';

void main() {
  group("Letters", () {
    test("result should be non-empty", () async {
      final res = await LetterService.getLetters();
      expect(res.$1.isNotEmpty, true);
    });

    test("finds a letter of id 1", () async {
      final res = await LetterService.getLetter("1");
      expect(res.$1?.id, "1");
    });
  });
}
