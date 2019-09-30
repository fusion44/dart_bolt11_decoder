import 'package:fixnum/fixnum.dart';

class WordReader {
  int index;
  final List<int> words;

  WordReader(this.words, [this.index = 0]);

  List<int> read(n, [pad = true]) {
    List<int> response = [];
    var val = 0;
    for (var i = 0; i < n; i++) {
      int wordIndex = (this.index / 5).floor();
      var bitIndex = 4 - this.index % 5;
      var word = this.words[wordIndex];
      var pow = (1 << (7 - i % 8)) * (word >> bitIndex & 1);
      val += pow;
      if (i % 8 == 7) {
        response.add(val);
        val = 0;
      }
      this.index++;
    }
    if (pad) {
      var bits = n % 8;
      if (bits > 0) {
        response.add((this.words.removeLast() << (8 - bits)) & 255);
      }
    }
    return response;
  }

  int readInt(n) {
    int val = 0;
    for (int i = 0; i < n; i++) {
      var wordIndex = (this.index / 5).floor();
      var bitIndex = 4 - this.index % 5;
      var word = this.words[wordIndex];
      var pow = (1 << (n - i - 1)) * (word >> bitIndex & 1);
      val += pow;
      this.index++;
    }
    return val;
  }

  Int64 readInt64(int n) {
    Int64 val = Int64.ZERO;
    for (int i = 0; i < n; i++) {
      var wordIndex = (this.index / 5).floor();
      var bitIndex = 4 - this.index % 5;
      var word = this.words[wordIndex];
      var pow = (1 << (n - i - 1)) * (word >> bitIndex & 1);
      val += pow;
      this.index++;
    }
    return val;
  }

  readWords(int n) {
    int wordIndex = (this.index / 5).floor();
    this.index += n.toInt() * 5;
    return this.words.sublist(wordIndex, wordIndex + n);
  }

  remaining() {
    return 5 * this.words.length - this.index;
  }
}
