package ru.maxpostnikov.engine.ui.buttons 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import ru.maxpostnikov.engine.Engine;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ButtonSoundOn extends Button
	{
		
		private var _buttonSoundOff:ButtonSoundOff;
		
		override protected function onAddedToStage(e:Event):void 
		{
			super.onAddedToStage(e);
			
			initButtonSoundOff();
			
			if (_buttonSoundOff) {
				if (Engine.getInstacne().isMuted) {
					this.visible = false;
					_buttonSoundOff.visible = true;
				} else {
					this.visible = true;
					_buttonSoundOff.visible = false;
				}
			}
		}
		
		override protected function click():void 
		{
			Engine.getInstacne().mute();
			
			if (_buttonSoundOff)
				_buttonSoundOff.visible = true;
			
			this.visible = false;
		}
		
		private function initButtonSoundOff():void 
		{
			for (var i:int = 0; i < this.parent.numChildren; i++) {
				var child:DisplayObject = this.parent.getChildAt(i);
				
				if (child is ButtonSoundOff) { 
					_buttonSoundOff = child as ButtonSoundOff;
					_buttonSoundOff.visible = false;
					_buttonSoundOff.buttonSoundOn = this;
					break;
				}
			}
		}
		
	}

}