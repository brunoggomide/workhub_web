import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/meetingRooms/addMeetingRooms/components/add_meeting_room_form.dart';

class AddMeetingRoomPage extends StatelessWidget {
  final PageController pageController;

  const AddMeetingRoomPage({Key? key, required this.pageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              'Adicionar Sala de Reunião',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            AddMeetingRoomForm(),
          ],
        ),
      ),
    );
  }
}
