#charset "us-ascii"
//
// resolverPreCondition.t
//
#include <adv3.h>
#include <en_us.h>

#include "resolverPreCondition.h"

// Module ID for the library
resolverPreConditionModuleID: ModuleID {
        name = 'Resolver Precondition Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

// Minimal class definition:  all a ResolverPreCondition needs is
// a checkResolverPreCondition() method.
class ResolverPreCondition: object checkResolverPreCondition() {};

// Modify the Action defition to add resolver preconditions and
// a method to check them.
modify Action
	resPreCond = static []

	resolverVerifyAction() {
		resPreCond.forEach(function(o) {
			(o).checkResolverPreCondition();
		});
	}
;

// We put this in a preprocessor conditional, but this should be
// unnecessary because we should error out in the header if its not
// defined. 
#ifdef MODULAR_EXECUTE_COMMAND_H

modify modularExecuteCommand
	getFirstAction(match) {
		local r;

		if((r = inherited(match)) != nil)
			r.resolverVerifyAction();

		return(r);
	}
;

#endif // MODULAR_EXECUTE_COMMAND_H
