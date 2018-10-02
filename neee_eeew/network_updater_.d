module network_mono_.d;

class NetworkMono {
	this() {
		
	}
	void addNetworker(Networker networker) {
		this.networkers ~= networker;
	}
	void addNetworkers(Networker networkers) {
		this.networkers ~= networkers;
	}
	void update() {
		foreach (networker of networkers) {
			networker.preUpdate();
		}
		foreach (networker of networkers) {
			networker.postUpdate();
		}
	}
	Networker[] networkers = [];
}

abstract class Networker {
	protected {
		this() {
		}
		abstract preUpdate();
		abstract postUpdate();
	}
}

