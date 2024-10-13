import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resturant_app/utils/constants.dart';
import 'package:resturant_app/utils/data.dart';
import 'package:resturant_app/utils/model.dart';

class ReviewScreen extends StatelessWidget {
  final Meals food;

  ReviewScreen({
    super.key,
    required this.food,
  });

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
              child: FutureBuilder<List<Comments>>(
                future: fetchComments(), // Fetch comments from the database
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No reviews found.'));
                  }

                  final comments = snapshot.data!;

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      // Reverse order of comments
                      index = comments.length - index - 1;
                      final review = comments[index];

                      // Check if the comment belongs to the given meal
                      if (food.id == review.mealId) {
                        final formattedTime = DateFormat('yyyy-MM-dd  kk:mm')
                            .format(review.createdAt ?? DateTime.now());

                        // Fetch the user's name using a FutureBuilder
                        return FutureBuilder(
                          future: supabase
                              .from('users')
                              .select('username')
                              .eq('id', review.userId?? 0)
                              .maybeSingle(), // Fetch single matching user
                          builder: (context, userSnapshot) {
                           
                            if (userSnapshot.hasError) {
                              return const Text('Error fetching user');
                            }

                            // Extract username or show 'Anonymous' if not found
                            final username = userSnapshot.data?['username'] ?? 'Anonymous';

                            return ListTile(
                              leading: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                ),
                              ),
                              title: Text(username), // Display username
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(formattedTime),
                                  const SizedBox(height: 4),
                                  Text(review.comment ?? ''),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink(); // Ignore non-matching meals
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
