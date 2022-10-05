// To parse this JSON data, do
//
//     final node = nodeFromJson(jsonString);
// from: https://stackoverflow.com/questions/69469993/map-recursive-json-to-class-flutter

import 'dart:convert';

Node nodeFromJson(String str) => Node.fromJson(json.decode(str));
// Node.children.from(json.decode(str).map((x) => Node.fromJson(x)));

class Node {
  Node({
    required this.keywords,
    required this.command,
    required this.children,
  });

  String keywords;
  String? command;
  List<Node> children;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
    // Debug

    keywords: json["keywords"],
    // TODO: parse string command to Command
    command: json["command"],
    children: json["children"] == null
        ? []
        : List<Node>.from(json["children"].map((x) => Node.fromJson(x))),
  );
}
