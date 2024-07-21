/// Represents a Tag according to BOLT11
class TaggedField {
  final String type;
  final dynamic data;

  TaggedField(this.type, this.data);

  Map<String, dynamic> toJson() {
    if (data is TaggedField) {
      return {'type': type, 'data': data.toJson()};
    }

    return {'type': type, 'data': data};
  }
}
