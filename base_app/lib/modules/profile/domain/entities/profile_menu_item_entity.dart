import '../enums/menu_item_type_enum.dart';

class ProfileMenuItemEntity {
  final String name;
  final MenuItemType type;
  final String assetIcon;
  final Function()? onTap;

  ProfileMenuItemEntity({
    this.type = MenuItemType.clickable,
    required this.name,
    required this.assetIcon,
    this.onTap,
  });
}
