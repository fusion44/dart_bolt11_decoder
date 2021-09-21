import 'package:bolt11_decoder/bolt11_decoder.dart';

void main() {
  var req = Bolt11PaymentRequest(
      'lnbc1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2ctnv5sxxmmwwd5kgetjypeh2ursdae8g6twvus8g6rfwvs8qun0dfjkxaq8rkx3yf5tcsyz3d73gafnh3cax9rn449d9p5uxz9ezhhypd0elx87sjle52x86fux2ypatgddc6k63n7erqz25le42c4u4ecky03ylcqca784w');
  print('amount: ${req.amount}');
  // => amount: 0
  print('timestamp: ${req.timestamp}');
  // => timestamp: 1496314658

  req.tags.forEach((TaggedField? t) {
    print('${t!.type}: ${t.data}');
  });
  // => payment_hash: 0001020304050607080900010203040506070809000102030405060708090102
  // => description: Please consider supporting this project
  print('');

  req = Bolt11PaymentRequest(
      'lnbc20m1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqsfpp3qjmp7lwpagxun9pygexvgpjdc4jdj85fr9yq20q82gphp2nflc7jtzrcazrra7wwgzxqc8u7754cdlpfrmccae92qgzqvzq2ps8pqqqqqqpqqqqq9qqqvpeuqafqxu92d8lr6fvg0r5gv0heeeqgcrqlnm6jhphu9y00rrhy4grqszsvpcgpy9qqqqqqgqqqqq7qqzqj9n4evl6mr5aj9f58zp6fyjzup6ywn3x6sk8akg5v4tgn2q8g4fhx05wf6juaxu9760yp46454gpg5mtzgerlzezqcqvjnhjh8z3g2qqdhhwkj');
  print('amount: ${req.amount}');
  // => amount: 0.0025
  print('timestamp: ${req.timestamp}');
  // => timestamp: 1496314658

  req.tags.forEach((TaggedField? t) {
    print('${t!.type}: ${t.data}');
  });
}
