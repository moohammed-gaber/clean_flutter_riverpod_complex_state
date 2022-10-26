class Quote {


  final int id ;
  final String quote ;
  final String author ;

//<editor-fold desc="Data Methods">

  const Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Quote &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          quote == other.quote &&
          author == other.author);

  @override
  int get hashCode => id.hashCode ^ quote.hashCode ^ author.hashCode;

  @override
  String toString() {
    return 'Quote{' +
        ' id: $id,' +
        ' quote: $quote,' +
        ' author: $author,' +
        '}';
  }

  Quote copyWith({
    int? id,
    String? quote,
    String? author,
  }) {
    return Quote(
      id: id ?? this.id,
      quote: quote ?? this.quote,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'quote': this.quote,
      'author': this.author,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as int,
      quote: map['quote'] as String,
      author: map['author'] as String,
    );
  }

//</editor-fold>
}