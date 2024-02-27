import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/selected_items_grid_view_item.dart';

class CustomSelectedItemsGridView extends StatelessWidget {
  const CustomSelectedItemsGridView({
    super.key,
     required this.selectedItems,
  });
  final List<Map<String, dynamic>> selectedItems;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemCount: selectedItems.length,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) {
        return CustomSelectedItemGridViewItem(
          itemName: selectedItems[index]['exerciseName'] ?? '',
          videoLink: selectedItems[index]['link'] ?? '',
        );
      },
    );
  }
}