import 'package:flutter/material.dart';

class FavButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onPressed;
  const FavButton({super.key, required this.isLiked, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
