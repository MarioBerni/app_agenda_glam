import 'dart:async';
import 'package:flutter/material.dart';

/// Helper para gestionar el temporizador de reenvío de códigos de verificación
class VerificationTimerHelper {
  /// Temporizador activo
  Timer? _timer;
  
  /// Tiempo restante en segundos
  int _timerSeconds;
  
  /// Valor inicial del temporizador
  final int initialSeconds;
  
  /// Función para actualizar el estado
  final Function(int) onTimerTick;
  
  /// Función para cuando el temporizador llega a cero
  final VoidCallback onTimerComplete;
  
  /// Número de reenvíos realizados
  int _resendCount = 0;
  
  /// Número máximo de reenvíos permitidos
  final int maxResends;
  
  /// Constructor
  VerificationTimerHelper({
    required this.initialSeconds,
    required this.onTimerTick,
    required this.onTimerComplete,
    this.maxResends = 2,
  }) : _timerSeconds = initialSeconds;
  
  /// Inicia el temporizador
  void startTimer() {
    _timer?.cancel();
    _timerSeconds = initialSeconds;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        onTimerTick(_timerSeconds);
      } else {
        timer.cancel();
        onTimerComplete();
      }
    });
  }
  
  /// Incrementa el contador de reenvíos y reinicia el temporizador
  void incrementResendCount() {
    _resendCount++;
    startTimer();
  }
  
  /// Verifica si se ha alcanzado el límite de reenvíos
  bool get hasReachedResendLimit => _resendCount >= maxResends;
  
  /// Obtiene el número de reenvíos realizados
  int get resendCount => _resendCount;
  
  /// Formatea el tiempo restante en minutos:segundos
  String get formattedTime {
    final minutes = _timerSeconds ~/ 60;
    final seconds = _timerSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// Limpia los recursos
  void dispose() {
    _timer?.cancel();
  }
}
