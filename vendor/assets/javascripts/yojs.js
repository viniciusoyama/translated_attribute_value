// git@github.com:codus/yojs.git
// Version: 0.0.1

if(!Array.prototype.last) {
  Array.prototype.last = function() {
    return this[this.length - 1];
  }
}

var yojs = (function(){
  var nameFunctionHash = {};
  var parentsNamespaces = [];

  var getNameSpaceResult = function(namespace, arguments) {
    if (typeof(nameFunctionHash[namespace]) == 'function') {
      return nameFunctionHash[namespace].apply(this, arguments);
    } else {
      return nameFunctionHash[namespace];
    }
  }
  return {
    define: function(namespace, value) {
      if (this.isDefined(namespace)) {
        var errorMessage = "Error: trying to define namespace '" + namespace + "'' twice";
        throw errorMessage;
      } else {
        nameFunctionHash[namespace] = value;
      }
      return;
    },

    set: function(namespace, value) {
      nameFunctionHash[namespace] = value;
    },

    call: function(namespace){
      var parentNamespaceArray = namespace.split(".");
      var lastNameCalled = parentNamespaceArray.pop();
      var currentParentNamespace = parentNamespaceArray.join(".");
      var returnValue = null;
      var lastParentNamespace = parentsNamespaces.last();
      var functionWithLastParentClassNamespace = lastParentNamespace + "." + lastNameCalled;
      var errorMessage = "";
      var calledFunctionArguments = Array.prototype.slice.apply(arguments, [1]);

      parentsNamespaces.push(currentParentNamespace);

      if (this.isDefined(namespace)) {
        returnValue = getNameSpaceResult(namespace, calledFunctionArguments);
      } else if (this.isDefined(functionWithLastParentClassNamespace)) {
        returnValue = getNameSpaceResult(functionWithLastParentClassNamespace, calledFunctionArguments);
      } else {
        var errorMessage = "Error: called namespace '" + namespace + "'. But it doesn't exist.";
        throw errorMessage;
      }

      parentsNamespaces.pop();

      return returnValue;
    },

    get: function(namespace) {
      return this.call(namespace);
    },

    isDefined: function(namespace) {
      return nameFunctionHash.hasOwnProperty(namespace);
    }
  }
}());
