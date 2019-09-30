import 'dart:convert';
import 'dart:math';
import 'package:convert/convert.dart';

import 'tagged_field.dart';
import 'word_reader.dart';

class TaggedFieldDecoder {
  TaggedField decode(int tag, List<int> data) {
    switch (tag) {
      case 1: // payment_hash
        return TaggedField('payment_hash', _processHex(data, 'hex'));
      case 13: // description
        return TaggedField('description', _processHex(data, 'utf8'));
      case 19: // payee_pubkey
        return TaggedField('payee_pubkey', _processHex(data, 'hex'));
      case 23: // purpose_hash
        return TaggedField('purpose_hash', _processHex(data, 'hex'));
      case 6: // expiry
        return TaggedField('expiry', _processInt(data));
      case 24: // min_final_cltv_expiry
        return TaggedField('min_final_cltv_expiry', _processInt(data));
      case 9: // fallback_address
        return TaggedField('fallback_address', _processFallbackAddress(data));
      case 3:
        return TaggedField('routing', _processRouting(data));
      default:
        return null;
    }
  }

  String _processFallbackAddress(List<int> data) {
    String version = '' + _processInt(data.sublist(0, 1)).toString();
    if (version.length % 2 != 0) version = '0' + version;
    return version + _processHex(data.sublist(1), 'hex');
  }

  _processRouting(List<int> data) {
    final WordReader reader = WordReader(data);
    List routing = [];
    while (reader.remaining() >= 404) {
      routing.add({
        'pubkey': hex.encode(reader.read(264)),
        'short_channel_id': hex.encode(reader.read(64)),
        'fee_base_msat': reader.readInt(32),
        'fee_proportional_millionths': reader.readInt(32),
        'cltv_expiry_delta': reader.readInt(16)
      });
    }
    return routing;
  }

  String _processHex(List<int> data, String enc) {
    final WordReader reader = WordReader(data);
    List<int> bytes = reader.read(reader.remaining(), false);
    return enc == 'utf8' ? utf8.decode(bytes) : hex.encode(bytes);
  }

  int _processInt(List<int> data) {
    int val = 0;
    for (int i = 0; i < data.length; i++) {
      int word = data[i];
      val += word * pow(32, data.length - i - 1);
    }
    return val;
  }
}
