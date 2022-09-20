import 'package:flutter/material.dart';
import 'package:hey_accountant_fe/util/command_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.question_mark,
              color: Color.fromARGB(255, 115, 115, 115),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(Icons.hearing, color: Colors.blue), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            // greetings row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // push items to the outside
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // Hi Jeff!
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi, Jeff',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '16 Sep 2022',
                            style: TextStyle(color: Colors.blue[200]),
                          ),
                        ],
                      ),

                      // Profile
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(Icons.person, color: Colors.white),
                      )
                    ],
                  ),

                  // create some space
                  const SizedBox(
                    height: 25,
                  ),

                  // listening bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.hearing,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          'Hey Accountant what',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // Status
                  const Text(
                    "Listening...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // Received / Possible commands
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(25),
                color: Colors.blue[600],
                child: Center(
                  child: Column(
                    children: [
                      // Commands list view
                      Expanded(
                        child: ListView(
                          children: const [
                            CommandTile(commandKeyword: 'Hey Accountant', matchesKeyword: true, ),                           
                            CommandTile(commandKeyword: 'what accounts...', matchesKeyword: false, ),                           
                            CommandTile(commandKeyword: 'what goals...', matchesKeyword: false, ),                           
                            CommandTile(commandKeyword: 'move...', matchesKeyword: false, ),                           
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
