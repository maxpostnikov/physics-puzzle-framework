package ru.maxpostnikov.engine.entities.components 
{
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class ComponentGroup extends Component
	{
		
		private var _group:Vector.<Component>;
		
		public function ComponentGroup() 
		{
			super();
			
			_group = new <Component>[];
			
			for (var i:int = 0; i < numChildren; i++) {
				var child:DisplayObject = getChildAt(i);
				
				if (child is Component)
					_group.push(child as Component);
				else
					child.visible = false;
			}
		}
		
		public function get group():Vector.<Component> { return _group; }
		
	}

}