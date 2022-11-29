import 'package:flutter/material.dart';

enum ConnectionStatus { none, waiting, done, error, active }

extension ConnectionStatusExt on ConnectionStatus {
  String get name {
    switch (this) {
      case ConnectionStatus.none:
        return 'Nenhuma conexão';
      case ConnectionStatus.waiting:
        return 'Aguardando conexão';
      case ConnectionStatus.done:
        return 'Conexão encerrada';
      case ConnectionStatus.error:
        return 'Erro na conexão';
      case ConnectionStatus.active:
        return 'Conexão ativa';
    }
  }

  Color get color {
    switch (this) {
      case ConnectionStatus.none:
        return Colors.grey;
      case ConnectionStatus.waiting:
        return Colors.green.shade100;
      case ConnectionStatus.done:
        return Colors.blue;
      case ConnectionStatus.error:
        return Colors.red;
      case ConnectionStatus.active:
        return Colors.green;
    }
  }
}
