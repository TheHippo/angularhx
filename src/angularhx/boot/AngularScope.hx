package angularhx.boot;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

class AngularScope {

	macro static function build():Array<Field> {
		// var pos = Context.currentPos();
		var fields = Context.getBuildFields();
		var localClass = Context.getLocalClass().get();
		for (field in fields) {
			if (field.name == "new") {
				// TODO: add more macro magic and remove this error!
				Context.error("Sorry. Scopes cannot have constructors!", field.pos);
			}
		}
		var constructor = createConstructor(localClass);
		fields.push(constructor);
		return fields;
	}

	static function createConstructor(cls:ClassType):Field {
		var path = cls.pack.join('.') + '.' +  cls.name;
		var f = {
			pos: cls.pos,
			name: "new",
			access: [APublic],
			meta: [],
			doc: null,
			kind: FFun({
				params: [],
				ret: null,
				args: [{
					name: "scope",
					opt: false,
					value: null,
					type: TPath({sub: null, name: 'Scope', pack:['angularhx'], params:[]})
				}],
				expr: macro untyped {
					__js__('for (var k in this) {');
						scope[k] = this[k];
					__js__('}');
					return untyped scope;
				}
			})
		};
		return f;
	}
}

