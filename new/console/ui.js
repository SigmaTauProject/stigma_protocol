



export default class UI {
	constructor(ship, /*input*/) {
		this.ship	= ship	;
		////this.input	= input	;
		
		this.uiElements	= [];
		{
			let radar = new UI_Radar("0",this.ship);
			this.uiElements	.push(	radar	);
			radar.getEl().classList.add("ui-full");
			document.body.appendChild(radar.getEl());
			
			////let button = new UI_Button("1",this.ship, "Click ME!");
			////this.uiElements	.push(	button	);
			////button.getEl().classList.add("ui-bottomLeft");
			////document.body.appendChild(button.getEl());
			
			let slider = new UI_Slider("1",this.ship,0,1,0.01);
			this.uiElements	.push(	slider	);
			slider.getEl().classList.add("ui-bottomLeft");
			document.body.appendChild(slider.getEl());
			slider.addEventListener("input",(e)=>{
				ship.setSpeed(e.target.value)
			});
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
	onAddEntity(entity) {
		for (var uiEl of this.uiElements) {
			uiEl.onAddEntity(entity);
		}
	}
}

class UI_Radar {
	constructor(id, ship) {
		this.id	= id	;
		this.ship	= ship	;
				
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
				svg (	"g",
					Div.attributes({"clip-path":"url(#clipCircle)"}),
					svg (	"rect",
						"radar-background",
						Div.attributes({x:"-1",y:"-1",width:"2",height:"2",}),
					),
					svg (	"g",
						"radar-view",
						(el)=>{this.view=el},
						Div.attributes({transform:"scale(0.1)"}),
					),
				),
				svg (	"circle",
					Div.attributes({cx:"0",cy:"0",r:"1",fill:"none",stroke:"black","stroke-width":"0.01",}),
				),
			);
	}
	getEl() {
		return this.el;
	}
	////onAddEntity(entity) {
	////	entity[this.id] = {};
	////	entity[this.id].el = svg("polygon", "entity", Div.attributes({points:"-0.5,0.5 0,-0.5 0.5,0.5 0,0.25"}))
	////	this.view.appendChild(entity[this.id].el);	
	////}
	updateInput() {
	}
	addEventListener() {
	}
	updateRender() {
		let shipViewComponent = this.ship.components.find(component=>component.type=="shipView");
		if (shipViewComponent) {
			let pos = shipViewComponent.us.pos;
			for (var ship of shipViewComponent.ships) {
				renderShip.bind(this)(ship);
			}
			renderShip.bind(this)(shipViewComponent.us);
			function renderShip(ship) {
				if (!ship.ui_radar) ship.ui_radar = {};
				if (!ship.ui_radar[this.id]) ship.ui_radar[this.id] = {};
				if (!ship.ui_radar[this.id].el) {
					ship.ui_radar[this.id] = {};
					ship.ui_radar[this.id].el = svg("polygon", "entity", Div.attributes({points:"-0.5,0.5 0,-0.5 0.5,0.5 0,0.25"}))
					this.view.appendChild(ship.ui_radar[this.id].el);	
				}
				ship.ui_radar[this.id].el.setAttribute("transform",`translate(${ship.pos[0]-pos[0]},${-(ship.pos[1]-pos[1])}) rotate(${Math.degrees(ship.rot)})`)
			}
		}
	}
}


class UI_Button {
	constructor(id, ship, text) {
		this.id	= id	;
		this.ship	= ship	;
				
		this.el	= div (	"button", "button",
				Div.text(text),
			);
	}
	getEl() {
		return this.el;
	}
	onAddEntity(entity) {
	}
	updateInput() {
	}
	addEventListener(type,callback) {
		this.el.addEventListener(type,callback);
	}
	updateRender() {
	}
}

class UI_Slider {
	constructor(id, ship, min, max, step) {
		this.id	= id	;
		this.ship	= ship	;
				
		this.input	= null	;
		this.el	= div (	"div", "verticalSlider-outer",
				div (	"input", "slider","verticalSlider",
					(el)=>{this.input=el},
					Div.attributes({type:"range",min:min,max:max,step:step}),
					Div.on("input", (e)=>{}),
				),
			);
	}
	getEl() {
		return this.el;
	}
	onAddEntity(entity) {
	}
	updateInput() {
	}
	addEventListener(type,callback) {
		this.input.addEventListener(type,callback);
	}
	updateRender() {
	}
}





