import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickblox_sdk/models/qb_ice_server.dart';
import 'package:quickblox_sdk/models/qb_rtc_session.dart';
import 'package:quickblox_sdk/quickblox_sdk.dart';
import 'package:quickblox_sdk/webrtc/constants.dart';
import 'package:quickblox_sdk/webrtc/rtc_video_view.dart';

import '../../utils/dialog_utils.dart';
import '../../utils/snackbar_utils.dart';

class VideoCall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WebRTCScreenState();
}

class _WebRTCScreenState extends State<VideoCall> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _sessionId;

  RTCVideoViewController? _localVideoViewController;
  RTCVideoViewController? _remoteVideoViewController;

  bool _isVideoCall = true;

  StreamSubscription? _callSubscription;
  StreamSubscription? _callEndSubscription;
  StreamSubscription? _rejectSubscription;
  StreamSubscription? _acceptSubscription;
  StreamSubscription? _hangUpSubscription;
  StreamSubscription? _videoTrackSubscription;
  StreamSubscription? _notAnswerSubscription;
  StreamSubscription? _peerConnectionSubscription;
  StreamSubscription? _reconnectionSubscription;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void dispose() {
    super.dispose();
    _unsubscribeEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(),
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: [
                  _buildButton('init WebRTC', () => _initWebRTC()),
                  _buildButton('release WebRTC', () => _releaseWebRTC()),
                  _buildButton('release Video Views', () => _releaseVideoViews()),
                  _buildButton('get WebRTC session', () => _getCallSession()),
                  _buildButton('make video call', () {
                    _createCall(QBRTCSessionTypes.VIDEO);
                    setState(() => _isVideoCall = true);
                  }),
                  _buildButton('make audio call', () {
                    _createCall(QBRTCSessionTypes.AUDIO);
                    setState(() => _isVideoCall = false);
                  }),
                  _buildButton('hangup call', () => _hangUpCall()),
                  _buildButton('disable video', () => _enableVideo(false)),
                  _buildButton('enable video', () => _enableVideo(true)),
                  _buildButton('disable audio', () => _enableAudio(false)),
                  _buildButton('enable audio', () => _enableAudio(true)),
                  _buildButton('switch camera', () => _switchCamera()),
                  _buildButton('mirror camera', () => _mirrorCamera()),


                  Container(margin: EdgeInsets.all(20.0), height: 1, width: double.maxFinite, color: Colors.grey),
                  Visibility(
                      visible: _isVideoCall,
                      child: OrientationBuilder(builder: (context, orientation) {
                        Alignment localVideoViewAlignment = orientation == Orientation.landscape
                            ? const FractionalOffset(0.5, 0.1)
                            : const FractionalOffset(0.0, 0.5);

                        Alignment remoteVideoViewAlignment = orientation == Orientation.landscape
                            ? const FractionalOffset(0.5, 0.5)
                            : const FractionalOffset(1.0, 0.5);

                        return Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Stack(children: <Widget>[
                              _buildVideoView(localVideoViewAlignment, (controller) => _localVideoViewController = controller),
                              _buildVideoView(remoteVideoViewAlignment, (controller) => _remoteVideoViewController = controller)
                            ]));
                      }))
                ]))));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        title: const Text('WebRTC'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()));
  }

  Widget _buildButton(String title, Function? callback) {
    return MaterialButton(
        minWidth: 200,
        child: Text(title),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () => callback?.call());
  }

  Widget _buildVideoView(Alignment alignment, Function(RTCVideoViewController) callback) {
    return Align(
        alignment: alignment,
        child: Container(
            margin: EdgeInsets.all(10.0),
            width: 160.0,
            height: 160.0,
            child: RTCVideoView(onVideoViewCreated: callback),
            decoration: BoxDecoration(color: Colors.black54)));
  }

  Future<void> _initWebRTC() async {
    try {
      await QB.webrtc.init();
      SnackBarUtils.showResult(_scaffoldKey, "WebRTC was initiated");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
      debugPrint(e.message);
    }
  }

  Future<void> _setRTCConfigs() async {
    try {
      await QB.rtcConfig.setAnswerTimeInterval(10);
      await QB.rtcConfig.setDialingTimeInterval(15);
      SnackBarUtils.showResult(_scaffoldKey, "RTCConfig was set success");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _getRTCConfigs() async {
    try {
      int? answerInterval = await QB.rtcConfig.getAnswerTimeInterval();
      int? dialingInterval = await QB.rtcConfig.getDialingTimeInterval();
      SnackBarUtils.showResult(_scaffoldKey,
          "RTCConfig was loaded success  \n Answer Interval: $answerInterval \n Dialing Interval: $dialingInterval");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _setIceServers() async {
    List<QBIceServer> servers = [];

    servers.add(_buildIceServer("stun:stun.l.google.com:19302", "", ""));
    servers.add(_buildIceServer("stun:turn.quickblox.com", "quickblox", "baccb97ba2d92d71e26eb9886da5f1e0"));
    servers.add(
        _buildIceServer("turn:turn.quickblox.com:3478?transport=tcp", "quickblox", "baccb97ba2d92d71e26eb9886da5f1e0"));
    servers.add(
        _buildIceServer("turn:turn.quickblox.com:3478?transport=udp", "quickblox", "baccb97ba2d92d71e26eb9886da5f1e0"));

    try {
      await QB.rtcConfig.setIceServers(servers);
      SnackBarUtils.showResult(_scaffoldKey, "Ice Servers were set success. Amount: ${servers.length}");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _setReconnectionTimeInterval() async {
    try {
      var INTERVAL_60_SECONDS = 60;
      await QB.rtcConfig.setReconnectionTimeInterval(INTERVAL_60_SECONDS);
      SnackBarUtils.showResult(
          _scaffoldKey, "Reconnection time interval was set success. Amount: $INTERVAL_60_SECONDS");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _getReconnectionTimeInterval() async {
    try {
      int? reconnectionInterval = await QB.rtcConfig.getReconnectionTimeInterval();
      SnackBarUtils.showResult(_scaffoldKey, "Reconnection time interval was loaded. Amount: \n$reconnectionInterval");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  QBIceServer _buildIceServer(String url, String? userName, String? password) {
    QBIceServer iceServer = QBIceServer();

    iceServer.url = url;
    iceServer.userName = userName;
    iceServer.password = password;

    return iceServer;
  }

  Future<void> _getIceServers() async {
    try {
      List<QBIceServer> servers = await QB.rtcConfig.getIceServers();
      SnackBarUtils.showResult(_scaffoldKey, "Ice Servers were loaded. Amount: ${servers.length}");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _releaseWebRTC() async {
    try {
      await QB.webrtc.release();
      _sessionId = null;
      SnackBarUtils.showResult(_scaffoldKey, "WebRTC was released");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _releaseVideoViews() async {
    try {
      await _localVideoViewController?.release();
      await _remoteVideoViewController?.release();
      SnackBarUtils.showResult(_scaffoldKey, "Video Views were released");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _getCallSession() async {
    try {
      QBRTCSession? session = await QB.webrtc.getSession(_sessionId!);
      _sessionId = session?.id;
      SnackBarUtils.showResult(_scaffoldKey, "The session with id $_sessionId was loaded");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _createCall(int sessionType) async {
    bool notGrantedPermissions = !await _checkPermissions();
    if (notGrantedPermissions) {
      if(!context.mounted)return;
      DialogUtils.showOneBtn(context, "There are not granted permissions");
      return;
    }

    try {
      List<int> opponentIds = [138975535, 138975537];
      QBRTCSession? session = await QB.webrtc.call(opponentIds, sessionType);
      _sessionId = session?.id;
      SnackBarUtils.showResult(_scaffoldKey, "The call was initiated for session id: $_sessionId");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _acceptCall(String sessionId) async {
    try {
      QBRTCSession? session = await QB.webrtc.accept(sessionId);
      SnackBarUtils.showResult(_scaffoldKey, "Session with id: ${session?.id} was accepted");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _rejectCall(String sessionId) async {
    try {
      QBRTCSession? session = await QB.webrtc.reject(sessionId);
      SnackBarUtils.showResult(_scaffoldKey, "Session with id: ${session?.id} was rejected");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _hangUpCall() async {
    try {
      QBRTCSession? session = await QB.webrtc.hangUp(_sessionId!);
      SnackBarUtils.showResult(_scaffoldKey, "Session with id: ${session?.id} was hang up");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _enableVideo(bool enable) async {
    try {
      await QB.webrtc.enableVideo(_sessionId!, enable: enable);
      SnackBarUtils.showResult(_scaffoldKey, "The video was enable $enable");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _enableAudio(bool enable) async {
    try {
      await QB.webrtc.enableAudio(_sessionId!, enable: enable);
      SnackBarUtils.showResult(_scaffoldKey, "The audio was enable $enable");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _switchCamera() async {
    try {
      await QB.webrtc.switchCamera(_sessionId!);
      SnackBarUtils.showResult(_scaffoldKey, "Camera was switched");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _switchAudioOutputToBluetooth() async {
    bool notHasPermissions = !await _checkPermissions();
    if (notHasPermissions) {
      DialogUtils.showOneBtn(context, "There are not permissions");
      return;
    }

    try {
      await QB.webrtc.switchAudioOutput(QBRTCAudioOutputTypes.BLUETOOTH);
      SnackBarUtils.showResult(_scaffoldKey, "Audio was switched");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<bool> _checkPermissions() async {
    bool cameraDenied = await Permission.camera.status.isDenied;
   // bool microphoneDenied = await Permission.microphone.status.isDenied;
   // bool bluetoothDenied = Platform.isAndroid ? await Permission.bluetoothConnect.status.isDenied : false;

    bool isAllPermissionsGranted = true;

    if (cameraDenied ) {
      Map<Permission, PermissionStatus> statuses =
      await [Permission.bluetoothConnect, Permission.camera, Permission.microphone].request();

      statuses.forEach((key, value) {
        if (value == PermissionStatus.denied || value == PermissionStatus.permanentlyDenied) {
          isAllPermissionsGranted = false;
        }
      });
    }

    return isAllPermissionsGranted;
  }

  Future<void> _mirrorCamera() async {
    try {
      await QB.webrtc.mirrorCamera(138975535, true);
      SnackBarUtils.showResult(_scaffoldKey, "Camera was switched");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _switchAudioOutput(int output) async {
    try {
      await QB.webrtc.switchAudioOutput(output);
      SnackBarUtils.showResult(_scaffoldKey, "Audio was switched");
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  String _parsePeerConnectionState(int state) {
    String parsedState = "";

    switch (state) {
      case QBRTCPeerConnectionStates.NEW:
        parsedState = "NEW";
        break;
      case QBRTCPeerConnectionStates.FAILED:
        parsedState = "FAILED";
        break;
      case QBRTCPeerConnectionStates.DISCONNECTED:
        parsedState = "DISCONNECTED";
        break;
      case QBRTCPeerConnectionStates.CLOSED:
        parsedState = "CLOSED";
        break;
      case QBRTCPeerConnectionStates.CONNECTED:
        parsedState = "CONNECTED";
        break;
    }

    return parsedState;
  }

  String _parseReconnectionState(int state) {
    String parsedState = "";

    switch (state) {
      case QBRTCReconnectionStates.RECONNECTING:
        parsedState = "RECONNECTING";
        break;
      case QBRTCReconnectionStates.RECONNECTED:
        parsedState = "RECONNECTED";
        break;
      case QBRTCReconnectionStates.FAILED:
        parsedState = "FAILED";
        break;
    }

    return parsedState;
  }

  Future<void> _startRenderingLocal() async {
    try {
      await _localVideoViewController?.play(_sessionId!, 138975535);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _startRenderingRemote(int opponentId) async {
    try {
      await _remoteVideoViewController?.play(_sessionId!, opponentId);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeCall() async {
    if (_callSubscription != null) {
      SnackBarUtils.showResult(_scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.CALL);
      return;
    }

    try {
      _callSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.CALL, (data) {
        Map<dynamic, dynamic> payloadMap = Map<dynamic, dynamic>.from(data["payload"]);
        Map<dynamic, dynamic> sessionMap = Map<dynamic, dynamic>.from(payloadMap["session"]);

        String sessionId = sessionMap["id"];
        _sessionId = sessionId;

        setState(() {
          int callType = sessionMap["type"];
          if (callType == QBRTCSessionTypes.AUDIO) {
            _isVideoCall = false;
          } else {
            _isVideoCall = true;
          }
        });

        String callType = _isVideoCall ? "Video" : "Audio";
        int userId = sessionMap["initiatorId"];
        DialogUtils.showTwoBtn(context, "The INCOMING $callType call from user $userId", () {
          _acceptCall(sessionId);
        }, () {
          _rejectCall(sessionId);
        });
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.CALL);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeCallEnd() async {
    if (_callEndSubscription != null) {
      SnackBarUtils.showResult(_scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.CALL_END);
      return;
    }
    try {
      _callEndSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.CALL_END, (data) {
        Map<dynamic, dynamic> payloadMap = Map<dynamic, dynamic>.from(data["payload"]);
        Map<dynamic, dynamic> sessionMap = Map<dynamic, dynamic>.from(payloadMap["session"]);

        String sessionId = sessionMap["id"];
        SnackBarUtils.showResult(_scaffoldKey, "The call with sessionId $sessionId was ended");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.CALL_END);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeVideoTrack() async {
    if (_videoTrackSubscription != null) {
      SnackBarUtils.showResult(
          _scaffoldKey, "You already have a subscription for:" + QBRTCEventTypes.RECEIVED_VIDEO_TRACK);
      return;
    }

    try {
      _videoTrackSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.RECEIVED_VIDEO_TRACK, (data) {
        Map<dynamic, dynamic> payloadMap = Map<dynamic, dynamic>.from(data["payload"]);

        int opponentId = payloadMap["userId"];
        if (opponentId == 138975535) {
          _startRenderingLocal();
        } else {
          _startRenderingRemote(opponentId);
        }
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.RECEIVED_VIDEO_TRACK);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeNotAnswer() async {
    if (_notAnswerSubscription != null) {
      SnackBarUtils.showResult(_scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.NOT_ANSWER);
      return;
    }

    try {
      _notAnswerSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.NOT_ANSWER, (data) {
        int userId = data["payload"]["userId"];
        DialogUtils.showOneBtn(context, "The user $userId is not answer");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.NOT_ANSWER);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeReject() async {
    if (_rejectSubscription != null) {
      SnackBarUtils.showResult(_scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.REJECT);
      return;
    }

    try {
      _rejectSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.REJECT, (data) {
        int userId = data["payload"]["userId"];
        DialogUtils.showOneBtn(context, "The user $userId was rejected your call");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.REJECT);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeAccept() async {
    if (_acceptSubscription != null) {
      SnackBarUtils.showResult(_scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.ACCEPT);
      return;
    }

    try {
      _acceptSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.ACCEPT, (data) {
        int userId = data["payload"]["userId"];
        SnackBarUtils.showResult(_scaffoldKey, "The user $userId was accepted your call");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.ACCEPT);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeHangUp() async {
    if (_hangUpSubscription != null) {
      SnackBarUtils.showResult(_scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.HANG_UP);
      return;
    }

    try {
      _hangUpSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.HANG_UP, (data) {
        int userId = data["payload"]["userId"];
        DialogUtils.showOneBtn(context, "the user $userId is hang up");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.HANG_UP);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribePeerConnection() async {
    if (_peerConnectionSubscription != null) {
      SnackBarUtils.showResult(
          _scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.PEER_CONNECTION_STATE_CHANGED);
      return;
    }

    try {
      _peerConnectionSubscription =
      await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.PEER_CONNECTION_STATE_CHANGED, (data) {
        int state = data["payload"]["state"];
        String parsedState = _parsePeerConnectionState(state);
        SnackBarUtils.showResult(_scaffoldKey, "PeerConnection state: $parsedState");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.PEER_CONNECTION_STATE_CHANGED);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  Future<void> _subscribeReconnection() async {
    if (_reconnectionSubscription != null) {
      SnackBarUtils.showResult(
          _scaffoldKey, "You already have a subscription for: " + QBRTCEventTypes.PEER_CONNECTION_STATE_CHANGED);
      return;
    }

    try {
      _reconnectionSubscription = await QB.webrtc.subscribeRTCEvent(QBRTCEventTypes.RECONNECTION_STATE_CHANGED, (data) {
        int state = data["payload"]["state"];
        String parsedState = _parseReconnectionState(state);
        SnackBarUtils.showResult(_scaffoldKey, "Reconnection state: $parsedState");
      });
      SnackBarUtils.showResult(_scaffoldKey, "Subscribed: " + QBRTCEventTypes.RECONNECTION_STATE_CHANGED);
    } on PlatformException catch (e) {
      if(!context.mounted)return;
      DialogUtils.showError(context, e);
    }
  }

  void _subscribeEvents() {
    _subscribeCall();
    _subscribeCallEnd();
    _subscribeReject();
    _subscribeAccept();
    _subscribeHangUp();
    _subscribeVideoTrack();
    _subscribeNotAnswer();
    _subscribePeerConnection();
    _subscribeReconnection();
  }

  void _unsubscribeEvents() {
    _callSubscription?.cancel();
    _callSubscription = null;

    _callEndSubscription?.cancel();
    _callEndSubscription = null;

    _rejectSubscription?.cancel();
    _rejectSubscription = null;

    _acceptSubscription?.cancel();
    _acceptSubscription = null;

    _hangUpSubscription?.cancel();
    _hangUpSubscription = null;

    _videoTrackSubscription?.cancel();
    _videoTrackSubscription = null;

    _notAnswerSubscription?.cancel();
    _notAnswerSubscription = null;

    _peerConnectionSubscription?.cancel();
    _peerConnectionSubscription = null;

    _reconnectionSubscription?.cancel();
    _reconnectionSubscription = null;
  }
}