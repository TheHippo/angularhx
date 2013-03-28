package angularhx.boot;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

class AngularScope {

	macro static function build():Array<Field> {
		var fields = Context.getBuildFields();
		var localClass = Context.getLocalClass().get();
		var oldConstructor:Field = null;
		var oldConstructorIndex:Int = null;
		var newName:String;
		for (i in 0...fields.length) {
			var field = fields[i];
			if (field.name == "new") {
				oldConstructor = field;
				oldConstructorIndex = i;
				newName = "oc_" + Context.signature(oldConstructor);
				break;
			}
		}
		var constructor = createConstructor(localClass, oldConstructor, newName);
		
		if (oldConstructorIndex != null) {	
			oldConstructor.name = newName;
			fields[oldConstructorIndex] = oldConstructor;
		}
		fields.push(constructor);
		return fields;
	}

	static function createConstructor(cls:ClassType, oldConstructor:Null<Field>, newName:String):Field {
		var path = cls.pack.join('.') + '.' +  cls.name;
		var args = [{
			name: "scope",
			opt: false,
			value: null,
			type: TPath({sub: null, name: 'Scope', pack:['angularhx'], params:[]})
		}];
		var cExpr = macro {};
		if (oldConstructor != null) {
			switch (oldConstructor.kind) {
				case FFun({args:oArgs, params: _, expr: _, ret: _}):
					args = oArgs.concat(args);
					var args = {
						expr: EArrayDecl([for (arg in oArgs) macro $i{arg.name}]),
						pos: oldConstructor.pos
					};
					cExpr = macro untyped {
						scope.$newName.apply(scope, $e{args});
					};
				default:
					Context.error("Not a valid constructor", oldConstructor.pos);
			}
		}
		var f = {
			pos: cls.pos,
			name: "new",
			access: [APublic],
			meta: [],
			doc: null,
			kind: FFun({
				params: [],
				ret: null,
				args: args,
				expr: macro untyped {
					// let's screw arround the the scope, build the class arround the existing scope
					__js__('for (var k in this) {');
						scope[k] = this[k];
					__js__('}');
					$e{cExpr};
					return scope;
				}
			})
		};
		return f;
	}
}

