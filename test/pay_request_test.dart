import 'package:bolt11_decoder/src/tagged_field.dart';
import 'package:bolt11_decoder/src/pay_request.dart';
import 'package:convert/convert.dart';

import 'package:test/test.dart';

import 'data/test_data.dart';

void main() {
  group('Test Library PayRequest', () {
    test('should initialize with proper bech32 prefix', () {
      testData.forEach((data) {
        var req = Bolt11PaymentRequest(data['request']);
        expect(req.prefix, data['prefix']);
      });
    });

    test('should initialize with proper payment amount', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        expect(pay.amount.toDouble(), data['amount']);
      });
    });

    test('should initialize with proper timestamp', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        expect(pay.timestamp, data['timestamp']);
      });
    });

    test('should initialize to proper tagged data count', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        expect(pay.tags.length.toInt(), data['tagged'].length);
      });
    });

    test('should initialize with proper signature', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        expect(hex.encode(pay.signature), data['signature']);
      });
    });

    test('should get payment hash from tagged field', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        String? testHash = _getTestItem(data, 'payment_hash');
        String? payHash = _getPayData(pay, 'payment_hash');
        expect(payHash, testHash);
      });
    });

    test('should get description from tagged field', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        String? testDesc = _getTestItem(data, 'description');
        String? payDesc = _getPayData(pay, 'description');
        expect(payDesc, testDesc);
      });
    });

    test('properly calculates expiry', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        int? testExpiry = _getTestItem(data, 'expiry');
        int? payExpiry = _getPayData(pay, 'expiry');
        expect(payExpiry, testExpiry);
      });
    });

    test('properly calculates payee_pubkey', () {
      testData.forEach((data) {
        // TODO: no test data
      });
    });

    test('properly calculates purpose_hash', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        String? testHash = _getTestItem(data, 'purpose_hash');
        String? payHash = _getPayData(pay, 'purpose_hash');
        expect(payHash, testHash);
      });
    });

    test('properly calculates min_final_cltv_expiry', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        int? testCLTV = _getTestItem(data, 'min_final_cltv_expiry');
        int? payCLTV = _getPayData(pay, 'min_final_cltv_expiry');
        expect(payCLTV, testCLTV);
      });
    });

    test('properly processes fallback_address', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        String? testAddr = _getTestItem(data, 'fallback_address');
        String? payAddr = _getPayData(pay, 'fallback_address');
        expect(payAddr, testAddr);
      });
    });

    test('properly processes routing info', () {
      testData.forEach((data) {
        var pay = Bolt11PaymentRequest(data['request']);
        dynamic testRoute = _getTestItem(data, 'routing');
        dynamic payRoute = _getPayData(pay, 'routing');
        expect(testRoute, payRoute);
        if (testRoute != null) {
          Map tr = testRoute[0];
          Map? pr = payRoute[0];
          tr.forEach((key, value) {
            expect(pr!.containsKey(key), true);
            expect(pr[key], tr[key]);
          });
        }
      });
    });
  });
}

dynamic _getPayData(Bolt11PaymentRequest pay, String type) {
  try {
    return pay.tags.firstWhere((TaggedField? tag) => tag!.type == type)!.data;
  } catch (e) {
    if (e is! StateError) {
      rethrow;
    }
    return null;
  }
}

dynamic _getTestItem(data, String type) {
  try {
    return data['tagged'].firstWhere(
      (tag) => tag['type'] == type,
    )['data'];
  } catch (e) {
    if (e is! StateError) {
      rethrow;
    }
    return null;
  }
}
