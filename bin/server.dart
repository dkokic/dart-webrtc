import "dart:io";
import "dart:async";
import "package:dart_webrtc/filehandler.dart";
import "package:dart_webrtc/websockethandler.dart";

var bindAddress = "0.0.0.0";
var port = 1337;
var webSocketContextPath = "/ws";
FileHandler fileHandler = new FileHandler();
WebSocketHandler webSocketHandler = new WebSocketHandler();

void main() {
  print("main(): Binding HttpServer on ${bindAddress}:${port} ...");
  HttpServer.bind(bindAddress, port).then((HttpServer server) {
    print("main(): HttpServer listening for connections at ${server.address}, port ${server.port}");
    server.listen((request) { 
      handleRequest(request);
    });
  });
}

void handleRequest(HttpRequest request) {
  var path = request.uri.path;
  if(path.contains(webSocketContextPath))
    webSocketHandler.handleRequest(request);
  else
    fileHandler.handleRequest(request);
}
