

export default class Socket {
	constructor() {
		this.connected	= false	;
		this._msgs	= []	;
		
		this._connect();
	}
	_connect() {
		console.log("[Socket]","Connecting...");
		this.socket = new WebSocket(_getURL());
		
		this.socket.onopen	= this._onOpen	;
		this.socket.onmessage	= this._onMsg	;
		this.socket.onclose	= this._onClose	;
		this.socket.onerror	= this._onError	;
	}
	
	getMsgs() {
		var msgs	= this._msgs	;
		this._msgs	= []	;
		return msgs;
	}
	close() {
		socket.close();
	}
	
	[Symbol.iterator]() {
		return this.getMsgs()[Symbol.iterator]();
	}
	
	_onMsg(msg) {
		this._msgs.push(msg);
	}
	_onOpen() {
		console.log("[Socket]","Connected");
		this.connected = true;
	}
	_onClose() {
		console.log("[Socket]","Disconnected");
		this.connected = false;
	}
	_orError(e) {
		console.log("[Socket]",e);
	}
	
}


function _getURL() {
	var baseURL;
	{
		let href = window.location.href.substring(7); // strip "http://"
		let idx = href.indexOf("/");
		baseURL = "ws://" + href.substring(0, idx);
	}
	return baseURL+"/ws";
}

