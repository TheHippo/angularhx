package angularhx;

typedef PromiseReason = Dynamic;

@:remove
extern class Promise<T> {

	@:overload(function(success:T->Void, error:PromiseReason->Void):Void {})
	public function then(success:T->Void):Void;
}