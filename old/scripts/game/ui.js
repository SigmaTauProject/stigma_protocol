


class UI {
	constructor(world, gameLogic, input) {
		this.world	= world	;
		this.gameLogic	= gameLogic	;
		this.input	= input	;
		
		this.uiElements	= [];
		{
			let radar = new UI_Radar("0",this.world);
			this.uiElements	.push(	radar	);
			radar.getEl().classList.add("ui-full");
			document.body.appendChild(radar.getEl());
			
			////let button = new UI_Button("1",this.world, "Click ME!");
			////this.uiElements	.push(	button	);
			////button.getEl().classList.add("ui-bottomLeft");
			////document.body.appendChild(button.getEl());
			
			let button = new UI_Slider("1",this.world);
			this.uiElements	.push(	button	);
			button.getEl().classList.add("ui-bottomLeft");
			document.body.appendChild(button.getEl());
		}
	}
	init() {
	}
	updateInput() {
		for (var uiEl of this.uiElements) {
			uiEl.updateInput();
		}
	}
	updateRender() {
		for (var uiEl of this.uiElements) {
			uiEl.updateRender();
		}
	}
	onCreateEntity(entity) {
		for (var uiEl of this.uiElements) {
			uiEl.onCreateEntity(entity);
		}
	}
}

class UI_Radar {
	constructor(id, world) {
		this.id	= id	;
		this.world	= world	;
				
		this.view	= null	;
		this.el	= svg (	"svg", "radar",
				"radar-circle",
				Div.attributes({viewBox:"-1 -1 2 2"}),
				svg (	"defs",
					svg (	"clipPath", Div.id("clipCircle"),
						svg (	"circle",
							Div.attributes({cx:"0",cy:"0",r:"1",}),
						),
					),
				),
				svg (	"rect",
					"radar-background",
					Div.attributes({x:"-1",y:"-1",width:"2",height:"2",}),
				),
				svg (	"circle",
					"radar-noClip",
					Div.attributes({cx:"0",cy:"0",r:"1",fill:"none",stroke:"black","stroke-width":"0.01",}),
				),
				svg (	"g",
					"view",
					(el)=>{this.view=el},
					Div.attributes({transform:"scale(0.1)"}),
				)
			);
	}
	getEl() {
		return this.el;
	}
	onCreateEntity(entity) {
		entity[this.id] = {};
		entity[this.id].el = svg("polygon", "entity", Div.attributes({points:"-0.5,0.5 0,-0.5 0.5,0.5 0,0.25"}))
		this.view.appendChild(entity[this.id].el);	
	}
	updateInput() {
		
	}
	updateRender() {
		for (var entity of this.world.entities) {
			entity[this.id].el.setAttribute("transform",`translate(${entity.pos[0]-this.world.player.pos[0]},${entity.pos[1]-this.world.player.pos[1]}) rotate(${entity.rot})`)
		}
	}
}

class UI_Button {
	constructor(id, world, text) {
		this.id	= id	;
		this.world	= world	;
				
		this.el	= div (	"button", "button",
				Div.text(text),
			);
	}
	getEl() {
		return this.el;
	}
	onCreateEntity(entity) {
	}
	updateInput() {
	}
	updateRender() {
	}
}

class UI_Slider {
	constructor(id, world, text) {
		this.id	= id	;
		this.world	= world	;
				
		this.input	= null	;
		this.el	= div (	"div", "verticalSlider-outer",
				div (	"input", "slider","verticalSlider",
					(el)=>{this.input=el},
					Div.attributes({type:"range",min:"0",max:"100",}),
					Div.on("input", (e)=>{}),
				),
			);
	}
	getEl() {
		return this.el;
	}
	onCreateEntity(entity) {
	}
	updateInput() {
		return {"value":Number(this.input.value),}
	}
	updateRender() {
	}
}





