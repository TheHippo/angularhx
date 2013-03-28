package angularhx;

typedef PromiseReason = Dynamic;

@:remove
extern class Promise {

	@:overload(function(success:Dynamic->Void, error:PromiseReason->Void):Void {})
	public function then(success:Dynamic->Void):Void;
}