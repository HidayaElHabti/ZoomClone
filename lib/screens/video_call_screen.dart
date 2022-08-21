import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:zoom_clone/resources/auth_methods.dart';
import 'package:zoom_clone/resources/jitsi_meet_methods.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController roomIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  bool isAudioMuted = true;
  bool isVideoMuted = true;
  @override
  void initState() {
    roomIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    roomIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
        roomName: roomIdController.text,
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
        name: nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: backgroundColor,
          title: const Text(
            'Join a Meeting',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: roomIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Room ID',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Join',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )),
          ),
          const SizedBox(height: 20),
          MeetingOption(
            text: 'Turn off My Audio',
            isMute: isAudioMuted,
            onChange: onAudioChange,
          ),
          MeetingOption(
            text: 'Turn off My Video',
            isMute: isVideoMuted,
            onChange: onVideoChange,
          ),
        ]));
  }

  onAudioChange(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  onVideoChange(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }
}
