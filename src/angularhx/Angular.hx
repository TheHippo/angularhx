package angularhx;


typedef AngularVersion = {
	full:String,
	major:Int,
	minor:Int,
	dot:Int,
	codeName:String
}

@:native('angular')
@:remove
extern class Angular {
	
	public static var version:AngularVersion;

	@:overload(function(o1:Dynamic, o2:Dynamic, o2:Dynamic):Void{})
	@:overload(function(o1:Dynamic, o2:Dynamic):Void{})
	public static function noop(o1:Dynamic):Void;

	public static function fromJson<T>(s:String):T;
	public static function toJson<T>(o:T):String;
	
	public static function isArray(o:Dynamic):Bool;
	public static function isDate(o:Dynamic):Bool;
	public static function isDefined(o:Dynamic):Bool;
	public static function isElement(o:Dynamic):Bool;
	public static function isFunction(o:Dynamic):Bool;
	public static function isNumber(o:Dynamic):Bool;
	public static function isObject(o:Dynamic):Bool;
	public static function isString(o:Dynamic):Bool;
	public static function isUndefined(o:Dynamic):Bool;

	public static function extend(dest:Dynamic, src:Dynamic):Void;

}