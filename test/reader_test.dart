import 'package:bolt11_decoder/src/word_reader.dart';
import 'package:test/test.dart';

void main() {
  group('Reader should read int values', () {
    test('Reader should a single read int value', () {
      // 000010000100010
      var fivebit = <int>[1, 1, 2];
      var reader = WordReader(fivebit);
      var i = reader.readInt(15);
      expect(i, 1058);

      // 00001
      fivebit = [1];
      reader = WordReader(fivebit);
      i = reader.readInt(5);
      expect(i, 1);

      // 111111
      fivebit = [1, 31];
      reader = WordReader(fivebit);
      i = reader.readInt(10);
      expect(i, 63);
    });

    test('reader should read sequence int values', () {
      // 000010001100010
      var fivebit = <int>[1, 3, 2];
      var reader = WordReader(fivebit);

      // first five 00001
      var i = reader.readInt(5);
      expect(i, 1);

      // next ten 0001100010
      i = reader.readInt(10);
      expect(i, 98);
    });

    test('reader should read bit values', () {
      // 00001 00001 00010 00001 00010 -> 00001000 01000100 00010001 (0 dropped)
      var fivebit = <int>[1, 1, 2, 1, 2];
      var reader = WordReader(fivebit);
      var b = reader.read(25, false);
      expect(b, [8, 68, 17]);

      // 00001 00001 00010 00001 00010 -> 00001000 01000100 00010001 00000000 (padded)
      fivebit = [1, 1, 2, 1, 2];
      reader = WordReader(fivebit);
      b = reader.read(25, true);
      expect(b, [8, 68, 17, 0]);

      // 00001 00001 00010 00001 00010 -> 00001000 01000100 00010001 10000000 (padded)
      fivebit = [1, 1, 2, 1, 3];
      reader = WordReader(fivebit);
      b = reader.read(25, true);
      expect(b, [8, 68, 17, 128]);
    });

    test('reader should read sequence word values', () {
      var fivebit = <int>[1, 2, 3, 4, 5, 6];
      var reader = WordReader(fivebit);

      var w = reader.readWords(2);
      expect(w, [1, 2]);

      w = reader.readWords(4);
      expect(w, [3, 4, 5, 6]);
    });

    test('reader should read hash value', () {
      /*
              0    1    2    3    4    5    6    7
      +0      q    p    z    r    y    9    x    8
      +8      g    f    2    t    v    d    w    0
      +16     s    3    j    n    5    4    k    h
      +24     c    e    6    m    u    a    7    l
    */

      // qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypq
      var b32 = _getb32List();
      // 0001020304050607080900010203040506070809000102030405060708090102
      var b256 = _getb265List();

      var reader = WordReader(b32);

      var w = reader.read(256, true);

      expect(w, b256);
    });
  });
}

List<int> _getb265List() => const [
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      1,
      2
    ];

List<int> _getb32List() => const [
      0,
      0,
      0,
      16,
      4,
      0,
      24,
      4,
      0,
      20,
      3,
      0,
      14,
      2,
      0,
      9,
      0,
      0,
      0,
      16,
      4,
      0,
      24,
      4,
      0,
      20,
      3,
      0,
      14,
      2,
      0,
      9,
      0,
      0,
      0,
      16,
      4,
      0,
      24,
      4,
      0,
      20,
      3,
      0,
      14,
      2,
      0,
      9,
      0,
      4,
      1,
      0
    ];
