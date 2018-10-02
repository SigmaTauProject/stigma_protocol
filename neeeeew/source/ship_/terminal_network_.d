module ship_.terminal_network_;

import std.stdio;

import vibe.core.core : processEvents, sleep;
import vibe.core.log;
import vibe.http.fileserver : serveStaticFiles, HTTPFileServerSettings;
import vibe.http.router : URLRouter;
import vibe.http.server;
import vibe.http.websockets : WebSocket, handleWebSockets;

import std.algorithm.searching : endsWith;

import core.time;

class TerminalNetworkMaster {
	this() {
		void handleWebSocketConnection(scope WebSocket socket) {
			int counter = 0;
			logInfo("WebSocket connected");
			newTerminals ~= new TerminalNetwork(socket);
			while (socket.connected) {
				sleep(1.seconds);
			}
			logInfo("WebSocket disconnected");
		}
		void handleMIME(scope HTTPServerRequest req, scope HTTPServerResponse res, ref string physicalPath) {
			if (physicalPath.endsWith(".mjs")) {
				res.contentType = "application/javascript";
			}
		}
		void main() {
			auto settings = new HTTPServerSettings;
			settings.port = 8080;
			settings.bindAddresses = ["::1", "127.0.0.1"];
			
			auto router = new URLRouter;
			/////router.get("/", &handleRequest);
			
			router.get("/ws", handleWebSockets(&handleWebSocketConnection));
			
			auto fileServerSettings = new HTTPFileServerSettings;
			fileServerSettings.encodingFileExtension = ["gzip" : ".gz"];
			fileServerSettings.preWriteCallback = &handleMIME;
			router.get("/gzip/*", serveStaticFiles("./public/", fileServerSettings));
			router.get("*", serveStaticFiles("./public/", fileServerSettings));
			
			listenHTTP(settings, router);
			
			////runApplication();
		}
		main();
	}
	TerminalNetwork[] newTerminals = []; 
	auto update() {
		newTerminals = [];
		processEvents();
		return newTerminals;
	}
}


class TerminalNetwork {
	this (WebSocket socket) {
		this.socket = socket;
	}
	private WebSocket socket;
	
	@property bool connected() {
		return socket.connected;
	}
	//---Send
	public {
		void send(const(ubyte[]) msg) {
			socket.send(msg);
		}
		alias put = send;
	}
	
	//---Receive
	public {
		@property bool empty() {
			if (current != null)
				return false;
			if (socket.dataAvailableForRead) {
				current = socket.receiveBinary();
				return false;
			}
			return true;
		}
		@property const(const(ubyte)[]) front() {
			return current;
		}
		void popFront() {
			assert(current!=null, "Empty not checked");
			current = null;
		}
		private const(ubyte)[] current=null;
	}
	
}


////class TerminalNetwork {
////	this (WebSocket socket) {
////		this.socket = socket;
////	}
////	private WebSocket socket;
////	
////	@property bool connected() {
////		return socket.connected;
////	}
////	//---Send
////	public {
////		void send(const(ubyte[]) msg) {
////			socket.send(msg);
////		}
////		alias put = send;
////	}
////	
////	//---Receive
////	public {
////		@property bool empty() {
////			"empty".writeln(!socket.dataAvailableForRead);
////			if (current!=null) {
////				return true;
////			}
////			if (!socket.dataAvailableForRead) {
////				current = socket.receiveBinary();
////				return true;
////			}
////			return false;
////		}
////		@property const(const(ubyte)[]) front() {
////			"front".writeln(current);
////			return current;
////		}
////		void popFront() {
////			current=null;
////			empty;
////			"popFront".writeln(current);
////		}
////		private const(ubyte)[] current=null;
////	}
////	
////}




