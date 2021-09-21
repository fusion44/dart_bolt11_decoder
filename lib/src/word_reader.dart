import 'package:fixnum/fixnum.dart';

class WordReader {
  int index;
  final List<int> words;

  WordReader(this.words, [this.index = 0]);

  List<int> read(n, [pad = true]) {
    var response = <int>[];
    var val = 0;
    for (var i = 0; i < n; i++) {
      var wordIndex = (index / 5).floor();
      var bitIndex = 4 - index % 5;
      var word = words[wordIndex];
      var pow = (1 << (7 - i % 8)) * (word >> bitIndex & 1);
      val += pow;
      if (i % 8 == 7) {
        response.add(val);
        val = 0;
      }
      index++;
    }
    if (pad) {
      var bits = (n % 8) as int;
      if (bits > 0) {
        response.add((words.removeLast() << (8 - bits)) & 255);
      }
    }
    return response;
  }

  int readInt(n) {
    var val = 0;
    for (var i = 0; i < n; i++) {
      var wordIndex = (index / 5).floor();
      var bitIndex = 4 - index % 5;
      var word = words[wordIndex];
      var pow = (1 << (n - i - 1)) * (word >> bitIndex & 1);
      val += pow;
      index++;
    }
    return val;
  }

  Int64 readInt64(int n) {
    var val = Int64.ZERO;
    for (var i = 0; i < n; i++) {
      var wordIndex = (index / 5).floor();
      var bitIndex = 4 - index % 5;
      var word = words[wordIndex];
      var pow = (1 << (n - i - 1)) * (word >> bitIndex & 1);
      val += pow;
      index++;
    }
    return val;
  }

  List<int> readWords(int n) {
    var wordIndex = (index / 5).floor();
    index += n.toInt() * 5;
    return words.sublist(wordIndex, wordIndex + n);
  }

  int remaining() => 5 * words.length - index;
}
