import 'package:flutter/material.dart';
import 'package:hey_accountant_fe/components/command_tile.dart';
import 'package:hey_accountant_fe/components/mic_button.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceUIPage extends StatefulWidget {
  const VoiceUIPage({super.key});

  @override
  State<VoiceUIPage> createState() => _VoiceUIPageState();
}

class _VoiceUIPageState extends State<VoiceUIPage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // This has to happen only once per app
  // TODO: move this up to main.dart
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  // start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  // Manually stop the active speech recognition session
  // Note that there are also timeouts that each platform enforces
  // and the SpeechToText plugin supports setting timeouts on the
  // listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  // This is the callback that the SpeechToText plugin calls when
  // the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
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
                              CommandTile(
                                commandKeyword: 'Hey Accountant',
                                matchesKeyword: true,
                              ),
                              CommandTile(
                                commandKeyword: 'what accounts...',
                                matchesKeyword: false,
                              ),
                              CommandTile(
                                commandKeyword: 'what goals...',
                                matchesKeyword: false,
                              ),
                              CommandTile(
                                commandKeyword: 'move...',
                                matchesKeyword: false,
                              ),
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
          const Align(
            alignment: Alignment.bottomRight,
            child: MicButton(),
          ),
        ],
      ),
    );
  }
}
