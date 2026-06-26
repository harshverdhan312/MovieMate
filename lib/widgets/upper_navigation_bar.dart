import 'package:flutter/material.dart';

class UpperNavigationBar extends StatelessWidget {
  final int selectedCategory;

  final Function(int) onCategorySelected;
  const UpperNavigationBar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  static const categories = ["Trending", "New", "Movies", "Shows"];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;

          final isSelected = selectedCategory == index;

          return GestureDetector(
            onTap: () {
              onCategorySelected(index);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: isSelected ? 22 : 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                    child: Text(category),
                  ),

                  const SizedBox(height: 5),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 3,
                    width: isSelected ? 30 : 0,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(254, 214, 68, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
