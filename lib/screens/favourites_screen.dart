
import 'package:flutter/material.dart';
import '../../utils/favourites.dart';
import '../../widgets/component/receipecard.dart';
import '../../models/recipe.dart';
import '../utils/route_generator.dart';

class FavoritesScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final List<Recipe> favorites = FavoritesManager().favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Recipes'),
        backgroundColor: Colors.orange.shade400,
        elevation: 0,
      ),
      body: favorites.isEmpty
          ? _buildEmptyState(context)
          : Container(
              color: const Color(0xFFF8F4EC), // Light cream background
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: favorites.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
  final recipe = favorites[index];
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(12),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: RecipeCard(
        recipe: recipe,
        onTap: () {
          Navigator.of(context, rootNavigator: true).pushNamed(
      RouteGenerator.recipedetails,
      arguments: recipe.id, // pass your ID here
    );
        },
      ),
    ),
  );
},

              ),
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F4EC),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, color: Colors.orange.shade300, size: 80),
          const SizedBox(height: 16),
          Text(
            'No favorites yet!',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon on recipes to save them here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}



