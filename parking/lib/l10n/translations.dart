import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'translations_pt.dart';

/// Callers can lookup localized strings with an instance of Tr
/// returned by `Tr.of(context)`.
///
/// Applications need to include `Tr.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/translations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Tr.localizationsDelegates,
///   supportedLocales: Tr.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Tr.supportedLocales
/// property.
// ignore_for_file: lines_longer_than_80_chars 
abstract class Tr {
  Tr(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Tr of(BuildContext context) {
    return Localizations.of<Tr>(context, Tr)!;
  }

  static const LocalizationsDelegate<Tr> delegate = _TrDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('pt')
  ];

  /// Labels de estacionamento
  ///
  /// In pt, this message translates to:
  /// **'Estacionamento'**
  String get parking;

  /// No description provided for @notFoundTicket.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum tíquete cadastrado'**
  String get notFoundTicket;

  /// No description provided for @historyTicket.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de tíquetes'**
  String get historyTicket;

  /// No description provided for @history.
  ///
  /// In pt, this message translates to:
  /// **'Ver histórico'**
  String get history;

  /// No description provided for @historyValue.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de valores'**
  String get historyValue;

  /// No description provided for @amountSaved.
  ///
  /// In pt, this message translates to:
  /// **'Valor economizado'**
  String get amountSaved;

  /// No description provided for @exitLimited.
  ///
  /// In pt, this message translates to:
  /// **'Limite de saída: '**
  String get exitLimited;

  /// No description provided for @notTransition.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não \nrealizou transações'**
  String get notTransition;

  /// No description provided for @estimatedProgress.
  ///
  /// In pt, this message translates to:
  /// **'Tempo estimado'**
  String get estimatedProgress;

  /// No description provided for @currentTime.
  ///
  /// In pt, this message translates to:
  /// **'Horário atual'**
  String get currentTime;

  /// No description provided for @charge.
  ///
  /// In pt, this message translates to:
  /// **'Cobrança'**
  String get charge;

  /// No description provided for @estimatedValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor estimado'**
  String get estimatedValue;

  /// No description provided for @amountPaid.
  ///
  /// In pt, this message translates to:
  /// **'Valor pago'**
  String get amountPaid;

  /// No description provided for @additionalValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor adicional'**
  String get additionalValue;

  /// No description provided for @valueDiscount.
  ///
  /// In pt, this message translates to:
  /// **'Valor com desconto de 50%'**
  String get valueDiscount;

  /// No description provided for @outputLimitExceeded.
  ///
  /// In pt, this message translates to:
  /// **'Limite de saída excedido'**
  String get outputLimitExceeded;

  /// No description provided for @perHour.
  ///
  /// In pt, this message translates to:
  /// **' por hora'**
  String get perHour;

  /// No description provided for @perMinute.
  ///
  /// In pt, this message translates to:
  /// **' por minuto'**
  String get perMinute;

  /// No description provided for @registeredVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Veículo cadastrado'**
  String get registeredVehicle;

  /// No description provided for @haveAnotherVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Está com outro veículo?'**
  String get haveAnotherVehicle;

  /// No description provided for @validateYourParking.
  ///
  /// In pt, this message translates to:
  /// **'Valide seu estacionamento'**
  String get validateYourParking;

  /// No description provided for @descriptionParking.
  ///
  /// In pt, this message translates to:
  /// **'Caso utilize TAG, informe a placa do veículo no campo abaixo:'**
  String get descriptionParking;

  /// No description provided for @enterPlate.
  ///
  /// In pt, this message translates to:
  /// **'Digite a placa do veículo'**
  String get enterPlate;

  /// No description provided for @deskTitle.
  ///
  /// In pt, this message translates to:
  /// **'Balcão Gen'**
  String get deskTitle;

  /// No description provided for @titleParkingDashBoard.
  ///
  /// In pt, this message translates to:
  /// **'Estacionamento'**
  String get titleParkingDashBoard;

  /// No description provided for @subtitleParkingDashBoard.
  ///
  /// In pt, this message translates to:
  /// **'Veja os principais serviços e campanhas relacionados ao estacionamento.'**
  String get subtitleParkingDashBoard;

  /// No description provided for @ticketTitle.
  ///
  /// In pt, this message translates to:
  /// **'Tíquete'**
  String get ticketTitle;

  /// No description provided for @ticketDescription.
  ///
  /// In pt, this message translates to:
  /// **'Tíquete e histórico'**
  String get ticketDescription;

  /// No description provided for @balconyTitle.
  ///
  /// In pt, this message translates to:
  /// **'Balcão'**
  String get balconyTitle;

  /// No description provided for @balconyDescription.
  ///
  /// In pt, this message translates to:
  /// **'Dúvidas e informações'**
  String get balconyDescription;

  /// No description provided for @walletTitle.
  ///
  /// In pt, this message translates to:
  /// **'Carteira'**
  String get walletTitle;

  /// No description provided for @walletDescription.
  ///
  /// In pt, this message translates to:
  /// **'Gerenciar cartões'**
  String get walletDescription;

  /// No description provided for @vehicleTitle.
  ///
  /// In pt, this message translates to:
  /// **'Veículo'**
  String get vehicleTitle;

