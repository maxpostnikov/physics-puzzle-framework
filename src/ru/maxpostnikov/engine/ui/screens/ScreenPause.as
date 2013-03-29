package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ScreenPause extends Screen
	{
		
		public static const ID:String = "Pause";
		
		public function ScreenPause(visual:MovieClip) 
		{
			super(visual);
		}
		
		override public function show(data:Object = null):void 
		{
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		override public function hide():void 
		{
			removeEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			Engine.getInstacne().pause();
		}
		
		override public function getID():String { return ID; }
		
	}

}