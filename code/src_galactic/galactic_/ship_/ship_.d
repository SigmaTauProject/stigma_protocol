module galactic_.ship_.ship_;
import commonImports;

import loose_.sleep_;
import core.time;

import galactic_.flat_world_	.world_	:	World	;
import galactic_.flat_world_	.entity_	:	Entity	;
import galactic_.network_	.network_	:	Network	;

import std.range	:	array	;

class Ship {
	this(World world, Network network) {
		this.world	= world	;
		this.network	= network	;
	}
	void update() {
		//---Get msgs
		{
			import galactic_msg_.up_;
			foreach (unknownMsg; network.map!(msgData=>UnknownMsg(msgData))) {
				final switch (unknownMsg.type) {
					case MsgType.chVel:
						auto msg = ChVelMsg(unknownMsg);
						msg.vel.log(msg.anv);
						break;
				}
			}
		}
		//---Send msgs
		{
			/*	Here we send msgs to the ship client to update its world.
				This does not get updated when entities get added or removed.
				    I chose not to have msgs sent because it was causing to much
				    spider webed communication.  The world logic needs to be able
				    to work without thinking about networking.
				The world.entities garantees that entities added will be added to
				    the end, thus garanteeing that world.entities will not get reordered.
				    Entities also have a `inWorld` property that gets set to false when
				    it is removed.
				We keep an array of what the ship client sees (and the ids attached
				    each entity).  (`syncedEntities` and `entityIds`)
				This allows a great algorithm which avoids exesive recursions of
				    either array.  We can loop through our array updating the client
				    while checking if the entity is remove.  We then know that the
				    entities we have are in world.entities and we also know they are
				    in the same order and at the beginning.  Thus, any entity in
				    `world.entities` after our last entity is a new entity.
			*/
			import galactic_msg_.down_;
			//---Update entities synced with cliend (update/remove)
			foreach_reverse (i, entity; syncedEntities) {
				if (!entity.getInWorld) {
					//---Send Remove Msg to client
					{
						auto msg = RemoveMsg();
						msg.id	= entityIds[i]	;
						network.send(msg);
					}
					//---Remove reference
					{
						syncedEntities	= syncedEntities	.remove(i);
						entityIds	= entityIds	.remove(i);
					}
				}
				else {
					//---Send Update Msg to client
					auto msg = UpdateMsg();
					msg.id	= entityIds[i]	;
					msg.pos	= entity.getPos	;
					msg.ori	= entity.getOri	;
					network.send(msg);
				}
			}
			//---Add new entities
			Entity[] newEntities =	syncedEntities.length>0
				? world.entities.find(syncedEntities[$-1])[1..$]
				: world.entities;
			syncedEntities.reserve(syncedEntities.length+newEntities.length);
			foreach (i,entity; newEntities) {
				entityIds	~=nextId++	;
				syncedEntities	~=entity	;
				//---Send Msg to client
				auto msg = AddMsg();
				msg.id	= entityIds[$-1]	;
				msg.pos	= entity.getPos	;
				msg.ori	= entity.getOri	;
				network.send(msg);
			}
		}
	}
	
	private {
		World	world	;
		Network	network	;
		
		ushort[]	entityIds	= []	;
		Entity[]	syncedEntities	= []	;
		ushort	nextId	= 0	;
	}
}

