package 
{
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import ru.maxpostnikov.engine.Engine;
	
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Main extends Sprite 
	{
		
		private var _level:Level;
		
		public function Main():void 
		{
			if (stage) 
				init();
			else 
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			Engine.getInstacne().launch(this);
			
			addLevel();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		private function onKey(e:KeyboardEvent):void 
		{
			if (e.keyCode == 82 && !Engine.getInstacne().isPaused) {
				removeChild(_level);
				addLevel();
			}
			
			if (e.keyCode == 68)
				Engine.getInstacne().debug();
			else if (e.keyCode == 80)
				Engine.getInstacne().pause();
		}
		
		private function addLevel():void 
		{
			_level = new Level();
			addChild(_level);
		}
		
	}
	
}