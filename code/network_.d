module galactic_.network_;

import std.experimental.logger;

import vibe.core.core : sleep;
import vibe.core.net;

import core.time;
import std.socket;

import cst_;

class NetworkMaster {
	this() {
		void handleConnection(TCPConnection socket) {
			int counter = 0;
			log("Socket connected");
			newNetworks ~= new Network(new MySocket((){ubyte[] dst;socket.read(dst);return dst;}, (ubyte[] msg){socket.write(msg);}, ()=>socket.connected));
			while (socket.connected) {
				sleep(1.seconds);
			}
			log("Socket disconnected");
		}
		void main() {
			listeners = listenTCP(1000, &handleConnection);
			listeners.log;
		}
		main();
	}
	auto update() {
		auto toReturn = newNetworks;
		newNetworks = [];
		return toReturn;
	}
	 
	private {
		TCPListener[]	listeners	;
		Network[]	newNetworks	= []	; 
	}
}

class MySocket {
	this(ubyte[] delegate() read, void delegate(ubyte[]) write, bool delegate() connected) {
		this._read	= read	;
		this._write	= write	;
		this._connected	= connected	;
	}
	ubyte[] read() {
		return this._read();
	}
	void write(ubyte[] data) {
		return this._write(data);
	}
	@property bool connected() {
		return this._connected();
	}
	private {
		ubyte[] delegate()	_read	;
		void delegate(ubyte[])	_write	;
		bool delegate()	_connected	;
	}
}

class Network {
	this (MySocket socket) {
		this.socket = socket;
		this.toMsg = new ToMsg(&socket.read, buffer=>buffer.length>0?buffer[0]:0);
	}
	private {
		MySocket	socket;
		ToMsg	toMsg;
	}
	
	@property bool connected() {
		return socket.connected;
	}
	//---Send
	public {
		void send(ubyte[] msg) {
			socket.write(msg);
		}
		alias put = send;
	}
	
	//---Receive
	public {
		@property bool empty() {
			return toMsg.empty;
		}
		@property const(const(ubyte)[]) front() {
			return toMsg.front;
		}
		void popFront() {
			return toMsg.popFront;
		}
	}
	
}


class ToMsg {
	this(ubyte[] delegate() read, ptrdiff_t delegate(ubyte[]) getMsgLen) {
		this.read	= read	;
		this.getMsgLen	= getMsgLen	;
	}
	
	
	@property bool empty() {
		buffer ~= this.read();
		
		for (ptrdiff_t msgLen=getMsgLen(buffer); msgLen>0; msgLen=getMsgLen(buffer)) {
			if (msgLen>buffer.length) {
				break;
			}
			msgs ~= buffer[0..msgLen];
		}
		return msgs.length==0;
	}
	@property const(const(ubyte)[]) front() {
		return msgs[0];
	}
	void popFront() {
		msgs = msgs[1..$];
	}
	
	private {
		ubyte[] delegate()	read	;
		ptrdiff_t delegate(ubyte[])	getMsgLen	;
		
		ubyte[]	buffer	;
		ubyte[][]	msgs	;
	}
}


