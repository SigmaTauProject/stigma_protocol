

export default class TermCom {
	constructor(world, clientNetworkMaster) {
		this.world	= world	;
		this.clientNetworkMaster	= clientNetworkMaster	;
		this.allClients	= []	;
		
		let i = 0;
		this.components = ["metaRadar"].map(component=>{
			if (component == "metaRadar") {
				return new MetaRadar(i++, this.world, this.allClients);
			}
		});
	}
	init() {
	}
	update() {
		this.components.each(comp=>comp.update());
		for (let newClient of this.clientNetworkMaster.getNew()) {
			
		}
	}
	
	onConnected(client) {
		this.allClients.push(client);
		console.log("Connected");
		client.send("msg",{"component":-1,"type":"components",components:["metaRadar"]});
	}
	onDisconnected(client) {
		this.allClients.splice(client,1);
		console.log("Disconnected");
	}
}

class TermNetwork {
	constructor(clientNetwork) {
		this.clientNetwork	= clientNetwork	;
		this.msgQueue
	}
	send(msg) {
		
	}
	update() {
		if (!clientNetwork.connected) {
			return false;
		}
		return true;
	}
}




class MetaRadar {
	constructor(id,world,allClients) {
		this.world	= world	;
		this.id	= id	;
		this.allClients	= allClients	;
		this.type	= "metaRadar"	;
	}
	update() {
		var msg = {component:this.id,type:"update",us:convertEntity(this.world.us),entities:this.world.entities.each(convertEntity)};
		this.allClients.each(client=>{client.send("msg",msg);});
		
		function convertEntity(entity) {
			return {pos:entity.pos,rot:entity.rot};
		}
	}
}






