import 'package:flutter/material.dart';
//import 'package:workhub_web/src/views/meetingRooms/meetingRoomsPage.dart';
import 'package:workhub_web/src/views/reservations/reservationsPage.dart';

import '../../controllers/auth/auth_controller.dart';
import '../meetingRooms/addMeetingRooms/addMeetingRoomPage.dart';
import '../meetingRooms/meeting_rooms_page.dart';
import '../reservations/reservationsCalendarPage.dart';
import '../desks/desk.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;

  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      builder: (context, snapshot) {
        return Scaffold(
          body: Row(
            children: <Widget>[
              // Sidebar
              NavigationRail(
                  backgroundColor: const Color.fromRGBO(55, 73, 87, 1),
                  selectedIndex: currentIndex,
                  onDestinationSelected: (int index) {
                    if (index == 4) {
                      AuthController().logout(context);
                    } else {
                      setState(() {
                        currentIndex = index;
                        pageController.jumpToPage(index);
                      });
                    }
                  },
                  labelType: NavigationRailLabelType.selected,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(
                        Icons.list_alt_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Reservas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.meeting_room, color: Colors.white),
                      label: Text(
                        'Salas de Reunião',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.chair, color: Colors.white),
                      label: Text(
                        'Mesas',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person, color: Colors.white),
                      label: Text(
                        'Perfil',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ]),
              const VerticalDivider(thickness: 1, width: 1),

              // Main content
              Expanded(
                child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ReservationsPage(pageController: pageController),
                      MeetingRoomsPage(),
                      Desks(),
                      Container(color: Colors.blue),
                      ReservationsCalendarPage(pageController: pageController),
                      AddMeetingRoomPage(pageController: pageController),
                    ]),
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToPage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }
}
