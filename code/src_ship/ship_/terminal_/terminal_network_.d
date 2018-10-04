module ship_.terminal_.terminal_network_;

import std.experimental.logger;
import cst_;

import vibe.core.core : processEvents, sleep;
import vibe.http.fileserver : serveStaticFiles, HTTPFileServerSettings;
import vibe.http.router : URLRouter;
import vibe.http.server;
import vibe.http.websockets : WebSocket, handleWebSockets;

import std.algorithm.searching : endsWith;

import core.time;


class TerminalNetworkMaster {
	this() {
		void handleWebSocketConnection(scope WebSocket socket) {
			log("WebSocket connected");
			auto newTerminal  = new TerminalNetwork(socket);
			newTerminals ~= newTerminal;
			while (socket.connected) {
				sleep(1.seconds);
			}
			newTerminal._vibeSocketHandlerStillExists = false;
			log("WebSocket disconnected");
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
	auto getNewTerminals() {
		auto toReturn = newTerminals;
		newTerminals = [];
		return toReturn;
	}
}


////class TerminalNetwork {
////	this (WebSocket socket) {
////		this.socket = socket;
////		this.toMsg = new ToMsg(
////			(){
////				if (socket.dataAvailableForRead) {
////					enum bufferSize = 64;
////					ubyte[] buffer = new ubyte[bufferSize];
////					auto length = socket.read(buffer, IOMode.once);
////					while (length==buffer.length) {
////						buffer.length += bufferSize;
////						length += socket.read(buffer[$-bufferSize..$], IOMode.once);
////					}
////					return buffer[0..length];
////				}
////				return new ubyte[0];
////			},
////			(buffer=>buffer.length>0?buffer[0]:0)
////		);
////	}
////	private {
////		WebSocket socket	;
////		ToMsg	toMsg	;
////	}
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
////			if (current != null)
////				return false;
////			if (socket.dataAvailableForRead) {
////				current = socket.receiveBinary();
////				return false;
////			}
////			return true;
////		}
////		@property const(const(ubyte)[]) front() {
////			return current;
////		}
////		void popFront() {
////			assert(current!=null, "Empty not checked");
////			current = null;
////		}
////		private const(ubyte)[] current=null;
////	}
////	
////}
////
////
////class Network {
////	this (TCPConnection* socket) {
////		this.socket = socket;
////		this.toMsg = new ToMsg(
////			(){
////				if (socket.dataAvailableForRead) {
////					enum bufferSize = 64;
////					ubyte[] buffer = new ubyte[bufferSize];
////					auto length = socket.read(buffer, IOMode.once);
////					while (length==buffer.length) {
////						buffer.length += bufferSize;
////						length += socket.read(buffer[$-bufferSize..$], IOMode.once);
////					}
////					return buffer[0..length];
////				}
////				return new ubyte[0];
////			},
////			(buffer=>buffer.length>0?buffer[0]:0)
////		);
////	}
////	private {
////		TCPConnection*	socket	;
////		ToMsg	toMsg	;
////	}
////	
////	@property bool connected() {
////		return _vibeSocketHandlerStillExists && socket.connected;
////	}
////	bool _vibeSocketHandlerStillExists = true; // should only be changed by the vibe tcp connected handler function (`NetworkMaster.this.handleConnection`)
////	
////	//---Send
////	public {
////		void send(const(ubyte[]) msg) {
////			if (connected) {
////				socket.write(msg);
////			}
////		}
////		alias put = send;
////	}
////	
////	//---Receive
////	public {
////		@property bool empty() {
////			if (connected) {
////				return toMsg.empty;
////			}
////			return true;
////		}
////		@property const(const(ubyte)[]) front() {
////			return toMsg.front;
////		}
////		void popFront() {
////			return toMsg.popFront;
////		}
////	}
////	
////}
////


class TerminalNetwork {
	this (WebSocket socket) {
		this.socket = socket;
	}
	private WebSocket socket;
	
	@property bool connected() {
		return _vibeSocketHandlerStillExists && socket.connected;
	}
	bool _vibeSocketHandlerStillExists = true; // should only be changed by the vibe tcp connected handler function (`NetworkMaster.this.handleConnection`)
	
	//---Send
	public {
		void send(const(ubyte[]) msg) {
			if (connected) {
				socket.send(msg);
			}
		}
		alias put = send;
	}
		
	//---Receive
	public {
		@property bool empty() {
			if (current != null)
				return false;
			if (connected && socket.dataAvailableForRead) {
				try {
					current = socket.receiveBinary();
				}
				catch (Throwable e) {
					e.log;
					return true;
				}
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




