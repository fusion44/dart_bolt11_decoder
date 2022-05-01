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
      case 3:
        return TaggedField('routing', _processRouting(data));
      case 5:
        return TaggedField('feature_bits', _processFeatureBits(data));
      case 6: // expiry
        return TaggedField('expiry', _processInt(data));
      case 9: // fallback_address
        return TaggedField('fallback_address', _processFallbackAddress(data));
      case 13: // description
        return TaggedField('description', _processHex(data, 'utf8'));
      case 16:
        return TaggedField('payment_secret', _processHex(data, 'hex'));
      case 19: // payee_pubkey
        return TaggedField('payee_pubkey', _processHex(data, 'hex'));
      case 23: // purpose_hash
        return TaggedField('purpose_hash', _processHex(data, 'hex'));
      case 24: // min_final_cltv_expiry
        return TaggedField('min_final_cltv_expiry', _processInt(data));
      default:
        return TaggedField('unknown tag: $tag', data);
    }
  }

  String _processFallbackAddress(List<int> data) {
    var version = '' + _processInt(data.sublist(0, 1)).toString();
    if (version.length % 2 != 0) version = '0' + version;
    return version + _processHex(data.sublist(1), 'hex');
  }

  List _processRouting(List<int> data) {
    final reader = WordReader(data);
    var routing = [];
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
    final reader = WordReader(data);
    var bytes = reader.read(reader.remaining(), false);
    return enc == 'utf8' ? utf8.decode(bytes) : hex.encode(bytes);
  }

  int _processInt(List<int> data) {
    var val = 0;
    for (var i = 0; i < data.length; i++) {
      var word = data[i];
      val += (word * pow(32, data.length - i - 1)).toInt();
    }
    return val;
  }

  Map<String, dynamic> _processFeatureBits(List<int> data) {
    const bolt9FeatureList = [
      'option_data_loss_protect',
      'initial_routing_sync',
      'option_upfront_shutdown_script',
      'gossip_queries',
      'var_onion_optin',
      'gossip_queries_ex',
      'option_static_remotekey',
      'payment_secret',
      'basic_mpp',
      'option_support_large_channel',
      'option_anchor_outputs',
      'option_anchors_zero_fee_htlc_tx',
      'option_shutdown_anysegwit',
      'option_channel_type',
      'option_payment_metadata',
    ];

    final flags = data.reversed
        .map((int word) => [
              word == 1,
              word == 2,
              word == 4,
              word == 8,
              word == 16,
            ])
        .reduce((value, element) => [...value, ...element]);

    while (flags.length < bolt9FeatureList.length * 2) {
      flags.add(false);
    }

    final featureBits = <String, dynamic>{
      'word_length': data.length,
    };

    for (var i = 0; i < bolt9FeatureList.length; i++) {
      final pos = i * 2;
      featureBits[bolt9FeatureList[i]] = {
        'required': flags[pos],
        'supported': flags[pos + 1],
      };
    }

    if (flags.length > bolt9FeatureList.length * 2) {
      final extraBits = flags.skip(bolt9FeatureList.length * 2);
      featureBits['extra_bits'] = {
        'start_bit': bolt9FeatureList.length * 2,
        'bits': extraBits,
        'has_required': extraBits.contains(true),
      };
    } else {
      featureBits['extra_bits'] = {
        'start_bit': bolt9FeatureList.length * 2,
        'bits': [],
        'has_required': false
      };
    }

    return featureBits;
  }
}
