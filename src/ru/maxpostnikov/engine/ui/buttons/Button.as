package ru.maxpostnikov.engine.ui.buttons 
{
	import com.greensock.easing.Ease;
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ru.maxpostnikov.engine.Engine;
	import ru.maxpostnikov.engine.ui.screens.Screen;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Button extends MovieClip
	{
		
		private const _TWEEN_DELAY:Number = 0.1;
		
		protected var screen:Screen;
		protected var scaleIncrease:Number = 0.04;
		protected var scaleDecrease:Number = 0.02;
		
		private var _scale:Number;
		
		public function Button() 
		{
			this.mouseChildren = false;
			
			_scale = this.scaleX;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage, false, 0, true);
		}
		
		protected function onAddedToStage(e:Event):void 
		{
			if (this.parent.parent && this.parent.parent is Screen)
				screen = this.parent.parent as Screen;
			
			this.scaleX = this.scaleY = _scale;
			
			addEventListener(MouseEvent.ROLL_OVER, onRollOver, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, onRollOut, false, 0, true);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
		}
		
		protected function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
			removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			TweenLite.killTweensOf(this);
			
			screen = null;
		}
		
		protected function click():void 
		{
			Engine.getInstacne().hideScreen(this.screen.getID());
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			click();
			
			tween(_scale + scaleIncrease, Linear.easeIn);
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			tween(_scale - scaleDecrease, Linear.easeOut);
		}
		
		private function onRollOver(e:MouseEvent):void 
		{
			tween(_scale + scaleIncrease, Linear.easeIn);
		}
		
		private function onRollOut(e:MouseEvent):void 
		{
			tween(_scale, Linear.easeOut);
		}
		
		private function tween(scale:Number, ease:Ease):void 
		{
			TweenLite.to(this, _TWEEN_DELAY, { scaleX:scale, scaleY:scale, ease:ease } );
		}
		
	}

}