import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/weather_data.dart';
import '../services/weather_service.dart';
import '../services/storage_service.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherData weatherData;

  const WeatherLoaded(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  void loadWeather(String city) async {
  try {
    emit(WeatherLoading());
    
    final weather = await WeatherService.getWeather(city);
    
    // Сохраняем в историю
    StorageService.addWeatherToHistory(weather);
    
    emit(WeatherLoaded(weather));
  } catch (e) {
    emit(WeatherError(e.toString())); // Показываем реальную ошибку
  }
}
}