
class Game {
	constructor() {
		this.world	= new World	(	);
		this.gameLogic	= new GameLogic	(this.world	);
		this.input	= new Input	(this.gameLogic	);
		this.ui	= new UI	(this.world, this.gameLogic, this.input	);
		this.world.giveHandlers(this.gameLogic, this.ui);
		this.ui.init();
		this.gameLogic.init();
		this.input.init();
		
		setInterval(this.update.bind(this), 50);
	}
	update() {
		this.ui	.updateInput();
		this.input	.update();
		this.gameLogic	.update();
		this.ui	.updateRender();
	}
}

