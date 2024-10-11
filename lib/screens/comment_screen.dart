import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatelessWidget {
  final ReviewController controller = Get.put(ReviewController());

  ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: controller.reviews.length,
                  itemBuilder: (context, index) {
                    final review = controller.reviews[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(review.userProfileUrl),
                      ),
                      title: Text(review.userName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(review.date),
                          const SizedBox(height: 4),
                          Text(review.comment),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewController extends GetxController {
  var reviews = <Review>[].obs; // Reactive list of reviews
  var isLoading = true.obs; // For loading state
  final reviewController = TextEditingController(); // Review input controller

  @override
  void onInit() {
    super.onInit();
    fetchReviews(); // Fetch reviews on init
  }

  void fetchReviews() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // Simulated delay
      // Example reviews (replace with API call)
      var fetchedReviews = [
        Review(
          userName: 'Alyce Lambo',
          date: '25/06/2020',
          userProfileUrl: 'https://example.com/user1.jpg',
          comment:
              'Really convenient and the points system helps benefit loyalty.',
        ),
        Review(
          userName: 'Gonela Solom',
          date: '22/06/2020',
          userProfileUrl: 'https://example.com/user2.jpg',
          comment:
              'Been a life saver for keeping our sanity during the pandemic.',
        ),
        Review(
          userName: 'Brian C',
          date: '21/06/2020',
          userProfileUrl: 'https://example.com/user3.jpg',
          comment:
              'Got an intro offer of 50% off first order that did not work...',
        ),
        Review(
          userName: 'Helsmar E',
          date: '20/06/2020',
          userProfileUrl: 'https://example.com/user4.jpg',
          comment: 'Great service, very responsive.',
        ),
      ];

      reviews.assignAll(fetchedReviews);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load reviews');
    } finally {
      isLoading.value = false;
    }
  }

  void submitReview() async {
    final newReview = reviewController.text;

    if (newReview.isEmpty) {
      Get.snackbar('Error', 'Please write a review before submitting.');
      return;
    }

    try {
      // Simulate sending new review to the database
      await Future.delayed(const Duration(seconds: 1));

      // Assuming the user submitting is 'Current User' for now
      reviews.add(
        Review(
          userName: 'Current User',
          date: 'Today',
          userProfileUrl: 'https://example.com/current_user.jpg',
          comment: newReview,
        ),
      );
      reviewController.clear(); // Clear the text field after submission
      Get.snackbar('Success', 'Your review has been submitted successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit review');
    }
  }
}

class Review {
  final String userName;
  final String date;
  final String userProfileUrl;
  final String comment;

  Review({
    required this.userName,
    required this.date,
    required this.userProfileUrl,
    required this.comment,
  });
}
