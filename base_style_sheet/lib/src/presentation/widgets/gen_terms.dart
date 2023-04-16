import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenTerms extends StatelessWidget {
  const GenTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '''TERMOS E CONDIÇÕES:''',
          textScaleFactor: 1.0,
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Última atualização: 03 de Outubro de 2022''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''1. RELACIONAMENTO CONTRATUAL''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Estes Termos de uso ("Termos") regem seu acesso e uso, como pessoa física e jurídica, dentro do Brasil, de aplicativos, sítios de Internet, conteúdos, bens e também serviços (os "Serviços") disponibilizados pela GENPAG Gestão e Serviços S. A., estabelecida no Brasil, com sede na Avenida Angélica, nº 2.261, Térreo, CEP: 01227-200, São Paulo/SP, inscrita no Cadastro Nacional de Pessoas Jurídicas do Ministério da Fazenda (CNPJ/ME) sob nº 37.606.428/0001-92 ("Genpag").''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''POR FAVOR, LEIA COM ATENÇÃO ESTES TERMOS ANTES DE ACESSAR OU USAR OS SERVIÇOS.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''AO SE TORNAR UM USUÁRIO DA "GENPAG" VOCÊ CONCORDA COM TODOS OS TERMOS E CONDIÇÕES CONSTANTES NA PÁGINA "TERMOS E CONDIÇÕES".''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''A GENPAG poderá imediatamente encerrar estes Termos ou quaisquer Serviços em relação a você (“Usuário”) ou, de modo geral, deixar de oferecer ou negar acesso aos Serviços ou a qualquer parte deles, a qualquer momento e por qualquer motivo. ''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''A continuidade no uso dos produtos e Serviços da GENPAG pelo Usuário após a entrada em vigor de nova versão revisada destes Termos implicará automaticamente a plena ciência e aceitação pelo Usuário de todos os seus termos e condições.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''A GENPAG poderá alterar os Termos relativos aos Serviços a qualquer momento. Aditamentos entrarão em vigor quando a GENPAG fizer a postagem da versão atualizada dos Termos neste local ou das condições atualizadas ou Termos adicionais sobre o respectivo Serviço, na qual deverão ser novamente aceitadas pelo Usuário. ''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Termos adicionais poderão se aplicar a determinados Serviços, tais como condições para um evento, atividade ou promoção em particular, e esses Termos adicionais serão divulgados em relação aos respectivos Serviços. Termos adicionais são complementares e considerados parte integrante destes Termos para os efeitos dos respectivos Serviços. Termos adicionais prevalecerão sobre estes Termos em caso de conflito com relação aos referidos Serviços.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Para ser registrado como Usuário da GENPAG, você deve ter no mínimo 18 (dezoito) anos, ser residente no Brasil e possuir cadastro ativo junto à Receita Federal do Brasil (Cadastro de Pessoa Física – CPF ou Cadastro Nacional de Pessoa Jurídica – CNPJ).''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''É parte integrante destes Termos, a Política de Privacidade da GENPAG, documento que informa aos titulares de dados pessoais os tratamentos de dados aos quais estarão sujeitos ao utilizarem os Serviços GENPAG e demonstra o compromisso da GENPAG em observar a Lei Geral de Proteção de Dados e outras leis e regulamentos relacionados ao tema. A Política de Privacidade se encontra disponível no endereço https://genpag.com.br/politica-de-privacidade.html.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''A GENPAG somente fornecerá dados e informações sobre dados de Usuários, transações e valores mediante expressa autorização judicial. Na ausência desta, a GENPAG se resguardará a analisar as solicitações quando necessárias para solucionar a reclamação, litígio ou conflito.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''VERIFICAÇÃO DE IDENTIDADE. Você autoriza a GENPAG, diretamente ou por meio de terceiros, a fazer todas as consultas e/ou solicitações que considerarmos necessárias para validar sua identidade, a obter seu relatório de crédito pessoal e/ou comercial junto a uma agência de crédito, incluindo, sem limitação, o SPC e/ou a SERASA, bem como se obriga a fornecer toda e qualquer informação solicitada pela GENPAG, para cumprimento das obrigações decorrentes da Lei n.º 9.613, de 3 de março de 1998, conforme alterada ("Lei de Lavagem de Dinheiro") e da Lei n.º 12.846, de 1 de agosto de 2013 ("Lei Anticorrupção"). Neste sentido, poderemos solicitar, sem limitação: I - que você apresente documentos ou informações adicionais, tais como número de telefone móvel válido no território nacional, II - que você siga alguns passos para confirmar que é o titular do e-mail ou instrumento financeiro informado quando de seu registro, III - a emissão de um relatório de crédito ou verificação de suas informações por meio de bancos de dados de terceiros ou de outras fontes, IV – Comprovantes de Endereços, incluindo também localização em tempo real, quando solicitado.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''2. OS SERVIÇOS''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Os Serviços integram uma plataforma de tecnologia que permite aos Usuários de aplicativos móveis ou sítios de Internet da GENPAG, fornecidos como parte dos Serviços (cada qual um "Aplicativo"), emissão de fatura para recebimentos através de boletos e cartões de créditos e/ou envio ou remessa de dinheiro entre usuários da GENPAG, mediante contrato com a GENPAG ou determinadas Afiliadas da GENPAG. ATRAVÉS DESTE FICA EXPRESSO QUE A GENPAG NÃO É UMA INSTITUIÇÃO FINANCEIRA, NÃO PRESTA NENHUM SERVIÇO FINANCEIRO E, NÃO SE EQUIPARA A BANCOS OU INSTITUIÇÕES FINANCEIRAS, E QUE TODOS ESSES SERVIÇOS DE EMISSÃO DE FATURAS DE COBRANÇAS SÃO PRESTADOS POR TERCEIROS INDEPENDENTES, QUE NÃO SÃO EMPREGADOS OU REPRESENTANTES DA GENPAG.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''LICENÇA. Sujeito ao cumprimento destes Termos, a GENPAG outorga a você uma licença limitada, não exclusiva, não passível de sublicença, revogável e não transferível para: I - acesso e uso dos Aplicativos em seu dispositivo pessoal, exclusivamente para o seu uso dos Serviços; e II - acesso e uso de qualquer conteúdo, informação e material correlato que possa ser disponibilizado por meio dos Serviços, em cada caso, para seu uso pessoal e comercial. Quaisquer direitos não expressamente outorgados por estes Termos são reservados à GENPAG e suas afiliadas licenciadoras.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''SERVIÇOS E CONTEÚDO DE TERCEIROS(AS). Os Serviços poderão ser disponibilizados e acessados em conexão com serviços e conteúdo de terceiros (as) (inclusive publicidade) que a GENPAG não controlará. VOCÊ RECONHECE QUE TERMOS DE USO E POLÍTICAS DE PRIVACIDADE DIFERENTES PODERÃO SER APLICÁVEIS AO USO DESSES SERVIÇOS E CONTEÚDO DE TERCEIROS(AS). A GENPAG NÃO ENDOSSA ESSES SERVIÇOS E CONTEÚDO DE TERCEIROS E A GENPAG NÃO SERÁ, EM HIPÓTESE ALGUMA, RESPONSÁVEL POR NENHUM PRODUTO OU SERVIÇO DESSESTERCEIROS FORNECEDORES. Além disto, Apple Inc., Google, Inc., Microsoft Corporation e/ou suas subsidiárias e afiliadas internacionais, poderão ter acesso à informações/dados cadastrais do Usuário, quando do uso do Serviço por aquelas plataformas, em caso de acesso aos Serviços usando aplicativos desenvolvidos para dispositivos móveis baseados em Apple iOS, Android, ou Microsoft Windows, respectivamente. Esses terceiros beneficiários não são partes destes Termos e não são responsáveis pela prestação dos Serviços ou por qualquer forma de suporte aos Serviços. Seu acesso aos Serviços usando esses dispositivos está sujeito às condições estabelecidas nos termos de serviços dos respectivos terceiros beneficiários.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''3. O USO DOS SERVIÇOS CONTAS DE USUÁRIOS.''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Para utilizar os Serviços disponibilizados pela GENPAG, deve-se, além do registro, a manter uma conta pessoal de usuário de Serviços ("Conta"). Você deve ter pelo menos 18 (dezoito) anos ou a maioridade exigida por lei em seu foro (se for diferente de 18 (dezoito) anos) para abrir uma Conta. Registro de Conta exige que você apresente à GENPAG certas informações pessoais, tais como seu nome, endereço, número de telefone celular e idade, assim como pelo menos um método de pagamento válido (cartão de crédito), dentre outras. Se você não mantiver informações corretas, completas e atualizadas em sua Conta, inclusive se o método de pagamento informado for inválido ou expirado, você poderá ficar impossibilitado de acessar e usar os Serviços. O USUÁRIO É RESPONSÁVEL POR TODAS AS ATIVIDADES REALIZADAS NA SUA CONTA E CONCORDA EM MANTER SEMPRE A SEGURANÇA E O SIGILO DO LOGIN E AUTENTICAÇÃO DA SUA CONTA.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''CONDUTA E OBRIGAÇÕES DO USUÁRIO. O Serviço não está disponível para uso para indivíduos menores de 18 (dezoito) anos. O Usuário não poderá autorizar terceiros a usar sua Conta, sendo portanto, de uso individual e incompartilhável. O Usuário não poderá ceder, nem de qualquer outro modo transferir, sua Conta a nenhuma outra pessoa ou entidade. O Usuário concorda em cumprir todas as leis aplicáveis quando usar os Serviços e que somente poderá usar os Serviços para finalidades legítimas. Em determinadas situações poderá ser solicitado ao Usuário, que forneça comprovante de identidade e de endereço para acessar ou usar os Serviços, e, em caso de negativa deste, poderá ter seu acesso ou uso dos Serviços NEGADO.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''EM NENHUMA HIPÓTESE A GENPAG AUTORIZA O USO DOS APLICATIVOS PARA ATIVIDADES ILÍCITAS, OU PARA TRANSAÇÕES COM INDÍCIOS DE PROBLEMAS OU FRAUDES. DESSA FORMA A QUALQUER MOMENTO, A GENPAG PODE VERIFICAR MAIS INFORMAÇÕES OU BLOQUEAR A CONTA QUE APRESENTAR SUSPEITA CONTRA AS LEGISLAÇÕES FISCAL, FINANCEIRA, CIVIL E PENAL VIGENTES. A qualquer tempo o usuário autoriza a GENPAG, diretamente ou por meio de terceiros, a fazer todas as consultas e/ ou solicitações que considerarmos necessárias para validar sua identidade e informações. Neste sentido poderemos solicitar: I - que o Usuário apresente documentos ou informações adicionais, II – seu número de CPF/CNPJ, III - que o Usuário siga alguns passos para confirmar que é o titular do e-mail ou instrumento(s) financeiro(s) informado(s), IV - a emissão de um relatório de crédito ou verificação de suas informações por meio de bancos de dados de terceiros ou de outras fontes, V - informações e documentos relacionados a transação comercial entre o Usuário e seu cliente, incluindo, sem limitação, contratos de serviços, notas fiscais ou comprovantes de entrega dos produtos ou serviços; VI – realização de contato direto com os clientes tomadores dos serviços do Usuário para validar as informações prestadas pelo Usuário. Autorização de relatório de crédito. O Usuário autoriza a GENPAG a obter seu relatório de crédito pessoal e/ou comercial junto a um sistema de crédito como, dentre outros, o SPC e a SERASA. Além disso, o Usuário autoriza a GENPAG a obter seu relatório de crédito pessoal e/ou comercial. Caso a GENPAG identifique a qualquer tempo que o cadastro esteja com informações incorretas ou desatualizadas, poderá suspender o acesso do Usuário ao Serviço até que as pendências cadastrais identificadas sejam regularizadas.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''O Usuário terá a opção de antecipar os recebíveis da venda, de acordo com as taxas e tarifas cobradas pela GENPAG. A GENPAG se reserva o direito de cancelar a funcionalidade de emissão de cobranças via cartão de crédito caso avalie que o Usuário está usando a plataforma de forma indevida, bem como caso avalie que o Usuário tem alto índice de "chargeback". Em caso de "chargeback", o valor total da cobrança será debitado do saldo da conta do favorecido na GENPAG, podendo o saldo ficar negativo caso não haja o montante suficiente. Além disso, o Usuário estará sujeito às demais sanções civis e penais previstas em lei.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''A GENPAG reserva-se o direito de entrar em contato com clientes finais e/ou solicitar documentos para confirmação da prestação do serviço ou venda do produto (contrato, notas fiscais, entre outros), independente de suspeita de fraudes ou infração. A GENPAG reserva-se o direito de reter os valores advindos dos pagamentos de cobranças emitidas pelo Usuário para fins de verificação de inconformidades, possíveis fraudes e crime de lavagem de dinheiro, observando-se a legislação pátria vigente, resoluções do CMN e Banco Central do Brasil, congelando-se o numerário pelo período de 180 (cento e oitenta) dias, podendo renovar-se por igual período, a contar do envio de documentos essenciais pelo Usuário, solicitados pela GENPAG, com intuito de averiguação e liberação das quantias retidas, NÃO RESPONDENDO A GENPAG POR NENHUM TIPO DE PERDAS E DANOS RELATIVOS AO PRAZO ESTIPULADO ACIMA.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''O Usuário obriga-se a tomar todas as precauções necessárias a fim de evitar que terceiros utilizem o Serviço em seu nome. O Usuário se responsabiliza pelas transações comerciais feitos em seu nome por terceiros, ainda que sem sua autorização, caso esses terceiros tenham, sem culpa exclusiva da GENPAG, tido acesso ao login e autenticação, de forma a realizar em nome do Usuário quaisquer transações comerciais, pagamentos ou movimentações. O Usuário não poderá ter mais de uma Conta sob sua titularidade ao mesmo tempo. A GENPAG reserva-se o direito de cancelar as Contas excedentes do Usuário, juntamente com os respectivos dados de cadastro, logins e autenticações excedentes, de forma a assegurar que, nos termos destes Termos, o Usuário mantenha ativo apenas uma única Conta. Não é permitido ao Usuário informar o mesmo endereço de e-mail, número de telefone celular, CPF ou CNPJ de Usuário já cadastrado, ou informar outros dados que indiquem que o Usuário já está cadastrado como Usuário junto à GENPAG.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''O usuário autoriza expressamente que o seu cadastramento seja feito e mantido pela GENPAG, bem como a autoriza a fornecer as informações constantes de referido cadastro I- à autoridades públicas competentes que as solicitarem formalmente, nos termos da Constituição Federal brasileira e demais legislações aplicáveis, entre eles mas a tanto não se limitando, Banco Central do Brasil (BACEN) e do Conselho de Controle de Atividades Financeiras (COAF) e II - à seus parceiros estratégicos, comerciais ou técnicos, com a finalidade de disponibilizar melhores conteúdos e/ou serviços ao usuário, III - ao terceiro prejudicado nos casos de descumprimento do presente termo de serviços, bem como quando ocorrer suspeita de fraude, má-fé na utilização dos Serviços entre outros.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''O Usuário declara expressamente e concorda que a GENPAG colete informações para realização de acompanhamento de tráfego, com intuito de identificar grupos de perfis de Usuários e para fins de orientação publicitária.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''CONTEÚDO FORNECIDO PELO USUÁRIO. A GENPAG poderá, a seu exclusivo critério, permitir que você ou qualquer pessoa apresente, carregue, publique ou, de qualquer modo, disponibilize para a GENPAG por meio dos Serviços, conteúdo e informações de texto, áudio ou vídeo, inclusive comentários e feedbacks relacionados aos Serviços, iniciação de solicitação de suporte (“Conteúdo de Usuário”). Qualquer Conteúdo de Usuário fornecido por você permanece de sua propriedade. Contudo, ao fornecer Conteúdo de Usuário para a GENPAG, você outorga uma licença em nível mundial, perpétua, irrevogável, transferível, isenta de royalties, e com direito a sublicenciar, usar, copiar, modificar, criar obras derivadas, distribuir, publicar, exibir, executar em público e, de qualquer outro modo, explorar esse Conteúdo de Usuário em todos os formatos e canais de distribuição hoje conhecidos ou desenvolvidos no futuro (inclusive em conexão com os Serviços e com os negócios da GENPAG e em sites e serviços de terceiros), sem ulterior aviso a você ou seu consentimento, e sem necessidade de pagamento a você ou a qualquer outra pessoa ou entidade.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''ACESSO À REDE E EQUIPAMENTOS. O Usuário é responsável por obter o acesso a rede de dados necessário para usar os Serviços. As taxas e encargos de sua rede de dados e mensagens poderão se aplicar se você acessar ou usar os Serviços de um dispositivo sem fio e você será responsável por essas taxas e encargos. Você é responsável por adquirir e atualizar os equipamentos e dispositivos necessários para acessar e usar os Serviços e Aplicativos e quaisquer de suas atualizações. A GENPAG NÃO GARANTE QUE OS SERVIÇOS, OU QUALQUER PARTE DELES, FUNCIONARÃO EM QUALQUER EQUIPAMENTO OU DISPOSITIVO EM PARTICULAR. Além disso, os Serviços poderão estar sujeitos a mau funcionamento, falhas e atrasos inerentes ao uso da Internet e de comunicações eletrônicas.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''4. PAGAMENTO''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''VERIFICAÇÃO DE CARTÃO CADASTRADO JUNTO À GENPAG COMO MEIO DE PAGAMENTO. Para confirmar que o cartão indicado NO REGISTRO pertence de fato ao Usuário, a GENPAG pode solicitar a sua verificação. Essa verificação é realizada por meio da cobrança provisória de um valor aleatório no cartão do Usuário, que pode chegar a até R\$ 5,00 (cinco reais). Com a cobrança realizada no cartão de crédito, ao receber sua fatura do cartão de crédito, o Usuário deve observar o valor que foi cobrado e informá-lo em seu registro no website ou aplicativo da GENPAG. Se os dados conferirem, a Conta do Usuário passa a ter o status de “Cartão Verificado para Pagamentos” e o valor cobrado pela GENPAG para realizar a verificação é devolvido ao Usuário no próprio cartão.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Pela contraprestação do Serviço, o Usuário pagará à GENPAG, percentual sobre o valor da transação comercial ou taxas fixas de acordo com o produto adquirido, conforme tabela de consultas, pelo cliente do Usuário cujos preços deverão ser consultados diretamente no aplicativo, podendo haver a cobrança de taxas em casos de pagamento parcelado dependendo da modalidade e do meio de pagamento escolhido, conforme as disposições do presente constante dentro do próprio aplicativo, no menu de configurações "Taxas e Valores".''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''PARA AS TRANSAÇÕES REALIZADAS VIA CARTÃO DE CRÉDITO, OS CRÉDITOS DAS VENDAS DESTES SERVIÇOS SERÃO CREDITADOS NA CONTA DO USUÁRIO NO PRAZO DE 02 (DOIS) DIAS – PLANO D+2 - OU DE 30 (TRINTA) DIAS APÓS A CONFIRMAÇÃO DE PAGAMENTO, À DEPENDER DO PLANO OPTADO PELO USUÁRIO ANTES DE REALIZAR A TRANSAÇÃO.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Em caso de contestação do titular do cartão crédito junto ao banco emissor (“Chargeback”) eventual valor estornado será de responsabilidade exclusiva do Usuário sendo automaticamente estornado de sua conta mantida junto a GENPAG. Em caso de o “Chargeback” ser liberado para pagamento, os valores serão liberados para a usuário tão logo ocorra o pagamento à GENPAG pelo banco emissor.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''As taxas referentes aos custos de boletos somente serão cobradas do usuário na ocorrência da liquidação/pagamento do mesmo. Para transferência dos valores recebidos através da plataforma disponibilizada pela GENPAG, via Transferência Eletrônica Disponível à instituição bancária pertencente ao Usuário, é estritamente necessário que a conta bancária informada seja da mesma Titularidade (CPF ou CNPJ) do cadastro constante na plataforma GENPAG.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''5. LIMITAÇÃO DE RESPONSABILIDADE; INDENIZAÇÃO.''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''LIMITAÇÃO DE RESPONSABILIDADE. A GENPAG não será responsável por qualquer tipo de danos, inclusive lucros cessantes, perda de dados, danos morais ou patrimoniais relacionados, associados ou decorrentes de qualquer uso dos Serviços. A GENPAG não será responsável por nenhum dano, obrigação ou prejuízo decorrente do: I - uso dos Serviços por parte do Usuário, mesmo que utilizados de forma lícita; ou II - qualquer operação ou relacionamento entre Usuário e qualquer prestador terceiro. A GENPAG não será responsável por atrasos ou falhas decorrentes de causas fora do controle razoável da GENPAG e, tampouco, pela qualidade e integridade dos bens disponibilizados por prestadores terceiros.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Você concorda em manter a GENPAG isenta de responsabilidade por todas e quaisquer reclamações, cobranças, prejuízos, responsabilidades e despesas (inclusive honorários advocatícios) decorrentes ou relacionados: I - ao uso dos Serviços, de serviços ou bens obtidos por meio do uso dos Serviços; II - descumprimento ou violação de qualquer disposição destes Termos;''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''6. LEGISLAÇÃO APLICÁVEL; JURISDIÇÃO. ELEIÇÃO DO FORO.''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Ao entrar em contato conosco e/ou utilizar os Serviços GENPAG, a GENPAG poderá realizar tratamentos de seus dados pessoais (por exemplo, coleta de dados para verificação de identidade do usuário, dados de cadastro para cadastro na GENPAG, dados de IP, verificação de dados de seu cartão de crédito, verificação do Conteúdo do Usuário postado).''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Para informações sobre o uso de seus dados pessoais, favor verificar os termos da Política de Privacidade, que se encontra disponível no endereço https://genpag.com.br/politica-de-privacidade.html.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''7. LEGISLAÇÃO APLICÁVEL; JURISDIÇÃO. ELEIÇÃO DO FORO.''',
            textScaleFactor: 1.0,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          child: Text(
            '''Estes Termos serão regidos e interpretados exclusivamente de acordo com as leis do Brasil. Qualquer reclamação, conflito ou controvérsia que surgir destes Termos ou a eles relacionada, inclusive que diga respeito a sua validade, interpretação ou exequibilidade, será solucionada exclusivamente pelos tribunais do foro de domicílio do usuário.''',
            textScaleFactor: 1.0,
            textAlign: TextAlign.justify,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
