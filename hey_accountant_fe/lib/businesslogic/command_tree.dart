import 'package:flutter/services.dart';
import 'package:hey_accountant_fe/models/node.dart';
import 'package:hey_accountant_fe/utils/constants.dart';
import 'package:hey_accountant_fe/utils/pair.dart';
import 'dart:convert';

class CommandTree {
  late Node currentNode;
  late Node rootNode;

  CommandTree() {
    init();
  }

  // create the root node
  init() async {
    String jsonRootNode = await rootBundle.loadString(JSON_COMMAND_PATH);
    rootNode = nodeFromJson(jsonRootNode) as Node;
    currentNode = rootNode;
  }

  reset() {
    currentNode = rootNode;
  }

  Pair<String, Node> moveToChildNodeByKeyword(String text, Node fromNode) {
    Pair<String, Node> output = Pair(text, fromNode);
    // Only continue if fromNode.Command is NULL
    if (fromNode.command != null) {
      // we have reached the command, so exit
      output = Pair(text, currentNode);
    } else {
      // restart command entry command
      if (text.contains('start over')) {
        reset();
        output = Pair(text, currentNode);
      } else {
        // check if any of the words in text match keywords
        // if so, then make matching node the current node
        // and return the text front-truncated
        int cutoffPlace = 0;
        currentNode.children.forEach((node) {
          node.keywords.split(",").forEach((keyword) {
            cutoffPlace = text.indexOf(keyword);
            if (cutoffPlace > -1) {
              // set the currentNode to the matched child
              // if its not the same node
              if (currentNode != node) {
                currentNode = node;
                // only return text after the keyword
                output = Pair(text.substring(cutoffPlace + keyword.length), node);
              }
            }
          });
        });
      }
    }

    return output;
  }
}
