import 'package:bech32/bech32.dart';
import 'package:decimal/decimal.dart';
import 'package:fixnum/fixnum.dart';

import 'tagged_field.dart';
import 'word_reader.dart';
import 'tagged_field_decoder.dart';

Map<String, Decimal> _amounts = {
  '': Decimal.fromInt(1),
  'm': Decimal.parse('0.001'),
  'u': Decimal.parse('0.000001'),
  'n': Decimal.parse('0.000000001'),
  'p': Decimal.parse('0.000000000001'),
};

/// Represents all possible prefixes for pay request
/// They should be ordered by length so the first one that matches has the most
///  characters in common and is the most specific
enum PayRequestPrefix {
  lnbcrt,
  lntbs,
  lnbc,
  lntb,
}

class Bolt11PaymentRequest {
  final String paymentRequest;
  late PayRequestPrefix prefix;
  late Decimal amount;
  late Int64 timestamp;
  late List<TaggedField> tags = [];
  late List<int> signature;

  late Bech32 _bech32;
  late WordReader _reader;

  Bolt11PaymentRequest(this.paymentRequest) {
    var codec = Bech32Codec();
    _bech32 = codec.decode(
      paymentRequest,
      paymentRequest.length,
    );
    _reader = WordReader(_bech32.data);

    prefix = PayRequestPrefix.values.firstWhere(
        (PayRequestPrefix prefix) => _bech32.hrp.startsWith(prefix.name));

    _processAmount();

    timestamp = _reader.readInt64(35);

    _processTags();

    signature = _reader.read(520);
  }

  void _processAmount() {
    final prefixLen = prefix.name.length;

    if (_bech32.hrp.length == prefixLen) {
      amount = Decimal.zero;
    } else {
      var amt = _bech32.hrp.substring(
        prefixLen,
      );

      final unit = amt.substring(amt.length - 1);

      if (_amounts[unit] == null) {
        amount = Decimal.parse(amt);
      } else {
        amt = amt.replaceAll(unit, '');

        amount = Decimal.parse(amt) * _amounts[unit]!;
      }
    }
  }

  void _processTags() {
    var decoder = TaggedFieldDecoder();

    while (_reader.remaining() > 520) {
      final identifier = _reader.readInt(5);
      final len = _reader.readInt(10);
      final data = _reader.readWords(len);
      var tag = decoder.decode(identifier, data);
      tags.add(tag);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentRequest': paymentRequest,
      'prefix': prefix.name,
      'amount': amount.toString(),
      'timestamp': timestamp.toString(),
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'signature': signature.join(','),
    };
  }
}
