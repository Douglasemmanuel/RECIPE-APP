import 'package:flutter/material.dart';
import '../data/receipe_data.dart';
import '../models/recipe.dart';
class RecipeListScreen extends StatelessWidget {
  // Sample recipe data


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Recipes'),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: sampleRecipes.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final recipe = sampleRecipes[index];
          return ListTile(
                      leading: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Rounded corners for image
              child: Image.network(
                recipe.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
              ),
            ),
            title: Text(recipe.title),
                    subtitle: Row(
          children: [
            Text(' ${recipe.cookTimeMinutes} mins'),
            SizedBox(width: 6),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 6),
            Text(recipe.difficulty),
          ],
        ),

            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Navigate to recipe details screen
            },
          );
        },
      ),
    );
  }
}
