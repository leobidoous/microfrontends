import 'cart_entity.dart';

class OrderEntity {
  final List<CartEntity> items;

  OrderEntity({this.items = const []});
}
