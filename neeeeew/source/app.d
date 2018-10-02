import game_	:	Game	;

void main() {
	Game game = new Game;
}






















////////import vibe.appmain;
////import vibe.d;
////
////import vibe.core.core : sleep;
////import vibe.core.log;
////import vibe.http.fileserver : serveStaticFiles;
////import vibe.http.router : URLRouter;
////import vibe.http.server;
////import vibe.http.websockets : WebSocket, handleWebSockets;
////
////import core.time;
////import std.conv : to;
////
////////void handleRequest(scope HTTPServerRequest req, scope HTTPServerResponse res)
////////{
////////	res.redirect("/index.html");
////////}
////
////void main() {
////	auto settings = new HTTPServerSettings;
////	settings.port = 8080;
////	settings.bindAddresses = ["::1", "127.0.0.1"];
////	
////	auto router = new URLRouter;
////	/////router.get("/", &handleRequest);
////	auto fileServerSettings = new HTTPFileServerSettings;
////	fileServerSettings.encodingFileExtension = ["gzip" : ".gz"];
////	router.get("/gzip/*", serveStaticFiles("./public/", fileServerSettings));
////	router.get("/ws", handleWebSockets(&handleWebSocketConnection));
////	router.get("*", serveStaticFiles("./public/",));
////	
////	listenHTTP(settings, router);
////	
////	runApplication();
////}
////
////void handleWebSocketConnection(scope WebSocket socket) {
////	int counter = 0;
////	logInfo("Got new web socket connection.");
////	while (true) {
////		sleep(1.seconds);
////		if (!socket.connected) break;
////		counter++;
////		logInfo("Sending '%s'.", counter);
////		socket.send(counter.to!string);
////	}
////	logInfo("Client disconnected.");
////}
