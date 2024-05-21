import 'package:fitness_ai_app/common/colo_extension.dart';
import 'package:flutter/material.dart';

class ExercisesRow extends StatelessWidget {
  final Map eObj;
  final VoidCallback onPressed;
  const ExercisesRow({super.key, required this.eObj, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              eObj["image"].toString(),
              width: 75,
              height: 75,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 25,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eObj["title"].toString(),
                style: TextStyle(color: TColor.black, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                eObj["value"].toString(),
                style: TextStyle(
                  color: TColor.gray,
                  fontSize: 12,
                ),
              ),
            ],
          )),
          IconButton(
              onPressed: onPressed,
              icon: Image.asset(
                "assets/img/next_go.png",
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ))
        ],
      ),
    );
  }
}
