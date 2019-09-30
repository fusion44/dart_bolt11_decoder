A decoder [BOLT #11](https://github.com/lightningnetwork/lightning-rfc/blob/master/11-payment-encoding.md) invoices.


## Usage

A simple usage example:

```dart
import 'package:bolt11_decoder/bolt11_decoder.dart';

main() {
  PaymentRequest req = PaymentRequest(
      "lnbc1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2ctnv5sxxmmwwd5kgetjypeh2ursdae8g6twvus8g6rfwvs8qun0dfjkxaq8rkx3yf5tcsyz3d73gafnh3cax9rn449d9p5uxz9ezhhypd0elx87sjle52x86fux2ypatgddc6k63n7erqz25le42c4u4ecky03ylcqca784w");
  print("amount: ${req.amount}");
  // => amount: 0
  print("timestamp: ${req.timestamp}");
  // => timestamp: 1496314658

  req.tags.forEach((TaggedField t) {
    print("${t.type}: ${t.data}");
  });
  // => payment_hash: 0001020304050607080900010203040506070809000102030405060708090102
  // => description: Please consider supporting this project
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][[tracker](https://github.com/fusion44/dart_bolt11_decoder/issues)].

[tracker]: http://example.com/issues/replaceme

## Credits
Much of this is based on Richard Bondis [bolt11 tutorial](https://github.com/rsbondi/bolt11-tutorial). Thanks a lot!


## License
Distributed under the MIT license. See LICENSE for more information.