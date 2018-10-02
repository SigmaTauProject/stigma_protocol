/**
SocketMsgQueue takes a TCP socket; recieves and converts the buffer to individual mesages.
*/


module SocketMsgQueue	;

import cst_;
import queue	;

import core.thread	;
import core.atomic	;
import std.socket	;



class SocketMsgQueue {
	private {
		Socket socket	;
		Queue!(ubyte[]) queue	;
		
		MsgThread msgThread;
		
		shared bool _closed = false;
	}
	
	this(Socket socket, ptrdiff_t function(ubyte[]) getMsgLength) {
		this.socket	= socket	;
		this.queue	= new Queue!(ubyte[])	;
				
		this.msgThread	= new MsgThread(socket, queue, _closed, getMsgLength)	;

		socket.blocking = true;
		
		msgThread.start();
	}
	
	public @property bool closed() {
		return _closed.atomicLoad;
	}
	
	auto empty()	{ return queue.empty	;	}
	auto popFront()	{ return queue.popFront	;	}
	auto front()	{ return queue.front	;	}
}

private class MsgThread : Thread {
	private:
	
	public this(Socket socket, Queue!(ubyte[]) queue, ref shared bool _closed, ptrdiff_t function(ubyte[]) getMsgLength) {
		this.socket	= socket	;
		this.queue	= queue	;
		this._closed	= &_closed	;
		
		this.getMsgLength = getMsgLength;
		
		super(&run);
	}
	
	Socket	socket	;
	Queue!(ubyte[])	queue	;
	shared bool*	_closed	;
	
	ptrdiff_t function(ubyte[]) getMsgLength;
	
	ubyte[258]	buffer	;// 258 = 255+3  (max msg size (ubyte) plus header)
	ubyte[]	partialMsg	;
	uint	readLength	;// The current length of the read data.
	
	private void run() {
		ptrdiff_t msgLength = 0;
		while (true) {
			import core.time : msecs;
			Thread.sleep(msecs(60));
			
			ptrdiff_t length = socket.receive(buffer[readLength..$]);
			if (length==0 || length==Socket.ERROR) {
				(*_closed).atomicStore(true); 
				return;
			}
			////readLength += length;
			////import std.math : min;
			partialMsg ~= buffer[0..length];
			
			if (msgLength==0) {
				msgLength=getMsgLength(partialMsg);
				if (msgLength==0) {
					continue;
				}
			}
			if (partialMsg.length >= msgLength) {
				queue.put(partialMsg[0..partialMsg[0]+3]);
				partialMsg = partialMsg[partialMsg[0]+3..$];
			}
		}
	}
	
}




