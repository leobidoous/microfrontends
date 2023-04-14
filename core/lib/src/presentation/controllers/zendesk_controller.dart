import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:zendesk_plugin/zendesk_plugin.dart';

import '../../../core.dart';


class ZendeskController extends GenController<Exception, Unit> {
  String accountKey = 'K457leoABsblsi1iIY7KkDCJEg7L3A3i';
  String appId = '53bf4ca71c3dc1c3d2c13f0c47516fb5d878ef97f5a76106';

  final SessionEntity session;

  ZendeskController({required this.session}) : super(unit) {
    initZendesk();
  }

  Future<void> initZendesk() async {
    await Zendesk.initialize(accountKey, appId);
  }

  Future<void> openChat() async {
    var name = session.customer.name;
    var email = session.customer.email;
    var phoneNumber = session.customer.phone;
    var department = 'Support';

    try {
      await Zendesk.setVisitorInfo(
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        department: department,
      );
      await Zendesk.startChat(
        titlePage: 'Chat com a Gen',
        isPreChatFormEnabled: false,
        isAgentAvailabilityEnabled: false,
        isChatTranscriptPromptEnabled: true,
        isOfflineFormEnabled: true,
      );
    } on Exception catch (ex) {
      debugPrint('Error in Zendesk.setVisitorInfo: $ex');
    }
  }
}
