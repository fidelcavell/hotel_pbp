import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _ratingContoller = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    // To clean up unnecessary controller's memory when widget is not longer used
    _ratingContoller.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rating',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          TextField(
            controller: _ratingContoller,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.star_border_rounded),
              border: UnderlineInputBorder(),
              hintText: 'Add your rating',
            ),
          ),
          const SizedBox(height: 24.0),
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.notes_rounded),
              border: UnderlineInputBorder(),
              hintText: 'Add your comment',
            ),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 230, 96, 81),
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit Review'),
            ),
          ),
        ],
      ),
    );
  }
}
