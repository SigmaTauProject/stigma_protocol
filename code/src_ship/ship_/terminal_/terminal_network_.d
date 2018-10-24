module ship_.terminal_.terminal_network_;
import commonImports;

import vibe.core.core : processEvents, sleep;
import vibe.http.fileserver : serveStaticFiles, HTTPFileServerSettings;
import vibe.http.router : URLRouter;
import vibe.http.server;
import vibe.http.websockets : WebSocket, handleWebSockets;

import core.time;


class TerminalNetworkMaster {
	this() {
		void handleWebSocketConnection(scope WebSocket socket) {
			log("WebSocket connected");
			auto newTerminal  = new TerminalNetwork(socket);
			newTerminals ~= newTerminal;
			while (newTerminal._keepVibeSocketHandlerAlive) {
				sleep(1_000.msecs);
			}
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
			////settings.bindAddresses = ["::1", "127.0.0.1","10.0.0.12"];
			
			auto router = new URLRouter;
			/////router.get("/", &handleRequest);
			
			router.get("/ws", handleWebSockets(&handleWebSocketConnection));
			
			auto fileServerSettings = new HTTPFileServerSettings;
			fileServerSettings.encodingFileExtension = ["gzip" : ".gz"];
			fileServerSettings.preWriteCallback = &handleMIME;
			router.get("/gzip/*", serveStaticFiles("./public/terminal", fileServerSettings));
			router.get("*", serveStaticFiles("./public/terminal", fileServerSettings));
			
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


class TerminalNetwork {
	this (WebSocket socket) {
		this.socket = socket;
	}
	private WebSocket socket;
	
	@property bool connected() {
		if (_keepVibeSocketHandlerAlive) {
			bool c = socket.connected;
			if (!c) _keepVibeSocketHandlerAlive = false;
			return c;
		}
		return false;
	}
	bool _keepVibeSocketHandlerAlive = true; // set to false when we are done, used in `NetworkMaster.this.handleConnection`
	
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







