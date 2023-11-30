
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrimonial_ai/Home/views/match.dart';
import 'package:matrimonial_ai/utils/SharePref.dart';
import 'package:matrimonial_ai/utils/snackbar_utils.dart';
import 'package:quickblox_sdk/chat/constants.dart';
import 'package:quickblox_sdk/models/qb_attachment.dart';
import 'package:quickblox_sdk/models/qb_dialog.dart';
import 'package:quickblox_sdk/models/qb_filter.dart';
import 'package:quickblox_sdk/models/qb_message.dart';
import 'package:quickblox_sdk/models/qb_sort.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import '../../model/content.dart';
import '../../routes/app_pages.dart';


class ChatController extends GetxController {

  RxInt selectedItem = 1.obs;
  Rx<Color> statusbarcolor = Colors.white.obs;
  final ScrollController scrollController = ScrollController();
   Rx<int> senderId = 0.obs;

  @override
  void onInit() {

    debugPrint("init called ");
    isConnectedToServer();
    newMessageSubscription();
    connectSubscription();
    createDialogForChat();

    super.onInit();




  }

  /*------------  Quick blox chat Functionality -----------------------------------------------------------------------*/
  String _dialogId = "";
  RxList<QBMessage?> messages = <QBMessage>[].obs;
  StreamSubscription? connectedSubscription;
  StreamSubscription? newMsgSbs;
  String event = QBChatEvents.CONNECTED;
  String newMessageEvent = QBChatEvents.RECEIVED_NEW_MESSAGE;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void onReady() {
    super.onReady();
    SharedPref().getQbId().then((value) => senderId.value =value);


  }

  void isConnectedToServer() async{
    try {
      bool? connected = await QB.chat.isConnected();
      SnackBarUtils.showResult(_scaffoldKey, connected.toString());
      if(!connected!){
        SharedPref().getQbId().then((value)async {
          await QB.chat.connect(value, "12345678");

        });
      }

    } on PlatformException catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }
  void disConnectToServer() async{
    try {
      bool? connected = await QB.chat.isConnected();
      if(!connected!){
        await QB.chat.disconnect();
      }

    } on PlatformException catch (e) {
      // Some error occurred, look at the exception message for more details
    }
  }

 void connectSubscription() async{
    try {
      connectedSubscription = await QB.chat.subscribeChatEvent(event, (data) {
        debugPrint(data.toString());
        SnackBarUtils.showResult(_scaffoldKey, "Chat Connected");
      });
          } on PlatformException catch (e) {
        SnackBarUtils.showResult(_scaffoldKey, e.message!);
      }


  }

  void newMessageSubscription() async{
    try {
      newMsgSbs = await QB.chat.subscribeChatEvent(newMessageEvent, (data) {

        Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(data);
        Map<dynamic, dynamic> payload = Map<dynamic, dynamic>.from(map["payload"]);
        String? messageId = payload["id"];
        QBMessage qbMessage =  QBMessage();
        qbMessage.body = payload["body"];
        qbMessage.dialogId = payload["dialogId"];
        qbMessage.dateSent = payload["dateSent"];
        qbMessage.senderId = payload["senderId"];
        qbMessage.recipientId = payload["recipientId"];
        messages.value.add(qbMessage);
        messages.refresh();


        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 500),
          );
        });




        debugPrint(payload["body"]);
        debugPrint(qbMessage.body);
        debugPrint(map.toString());
       // debugPrint(payload.toString());

      });
    } on PlatformException catch (e) {
      SnackBarUtils.showResult(_scaffoldKey, e.message!);
    }
  }


  void sendMessage(String message) async{

    List<QBAttachment>? attachments = [];
    Map<String, String>? properties = {};
    bool markable = false;
    String dateSent = "2000-023T01:23:45.678+09:00";
    bool saveToHistory = true;

    try {

      debugPrint("dialog id "+_dialogId);
      await QB.chat.sendMessage(_dialogId, body: message, attachments: attachments, properties: properties, markable: markable, saveToHistory: saveToHistory);
      debugPrint("send ");

    } on PlatformException catch (e) {
      debugPrint(e.message);
      SnackBarUtils.showResult(_scaffoldKey, e.message!);
    }
  }


  void getChatHistory() async{

    QBSort sort = QBSort();
    sort.field = QBChatMessageSorts.DATE_SENT;
    sort.ascending = false;

    QBFilter filter = QBFilter();
    filter.field = QBChatMessageFilterFields.ID;
    filter.operator = QBChatMessageFilterOperators.IN;

    int limit = 100;
    int skip = 50;
    bool markAsRead = true;
   debugPrint("chat"+_dialogId);
    try {
        await QB.chat.getDialogMessages(_dialogId).then((value) => messages.value = value.where((element) => element!=null).map((e) => e!).toList());


        if (scrollController.hasClients) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if(scrollController.positions.isNotEmpty){
              scrollController?.jumpTo(scrollController.position.maxScrollExtent);

            }
          });
        }


        debugPrint(messages.length.toString());
     

    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

  void createDialogForChat() async {
    List<int> ids = [138975535, 138975537];
    String dialogName = "test dialog";
    int type = QBChatDialogTypes.CHAT;
    debugPrint("create dialog");
    try {
      QBDialog? createdDialog = await QB.chat.createDialog(type,occupantsIds: ids,dialogName: dialogName);
      if(createdDialog != null) {
         _dialogId = createdDialog.id!;


       // await QB.chat.joinDialog(_dialogId);
         debugPrint("innf"+createdDialog!.name!);

         getChatHistory();
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }

@override
  void onClose() {
    super.onClose();
    connectedSubscription?.cancel();
    disConnectToServer();
  }


  String datetimeFormat(int milli){
    var dt = DateTime.fromMillisecondsSinceEpoch(milli);

    var date = DateFormat('hh:mm a').format(dt);
    return date;
  }


}
