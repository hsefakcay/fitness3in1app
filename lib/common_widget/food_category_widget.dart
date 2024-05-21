import 'package:fitness_ai_app/common_widget/find_eat_cell.dart';
import 'package:fitness_ai_app/view/meal_planner/meal_food_details_view.dart';
import 'package:flutter/material.dart';

class food_category_widget extends StatelessWidget {
  const food_category_widget({
    super.key,
    required this.media,
    required this.findEatArr,
  });

  final Size media;
  final List findEatArr;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: media.width * 0.85,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          scrollDirection: Axis.horizontal,
          itemCount: findEatArr.length,
          itemBuilder: (context, index) {
            var fObj = findEatArr[index] as Map? ?? {};
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MealFoodDetailsView(eObj: fObj)));
              },
              child: FindEatCell(
                fObj: fObj,
                index: index,
              ),
            );
          }),
    );
  }
}
