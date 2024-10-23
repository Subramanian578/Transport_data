import 'package:biometric_transport/Specific_stop_details.dart';
import 'package:biometric_transport/total_seats.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> busStops = [];
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    fetchBusStops();
  }

  Future<void> fetchBusStops() async {
    final response = await http.get(
      Uri.parse('http://192.168.119.202:3000?email=${widget.user.email}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      print('Bus stop data: $data');

      setState(() {
        busStops = data.map((stop) {
          List<dynamic> students = stop['students'] ?? [];
          int presentCount = students.length;
          int absentCount =
              students.where((student) => student['status'] == 0).length;

          return {
            "stop_name": stop['stop_name'],
            "bus_no": stop['bus_no'],
            "present_count": presentCount,
            "absent_count": absentCount,
          };
        }).toList();

        // Reset current step if it's out of range
        if (_currentStep >= busStops.length) {
          _currentStep = 0;
        }
      });
    } else {
      print('Failed to load bus stops. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 116, 247),
        title: Text(
          'Welcome ${widget.user.displayName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              widget.user.photoURL ?? "https://example.com/default-avatar.png",
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 114, 116, 247),
        unselectedItemColor: Colors.black54,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home_outlined),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.report_outlined),
            ),
            label: "Report",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Total_Seats(busNumber: busStops[0]['bus_no']),
                      ),
                    );
                  },
                  child: Container(
                    height: screenWidth * 0.3,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 114, 104, 200),
                          width: 2),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                busStops.isNotEmpty
                                    ? busStops[0]['bus_no']
                                    : "N/A",
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Bus-No",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          color: Colors.black54,
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "PR",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "- ${busStops.isNotEmpty ? busStops[0]['present_count'] : 0}",
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "AB",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "- ${busStops.isNotEmpty ? busStops[0]['absent_count'] : 0}",
                                    style: const TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              busStops.isNotEmpty
                  ? Stepper(
                      currentStep: _currentStep,
                      onStepTapped: (step) {
                        setState(() {
                          _currentStep = step;
                        });
                      },
                      steps: busStops.map((stop) {
                        return Step(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                stop['stop_name'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigate to Specific_Stop and pass the stop name and bus number
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SpecificStop(
                                        stopName: stop['stop_name'],
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 91, 94, 247)),
                                    color:
                                        const Color.fromRGBO(225, 222, 249, 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Center(
                                          child: Text(
                                              "${stop['present_count'] ?? 0}")),
                                      Container(
                                          width: 1,
                                          color: const Color.fromARGB(
                                              255, 91, 94, 247)),
                                      Center(
                                          child: Text(
                                              "${stop['absent_count'] ?? 0}")),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          content: const SizedBox(),
                        );
                      }).toList(),
                      controlsBuilder:
                          (BuildContext context, ControlsDetails controls) {
                        return Container();
                      },
                      type: StepperType.vertical,
                    )
                  : const Center(child: Text('No bus stops available.')),
            ],
          ),
        ),
      ),
    );
  }
}
