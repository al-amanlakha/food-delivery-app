import 'package:get/get.dart';

import '../../../data/model/faq/faq_model.dart';

class HelpViewModel extends GetxController{
  final List<FAQ> faqs = [
    FAQ(
        question: "How do I search for ingredients?",
        answer: "Enter the name of the ingredient in the search bar and press 'Search'."
    ),
    FAQ(
        question: "Can I save my favorite recipes?",
        answer: "Yes, you can save recipes by tapping the 'Save' button on any recipe page."
    ),
    FAQ(
        question: "What should I do if I find incorrect information?",
        answer: "Please use the 'Report' button on the recipe page to inform us of any inaccuracies."
    ),
    // Add more FAQs as needed
  ];

}