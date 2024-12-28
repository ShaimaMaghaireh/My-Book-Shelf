class Book {
  final String title;
  final String author;
  final int availableCopies;
  final int totalCopies;
  final String image;
  final String pdf; 
  Book({required this.title, required this.author, required this.availableCopies, required this.totalCopies, required this.image, required this.pdf});


  // Convert a Map object into a Book object
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      author: json['author'],
      availableCopies:json['availableCopies'],
      totalCopies:json['totalCopies'],
      image:json['image']?? 'Not found',
       pdf: json['pdf'],
    );
  }

  // Convert a Book object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'totalCopies': totalCopies,
      'availableCopies': availableCopies,
      'image':image,
      'pdf':pdf,
    };
  }
}
