import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

abstract class NavigationState {}

class FirstScreenState extends NavigationState {}

class SecondScreenState extends NavigationState {
  final int numA;
  final int numB;
  final num result;

  SecondScreenState({required this.numA, required this.numB, required this.result});
}

class HistoryScreenState extends NavigationState {
  final List<String> history; //Использую List для хранения результатов

  HistoryScreenState(this.history);
}

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(FirstScreenState());

  void showFirstScreen() {
    emit(FirstScreenState());
  }

  Future<void> calculateAndShowSecondScreen(int numA, int numB) async {
    num result = pow(numA, 2) + pow(numB, 2);
    await _saveToHistory(numA, numB, result);
    emit(SecondScreenState(numA: numA, numB: numB, result: result));
  }

  Future<void> showHistoryScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('calc_history') ?? [];
    emit(HistoryScreenState(history));
  }

  Future<void> _saveToHistory(int a, int b, num result) async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList('calc_history') ?? [];
    history.add("Масса тела = $a кг, скорость = $b м/с, кинетическая энергия = $result Дж");
    await prefs.setStringList('calc_history', history);
  }
}