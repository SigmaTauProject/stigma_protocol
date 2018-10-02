/**
This class is what handles this application specifice networking.

This class will connect clients and send messages from those clents to back.
*/
module Network;

import cst_;
import SocketMsgQueue : SocketMsgQueue;

import std.stdio;
import std.socket;

import Network.NetworkListener : NetworkListener;

class Connection {
	SocketMsgQueue msgQueue;
}


class Network {
	private {
		NetworkListener networkListener;
	}
	
	this (string ip){
		networkListener = new NetworkListener(ip, &this.onConnected);
	}
	~this() {
	}
	
	void update() {
		networkListener.update;
	}
	
	void onConnected(Socket client) {
	}
}
