import 'package:flutter/material.dart';
import '../../models/recipe.dart';
import '../../utils/favourites.dart';
class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onTap;

  const RecipeCard({
    Key? key,
    required this.recipe,
    this.onTap,
  }) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
    late bool isFavorite;
  


  @override
  void initState() {
    super.initState();
   isFavorite = FavoritesManager.instance.isFavorite(widget.recipe.id);


  }

  void _toggleFavorite() {
    setState(() {
      FavoritesManager.instance.toggleFavorite(widget.recipe);

      isFavorite = !isFavorite;
    });
  }

  Widget _buildDifficultyButton(String difficulty) {
    Color color;
    switch (difficulty.toLowerCase()) {
      case 'easy':
        color = Colors.green;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'hard':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        difficulty.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber, size: 16);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with heart icon on top right
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    widget.recipe.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap:  _toggleFavorite,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.7),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDifficultyButton(widget.recipe.difficulty),
                      Row(
                        children: [
                          const Icon(Icons.schedule, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('${widget.recipe.cookTimeMinutes} mins',
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      _buildRatingStars(widget.recipe.rating),
                      const SizedBox(width: 8),
                      Text('(${widget.recipe.reviewCount})',
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

