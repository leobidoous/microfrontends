import 'package:intl/intl.dart' as intl;

import 'translations.dart';

/// The translations for Portuguese (`pt`).
class TrPt extends Tr {
  TrPt([String locale = 'pt']) : super(locale);

  @override
  String get parking => 'Estacionamento';

  @override
  String get notFoundTicket => 'Nenhum tíquete cadastrado';

  @override
  String get historyTicket => 'Histórico de tíquetes';

  @override
  String get history => 'Ver histórico';

  @override
  String get historyValue => 'Histórico de valores';

  @override
  String get amountSaved => 'Valor economizado';

  @override
  String get exitLimited => 'Limite de saída: ';

  @override
  String get notTransition => 'Você ainda não \nrealizou transações';

  @override
  String get estimatedProgress => 'Tempo estimado';

  @override
  String get currentTime => 'Horário atual';

  @override
  String get charge => 'Cobrança';

  @override
  String get estimatedValue => 'Valor estimado';

  @override
  String get amountPaid => 'Valor pago';

  @override
  String get additionalValue => 'Valor adicional';

  @override
  String get valueDiscount => 'Valor com desconto de 50%';

  @override
  String get outputLimitExceeded => 'Limite de saída excedido';

  @override
  String get perHour => ' por hora';

  @override
  String get perMinute => ' por minuto';

  @override
  String get registeredVehicle => 'Veículo cadastrado';

  @override
  String get haveAnotherVehicle => 'Está com outro veículo?';

  @override
  String get validateYourParking => 'Valide seu estacionamento';

  @override
  String get descriptionParking => 'Caso utilize TAG, informe a placa do veículo no campo abaixo:';

  @override
  String get enterPlate => 'Digite a placa do veículo';

  @override
  String get deskTitle => 'Balcão Gen';

  @override
  String get titleParkingDashBoard => 'Estacionamento';

  @override
  String get subtitleParkingDashBoard => 'Veja os principais serviços e campanhas relacionados ao estacionamento.';

  @override
  String get ticketTitle => 'Tíquete';

  @override
  String get ticketDescription => 'Tíquete e histórico';

  @override
  String get balconyTitle => 'Balcão';

  @override
  String get balconyDescription => 'Dúvidas e informações';

  @override
  String get walletTitle => 'Carteira';

  @override
  String get walletDescription => 'Gerenciar cartões';

  @override
  String get vehicleTitle => 'Veículo';

  @override
  String get vehicleDescription => 'Confira dados do veículo';

  @override
  String get campaignHeader => 'Campanha';

  @override
  String get seeRegulation => 'Ver regulamento';

  @override
  String get registeredCoupons => 'Cupons registrados';

  @override
  String validCoupons(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
      
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString cupons válidos',
      one: '1 cupom válido',
      zero: '$countString cupons válidos',
    );
    return '$_temp0';
  }

  @override
  String get fiftyDiscount => 'Pague seu estacionamento \ncom 50% de desconto';

  @override
  String get fullDiscount => 'Valide agora e ganhe o \n estacionamento gratuito';

  @override
  String get offDiscount => 'Pague seu estacionamento';

  @override
  String get establishment => 'Estabelecimento';

  @override
  String get formOfPayment => 'Forma de Pagamento';

  @override
  String get registerNewCard => 'Cadastrar novo cartao';

  @override
  String get voucherToEmail => 'O comprovante de pagamento foi enviado para o seu e-mail';

  @override
  String get information => 'Informações';

  @override
  String get address => 'Endereço';

  @override
  String get time => 'Horário';

  @override
  String get entry => 'Entrada';

  @override
  String get payment => 'Pagamento';

  @override
  String get exit => 'Saída';

  @override
  String get stay => 'Permanência';

  @override
  String get consultTicket => 'Consultar tíquete';

  @override
  String get paymentVoucher => 'Comprovante';

  @override
  String get seeCoupons => 'Ver cupons';

  @override
  String get anotationCoupons => '* Seus cupons serão válidos somente na data da compra.';

  @override
  String missingMessage(int value) {
    return 'Faltam $value para você ganhar o estacionamento gratuito';
  }

  @override
  String get addCoupon => 'Adicionar cupons';

  @override
  String get validateParking => 'Validar estacionamento';

  @override
  String get ticketTime => 'Tempo';

  @override
  String get ticketValue => 'Valor';

  @override
  String get ticketStatus => 'Status';

  @override
  String get payTextButton => 'Pagar';

  @override
  String get ticketNotFound => 'Nenhum tíquete encontrado';

  @override
  String get scanTicketButton => 'Escanear tíquete';

  @override
  String get canWeHelpYou => 'Podemos te ajudar?';

  @override
  String get contactSupport => 'Fale com o nosso time de Suporte e tire suas dúvidas.';

  @override
  String get contactUs => 'Fale conosco';

  @override
  String get removeVehicle => 'Excluir este veículo?';

  @override
  String get actionCannotBeUndone => 'Essa ação não pode ser desfeita.';

  @override
  String get yesRemov => 'Sim, excluir';

  @override
  String get titleVehicle => 'Veículos';

  @override
  String get seeAllVehicle => 'Veja todos os seus veículos registrados:';

  @override
  String get addVehicle => '+ Adicionar veículo';

  @override
  String get notFoundVehicles => 'Você não tem\n veículos cadastrado.';

  @override
  String get vehicleRegistration => 'Cadastro de veículo';

  @override
  String get continueButton => 'Continuar';

  @override
  String get successVehicle => 'Veículo cadastrado com sucesso!';

  @override
  String get alreadyRegistered => 'Ops! Você já cadastrou essa placa.';

  @override
  String get close => 'Fechar';

  @override
  String get registerVehicle => 'Cadastre o seu veículo para agilizar a liberação do estacionamento.';

  @override
  String get whichBrand => 'Qual é a marca do veículo?';

  @override
  String get whichModel => 'Escreva o modelo do veículo.';

  @override
  String get whichPlate => 'Escreva a placa do veículo.';

  @override
  String get brand => 'Marca';

  @override
  String get model => 'Modelo';

  @override
  String get plate => 'Placa';

  @override
  String get mainDoubts => 'Principais dúvidas';

  @override
  String get startRelease => 'Iniciar liberação';

  @override
  String get continueRelease => 'Continuar liberação';

  @override
  String get totalAmountRegistered => 'Valor total registrado';

  @override
  String get deskDoubtsInfo => 'Tire suas dúvidas relacionadas aos \ncupons fiscais, estacionamento e \npagamentos.';

  @override
  String get deskDoubtsInfoPending => 'Realize a liberação para resolver seus \nproblemas relacionados aos cupons fiscais, \nestacionamento ou pagamentos.';

  @override
  String get noItemAvailable => 'Nenhum item disponível';

  @override
  String get takePicture => 'Tirar foto';

  @override
  String ticketWindowHelperText(String name) {
    return 'Olá, $name. Notei que você tentou cadastrar seus cupons e não está tendo sucesso.\n\nEstou aqui para te ajudar. Vamos começar?\n\nMe envie a foto de cada um dos seus cupons fiscais.';
  }

  @override
  String get addCouponsLabel => 'Adicione seus cupons fiscais para ganhar estacionamento gratuito';

  @override
  String get typePlate => 'Digitar placa';
}
