#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the resolverPreCondition
// library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

versionInfo:    GameID
        name = 'resolverPreCondition Library Demo Game'
        byline = 'Diegesis & Mimesis'
        desc = 'Demo game for the resolverPreCondition library. '
        version = '1.0'
        IFID = '12345'
	showAbout() {
		"This is a simple test game that demonstrates the features
		of the resolverPreCondition library.
		<.p>
		What to look for:  you CANNOT take anything from the
		starting room and you CAN take things from the other room.
		This is all controlled by preconditions that are applied
		before noun resolution.
		<.p>
		The difference between what's provided by this module and
		stock T3/adv3 is that a <q>normal</q> action precondition would
		result in a noun disambiguation prompt prior to the failure
		message.  That is, if you just typed &gt;TAKE in the starting
		room, you'd be asked if you meant the black or white stone
		before being told that you can't take anything.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;

class NoTakeRoom: Room
	noTake = true
;

modify playerActionMessages
	cantTakeHere = '{You/he} can\'t take anything here. '
;

checkTakeFlag: ResolverPreCondition
	checkResolverPreCondition() {
		local rm;

		if(((rm = gActor.getOutermostRoom()) == nil)
			|| (rm.noTake == true)) {
			reportFailure(&cantTakeHere);
			exit;
		}

		return(nil);
	}
;

modify TakeAction
	resPreCond = static [ checkTakeFlag ]
;

startRoom: NoTakeRoom 'Void'
        "This is a featureless void.  Nothing can be taken here.  The other
		room is to the north. "
	north = otherRoom
;
+me: Person;
+blackStone: Thing '(black) (go) stone' 'black go stone' "A black go stone. ";
+whiteStone: Thing '(white) (go) stone' 'white go stone' "A white go stone. ";

otherRoom: Room 'The Other Room'
	"This is the other room.  Things can be taken here.  The void is to
		the south. "
	south = startRoom
;
+rock: Thing 'ordinary rock' 'rock' "An ordinary rock. ";

gameMain: GameMainDef initialPlayerChar = me;
