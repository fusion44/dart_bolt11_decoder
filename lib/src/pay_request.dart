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
enum PayRequestPrefix { lnbcrt, lnbc, lntb, lnsb }

class Bolt11PaymentRequest {
  final String paymentRequest;
  PayRequestPrefix prefix;
  Decimal amount;
  Int64 timestamp;
  List<TaggedField> tags = [];
  List<int> signature;

  Bech32 _bech32;
  WordReader _reader;

  Bolt11PaymentRequest(this.paymentRequest) {
    Bech32Codec codec = Bech32Codec();
    this._bech32 = codec.decode(
      this.paymentRequest,
      this.paymentRequest.length,
    );
    this._reader = WordReader(this._bech32.data);

    this.prefix = PayRequestPrefix.values.firstWhere(
        (PayRequestPrefix prefix) => this._bech32.hrp.startsWith(
                prefix.toString().replaceAll('PayRequestPrefix.', ''))
            ? true
            : false);

    _processAmount();

    this.timestamp = this._reader.readInt64(35);

    _processTags();

    this.signature = this._reader.read(520);
  }

  _processAmount() {
    final int prefixLen =
        this.prefix.toString().replaceAll('PayRequestPrefix.', '').length;

    if (this._bech32.hrp.length == prefixLen) {
      this.amount = Decimal.zero;
    } else {
      String amt = this._bech32.hrp.substring(
            prefixLen,
            this._bech32.hrp.length,
          );
      final String unit = amt.substring(amt.length - 1);
      amt = amt.replaceAll(unit, '');

      this.amount = Decimal.parse(amt) * _amounts[unit];
    }
  }

  _processTags() {
    TaggedFieldDecoder decoder = TaggedFieldDecoder();

    while (this._reader.remaining() > 520) {
      final int identifier = this._reader.readInt(5);
      final int len = this._reader.readInt(10);
      final List<int> data = this._reader.readWords(len);
      TaggedField tag = decoder.decode(identifier, data);
      this.tags.add(tag);
    }
  }
}
