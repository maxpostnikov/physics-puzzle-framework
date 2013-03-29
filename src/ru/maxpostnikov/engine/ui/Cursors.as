package ru.maxpostnikov.engine.ui 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Cursors 
	{
		
		private var _stage:Stage;
		private var _cursor:Sprite;
		private var _cursors:Dictionary;
		
		private static var _instance:Cursors;
		
		public function Cursors(singleton:PrivateClass) 
		{
			_instance = this;
		}
		
		public static function getInstacne():Cursors 
		{
			return (_instance) ? _instance : new Cursors(new PrivateClass());
		}
		
		public function init(stage:Stage, cursors:Vector.<Class>):void 
		{
			_stage = stage;
			_cursors = new Dictionary();
			
			for (var i:String in cursors) {
				var cursorClass:Class = cursors[i];
				var cursor:Sprite = new cursorClass();
				
				cursor.mouseEnabled = false;
				cursor.mouseChildren = false;
				
				_cursors[i] = cursor;
			}
			
			_stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function showCursor(id:uint):void 
		{
			if (_cursors)
				var cursor:Sprite = _cursors[id];
			
			if (cursor) {
				var _isVisible:Boolean = true;
				
				if (_cursor) {
					_isVisible = _cursor.visible;
					hideCursor();
				}
				
				_cursor = cursor;
				_stage.addChild(_cursor);
				
				_cursor.visible = _isVisible;
				Mouse.hide();
				
				moveCursor();
			}
		}
		
		private function hideCursor():void 
		{
			_stage.removeChild(_cursor);
			_cursor = null;
		}
		
		private function onMouseLeave(e:Event):void 
		{
			if (_cursor) {
				_cursor.visible = false;
				Mouse.show();
			}
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (_cursor) {
				moveCursor();
				
				if (!_cursor.visible) {
					_cursor.visible = true;
					Mouse.hide();
				}
			}
		}
		
		private function moveCursor():void 
		{
			_cursor.x = _stage.mouseX;
			_cursor.y = _stage.mouseY;
			
			if (_stage.getChildIndex(_cursor) != _stage.numChildren - 1)
				_stage.setChildIndex(_cursor, _stage.numChildren - 1);
		}
		
	}

}

class PrivateClass {}