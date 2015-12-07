// Generated by CoffeeScript 1.9.2
(function(ªG) {
/*! Proon 0.0.9 //// MIT Licence //// http://proon.richplastow.com/ */
var Proon, SomeClass, ª, ªA, ªB, ªC, ªE, ªF, ªN, ªO, ªR, ªS, ªU, ªV, ªX, ªex, ªhas, ªinsert, ªis, ªisU, ªredefine, ªtype, ªuid;

ªC = 'Proon';

ªV = '0.0.9';

SomeClass = (function() {
  SomeClass.prototype.C = 'SomeClass';

  SomeClass.prototype.toString = function() {
    return '[object SomeClass]';
  };

  function SomeClass(config) {
    var M;
    if (config == null) {
      config = {};
    }
    M = "/proon/src/SomeClass/SomeClass.litcoffee SomeClass()\n  ";
    this.x = null;
  }

  SomeClass.prototype.xx = function(yy) {
    var M;
    return M = "/proon/src/SomeClass/SomeClass.litcoffee SomeClass:xx()\n  ";
  };

  return SomeClass;

})();

SomeClass.xx = function(yy) {
  var M;
  return M = "/proon/src/SomeClass/SomeClass.litcoffee SomeClass.xx()\n  ";
};

Proon = (function() {
  Proon.prototype.C = 'Proon';

  Proon.prototype.toString = function() {
    return '[object Proon]';
  };

  function Proon(config) {
    var M, pwdRx, ts;
    if (config == null) {
      config = {};
    }
    M = "/proon/src/Proon.litcoffee Proon()\n  ";
    if (ªU === typeof config.object) {
      this.object = null;
    } else if (ªO !== ªtype(config.object)) {
      throw TypeError(M + "Optional `config.object` is " + (ªtype(config.object)) + " not object");
    } else {
      this.object = config.object;
    }
    ts = ªtype(config.storage);
    if (ªU === ts) {
      this.storage = null;
    } else if (ªO !== ts && 'storage' !== ts) {
      throw TypeError(M + "Optional `config.storage` is " + ts + " not object or storage");
    } else if (ªF !== typeof config.storage.setItem) {
      throw TypeError(M + "Optional `config.storage` has no `setItem()` method");
    } else {
      this.storage = config.storage;
    }
    if (ªU === typeof config.fs) {
      this.fs = null;
    } else if (ªO !== ªtype(config.fs)) {
      throw TypeError(M + "Optional `config.fs` is " + (ªtype(config.fs)) + " not object");
    } else if (ªF !== typeof config.fs.readFileSync) {
      throw TypeError(M + "Optional `config.fs` has no `readFileSync()` method");
    } else if (ªF !== typeof config.fs.statSync) {
      throw TypeError(M + "Optional `config.fs` has no `statSync()` method");
    } else if (ªF !== typeof config.fs.mkdirSync) {
      throw TypeError(M + "Optional `config.fs` has no `mkdirSync()` method");
    } else if (ªF !== typeof config.fs.writeFileSync) {
      throw TypeError(M + "Optional `config.fs` has no `writeFileSync()` method");
    } else {
      this.fs = config.fs;
    }
    if (ªU === typeof config.db) {
      this.db = null;
    } else if (ªO !== ªtype(config.db)) {
      throw TypeError(M + "Optional `config.db` is " + (ªtype(config.db)) + " not object");
    } else {
      this.db = config.db;
    }
    if (ªU === typeof config.dom) {
      this.dom = null;
    } else if (ªO !== ªtype(config.dom)) {
      throw TypeError(M + "Optional `config.dom` is " + (ªtype(config.dom)) + " not object");
    } else {
      this.dom = config.dom;
    }
    pwdRx = /^[.\/a-z0-9][-.\/a-z0-9]{0,62}[-a-z0-9]$/i;
    if (ªU === typeof config.pwd) {
      this.pwd = '.';
    } else if (ªS !== ªtype(config.pwd)) {
      throw TypeError(M + "Optional `config.pwd` is " + (ªtype(config.pwd)) + " not string");
    } else if (!pwdRx.test(config.pwd)) {
      throw RangeError(M + "Optional `config.pwd` fails " + pwdRx);
    } else {
      this.pwd = config.pwd;
    }
  }

  Proon.prototype.add = function(node) {
    var M, content, curr, e, i, j, key, len, len1, len2, len3, len4, len5, m, maxLen, maxLevels, name, nameRx, o, path, pathRx, q, r, real, ref, ref1, rel, s, stat, str, u, value;
    M = "/proon/src/Proon.litcoffee Proon:add()\n  ";
    if (ªO !== ªtype(node)) {
      throw TypeError(M + "`node` is " + (ªtype(node)) + " not object");
    }
    name = node.name;
    path = node.path;
    content = node.content;
    nameRx = /^[a-z][-a-z0-9]{0,23}$/;
    if (ªS !== typeof name) {
      throw TypeError(M + "`node.name` is " + (ªtype(name)) + " not string");
    }
    if (!nameRx.test(name)) {
      throw RangeError(M + "`node.name` fails " + nameRx);
    }
    pathRx = /^[a-z][-a-z0-9]{0,23}$/;
    maxLevels = 99;
    if (ªU === typeof path) {
      path = [];
    } else if (ªA !== ªtype(path)) {
      throw TypeError(M + "`node.path` is " + (ªtype(path)) + " not array");
    } else if (maxLevels < path.length) {
      throw RangeError(M + "`node.path.length` " + path.length + " > " + maxLevels);
    }
    for (i = j = 0, len = path.length; j < len; i = ++j) {
      str = path[i];
      if (ªS !== typeof str) {
        throw TypeError(M + "`node.path[" + i + "]` is " + (ªtype(path[i])) + " not string");
      }
      if (!pathRx.test(str)) {
        throw RangeError(M + "`node.path[" + i + "]` fails " + pathRx);
      }
    }
    maxLen = 1024 * 1024;
    if (ªU === typeof content) {
      content = '';
    } else if (ªS !== typeof content) {
      throw TypeError(M + "`node.content` is " + (ªtype(content)) + " not string");
    } else if (maxLen < content.length) {
      throw TypeError(M + "`node.content.length` " + content.length + " > " + maxLen);
    }
    if (this.object) {
      curr = this.object;
      for (i = m = 0, len1 = path.length; m < len1; i = ++m) {
        str = path[i];
        curr = curr[str];
        if (ªS === typeof curr) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is already an object leaf-node");
        }
        if (ªU === typeof curr) {
          break;
        }
      }
      if (curr) {
        if (ªS === typeof curr[name]) {
          throw RangeError(M + "`node.name` '" + name + "' is already an object leaf-node");
        }
        if (ªU !== typeof curr[name]) {
          throw RangeError(M + "`node.name` '" + name + "' is already an object branch-node");
        }
      }
    }
    if (this.storage) {
      key = '/';
      value = true;
      for (i = o = 0, len2 = path.length; o < len2; i = ++o) {
        str = path[i];
        value = this.storage.getItem(key += str);
        if (null === value) {
          break;
        }
        if ('/' !== value) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is already a storage leaf-node");
        }
        key += '/';
      }
      if (value) {
        value = this.storage.getItem(key += name);
        if ('/' === value) {
          throw RangeError(M + "`node.name` '" + name + "' is already a storage branch-node");
        }
        if (null !== value) {
          throw RangeError(M + "`node.name` '" + name + "' is already a storage leaf-node");
        }
      }
    }
    if (this.fs) {
      rel = this.pwd;
      real = [];
      for (i = q = 0, len3 = path.length; q < len3; i = ++q) {
        str = path[i];
        rel += '/' + str;
        try {
          stat = this.fs.statSync(rel);
        } catch (_error) {
          e = _error;
          if ('ENOENT' === e.code) {
            break;
          }
          throw Error("" + M + e.code + " checking `node.path[" + i + "]` '" + str + "'");
        }
        if (!stat.isDirectory()) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is already a file");
        }
        real.push(str);
      }
      if (real.length === path.length) {
        e = {
          code: false
        };
        rel += '/' + name;
        try {
          stat = this.fs.statSync(rel);
        } catch (_error) {
          e = _error;
          if ('ENOENT' !== e.code) {
            throw Error("" + M + e.code + " checking `node.name` '" + name + "'");
          }
        }
        if (!e.code) {
          if (stat.isFile()) {
            throw RangeError(M + "`node.name` '" + name + "' is already a file");
          }
          if (stat.isDirectory()) {
            throw RangeError(M + "`node.name` '" + name + "' is already a directory");
          }
        }
      }
    }
    if (this.db) {
      123;
    }
    if (this.dom) {
      123;
    }
    if (this.object) {
      curr = this.object;
      for (i = r = 0, len4 = path.length; r < len4; i = ++r) {
        str = path[i];
        if (ªU === typeof curr[str]) {
          curr[str] = {
            __: curr
          };
        }
        curr = curr[str];
      }
      curr[name] = content;
    }
    if (this.storage) {
      key = '/';
      for (i = s = 0, len5 = path.length; s < len5; i = ++s) {
        str = path[i];
        if (null === this.storage.getItem(key = "" + key + str)) {
          this.storage.setItem(key, '/');
        }
        key += '/';
      }
      key = "" + key + name;
      this.storage.setItem(key, '-' + content);
    }
    if (this.fs) {
      rel = rel.replace(/\/[^\/]+$/, '');
      if (real.length !== path.length) {
        for (i = u = ref = real.length, ref1 = path.length - 1; ref <= ref1 ? u <= ref1 : u >= ref1; i = ref <= ref1 ? ++u : --u) {
          rel += '/' + path[i];
          try {
            this.fs.mkdirSync(rel);
          } catch (_error) {
            e = _error;
            throw Error("" + M + e.code + " making `node.path[" + i + "]` '" + str + "'");
          }
        }
      }
      try {
        this.fs.writeFileSync(rel + '/' + name, content);
      } catch (_error) {
        e = _error;
        throw Error("" + M + e.code + " making `node.name` '" + name + "'");
      }
    }
    if (this.db) {
      123;
    }
    if (this.dom) {
      123;
    }
    return this;
  };

  Proon.prototype["delete"] = function(node) {
    var M, curr, e, i, items, j, k, key, l, len, len1, len2, len3, len4, len5, m, maxLevels, name, nameRx, o, path, pathRx, q, r, ref, ref1, rel, s, stat, str, subs, u, v, value;
    M = "/proon/src/Proon.litcoffee Proon:delete()\n  ";
    if (ªO !== ªtype(node)) {
      throw TypeError(M + "`node` is " + (ªtype(node)) + " not object");
    }
    name = node.name;
    path = node.path;
    nameRx = /^[a-z][-a-z0-9]{0,23}$/;
    if (ªU === typeof name) {
      name = false;
    } else if (ªS !== typeof name) {
      throw TypeError(M + "`node.name` is " + (ªtype(name)) + " not string");
    } else if (!nameRx.test(name)) {
      throw RangeError(M + "`node.name` fails " + nameRx);
    }
    pathRx = /^[a-z][-a-z0-9]{0,23}$/;
    maxLevels = 99;
    if (ªU === typeof path) {
      path = [];
    } else if (ªA !== ªtype(path)) {
      throw TypeError(M + "`node.path` is " + (ªtype(path)) + " not array");
    } else if (maxLevels < path.length) {
      throw RangeError(M + "`node.path.length` " + path.length + " > " + maxLevels);
    }
    for (i = j = 0, len = path.length; j < len; i = ++j) {
      str = path[i];
      if (ªS !== typeof str) {
        throw TypeError(M + "`node.path[" + i + "]` is " + (ªtype(path[i])) + " not string");
      }
      if (!pathRx.test(str)) {
        throw RangeError(M + "`node.path[" + i + "]` fails " + pathRx);
      }
    }
    if (this.object) {
      curr = this.object;
      for (i = m = 0, len1 = path.length; m < len1; i = ++m) {
        str = path[i];
        curr = curr[str];
        if (ªU === typeof curr) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is undefined in the object");
        }
        if (ªS === typeof curr) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is an object leaf- not branch-node");
        }
      }
      if (name) {
        if (ªU === typeof curr[name]) {
          throw RangeError(M + "`node.name` '" + name + "' is undefined in the object");
        }
        if (ªS !== typeof curr[name]) {
          throw RangeError(M + "`node.name` '" + name + "' is an object branch- not leaf-node");
        }
      }
    }
    if (this.storage) {
      key = '/';
      for (i = o = 0, len2 = path.length; o < len2; i = ++o) {
        str = path[i];
        value = this.storage.getItem(key += str);
        if (null === value) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is undefined in storage");
        }
        if ('/' !== value) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is a storage leaf- not branch-node");
        }
        key += '/';
      }
      if (name) {
        value = this.storage.getItem(key + name);
        if (null === value) {
          throw RangeError(M + "`node.name` '" + name + "' is undefined in storage");
        }
        if ('/' === value) {
          throw RangeError(M + "`node.name` '" + name + "' is a storage branch- not leaf-node");
        }
      }
    }
    if (this.fs) {
      rel = this.pwd;
      for (i = q = 0, len3 = path.length; q < len3; i = ++q) {
        str = path[i];
        rel += '/' + str;
        try {
          stat = this.fs.statSync(rel);
        } catch (_error) {
          e = _error;
          if ('ENOENT' === e.code) {
            throw RangeError(M + "`node.path[" + i + "]` '" + str + "' does not exist in filesystem");
          }
          throw Error("" + M + e.code + " checking `node.path[" + i + "]` '" + str + "'");
        }
        if (!stat.isDirectory()) {
          throw RangeError(M + "`node.path[" + i + "]` '" + str + "' is a file, not a directory");
        }
      }
      if (name) {
        rel += '/' + name;
        try {
          stat = this.fs.statSync(rel);
        } catch (_error) {
          e = _error;
          if ('ENOENT' === e.code) {
            throw RangeError(M + "`node.name` '" + name + "' does not exist in filesystem");
          }
          throw Error("" + M + e.code + " checking `node.name` '" + name + "'");
        }
        if (stat.isDirectory()) {
          throw RangeError(M + "`node.name` '" + name + "' is a directory, not a file");
        }
      }
    }
    if (this.db) {
      123;
    }
    if (this.dom) {
      123;
    }
    if (this.object) {
      curr = this.object;
      for (i = r = 0, len4 = path.length; r < len4; i = ++r) {
        str = path[i];
        curr = curr[str];
      }
      if (name) {
        delete curr[name];
      } else if (0 === path.length) {
        this.object = {};
      } else if (str = path[--i]) {
        curr = curr.__;
        delete curr[str];
      }
      while (str = path[--i]) {
        curr = curr.__;
        if (1 === Object.keys(curr[str]).length) {
          delete curr[str];
        }
      }
    }
    if (this.storage) {
      key = path.length ? '/' + path.join('/') : '';
      if (name) {
        this.storage.removeItem(key + '/' + name);
      } else if (0 === path.length) {
        this.storage.clear();
      } else {
        this.storage.removeItem(key);
        l = key.length;
        subs = [];
        for (i = s = 0, ref = this.storage.length - 1; 0 <= ref ? s <= ref : s >= ref; i = 0 <= ref ? ++s : --s) {
          if ((k = this.storage.key(i)) && k.substr(0, l) === key) {
            subs.push(k);
          }
        }
        for (u = 0, len5 = subs.length; u < len5; u++) {
          k = subs[u];
          this.storage.removeItem(k);
        }
      }
      outer: //;
      while (key) {
        l = key.length;
        for (i = v = 0, ref1 = this.storage.length - 1; 0 <= ref1 ? v <= ref1 : v >= ref1; i = 0 <= ref1 ? ++v : --v) {
          if ((k = this.storage.key(i)) !== key && k.substr(0, l) === key) {
            break outer;
          }
        }
        this.storage.removeItem(key);
        key = key.replace(/\/[^\/]+$/, '');
      }
    }
    if (this.fs) {
      rel = path.length ? this.pwd + '/' + path.join('/') : this.pwd;
      if (name) {
        try {
          this.fs.unlinkSync(rel + '/' + name);
        } catch (_error) {
          e = _error;
          throw Error("" + M + e.code + " deleting `node.name` '" + name + "'");
        }
      } else if (0 === path.length) {
        this._fsClear();
      } else {
        this._fsClear(rel);
      }
      while (rel.length > this.pwd.length) {
        try {
          items = this.fs.readdirSync(rel);
        } catch (_error) {
          e = _error;
          throw Error("" + M + e.code + " deleting directory '" + rel + "'");
        }
        if (0 !== items.length) {
          break;
        }
        this.fs.rmdirSync(rel);
        rel = rel.replace(/\/[^\/]+$/, '');
      }
    }
    if (this.db) {
      123;
    }
    if (this.dom) {
      123;
    }
    return this;
  };

  Proon.prototype._fsSerializer = function(pwd) {
    var M, item, items, j, l, len, len1, m, ref, stat, sub, subs;
    if (pwd == null) {
      pwd = this.pwd;
    }
    M = "/proon/src/Proon.litcoffee _fsSerializer()\n  ";
    items = this.fs.readdirSync(pwd);
    if (0 === items.length) {
      return '[EMPTY]';
    }
    for (j = 0, len = items.length; j < len; j++) {
      item = items[j];
      stat = this.fs.statSync(pwd + '/' + item);
      if (stat.isDirectory()) {
        subs = this._fsSerializer(pwd + '/' + item);
        if ('[EMPTY]' === sub) {
          continue;
        }
        ref = subs.split('\n');
        for (m = 0, len1 = ref.length; m < len1; m++) {
          sub = ref[m];
          items.push(item + '/' + sub);
        }
      }
    }
    l = pwd.length;
    return items.sort().join('\n');
  };

  Proon.prototype._fsClear = function(start) {
    var M, e, item, items, j, len, ref, results, stat;
    if (start == null) {
      start = this.pwd;
    }
    M = "/proon/src/Proon.litcoffee _fsClear()\n  ";
    items = this._fsSerializer(start);
    if ('[EMPTY]' === items) {
      return;
    }
    ref = items.split('\n').reverse();
    results = [];
    for (j = 0, len = ref.length; j < len; j++) {
      item = ref[j];
      try {
        stat = this.fs.statSync(start + '/' + item);
      } catch (_error) {
        e = _error;
        throw Error("" + M + e.code + " checking '" + item + "'");
      }
      if (stat.isDirectory()) {
        try {
          results.push(this.fs.rmdirSync(start + '/' + item));
        } catch (_error) {
          e = _error;
          throw Error("" + M + e.code + " deleting directory '" + item + "'");
        }
      } else {
        try {
          results.push(this.fs.unlinkSync(start + '/' + item));
        } catch (_error) {
          e = _error;
          throw Error("" + M + e.code + " deleting file '" + item + "'");
        }
      }
    }
    return results;
  };

  return Proon;

})();

