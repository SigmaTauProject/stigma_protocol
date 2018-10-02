
import std.socket;
import SocketMsgQueue : SocketMsgQueue;

import app;

class ClientHandler {
	Client[]	clients	=[];
	Client[]	lobbyClients	=[];
	World	world	;
	this (World world) {
		this.world	= world	;
	}
	void onClientConnected(Client client) {
		clients	~= client;
		lobbyClients	~= client;
	}
	void onClientConnected(Socket clientSocket) {
		this.onClientConnected(new Client(clientSocket));
	}
}
class Client {
	Socket	socket	;
	SocketMsgQueue	msgQueue	;
	this (Socket socket) {
		this.socket	= socket	;
		this.msgQueue	= new SocketMsgQueue(socket, (msg){if (msg.length<3) return 0; else return msg[3]+3;})	;
	}
}


