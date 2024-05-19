import 'package:flutter/material.dart';
import 'package:fitness_ai_app/util/api_helper.dart';

class ApiTestWidget extends StatefulWidget {
  const ApiTestWidget({super.key});

  @override
  State<ApiTestWidget> createState() => _ApiTestWidgetState();
}

class _ApiTestWidgetState extends State<ApiTestWidget> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _foodData;

  void _searchFood() async {
    String query = _controller.text.trim();
    if (query.isNotEmpty) {
      try {
        final result = await ApiHelper.edamamAPI.searchFood(query);
        setState(() {
          _foodData = result;
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edamam API Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Search Food'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _searchFood,
              child: Text('Search'),
            ),
            SizedBox(height: 20.0),
            if (_foodData != null)
              Expanded(
                child: ListView.builder(
                  itemCount: _foodData!['hints'].length,
                  itemBuilder: (context, index) {
                    final food = _foodData!['hints'][index]['food'];
                    final String? imageUrl = food['image'];
                    final nutrients = food['nutrients'];
                    return Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageUrl != null
                                      ? NetworkImage(imageUrl)
                                      : AssetImage('assets/img/chicken.png') as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food['label'],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Calories: ${nutrients['ENERC_KCAL'] ?? 'N/A'} kcal',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'Protein: ${nutrients['PROCNT'] ?? 'N/A'} g',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'Fat: ${nutrients['FAT'] ?? 'N/A'} g',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    'Carbs: ${nutrients['CHOCDF'] ?? 'N/A'} g',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
