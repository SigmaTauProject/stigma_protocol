/**
This class is what handles this application specifice networking.

This class will connect clients and send messages from those clents to back.
*/
module Network.NetworkListener;

import cst_;
import SocketMsgQueue : SocketMsgQueue;

import std.stdio;
import std.socket;

class NetworkListener {
	private {
		Socket	listener	;
		void delegate(Socket)	onConnectedCallback	;
	}
	
	this (string ip, void delegate(Socket) onConnectedCallback){
		this.onConnectedCallback = onConnectedCallback;
		//---listener
		{
			listener = new TcpSocket();
			listener.blocking = false;
			
			Address address;
			{
				string	justIp	;
				ushort	port	;
				{
					import std.algorithm : countUntil;
					
					size_t colonIndex = ip.countUntil(':');
					
					if (colonIndex == -1) {
						justIp	= ip	;
						port	= 128	;
					}
					else {
						import std.conv;
						justIp	= ip[0..colonIndex];
						auto portString	= ip[colonIndex+1..$];
						port	= portString.parse!ushort;
					}
				}
				address = parseAddress(justIp,port);
			}
			
			listener.bind(address);
			listener.listen(2);
		}
		//---
	}
	~this() {
		listener.shutdown(SocketShutdown.BOTH);
		listener.close();
	}
	
	void update() {
		again: {
			Socket connection;
			connection = listener.accept;
			if (connection.isAlive) {
				connection.isAlive.writeln;
				writefln("Console connected: %s", connection.remoteAddress);
				
				onConnectedCallback(connection);
				goto again;
			}
		}
	}
}
