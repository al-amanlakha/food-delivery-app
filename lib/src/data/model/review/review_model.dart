class ReviewModel {
  final String name; // Reviewer's name
  final String? image; // URL or path to the reviewer's image
  final double rating; // Rating given by the reviewer
  final String? review; // Review text
  final DateTime reviewDate; // Date of the review
  final String flatNo; // Flat number or apartment identifier
  int likes; // Number of likes on the review

  ReviewModel({
    required this.name,
    this.image,
    required this.rating,
    this.review,
    required this.reviewDate,
    required this.flatNo,
    this.likes = 0, // Default value for likes is 0
  });
}
