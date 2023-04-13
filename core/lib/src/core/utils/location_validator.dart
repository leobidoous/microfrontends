import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;


class LocationValidator {
  static Future<Map<String, dynamic>> initLocationPosition(
    bool isDashboardRoute,
  ) async {
    // Verifica se o serviço de localização está ativo
    bool serviceEnabled = await isLocationServiceEnabled();

    if (serviceEnabled == false) {
      openServiceBottomSheet();
      return {};
    } else {
      return await validatePermission(isDashboardRoute);
    }
  }

  static Future<Map<String, dynamic>> validatePermission(
    bool isDashboardRoute,
  ) async {
    // Verifica se o aplicativo tem permissão para acessar a localização
    String status = await checkPermission();

    if (status == 'denied') {
      if (!isDashboardRoute) {
        Get.back();
      }
      openPermissionBottomSheet();
      return {};
    } else if (status == 'granted' || status == 'limited') {
      return getClosestMall();
    } else if (status == 'permanentlyDenied' || status == 'restricted') {
      if (!isDashboardRoute) {
        Get.back();
      }
      openPermissionBottomSheet();
      return {};
    } else {
      if (!isDashboardRoute) {
        Get.back();
      }
      return {};
    }
  }

  static Future<bool> openAppSettings() async {
    return permission.openAppSettings();
  }

  static Future<bool> isLocationServiceEnabled() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();

    return serviceEnabled;
  }

  static Future<bool> requestService() async {
    var serviceEnabled = await Location().requestService();

    return serviceEnabled;
  }

  static Future<permission.PermissionStatus> requestPermission() async {
    return await permission.Permission.location.request();
  }

  static Future<String> checkPermission() async {
    var status = await requestPermission();

    switch (status) {
      case permission.PermissionStatus.denied:
        return 'denied';
      case permission.PermissionStatus.permanentlyDenied:
        return 'permanentlyDenied';
      case permission.PermissionStatus.granted:
        return 'granted';
      case permission.PermissionStatus.limited:
        return 'limited';
      case permission.PermissionStatus.restricted:
        return 'restricted';
      default:
        return '';
    }
  }

  static getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }

  static Future<double> distanceBetween(
    double latitude,
    double longitude,
  ) async {
    var position = await getCurrentPosition();
    return Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      latitude,
      longitude,
    );
  }

  static Future<Map<String, dynamic>> getClosestMall() async {
    var list = await ParkingRepository().getShoppings();

    var closestMallDistance = await distanceBetween(
      double.parse(list.first.latitude!),
      double.parse(list.first.longitude!),
    );
    var closestMallId = list.first.id;
    var closesMallName = list.first.name;
    var closesMallAddress = list.first.address;

    for (var i = 0; i < list.length; i++) {
      var distance = await distanceBetween(
        double.parse(list[i].latitude!),
        double.parse(list[i].longitude!),
      );
      if (distance < closestMallDistance) {
        closestMallDistance = distance;
        closestMallId = list[i].id;
        closesMallName = list[i].name;
        closesMallAddress = list[i].address;
      }
    }

    final mall = list.firstWhere((element) => element.id == closestMallId);
    Factory<ShoppingModel>(() => mall);

    return {
      'closestMallDistance': closestMallDistance,
      'closestMallId': closestMallId,
      'closesMallName': closesMallName,
      'closesMallAddress': closesMallAddress,
    };
  }

  static void openServiceBottomSheet() async {
    Get.bottomSheet(
      BottomSheetComponent(
        height: 350.0,
        hasClose: false,
        bottomWidget: GenButton.text(
          text: 'Continuar',
          onPressed: () async {
            Get.back();
            await requestService();
          },
        ),
        child: [
          const SizedBox(height: 48.0),
          Text(
            'Ativar Localização',
            style: TextStyles.inter(
              color: const Color(0xFF531DAB),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Ativar sua localização',
                style: TextStyles.poppins(color: const Color(0xFF531DAB)),
                children: <TextSpan>[
                  TextSpan(
                    text: ' permite que você participe de ',
                    style: TextStyles.poppins(
                      color: const Color(0xFF531DAB),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const TextSpan(
                    text: 'Campanhas, Promoções e Eventos',
                  ),
                  TextSpan(
                    text: ' próximos à você.',
                    style: TextStyles.poppins(
                      color: const Color(0xFF531DAB),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void openPermissionBottomSheet() {
    Get.bottomSheet(
      BottomSheetComponent(
        height: 350.0,
        hasClose: false,
        bottomWidget: GenButton.text(
          text: 'Continuar',
          onPressed: () async {
            Get.back();
            await requestPermission();
          },
        ),
        child: [
          const SizedBox(height: 48.0),
          Text(
            'Autorizar Localização',
            style: TextStyles.inter(
              color: const Color(0xFF531DAB),
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Autorizar sua localização',
                style: TextStyles.poppins(color: const Color(0xFF531DAB)),
                children: <TextSpan>[
                  TextSpan(
                    text: ' permite que você participe de ',
                    style: TextStyles.poppins(
                      color: const Color(0xFF531DAB),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const TextSpan(
                    text: 'Campanhas, Promoções e Eventos',
                  ),
                  TextSpan(
                    text: ' próximos à você.',
                    style: TextStyles.poppins(
                      color: const Color(0xFF531DAB),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
