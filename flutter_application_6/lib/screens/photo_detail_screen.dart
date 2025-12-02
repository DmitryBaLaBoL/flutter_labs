import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали фотографии'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
  width: double.infinity,
  height: 300,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: photo.imgSrc.startsWith('assets/')
        ? Image.asset(
            photo.imgSrc,
            fit: BoxFit.cover,
          )
        : Image.network(
            photo.imgSrc,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, size: 64),
                    Text('Ошибка загрузки изображения'),
                  ],
                ),
              );
            },
          ),
  ),
),
              ),
            ),

            const SizedBox(height: 24),

            // Информация о фотографии
            _buildInfoCard(
              'Информация о фотографии',
              [
                _buildInfoRow('ID:', photo.id.toString()),
                _buildInfoRow('Марсианский день (сол):', photo.sol.toString()),
                _buildInfoRow('Земная дата:', photo.earthDate),
              ],
            ),

            const SizedBox(height: 16),

            // Информация о камере
            _buildInfoCard(
              'Информация о камере',
              [
                _buildInfoRow('Название:', photo.camera.name),
                _buildInfoRow('Полное название:', photo.camera.fullName),
                _buildInfoRow('ID камеры:', photo.camera.id.toString()),
              ],
            ),

            const SizedBox(height: 16),

            // Информация о марсоходе
            _buildInfoCard(
              'Информация о марсоходе',
              [
                _buildInfoRow('Название:', photo.rover.name),
                _buildInfoRow('Статус:', photo.rover.status),
                _buildInfoRow('Дата посадки:', photo.rover.landingDate),
                _buildInfoRow('Дата запуска:', photo.rover.launchDate),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}