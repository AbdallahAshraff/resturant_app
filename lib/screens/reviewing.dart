// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:resturant_app/screens/comment_screen.dart';
import 'package:resturant_app/utils/model.dart';

class RateOrderScreen extends StatelessWidget {
  RateOrderScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);
  final Meals meal;

  final TextEditingController reviewController = TextEditingController();

  final rating = 2.5.obs;

   final checkboxItems = <String>[
    'Add pepper',
    'Add salt',
    'Add ketchup',
    'Add mayonnaise'
  ];

  // RxList for checkbox values to make them reactive
  final RxList<bool> checkboxValues = List.filled(4, false).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // This property ensures the screen adjusts when the keyboard is opened
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView to make it scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Food Image (Local Directory Version)
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  meal.imageUrl ?? '',
                  // <-- Replace with your image directory
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),

               Text(
                'How was your ${meal.name} order ?',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),

              // Rating Bar
              Obx(() => RatingBar.builder(
                    initialRating: rating.value,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) {
                      rating.value = newRating;
                    },
                  )),

              const SizedBox(height: 16.0),
              Obx(() {
                String ratingText;

                if (rating.value > 1 && rating.value < 2.5) {
                  ratingText = 'Bad';
                } else if (rating.value >= 2.5 && rating.value < 3.5) {
                  ratingText = 'Good';
                } else if (rating.value >= 3.5 && rating.value < 4.5) {
                  ratingText = 'Very Good';
                } else if (rating.value >= 4.5 && rating.value <= 5) {
                  ratingText = 'Excellent';
                } else {
                  ratingText = 'Very Bad';
                }
                return Text(
                  ratingText,
                  style: const TextStyle(color: Colors.orange, fontSize: 18),
                );
              }),

              const Gap(20),

              // Reactive Row with CheckboxListTile
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 0; i < checkboxItems.length - 2; i++)
                        Expanded(
                          child: CheckboxListTile(
                            value: checkboxValues[i],
                            onChanged: (v) {
                              checkboxValues[i] = v!; // Update the RxList
                            },
                            title: Text(checkboxItems[i]),
                          ),
                        ),
                    ],
                  )),
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (var i = 2; i < checkboxItems.length; i++)
                        Expanded(
                          child: CheckboxListTile(
                            value: checkboxValues[i],
                            onChanged: (v) {
                              checkboxValues[i] = v!; // Update the RxList
                            },
                            title: Text(checkboxItems[i]),
                          ),
                        ),
                    ],
                  )),

              const Gap(20),

              // Review Input Field
              TextField(
                controller: reviewController,
                decoration: InputDecoration(
                  labelText: 'Write your review...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 3,
              ),
              const Gap(16),

              // Submit Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Submit to the database logic here (can be implemented later)

                      final commentReview = reviewController.text;

                      if (kDebugMode) {
                        Fluttertoast.showToast(
                            msg:
                                'Submitted: ${reviewController.text}, Rating: ${rating.value}, Checkbox Values: $checkboxValues',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }

                      if (rating > 3.5) {
                        Fluttertoast.showToast(
                            msg:
                                "Thank you for your review and for visiting our restaurant.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Thank you for your evaluation, and we promise to take it into consideration.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }

                      reviewController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReviewScreen(food: meal,)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
                    ),
                    child:
                        const Text('Reviews', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
