import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:resturant_app/screens/comment_screen.dart';
import 'package:resturant_app/utils/data.dart';
import 'package:resturant_app/utils/model.dart';

class RateOrderScreen extends StatelessWidget {
  RateOrderScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  final Meals meal;
  final TextEditingController reviewController = TextEditingController();

  final rating = 2.5.obs;

  // RxList for checkbox values
  late RxList<bool> checkboxValues;

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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Food Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  meal.imageUrl ?? '',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16.0),

              Text(
                'How was your ${meal.name} order?',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
               const Text(
                'What would you like to add to the meal?',
                style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),  

              // Checkbox List
              FutureBuilder<List<Additions>>(
                future: fetchAdditions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No additions found.');
                  }

                  final fetchedAdditions = snapshot.data!;

                  // Initialize checkbox values based on fetched additions
                  checkboxValues = List.filled(fetchedAdditions.length, false).obs;

                  // Filter additions based on meal ID
                  final filteredAdditions = fetchedAdditions
                      .where((addition) => addition.mealId == meal.id)
                      .toList();

                  if (filteredAdditions.isEmpty) {
                    return const Text('No additions available for this meal.');
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredAdditions.length,
                    itemBuilder: (context, index) {
                      final addition = filteredAdditions[index];
                      return Obx(() {
                        return CheckboxListTile(
                          value: checkboxValues[index],
                          onChanged: (value) {
                            checkboxValues[index] = value!;
                            checkboxValues.refresh(); // Refresh state
                          },
                          title: Text(addition.additionDescription),
                        );
                      });
                    },
                  );
                },
              ),

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

              // Submit and Reviews Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      final commentReview = reviewController.text;
                      if (commentReview.isNotEmpty) {
                         final toastMessage =
                          'Submitted: $commentReview, Rating: ${rating.value}';
                      Fluttertoast.showToast(
                        msg: toastMessage,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.blue,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      if (rating.value > 3.5) {
                        Fluttertoast.showToast(
                          msg: "Thank you for your review!",
                          backgroundColor: Colors.green,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "We value your feedback and will improve!",
                          backgroundColor: Colors.red,
                        );
                      }

                      reviewController.clear();  
                      }
                       else {
                        Fluttertoast.showToast(
                          msg: "Please write a review!",
                          backgroundColor: Colors.red,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text('Submit', style: TextStyle(fontSize: 16 , color: Colors.white) ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewScreen(food: meal),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child:
                        const Text('Reviews', style: TextStyle(fontSize: 16 , color: Colors.white) ),
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
