import 'package:flutter/cupertino.dart';
import 'package:food_delivery/src/data/model/profile/user_model.dart';
import 'package:food_delivery/src/data/model/profile/user_profile_model.dart';
import 'package:get/get.dart';

import '../../../data/model/review/review_model.dart';
import '../../../data/preference/preference_manager.dart';

class ReviewsViewModel extends GetxController {
  final PreferenceManager _preference =
  Get.find(tag: (PreferenceManager).toString());

  UserModel? userProfile;

  final TextEditingController reviewController = TextEditingController();

  double initialRating = 0.0;
  List<ReviewModel> reviews = [
    ReviewModel(
      name: 'John Doe',
      rating: 4,
      review: 'The food was amazing! Loved the ambience and service.',
      reviewDate: DateTime.now().subtract(const Duration(days: 2)),
      flatNo: 'A-101',
      likes: 15,
    ),
    ReviewModel(
      name: 'Jane Smith',
      rating: 5.0,
      review: 'Exceptional experience! Highly recommended.',
      reviewDate: DateTime.now().subtract(const Duration(days: 5)),
      flatNo: 'B-205',
      likes: 22,
    ),
    ReviewModel(
      name: 'David Miller',
      rating: 3,
      review: 'Food was decent, but delivery took longer than expected.',
      reviewDate: DateTime.now().subtract(const Duration(days: 7)),
      flatNo: 'C-302',
      likes: 8,
    ),
  ];

  @override
  void onInit() {
    _loadUser();
    super.onInit();
  }

  void _loadUser() async {
    userProfile = await _preference.getUserProfile();
    update();
  }

  void onRatingChanged(double val) {
    initialRating = val;
    update(); // Update the UI to enable the submit button once a rating is selected
  }

  void onSubmit() {
    if (initialRating > 0) {
      final newReview = ReviewModel(
        name: userProfile?.fullName ?? 'Anonymous',
        rating: initialRating,
        review: reviewController.text.trim(),
        reviewDate: DateTime.now(),
        flatNo: 'Your Flat',  // You can change this based on your app logic
        likes: 0,
      );

      // Add the new review to the list
      reviews.add(newReview);

      // Clear the rating and review input fields
      initialRating = 0.0;
      reviewController.clear();
      update(); // Notify listeners of the changes
    }
  }
}