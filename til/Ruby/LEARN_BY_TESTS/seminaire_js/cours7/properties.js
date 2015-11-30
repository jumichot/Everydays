// existe des propriétés genre enumerable
// enumerable : false  -> contenu invisible dans le console.log, ou les parcours genre in
// writeable : true -> tu peux faire égale dessus. Si tu mets un objet tu peux pas modifier la reference mais tu peux modifier cet objet
// configurable : false -> tu peux plus supprimer l'attribut. deleteObjAt, et on peux pas modifier la conf, genre defineProperty. Empeche de faire des conf et de supprimer les attributs
// toute les conf par défauts à true.
// define property met tout à false par défaut
// si pas en mode strict si un object est en writeable false et qu'on essaye de setter ça ne va pas lever une exception.
// toujours utiliser le mode strict
// car idem avec le delete pas forcément de throw.

'use strict';