if (!Function.prototype.bind) {
  Function.prototype.bind = function(oThis) {
    var aArgs, fBound, fNOP, fToBind;
    if ('function' !== typeof this) {
      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
    }
    aArgs = Array.prototype.slice.call(arguments, 1);
    fToBind = this;
    fNOP = function() {};
    fBound = function() {
      return fToBind.apply((this instanceof fNOP ? this : oThis), aArgs.concat(Array.prototype.slice.call(arguments)));
    };
    if (this.prototype) {
      fNOP.prototype = this.prototype;
    }
    fBound.prototype = new fNOP;
    return fBound;
  };
}

ªA = 'array';

ªB = 'boolean';

ªE = 'error';

ªF = 'function';

ªN = 'number';

ªO = 'object';

ªR = 'regexp';

ªS = 'string';

ªU = 'undefined';

ªX = 'null';

ª = console.log.bind(console);

ªex = function(x, a, b) {
  var pos;
  if (-1 === (pos = a.indexOf(x))) {
    return x;
  } else {
    return b.charAt(pos);
  }
};

ªis = function(c, t, f) {
  if (t == null) {
    t = true;
  }
  if (f == null) {
    f = false;
  }
  if (c) {
    return t;
  } else {
    return f;
  }
};

ªhas = function(h, n, t, f) {
  if (t == null) {
    t = true;
  }
  if (f == null) {
    f = false;
  }
  if (-1 !== h.indexOf(n)) {
    return t;
  } else {
    return f;
  }
};

ªtype = function(x) {
  return {}.toString.call(x).match(/\s([a-z0-9]+)/i)[1].toLowerCase();
};

ªisU = function(x) {
  return ªU === typeof x;
};

ªuid = function(p) {
  return p + '_' + (Math.random() + '1111111111111111').slice(2, 18);
};

ªinsert = function(basis, overlay, offset) {
  return basis.slice(0, offset) + overlay + basis.slice(offset + overlay.length);
};

ªredefine = function(obj, name, value, kind) {
  switch (kind) {
    case 'constant':
      return Object.defineProperty(obj, name, {
        value: value,
        enumerable: true
      });
    case 'private':
      return Object.defineProperty(obj, name, {
        value: value,
        enumerable: false
      });
  }
};

if (ªF === typeof define && define.amd) {
  define(function() {
    return Proon;
  });
} else if (ªO === typeof module && module && module.exports) {
  module.exports = Proon;
} else {
  ªG.Proon = Proon;
}
}).call(this,this);
// Example vendor file. 
