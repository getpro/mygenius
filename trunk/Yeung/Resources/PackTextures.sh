#!/bin/sh

# PackTextures.sh
# GuessWhat
#
# Created by Peteo on 12-4-9.
# Copyright 2012 The9. All rights reserved.


if [ 1 == 0 ]
then

	TP="/usr/local/bin/TexturePacker"

	if [ "${ACTION}" = "clean" ]
	then
	echo "cleaning..."
	rm Resources/game/*.plist
	rm Resources/game/*.pvr.ccz
	else
	echo "building..."

    #game
	${TP} --smart-update \
	--format cocos2d \
	--data  Resources/game/game-hd.plist \
	--sheet Resources/game/game-hd.pvr.ccz \
	--dither-fs-alpha \
	--premultiply-alpha \
	--opt RGBA4444 \
	Art/game/*.png
	${TP} --smart-update \
	--format cocos2d \
	--data  Resources/game/game.plist \
	--sheet Resources/game/game.pvr.ccz \
	--dither-fs-alpha \
	--premultiply-alpha \
	--scale 0.5 \
	--opt RGBA4444 \
	Art/game/*.png
	
	fi
	exit 0

fi
