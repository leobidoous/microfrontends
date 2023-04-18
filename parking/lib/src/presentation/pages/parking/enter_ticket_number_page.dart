import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/translations.dart';
import '../../routes/parking_routes.dart';
import '../../routes/ticket_routes.dart';
import '../ticket/ticket_submit/ticket_submit_page.dart';
import 'widgets/shopping_location.dart';

class EnterTicketNumberPage extends StatefulWidget {
  const EnterTicketNumberPage({super.key});

  @override
  State<EnterTicketNumberPage> createState() => _EnterTicketNumberPageState();
}

class _EnterTicketNumberPageState extends State<EnterTicketNumberPage> {
  final ticketController = TextEditingController();
  bool enableButton = false;

  final shopping = DM.i.get<ShoppingEntity>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenAppBar(
        title: Tr.of(context).parking,
        actions: [
          AppBarButton(
            onTap: DM.i.get<ZendeskController>().openChat,
            child: Icon(
              CoreIcons.contactUs,
              size: const Spacing(3).value,
            ),
          ),
        ],
      ),
      body: GenScrollContent(
        padding: EdgeInsets.all(const Spacing(3).value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MallLocation(shopping: shopping),
            Spacing.sm.vertical,
            Text(
              'Pague seu estacionamento',
              textAlign: TextAlign.left,
              style: context.textTheme.headlineSmall,
            ),
            Spacing.sm.vertical,
            Text(
              '''Escaneie o código de barras ou digite os números do seu tíquete.''',
              textAlign: TextAlign.left,
              style: context.textTheme.labelMedium,
            ),
            Spacing.md.vertical,
            GenButton.text(
              text: 'Escanear tíquete',
              onPressed: () {
                Nav.to.pushNamed(
                  ParkingRoutes.scanTicket.completePath,
                  arguments: (code) {
                    Nav.to.pushNamed(
                      TicketRoutes.root,
                      arguments: TicketSubmitPageArgs(
                        ticketOrPlate: code,
                        onPop: () {
                          Nav.to.popUntil(
                            ModalRoute.withName(
                              ParkingRoutes.root.completePath,
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
            Spacing.sm.vertical,
            Text(
              '- ou -',
              textAlign: TextAlign.center,
              style: context.textTheme.labelMedium,
            ),
            Spacing.sm.vertical,
            GenInputField(
              controller: ticketController,
              keyboardType: TextInputType.number,
              onChanged: (ticket) {
                if (ticket!.length > 4 && ticket.length < 14) {
                  setState(() {
                    enableButton = true;
                  });
                } else {
                  setState(() {
                    enableButton = false;
                  });
                }
              },
              hintText: 'Digite os números do tíquete',
            ),
            Spacing.sm.vertical,
            GenButton.text(
              text: 'Continuar',
              isEnabled: enableButton,
              type: enableButton ? ButtonType.primary : ButtonType.background,
              onPressed: () {
                Nav.to.pushNamed(
                  TicketRoutes.root,
                  arguments: TicketSubmitPageArgs(
                    ticketOrPlate: ticketController.text,
                    onPop: () {
                      Nav.to.popUntil(
                        ModalRoute.withName(ParkingRoutes.root.completePath),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
