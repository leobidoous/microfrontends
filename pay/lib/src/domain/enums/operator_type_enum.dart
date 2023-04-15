enum OperatorType {
  vivo, tim, claro, oi
}

extension OperatorTypeExt on OperatorType {
  String get name {
    switch(this) {
      
      case OperatorType.vivo:
        return 'Vivo';
      case OperatorType.tim:
        return 'Tim';
      case OperatorType.claro:
        return 'Claro';
      case OperatorType.oi:
        return 'Oi';
    }
  }
}