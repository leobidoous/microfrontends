import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import './widgets/bank_card.dart';
import '../../../../open_banking.dart';
import '../../../domain/entities/Institution_entity.dart';
import '../../controllers/institution/institution_controller.dart';
    
class InstitutionListPage extends StatefulWidget {
  const InstitutionListPage({Key? key}) : super(key: key);

  @override
  _InstitutionListPageState createState() => _InstitutionListPageState();
}

class _InstitutionListPageState extends State<InstitutionListPage> {

  final institutionController = DM.i.get<InstitutionController>();
  final searchIntController = TextEditingController();

  @override
  void initState() {
    super.initState();
    institutionController.fetchBankList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open Banking',
           style: context.textTheme.bodyMedium?.copyWith(
            fontFamily: 'Inter',
            fontWeight: context.textTheme.fontWeightMedium,
          ),
        ),
        centerTitle: true,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: Nav.to.canPop(),
        backgroundColor: context.colorScheme.background,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            AppThemeBase.shadowLightmodeLevel6,
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: const Spacing(2).value,
            left: const Spacing(3).value,
            right: const Spacing(3).value,
          ),
          child: Column(
            children: [
              Text(
                'A sua transformação financeira começa agora',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: context.textTheme.fontWeightBold,
                ),
                textAlign: TextAlign.start,
              ),
              Spacing.xs.vertical,
              Text(
                'Escolha de quais bancos você quer trazer seus dados',
                 style: context.textTheme.labelLarge?.copyWith(
                  color: context.colorScheme.surfaceTint,
                  fontWeight: context.textTheme.fontWeightRegular,
                ),
                textAlign: TextAlign.start,
              ),
              ValueListenableBuilder<List<InstitutionEntity>>(
                valueListenable: institutionController,
                builder: (_, state, child) {
                  if(institutionController.isLoading) {
                    return const Expanded(
                      child: Center(
                        child: CustomLoading(),
                      ),
                    );
                  } else if(institutionController.hasError) {
                    return _emptyList(
                      'Não foi possível executar a ação',
                    );
                  } 
                  return _intitutionList();
                },
              ), 
            ],
          ),
        ),
      ),
    );
  }

   Widget _intitutionList() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: const Spacing(2).value,
              left: const Spacing(0.1).value,
              right: const Spacing(0.1).value,
            ),
            child: SizedBox(
              height: const Spacing(4.5).value.responsiveHeight,
              child: DecoratedBox(  
                decoration: BoxDecoration(  
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  border: Border.all(
                    width: 0.5,
                    color: context.colorScheme.outlineVariant,
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(  
                    prefixIcon: Icon(
                      CoreIcons.search,
                      size: const Spacing(2).value,
                    ),
                    suffixIcon: ValueListenableBuilder(
                      valueListenable: searchIntController,
                      builder: (_, state, child) {
                        if(searchIntController.value.text != '') {
                          return InkWell(
                            onTap: () {
                              searchIntController.text = '';
                              institutionController.clenSearchInput();
                            },
                            child: Icon(
                              CoreIcons.block,
                              size: const Spacing(1.5).value,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    hintText: 'Pesquisar',
                    hintStyle: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.outlineVariant,
                      fontWeight: context.textTheme.fontWeightLight,
                    ),
                    border: InputBorder.none,
                  ),
                  style: context.textTheme.bodyLarge?.copyWith(
                    decorationThickness: 0,
                    fontWeight: context.textTheme.fontWeightLight,
                  ),
                  onChanged: (value) {
                    institutionController.getBankByName(value);
                  },  
                  controller: searchIntController,
                ),
              ),
            ),
          ),
          ValueListenableBuilder<List<InstitutionEntity>>(
            valueListenable: institutionController.bankList,
            builder: (_, state, child) {
              if(state.isNotEmpty) return _loadedInstitutionList(state);
              return _emptyList('Nenhum banco encontrado');
            },
          ),
        ],
      ),
    );
  }

  Widget _loadedInstitutionList(
    List<InstitutionEntity> state,
    ) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.length,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(
          top: const Spacing(2).value,
          left: const Spacing(0.1).value,
          right: const Spacing(0.1).value,
        ),
        itemBuilder: (context, index) {
          Map institution =  {
            'countryCode': state[index].countryCode,
            'displayName': state[index].displayName,
            'iconLogo': state[index].iconLogo,
            'id': state[index].id,
            'logo': state[index].logo,
            'name': state[index].name,
            'primaryColor': state[index].primaryColor,
            'resources': state[index].resources,
            'status': state[index].status,
            'textLogo': state[index].textLogo,
            'type': state[index].type,
            'website': state[index].website
          };
          return BankCard(
            onTap: () => Nav.to.pushNamed(
              OpenBankingRoutes.institutionSelected.relativePath,
              arguments: {
                'institution': institution,
              },
            ),
            institution: institution,
          );
        },
      ),
    );
  }

  Widget _emptyList(String text) {
    return Expanded(
      child: Center(
        child: Text(text),
      ),
    );
  }
}