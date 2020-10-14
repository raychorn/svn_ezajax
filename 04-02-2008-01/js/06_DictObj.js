// DictObj.js

ezDictObj = function(id){
	this.id = id;
	this.keys = [];
	this.cache = [];
};

ezDictObj.$ = [];

ezDictObj.get$ = function(aSpec) {
	var instance = ezDictObj.$[ezDictObj.$.length];
	if (instance == null) {
		instance = ezDictObj.$[ezDictObj.$.length] = new ezDictObj(ezDictObj.$.length);
	}
	instance.fromSpec(aSpec);
	return instance;
};

ezDictObj.remove$ = function(id) {
	var ret_val = false;
	if ( (id > -1) && (id < ezDictObj.$.length) ) {
		var instance = ezDictObj.$[id];
		if (!!instance) {
			ezDictObj.$[id] = ezObjectDestructor(instance);
			ret_val = (ezDictObj.$[id] == null);
		}
	}
	return ret_val;
};

ezDictObj.remove$s = function() {
	var ret_val = true;
	for (var i = 0; i < ezDictObj.$.length; i++) {
		ezDictObj.remove$(i);
	}
	return ret_val;
};

ezDictObj.prototype = {
	id : -1,
	bool_returnArray : false,
	keys : [],
	cache : [],
	toString : function() {
		var aKey = -1;
		var aVal = -1;
		var s = 'ezDictObj(' + this.id + ') :: (';
		if (this.id != null) {
			s += '\n';
			for (var i = 0; i < this.keys.length; i++) {
				aKey = this.keys[i];
				aVal = this.getValueFor(aKey);
				s += '{' + aKey + '} = [';
				if (typeof aVal == const_object_symbol) {
					for (var j = 0; j < aVal.length; j++) {
						s += '\n\t[';
						s += aVal[j];
						s += ']';
					}
				} else {
					s += aVal;
				}
				s += ']' + '\n';
			}
		}
		s += ')';
		return s;
	},
	fromSpec : function(aSpec) { 
		var i = -1;
		var ar = [];
		var ar2 = [];
		if (!!aSpec) {
			ar = aSpec.split(',');
			if (ar.length == 1) {
				ar = aSpec.split('&');
			}
			for (i = 0; i < ar.length; i++) {
				if (ar[i].length > 0) {
					ar2 = ar[i].split('=');
					if (ar2.length == 2) {
						this.push(ar2[0], ar2[1]);
					} else {
						this.push(ar[i], ar[i + 1]);
						i++;
					}
				}
			}
			this.URLDecode();
		}
	},
	URLDecode : function() { 
		var aKey = -1;
		var aVal = -1;
		for (var i = 0; i < this.keys.length; i++) {
			aKey = this.keys[i];
			aVal = this.getValueFor(aKey);
			try {
				this.cache[aKey] = aVal.toString().ezURLDecode();
			} catch(e) {} finally {};
		}
	},
	asQueryString : function(ch_delim) { 
		var aKey = -1;
		var s = '';
		var aVal = -1;
		ch_delim = ((!!ch_delim) ? ch_delim : ',');
		for (var i = 0; i < this.keys.length; i++) {
			aKey = this.keys[i];
			aVal = this.getValueFor(aKey);
			try {
				aVal = aVal.toString().ezURLEncode();
			} catch(e) {} finally {};
			if (!!ch_delim) {
				s += aKey + '=' + aVal + ((i < (this.keys.length - 1)) ? ch_delim : '');
			} else {
				s += '&' + aKey + '=' + aVal;
			}
		}
		return s;
	},
	push : function(key, value) {
		var _f = -1;
		if ( (key != null) && ((typeof key) != const_string_symbol) ) {
			key = key.toString();
		} else if (key == null) {
			key = '';
		}
		if ( (value != null) && ((typeof value) != const_string_symbol) ) {
			value = value.toString();
		} else if (value == null) {
			value = '';
		}
		var _key = key.ezTrim().toUpperCase();
		for (var i = 0; i < this.keys.length; i++) {
			if (this.keys[i].ezTrim().toUpperCase() == _key) {
				_f = i;
				break;
			}
		}
		if (_f == -1) {
			this.keys.push(key);
			this.cache[key] = value;
			return true;
		} else { 
			if (typeof this.cache[key] != const_object_symbol) {
				var a = [];
				a.push(this.cache[key]);
				this.cache[key] = a;
			}
			this.cache[key].push(value);
		}
		return false;
	},
	put : function(key, value) {
		if (this.cache[key] != null) {
			this.cache[key] = value;
		} else {
			alert('WARNING - Programming Error: The key (' + key + ') does not appear in the dictionary... Are you sure you didn\'t really mean to use the push method instead ?');
		}
	},
	drop : function(key) {
		if (this.cache[key] != null) {
			this.cache[key] = null;
			var ar = this.keys;
			this.keys = [];
			for (var i = 0; i < ar.length; i++) {
				if (ar[i] != key) {
					this.keys.push(ar[i]);
				}
			}
		} else {
			alert('WARNING - Programming Error: The key (' + key + ') does not appear in the dictionary... Are you sure you didn\'t really mean to use the push method instead ?');
		}
	},
	getValueFor : function(key) {
		var _retVal = this.cache[key];
		if (_retVal != null) {
			this.bool_returnArray = ((this.bool_returnArray == true) ? this.bool_returnArray : false);
			if ( (this.bool_returnArray) && (typeof _retVal != const_object_symbol) ) {
				var _ar = [];
				_ar.push(_retVal);
				_retVal = _ar;
			}
		}
		return (_retVal);
	},
	getKeysMatching : function(aFunc) {
		var a = [];
		for (var i = 0; i < this.keys.length; i++) {
			if ( (!!aFunc) && (typeof aFunc == const_function_symbol) && (aFunc(this.keys[i], this.getValueFor(this.keys[i]))) ) {
				a.push(this.keys[i]);
			}
		}
		return (a);
	},
	getKeys : function() {
		return (this.keys);
	},
	adjustKeyNames : function(func) { 
		var k = this.keys;
		if ( (!!func) && (typeof func == const_function_symbol) ) {
			k = [];
			for (var i = 0; i < this.keys.length; i++) {
				k.push(func(this.keys[i]));
			}
		}
		return (k); 
	},
	length : function() {
		return (this.keys.length);
	},
	keyForLargestValue : function() {
		var i = -1;
		var maxValue = -2^31;
		for (i = 0; i < this.keys.length; i++) {
			maxValue = Math.max(maxValue, this.cache[this.keys[i]]);
		}
		for (i = 0; i < this.keys.length; i++) {
			if (this.cache[this.keys[i]] == maxValue) {
				return this.keys[i];
			}
		}
		return null;
	},
	intoNamedArgs : function() {
		var _newKey = -1;
		var _newVal = -1;
		var key1 = -1;
		var key2 = -1;
		var argCnt = this.getValueFor('argCnt');
		if ( (!!argCnt) && ((argCnt % 2) == 0) ) {
			for (var i = 1; i <= argCnt; i += 2) {
				key1 = 'arg' + i;
				key2 = 'arg' + (i + 1);
				_newKey = this.getValueFor(key1);
				try {
					_newVal = this.getValueFor(key2).ezURLDecode();
				} catch(e) {
					_newVal = '';
				} finally {
				}
				this.push(_newKey, _newVal);
				this.drop(key1);
				this.drop(key2);
			}
			this.drop('argCnt');
		}
		return this;
	},
	init : function() {
		this.keys = [];
		this.cache = [];
		return this;
	},
	destructor : function() {
		return (this.id = ezDictObj.$[this.id] = this.keys = this.cache = null);
	}
};

