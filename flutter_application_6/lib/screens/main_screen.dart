import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nasa_cubit.dart';
import 'photo_detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA Mars Rover Photos'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<NasaCubit, NasaState>(
        builder: (context, state) {
          print('Current state: $state'); // Для отладки

          if (state is NasaLoadingState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Загрузка фотографий с Марса...'),
                ],
              ),
            );
          } else if (state is NasaErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Ошибка: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<NasaCubit>().loadData(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          } else if (state is NasaLoadedState) {
            final photos = state.photosResponse.photos;

            // Баннер демо-данных
            if (state.isDemoData) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Используются демо-данные (NASA API недоступен)'),
                    backgroundColor: Colors.orange,
                    duration: const Duration(seconds: 4),
                  ),
                );
              });
            }

            return Column(
              children: [
                // Информация о демо-данных
                if (state.isDemoData)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    color: Colors.orange.withOpacity(0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info, size: 20, color: Colors.orange[700]),
                        const SizedBox(width: 8),
                        Text(
                          'Демо-данные',
                          style: TextStyle(
                            color: Colors.orange[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                
                // Список фотографий
                Expanded(
                  child: photos.isEmpty
                      ? const Center(
                          child: Text('Нет фотографий для отображения'),
                        )
                      : ListView.builder(
                          itemCount: photos.length,
                          itemBuilder: (context, index) {
                            final photo = photos[index];
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: ListTile(
                                leading: Container(
  width: 60,
  height: 60,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: Colors.grey[200],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.network(
      photo.imgSrc,
      width: 60,
      height: 60,
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
        return Container(
          color: Colors.grey[300],
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo, size: 20, color: Colors.grey),
              SizedBox(height: 4),
              Text('Фото', style: TextStyle(fontSize: 10)),
            ],
          ),
        );
      },
    ),
  ),
),
                                title: Text('Камера: ${photo.camera.fullName}'),
                                subtitle: Text('Сол: ${photo.sol}'),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoDetailScreen(photo: photo),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          } else {
            // NasaInitialState или неизвестное состояние
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Нажмите для загрузки данных'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<NasaCubit>().loadData(),
                    child: const Text('Загрузить данные'),
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<NasaCubit>().loadData(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}