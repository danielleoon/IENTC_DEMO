import 'package:flutter/material.dart';
import 'package:ientc_jdls/utils/DanielAppUtils/DanielColors.dart';

class TransformationCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const TransformationCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 120,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Card(
            color: DanielBaseColors.white,
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  imageUrl,
                  height: 100,
                  width: 100,
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Daniel-Bold',
                    color: DanielBaseColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
