class popularBook {
  final String id;
  final String title1;
  final String image1;
  final double rating;
  bool isFavorite;
  final String description;

  popularBook({
    required this.id,
    required this.title1,
    required this.image1,
    required this.rating,
   this.isFavorite=false,
    required this.description,
  });

  factory popularBook.fromJson(Map<String, dynamic> json) {
    return popularBook(
      id: json['_id']?? '',
      title1: json['title1']??'',
      image1: json['image1']??'',
      rating: json['rating']?? 4.0,
      isFavorite: json['isFavorite']?? true,
      description: json['description']??'',
    );
  }

// Convert a Book object into a Map object
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title': title1,
      'image': image1,
      'rating': rating,
      'isFavorite': isFavorite,
      'description':description,
    };
  }
  
}