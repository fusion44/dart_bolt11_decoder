import 'package:bolt11_decoder/src/tagged_field_decoder.dart';
import 'package:test/test.dart';

void main() {
  var decoder = TaggedFieldDecoder();
  group('Test decoder', () {
    test('decoder should decode a payment hash', () {
      var hex =
          '0001020304050607080900010203040506070809000102030405060708090102';

      var result = decoder.decode(1, _getb32PaymentHash());
      expect(result.type, 'payment_hash');
      expect(result.data, hex);
    });

    test('decoder should decode a description', () {
      var desc = '1 cup coffee';

      // xysxxatsyp3k7enxv4js
      var result = decoder.decode(13, _getb32Description());
      expect(result.type, 'description');
      expect(result.data, desc);
    });

    test('decoder should decode expiry', () {
      // pu
      var b32 = <int>[1, 28];
      var exp = 60;

      var result = decoder.decode(6, b32);
      expect(result.type, 'expiry');
      expect(result.data, exp);
    });
  });
}

List<int> _getb32PaymentHash() => const [
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

List<int> _getb32Description() => const [
      6,
      4,
      16,
      6,
      6,
      29,
      11,
      16,
      4,
      1,
      17,
      22,
      30,
      25,
      19,
      6,
      12,
      21,
      18,
      16
    ];
