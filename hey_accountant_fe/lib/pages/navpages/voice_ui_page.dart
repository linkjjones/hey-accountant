import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:hey_accountant_fe/components/command_tile.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:hey_accountant_fe/businesslogic/node.dart';
import 'package:hey_accountant_fe/businesslogic/command_tree.dart';
import 'package:hey_accountant_fe/businesslogic/pair.dart';

class VoiceUIPage extends StatefulWidget {
  const VoiceUIPage({super.key});

  @override
  State<VoiceUIPage> createState() => _VoiceUIPageState();
}

class _VoiceUIPageState extends State<VoiceUIPage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;
  String _lastWords = "";
  Node currentNode = Node(children: [], command: "", keywords: "");
  final CommandTree _commandTree = CommandTree();

  late RestartableTimer _timer = RestartableTimer(const Duration(seconds: 2), _stopListening);

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // This has to happen only once per app
  // ignore: todo
  // TODO: If this page only render once, leave it
  //  but if it renderes on navigation, move it to main.dart
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    currentNode = _commandTree.currentNode;
    setState(() {});
  }

  // start a speech recognition session
  void _startListening() async {
    _timer.reset();
    await _speechToText.listen(onResult: _onSpeechResult);
    _lastWords = "";
  }

  // Manually stop the active speech recognition session
  // Note that there are also timeouts that each platform enforces
  // and the SpeechToText plugin supports setting timeouts on the
  // listen method.
  // since we can't tell when the platform will timeout
  // we'll just manually stop after a few seconds of inactivity
  // of result.recognizedWords
  void _stopListening() async {
    await _speechToText.stop();
    if(_timer.isActive) { _timer.cancel(); }
    // TODO:
    // If the current node has a command
    // run it and pass the remaining _lastWords
    setState(() {
      _isListening = false;
    });
  }

  // This is the callback that the SpeechToText plugin calls when
  // the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    // Pair<result.recognizedWords truncated or not, node 
    Pair<String, Node> node = _commandTree.findChildNodeByKeyword(result.recognizedWords, currentNode);
    currentNode = node.b;
    // TODO: update command buttons
    
    // Debug
    print("New current node: ${currentNode.keywords}");
    // get node.children to update UI command list
    setState(() {
      _lastWords = node.a;
    });
    _timer.reset();
  }

  void _listenToggle() async {
    if (_speechEnabled) {
      setState(() => _isListening = !_isListening);
      // _timer.reset();
      _isListening ? _startListening() : _stopListening();
    }
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
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
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
                        children: [
                          const Icon(
                            Icons.hearing,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            _lastWords,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    // Status
                    Text( _isListening ? "Listening..." : "",
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
          Align(
            alignment: Alignment.bottomCenter,
            child: 
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      spreadRadius: 0.0,
                    )
                  ],
                ),
                margin: const EdgeInsets.only(bottom: 22),
                child: ClipOval(
                  child: Material(
                    color: _isListening ? Colors.red : Colors.green,
                    child: InkWell(
                      onTap: _listenToggle,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          size: 33,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
