

class DocumentModel {
  int id;
  String url;
  String cause;
  int state;

  DocumentModel({
    required this.id,
    required this.url,
    required this.cause,
    required this.state,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['idDocument'] as int,
      url: json['url'] as String,
      cause: json['cause'] as String,
      state: json['state'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDocument'] = id;
    data['url'] = url;
    data['cause'] = cause;
    data['state'] = state;
    return data;
  }

  static DocumentModel notNull = DocumentModel(id: -1, url: "", cause: "", state: -1);
}