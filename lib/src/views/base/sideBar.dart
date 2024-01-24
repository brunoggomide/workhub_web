import 'package:flutter/material.dart';
import 'package:workhub_web/src/views/base/meetingRooms/meetingRoomsPage.dart';

import '../../controllers/auth/auth_controller.dart';

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
                    setState(() {
                      currentIndex = index;
                      pageController.jumpToPage(index);
                    });
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
                  ]),
              VerticalDivider(thickness: 1, width: 1),

              // Main content
              Expanded(
                child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(color: Colors.blue),
                      MeetingRoomsPage(),
                      Container(color: Colors.blue),
                      Container(color: Colors.green),
                    ]),
              ),
            ],
          ),
        );
      },
    );
  }
}
