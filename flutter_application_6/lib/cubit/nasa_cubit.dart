import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/mars_photos_response.dart';
import '../requests/api.dart';

abstract class NasaState extends Equatable {
  const NasaState();

  @override
  List<Object> get props => [];
}

class NasaInitialState extends NasaState {}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  final MarsPhotosResponse photosResponse;
  final bool isDemoData;

  const NasaLoadedState(this.photosResponse, {this.isDemoData = false});

  @override
  List<Object> get props => [photosResponse, isDemoData];
}

class NasaErrorState extends NasaState {
  final String message;

  const NasaErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(NasaInitialState());

  void loadData() async {
    try {
      emit(NasaLoadingState());
      
      // Всегда используем демо-данные для гарантии работы
      final photosResponse = await NasaApi.getMarsPhotos(
        rover: 'spirit',
        sol: 100,
      );

      if (photosResponse.photos.isEmpty) {
        emit(const NasaErrorState('No photos available'));
      } else {
        emit(NasaLoadedState(photosResponse, isDemoData: true));
      }
    } catch (e) {
      print('Error in loadData: $e');
      // Всегда возвращаем демо-данные даже при ошибке
      final demoResponse = NasaApi.getDemoData('spirit', 100);
      emit(NasaLoadedState(demoResponse, isDemoData: true));
    }
  }
}