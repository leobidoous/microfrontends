import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final customer = DM.i.get<SessionEntity>().customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Meu perfil'),
      body: SafeArea(
        child: CustomScrollContent(
          padding: EdgeInsets.all(const Spacing(3).value),
          expanded: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Dados pessoais',
                style: context.textTheme.titleMedium,
              ),
              const Divider(),
              Spacing.sm.vertical,
              CustomInputField(
                readOnly: true,
                initialValue: customer.name,
                labelWidget: const InputLabel(label: 'Nome'),
              ),
              Spacing.sm.vertical,
              CustomInputField(
                readOnly: true,
                initialValue: customer.cpf,
                labelWidget: const InputLabel(label: 'CPF'),
              ),
              Spacing.sm.vertical,
              CustomInputField(
                readOnly: true,
                initialValue: customer.email,
                labelWidget: const InputLabel(label: 'E-mail'),
              ),
              Spacing.sm.vertical,
              CustomInputField(
                readOnly: true,
                initialValue: customer.phone,
                labelWidget: const InputLabel(label: 'Telefone'),
              ),
              Spacing.md.vertical,
              Text(
                'Endereço',
                style: context.textTheme.titleMedium,
              ),
              const Divider(),
              Spacing.sm.vertical,
              CustomInputField(
                hintText: '000.000-00',
                initialValue: customer.address.postalCode,
                labelWidget: const InputLabel(label: 'CEP'),
              ),
              Spacing.sm.vertical,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: CustomInputField(
                      hintText: 'Nome da rua',
                      initialValue: customer.address.line1,
                      labelWidget: const InputLabel(label: 'Rua'),
                    ),
                  ),
                  Spacing.sm.horizontal,
                  Expanded(
                    flex: 3,
                    child: CustomInputField(
                      hintText: '0',
                      initialValue: customer.address.line2,
                      labelWidget: const InputLabel(label: 'Número'),
                    ),
                  ),
                ],
              ),
              Spacing.sm.vertical,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomInputField(
                      hintText: 'Nome do bairro',
                      initialValue: customer.address.neighborhood,
                      labelWidget: const InputLabel(label: 'Bairro'),
                    ),
                  ),
                  Spacing.sm.horizontal,
                  Expanded(
                    child: CustomInputField(
                      hintText: 'Ex.: Próximo à...',
                      initialValue: customer.address.line3,
                      labelWidget: const InputLabel(label: 'Complemento'),
                    ),
                  ),
                ],
              ),
              Spacing.sm.vertical,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 7,
                    child: CustomInputField(
                      hintText: 'Nome da cidade',
                      initialValue: customer.address.city,
                      labelWidget: const InputLabel(label: 'Cidade'),
                    ),
                  ),
                  Spacing.sm.horizontal,
                  Expanded(
                    flex: 3,
                    child: CustomInputField(
                      hintText: 'UF',
                      initialValue: customer.address.state,
                      labelWidget: const InputLabel(label: 'UF'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