  /// No description provided for @vehicleDescription.
  ///
  /// In pt, this message translates to:
  /// **'Confira dados do veículo'**
  String get vehicleDescription;

  /// No description provided for @campaignHeader.
  ///
  /// In pt, this message translates to:
  /// **'Campanha'**
  String get campaignHeader;

  /// No description provided for @seeRegulation.
  ///
  /// In pt, this message translates to:
  /// **'Ver regulamento'**
  String get seeRegulation;

  /// No description provided for @registeredCoupons.
  ///
  /// In pt, this message translates to:
  /// **'Cupons registrados'**
  String get registeredCoupons;

  /// A plural message
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{{count} cupons válidos} =1{1 cupom válido} other{{count} cupons válidos}}'**
  String validCoupons(num count);

  /// No description provided for @fiftyDiscount.
  ///
  /// In pt, this message translates to:
  /// **'Pague seu estacionamento \ncom 50% de desconto'**
  String get fiftyDiscount;

  /// No description provided for @fullDiscount.
  ///
  /// In pt, this message translates to:
  /// **'Valide agora e ganhe o \n estacionamento gratuito'**
  String get fullDiscount;

  /// No description provided for @offDiscount.
  ///
  /// In pt, this message translates to:
  /// **'Pague seu estacionamento'**
  String get offDiscount;

  /// No description provided for @establishment.
  ///
  /// In pt, this message translates to:
  /// **'Estabelecimento'**
  String get establishment;

  /// No description provided for @formOfPayment.
  ///
  /// In pt, this message translates to:
  /// **'Forma de Pagamento'**
  String get formOfPayment;

  /// No description provided for @registerNewCard.
  ///
  /// In pt, this message translates to:
  /// **'Cadastrar novo cartao'**
  String get registerNewCard;

  /// No description provided for @voucherToEmail.
  ///
  /// In pt, this message translates to:
  /// **'O comprovante de pagamento foi enviado para o seu e-mail'**
  String get voucherToEmail;

  /// No description provided for @information.
  ///
  /// In pt, this message translates to:
  /// **'Informações'**
  String get information;

  /// No description provided for @address.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get address;

  /// No description provided for @time.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get time;

  /// No description provided for @entry.
  ///
  /// In pt, this message translates to:
  /// **'Entrada'**
  String get entry;

  /// No description provided for @payment.
  ///
  /// In pt, this message translates to:
  /// **'Pagamento'**
  String get payment;

  /// No description provided for @exit.
  ///
  /// In pt, this message translates to:
  /// **'Saída'**
  String get exit;

  /// No description provided for @stay.
  ///
  /// In pt, this message translates to:
  /// **'Permanência'**
  String get stay;

  /// No description provided for @consultTicket.
  ///
  /// In pt, this message translates to:
  /// **'Consultar tíquete'**
  String get consultTicket;

  /// No description provided for @paymentVoucher.
  ///
  /// In pt, this message translates to:
  /// **'Comprovante'**
  String get paymentVoucher;

  /// No description provided for @seeCoupons.
  ///
  /// In pt, this message translates to:
  /// **'Ver cupons'**
  String get seeCoupons;

  /// No description provided for @anotationCoupons.
  ///
  /// In pt, this message translates to:
  /// **'* Seus cupons serão válidos somente na data da compra.'**
  String get anotationCoupons;

  /// No description provided for @missingMessage.
  ///
  /// In pt, this message translates to:
  /// **'Faltam {value} para você ganhar o estacionamento gratuito'**
  String missingMessage(int value);

  /// No description provided for @addCoupon.
  ///
  /// In pt, this message translates to:
  /// **'Adicionar cupons'**
  String get addCoupon;

  /// No description provided for @validateParking.
  ///
  /// In pt, this message translates to:
  /// **'Validar estacionamento'**
  String get validateParking;

  /// No description provided for @ticketTime.
  ///
  /// In pt, this message translates to:
  /// **'Tempo'**
  String get ticketTime;

  /// No description provided for @ticketValue.
  ///
  /// In pt, this message translates to:
  /// **'Valor'**
  String get ticketValue;

  /// No description provided for @ticketStatus.
  ///
  /// In pt, this message translates to:
  /// **'Status'**
  String get ticketStatus;

  /// No description provided for @payTextButton.
  ///
  /// In pt, this message translates to:
  /// **'Pagar'**
  String get payTextButton;

  /// No description provided for @ticketNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum tíquete encontrado'**
  String get ticketNotFound;

  /// No description provided for @scanTicketButton.
  ///
  /// In pt, this message translates to:
  /// **'Escanear tíquete'**
  String get scanTicketButton;

  /// No description provided for @canWeHelpYou.
  ///
  /// In pt, this message translates to:
  /// **'Podemos te ajudar?'**
  String get canWeHelpYou;

  /// No description provided for @contactSupport.
  ///
  /// In pt, this message translates to:
  /// **'Fale com o nosso time de Suporte e tire suas dúvidas.'**
  String get contactSupport;

  /// No description provided for @contactUs.
  ///
  /// In pt, this message translates to:
  /// **'Fale conosco'**
  String get contactUs;

  /// No description provided for @removeVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Excluir este veículo?'**
  String get removeVehicle;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In pt, this message translates to:
  /// **'Essa ação não pode ser desfeita.'**
  String get actionCannotBeUndone;

  /// No description provided for @yesRemov.
  ///
  /// In pt, this message translates to:
  /// **'Sim, excluir'**
  String get yesRemov;

  /// No description provided for @titleVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Veículos'**
  String get titleVehicle;

  /// No description provided for @seeAllVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Veja todos os seus veículos registrados:'**
  String get seeAllVehicle;

  /// No description provided for @addVehicle.
  ///
  /// In pt, this message translates to:
  /// **'+ Adicionar veículo'**
  String get addVehicle;

  /// No description provided for @notFoundVehicles.
  ///
  /// In pt, this message translates to:
  /// **'Você não tem\n veículos cadastrado.'**
  String get notFoundVehicles;

  /// No description provided for @vehicleRegistration.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro de veículo'**
  String get vehicleRegistration;

  /// No description provided for @continueButton.
  ///
  /// In pt, this message translates to:
  /// **'Continuar'**
  String get continueButton;

  /// No description provided for @successVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Veículo cadastrado com sucesso!'**
  String get successVehicle;

  /// No description provided for @alreadyRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Ops! Você já cadastrou essa placa.'**
  String get alreadyRegistered;

  /// No description provided for @close.
  ///
  /// In pt, this message translates to:
  /// **'Fechar'**
  String get close;

  /// No description provided for @registerVehicle.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre o seu veículo para agilizar a liberação do estacionamento.'**
  String get registerVehicle;

  /// No description provided for @whichBran.
  ///
  /// In pt, this message translates to:
  /// **'Qual é a marca do veículo?'**
  String get whichBran;

  /// No description provided for @whichModel.
  ///
  /// In pt, this message translates to:
  /// **'Escreva o modelo do veículo.'**
  String get whichModel;

  /// No description provided for @whichPlate.
  ///
  /// In pt, this message translates to:
  /// **'Escreva a placa do veículo.'**
  String get whichPlate;

  /// No description provided for @brand.
  ///
  /// In pt, this message translates to:
  /// **'Marca'**
  String get brand;

  /// No description provided for @model.
  ///
  /// In pt, this message translates to:
  /// **'Modelo'**
  String get model;

  /// No description provided for @plate.
  ///
  /// In pt, this message translates to:
  /// **'Placa'**
  String get plate;

  /// No description provided for @mainDoubts.
  ///
  /// In pt, this message translates to:
  /// **'Principais dúvidas'**
  String get mainDoubts;

  /// No description provided for @startRelease.
  ///
  /// In pt, this message translates to:
  /// **'Iniciar liberação'**
  String get startRelease;

  /// No description provided for @continueRelease.
  ///
  /// In pt, this message translates to:
  /// **'Continuar liberação'**
  String get continueRelease;

  /// No description provided for @totalAmountRegistered.
  ///
  /// In pt, this message translates to:
  /// **'Valor total registrado'**
  String get totalAmountRegistered;

  /// No description provided for @deskDoubtsInfo.
  ///
  /// In pt, this message translates to:
  /// **'Tire suas dúvidas relacionadas aos \ncupons fiscais, estacionamento e \npagamentos.'**
  String get deskDoubtsInfo;

  /// No description provided for @deskDoubtsInfoPending.
  ///
  /// In pt, this message translates to:
  /// **'Realize a liberação para resolver seus \nproblemas relacionados aos cupons fiscais, \nestacionamento ou pagamentos.'**
  String get deskDoubtsInfoPending;

  /// No description provided for @noItemAvailable.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum item disponível'**
  String get noItemAvailable;

  /// No description provided for @takePicture.
  ///
  /// In pt, this message translates to:
  /// **'Tirar foto'**
  String get takePicture;

  /// No description provided for @ticketWindowHelperText.
  ///
  /// In pt, this message translates to:
  /// **'Olá, {name}. Notei que você tentou cadastrar seus cupons e não está tendo sucesso.\n\nEstou aqui para te ajudar. Vamos começar?\n\nMe envie a foto de cada um dos seus cupons fiscais.'**
  String ticketWindowHelperText(String name);

  /// No description provided for @addCouponsLabel.
  ///
  /// In pt, this message translates to:
  /// **'Adicione seus cupons fiscais para ganhar estacionamento gratuito'**
  String get addCouponsLabel;

  /// No description provided for @typePlate.
  ///
  /// In pt, this message translates to:
  /// **'Digitar placa'**
  String get typePlate;

  /// Labels de carteira
  ///
  /// In pt, this message translates to:
  /// **'Carteira'**
  String get wallet;
}

class _TrDelegate extends LocalizationsDelegate<Tr> {
  const _TrDelegate();

  @override
  Future<Tr> load(Locale locale) {
    return SynchronousFuture<Tr>(lookupTr(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_TrDelegate old) => false;
}

Tr lookupTr(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pt': return TrPt();
  }

  throw FlutterError(
    'Tr.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
