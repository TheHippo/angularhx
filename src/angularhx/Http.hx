package angularhx;

import angularhx.Promise;

typedef HttpData = Dynamic;
typedef HttpStatus = Int;
typedef HttpHeaders = Dynamic;
typedef HttpConfig = Dynamic;

@:remove
extern class HttpPromise extends Promise {

	@:overload(function(cb:HttpData->Void):HttpPromise{})
	@:overload(function(cb:HttpData->HttpStatus->Void):HttpPromise{})
	@:overload(function(cb:HttpData->HttpStatus->HttpHeaders->Void):HttpPromise{})
	public function success(cb:HttpData->HttpStatus->HttpHeaders->HttpConfig->Void):HttpPromise;
	
	@:overload(function(cb:HttpData->Void):HttpPromise{})
	@:overload(function(cb:HttpData->HttpStatus->Void):HttpPromise{})
	@:overload(function(cb:HttpData->HttpStatus->HttpHeaders->Void):HttpPromise{})
	public function error(cb:HttpData->HttpStatus->HttpHeaders->HttpConfig->Void):HttpPromise;
}

@:remove
extern class Http {

	@:overload(function(url:String,config:HttpConfig):HttpPromise {})
	public function delete(url:String):HttpPromise;
	
	@:overload(function(url:String,config:HttpConfig):HttpPromise {})
	public function get(url:String):HttpPromise;

	@:overload(function(url:String,config:HttpConfig):HttpPromise {})
	public function head(url:String):HttpPromise;

	@:overload(function(url:String,config:HttpConfig):HttpPromise {})
	public function jsponp(url:String):HttpPromise;	

	@:overload(function(url:String,data:Dynamic, config:HttpConfig):HttpPromise {})
	public function post(url:String, data:Dynamic):HttpPromise;

	@:overload(function(url:String,data:Dynamic, config:HttpConfig):HttpPromise {})
	public function put(url:String, data:Dynamic):HttpPromise;
}