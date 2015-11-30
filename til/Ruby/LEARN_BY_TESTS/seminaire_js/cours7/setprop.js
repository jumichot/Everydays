// écrire setProp, object , attrib, valeur, 'ewc')
'use strict';

function setProp(object, prop, value, mode) {
  mode = mode || 'ewc';
  var mode_config = {};
  // ~ true que pour -1
  // mode_config.value = !~mode.indexOf('v');
  if(mode.indexOf('w') !== -1) mode_config.writable = true;
  if(mode.indexOf('e') !== -1) mode_config.enumerable = true;
  if(mode.indexOf('c') !== -1) mode_config.configurable = true;
  Object.defineProperty(object, prop, mode_config);

  object[prop] = object[prop] || value;
  return object;
}
