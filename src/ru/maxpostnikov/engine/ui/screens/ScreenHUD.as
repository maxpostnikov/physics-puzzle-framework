package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import ru.maxpostnikov.engine.effects.MCEffect;
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
		
		override public function getID():String { return ID; }
		
	}

}