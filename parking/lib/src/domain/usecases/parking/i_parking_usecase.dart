import 'package:core/core.dart';

import '../../../infra/models/ticket/history_ticket_model.dart';
import '../../entities/dashboard/coupon_entity.dart';
import '../../entities/dashboard/ticket_entity.dart';
import '../../entities/ticket/ticket_payment_entity.dart';
import '../../entities/ticket/ticket_payment_request_entity.dart';
import '../../failures/dashboard/dashboard_failure.dart';

abstract class IParkingUsecase {
  Future<Either<Exception, CouponEntity>> fetchCoupon({
    required String idShopping,
  });

  /// `RETORNA INFORMAÇÃO` DE TICKET DO ESTACIONAMENTO
  ///
  /// Este usecase deve ser chamado na verificação de um ticket, ou para saber
  /// se existe algum ticket em aberto escaneado
  ///
  /// Parametros obrigatórios:
  /// - id_mall: código do shopping
  /// - customerId: customer do usuário logado
  ///
  ///
  /// Retornos:
  /// - Status 200 - Ticket encontrado, retorna as informações sobre o ticket
  /// - Status 400 - Parametros obrigatórios faltando (id_mall e/ou customerId)
  /// - Status 404 - Ticket não encontrado
  ///      - Cod 1 - Ticket/Placa não encontrado no estabeleciomento
  ///      - Cod 2 - Ticket/Placa pago e não se encontra mais no estabelecimento
  ///      - Cod 3 - Ticket não encontrado para o usuário
  /// - Status 500 - Erro interno no serviço
  ///
  ///
  ///
  /// `ESCANER` TICKET DE ESTACIONAMENTO
  ///
  /// Este mesmo usecase pode ser chamado após um ticket ser escaneado,
  /// basta passar o parametro CODE preenchido com o código do ticker
  ///
  /// Parametros opcionais:
  /// - code: passado apenas quando o usecase é chamado para escanear um ticket
  Future<Either<IParkingDashboardFailures, TicketEntity>> fecthInfoTicket({
    String? code,
    required String idShopping,
  });

  Future<Either<IParkingDashboardFailures, TicketPaymentEntity>> paymentTicket({
    required TicketPaymentRequestEntity paymentRequestEntity,
  });

  Future<Either<Exception, List<HistoryTicketModel>>> fetchHistoryTicket({
    required String page,
    required String perPage,
  });

  Future<Either<Exception, String>> fetchParkingRules({
    required String shoppingId,
  });
}
