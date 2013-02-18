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
			Engine.getInstacne().levels.addLevel(1);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKey);
		}
		
		private function onKey(e:KeyboardEvent):void 
		{
			if (!Engine.getInstacne().isPaused) {
				if (e.keyCode == 82)
					Engine.getInstacne().levels.restartLevel();
				else if (e.keyCode == 37)
					Engine.getInstacne().levels.prevLevel();
				else if (e.keyCode == 39)
					Engine.getInstacne().levels.nextLevel();
			}
			
			if (e.keyCode == 68)
				Engine.getInstacne().debug();
			else if (e.keyCode == 80)
				Engine.getInstacne().pause();
		}
		
	}
	
}