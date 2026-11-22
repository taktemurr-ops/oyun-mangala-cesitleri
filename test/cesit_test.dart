import 'package:flutter_test/flutter_test.dart';
import 'package:oyun_mangala_cesitleri/oyun_mangala_cesitleri.dart';
import 'package:studio_core/core/level_plan.dart';

void main() {
  test('8 çeşit, kimlikler benzersiz, 33 dil', () {
    expect(mangalaCesitConfigs.length, 8);
    expect(mangalaCesitConfigs.map((c) => c.gameId).toSet().length, 8);
    expect(mangalaCesitGroup.title.length, 33);
    expect(mangalaCesitGroup.tagline.length, 33);
    for (final c in mangalaCesitConfigs) {
      expect(c.title.length, 33);
      expect(c.tagline.length, 33);
      for (final s in c.tutorial) {
        expect(s.text.length, 33);
      }
    }
  });

  for (final rules in mangalaCesitRules) {
    test('${rules.gameId}: bölümler üretilir ve doğrulanır', () {
      final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: const []);
      for (final lv in [1, 300, 12345, 49999]) {
        final gl = rules.build(planner.spec(lv));
        expect(gl.validation.ok, isTrue, reason: '${rules.gameId} $lv');
      }
    }, timeout: const Timeout(Duration(minutes: 10)));
  }
}
