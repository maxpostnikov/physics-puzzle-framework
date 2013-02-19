package ru.maxpostnikov.engine.core 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Max stagefear Postnikov
	 */
	public class Cookie 
	{
		
		private var _sharedObject:SharedObject;
		
		public function Cookie(name:String) 
		{
			_sharedObject = SharedObject.getLocal(name);
		}
		
		public function load():Object 
		{
			return _sharedObject.data.cookie;
		}
		
		public function save(data:Object):void 
		{
			_sharedObject.data.cookie = data;
			_sharedObject.flush();
		}
		
	}

}