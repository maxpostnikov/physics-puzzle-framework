package ru.maxpostnikov.engine.ui.screens 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Screen extends MovieClip
	{
		
		protected var visual:MovieClip
		
		public function Screen()
		{
			addChild(visual);
		}
		
		public function show(data:Object = null):void 
		{
			
		}
		
		public function update(data:Object):void 
		{
			
		}
		
		public function hide():void 
		{
			
		}
		
		public function getID():uint { throw Error("Override Screen -> getID"); }
		
	}

}