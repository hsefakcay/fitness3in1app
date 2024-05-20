import 'package:fitness_ai_app/view/meal_planner/meal_planner_view.dart';
import 'package:flutter/material.dart';
import 'package:fitness_ai_app/util/api_helper.dart';
import 'package:provider/provider.dart';
import '../../data/UserProvider.dart';
import '../../data/repo/user_repository.dart';
import '../../data/model/user.dart';

class ApiTestWidget extends StatefulWidget {
  const ApiTestWidget({super.key});

  @override
  State<ApiTestWidget> createState() => _ApiTestWidgetState();
}

class _ApiTestWidgetState extends State<ApiTestWidget> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? _foodData;
  List<String> _suggestedMeals = [];
  String? _selectedGoal;
  final Map<String, int> _calorieGoals = {
    'Improve Shape': 270,
    'Lean & Tone': 200,
    'Lose Fat': 150,
  };

  late UserProvider _userProvider;
  final UserRepository userRepository = UserRepository();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = await userRepository.getUserById(_userProvider.userId ?? "");
    if (user != null) {
      _userProvider.setUser(user);
    }
  }

  User? fetchUser() {
    return _userProvider.user;
  }

  List<String> suggestMeals(
      String? goalType, int calorieGoal, List<Map<String, dynamic>> foods) {
    List<String> suggestedMeals = [];
    int proteinMin = 0;
    int fatMax = 0;
    int carbMax = 0;

    // Set nutrient requirements based on goal type
    switch (goalType) {
      case 'Improve Shape':
        proteinMin = 15;
        fatMax = 20;
        carbMax = 50;
        break;
      case 'Lean & Tone':
        proteinMin = 13;
        fatMax = 25;
        carbMax = 50;
        break;
      case 'Lose Fat':
        proteinMin = 0;
        fatMax = 35;
        carbMax = 20;
        break;
      default:
        // Default values (can be adjusted based on specific requirements)
        proteinMin = 20;
        fatMax = 15;
        carbMax = 50;
    }

    for (var food in foods) {
      if (food['nutrients']['ENERC_KCAL'] <= calorieGoal &&
          food['nutrients']['PROCNT'] >= proteinMin &&
          food['nutrients']['FAT'] <= fatMax &&
          food['nutrients']['CHOCDF'] <= carbMax) {
        suggestedMeals.add(food['label']);
      }

      if (suggestedMeals.length >= 3) {
        break;
      }
    }

    return suggestedMeals;
  }

  void _searchFood() async {
    String query = _controller.text.trim();
    if (query.isNotEmpty) {
      try {
        final result = await ApiHelper.edamamAPI.searchFood(query);
        setState(() {
          _foodData = result;

          // Assuming _foodData['hints'] contains the list of foods with their nutritional information
          List<Map<String, dynamic>> foods = _foodData!['hints']
              .map<Map<String, dynamic>>(
                  (hint) => hint['food'] as Map<String, dynamic>)
              .toList();

          int calorieGoal = _calorieGoals[_userProvider.user?.programType]!;
          // Call suggestMeals with the desired calorie goal and list of foods
          _suggestedMeals =
              suggestMeals(_userProvider.user?.programType, calorieGoal, foods);
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  List findEatArr = [
    {
      "name": "Breakfast",
      "image": "assets/img/m_3.png",
      "number": "120+ Foods"
    },
    {"name": "Lunch", "image": "assets/img/m_4.png", "number": "130+ Foods"},
  ];
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Food Searcher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            food_category_widget(media: media, findEatArr: findEatArr),
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
                    if (imageUrl != null) {
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
                                    image: NetworkImage(imageUrl),
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
                    } else {
                      return SizedBox(); // Return an empty SizedBox if imageUrl is null
                    }
                  },
                ),
              ),
            if (_suggestedMeals.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggested Meals:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _suggestedMeals.length,
                    itemBuilder: (context, index) {
                      return Text(
                        _suggestedMeals[index],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
