import express	from "express"	;
import http	from "http"	;
import socket_io	from "socket.io"	;

var expressApp	= express();
var httpServer	= http.createServer(expressApp);
var socketIO = socket_io(httpServer);

expressApp.use(express.static("client"));





import * as _ from "./loose/each.mjs";
import vec from "./glVec2/vec.mjs";
global.vec = vec;





{
	class ClientNetwork {
		constructor(socket) {
			this.socket = socket;
		}
		on(...args) {
			this.socket.on(...args);
		}
		send(...args) {
			this.socket.emit(...args);
		}
	}
	
	var connections	= [];
	socketIO.sockets.on("connection", (socket)=>{
		var controller = new ClientNetwork(socket);
		connections.push(controller);
		socket.on("disconnect", ()=>{
			network.onDisconnected(controller);
			connections.splice(controller,1);
		});
		network.onConnected(controller);
	});
}













httpServer.listen(process.env.PORT || 8080);



