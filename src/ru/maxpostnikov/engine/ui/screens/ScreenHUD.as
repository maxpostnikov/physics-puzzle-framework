package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.effects.MCEffect;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.EngineEvent;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenHUD extends Screen
	{
		
		public static const ID:String = "HUD";
		
		private var _effect:MCEffect;
		
		public function ScreenHUD(visual:MovieClip, effectLevelChangeClass:Class) 
		{
			super(visual);
			
			_effect = new effectLevelChangeClass();
			
			this.mouseEnabled = false;
			visual.mouseEnabled = false;
			visual.mcLevelData.mouseEnabled = false;
			visual.mcLevelData.mouseChildren = false;
			
			
		}
		
		override public function show(data:Object = null):void 
		{
			update(data);
			
			if (data && !data.isResumed) 
				_effect.init(this, new Point());
			
			visual.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
		}
		
		override public function hide():void 
		{
			visual.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		}
		
		override public function update(data:Object):void 
		{
			if (data) {
				if (data.level)
					visual.mcLevelData.tLevel.text = data.level;
				if (data.score)
					visual.mcLevelData.tScore.text = data.score;
			}
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			Engine.getInstacne().dispatchEvent(new EngineEvent(EngineEvent.HUD_MOUSE_OVER, e));
		}
		
		override public function getID():String { return ID; }
		
	}

}