package angularhx;

import angularhx.Promise;

@:remove
extern class HttpPromise extends Promise<Dynamic> {

	public function success(cb:String->Int->Dynamic->Dynamic->Void):HttpPromise;
	public function error(cb:String->Int->Dynamic->Dynamic->Void):HttpPromise;
}

@:remove
extern class Http {

	@:overload(function(url:String,config:Dynamic):HttpPromise {})
	public function delete(url:String):HttpPromise;
	
	@:overload(function(url:String,config:Dynamic):HttpPromise {})
	public function get(url:String):HttpPromise;

	@:overload(function(url:String,config:Dynamic):HttpPromise {})
	public function head(url:String):HttpPromise;

	@:overload(function(url:String,config:Dynamic):HttpPromise {})
	public function jsponp(url:String):HttpPromise;	

	@:overload(function(url:String,data:Dynamic, config:Dynamic):HttpPromise {})
	public function post(url:String, data:Dynamic):HttpPromise;

	@:overload(function(url:String,data:Dynamic, config:Dynamic):HttpPromise {})
	public function put(url:String, data:Dynamic):HttpPromise;
}