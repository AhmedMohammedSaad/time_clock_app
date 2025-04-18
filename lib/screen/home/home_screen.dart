import 'dart:async';

import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';
import 'package:segment_display/segment_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum SingingCharacter { analogClock, digitalClock, textCock }

class _HomeScreenState extends State<HomeScreen> {
  SingingCharacter? _character = SingingCharacter.analogClock;
  double currentSliderValue1 = 50;
  double opacityDrawer = 1;
  void changeOpacity() {
    setState(() {
      opacityDrawer = 0;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        opacityDrawer = 1;
      });
    });
  }

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
  ];
  int borderColors = 0;
  Widget digitalClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });

    String hours = DateTime.now().hour.toString();
    String minutes = DateTime.now().minute.toString();
    String seconds = DateTime.now().second.toString();

    return SevenSegmentDisplay(
      size: currentSliderValue1 / 10,
      characterSpacing: 6.0,
      backgroundColor: Colors.transparent,
      segmentStyle: HexSegmentStyle(
        enabledColor: colors[borderColors],
        disabledColor: colors[borderColors].withOpacity(0.15),
      ),
      value: "$hours:$minutes:$seconds",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white.withOpacity(opacityDrawer),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blue.withOpacity(opacityDrawer),
              child: Row(
                spacing: 12,
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.access_time, color: Colors.white, size: 40),

                  Text(
                    "Setting",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              spacing: 12,
              children: [
                SizedBox(width: 15),
                Icon(Icons.access_alarm, color: Colors.black, size: 40),

                Text(
                  "Clock Type",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              spacing: 15,
              children: [
                Radio<SingingCharacter>(
                  value: SingingCharacter.analogClock,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      setState(() {
                        changeOpacity();
                      });
                    });
                  },
                ),
                Text(
                  "Analog Clock",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              spacing: 15,
              children: [
                Radio<SingingCharacter>(
                  value: SingingCharacter.digitalClock,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;

                      changeOpacity();
                    });
                  },
                ),
                Text(
                  "Digital Clock",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              spacing: 15,
              children: [
                Radio<SingingCharacter>(
                  value: SingingCharacter.textCock,
                  groupValue: _character,
                  onChanged: (SingingCharacter? value) {
                    setState(() {
                      _character = value;
                      changeOpacity();
                    });
                  },
                ),
                Text(
                  "Text Clock",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              spacing: 12,
              children: [
                SizedBox(width: 15),
                Icon(Icons.title_sharp),
                Text(
                  "Clock Size",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Slider(
              thumbColor: Colors.blue,
              activeColor: Colors.blue,
              inactiveColor: Colors.grey,
              value: currentSliderValue1,
              max: 100,
              divisions: 5,
              label: currentSliderValue1.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue1 = value;
                  changeOpacity();
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              spacing: 12,
              children: [
                SizedBox(width: 15),
                Icon(Icons.color_lens, size: 40, color: Colors.grey),
                Text(
                  "Color Clock",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      changeOpacity();
                      setState(() {
                        borderColors = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              borderColors == index
                                  ? Colors.black
                                  : const Color.fromARGB(0, 255, 255, 255),
                          width: 2,
                        ),
                        color: colors[index],
                      ),
                      margin: EdgeInsets.all(10),
                      width: 40,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Clock',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child:
            _character == SingingCharacter.analogClock
                ? AnalogClock(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: colors[borderColors]),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  width: currentSliderValue1 + 100,
                  isLive: true,
                  hourHandColor: colors[borderColors],
                  minuteHandColor: colors[borderColors],
                  showSecondHand: true,
                  numberColor: colors[borderColors],
                  showNumbers: true,
                  showAllNumbers: true,
                  textScaleFactor: 1.4,
                  showTicks: true,
                  showDigitalClock: true,
                  datetime: DateTime(2019, 1, 1, 9, 12, 15),
                )
                : _character == SingingCharacter.digitalClock
                ? digitalClock()
                : DigitalClock(
                  showSeconds: true,
                  isLive: true,
                  digitalClockTextColor: colors[borderColors],
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,

                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  datetime: DateTime.now(),
                ),
      ),
    );
  }
}
