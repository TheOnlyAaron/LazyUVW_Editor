/*
10-31-2014 created  by AaronDabelow theonlyaaron@gmail.com
	- Initial complete build
*/

versionNumber = 1.0

global lazyUVW_Def
global lazyUVW_UI

-- an object that contains the instructions for an operation, populated with default attributes, which will be applied to the UI
struct uvwDefinition
(
	mode = 1,
	textureMap1,
	textureMap1_tile_U = 1,
	textureMap1_tile_V = 1,
	textureMap2,
	textureMap2_tile_U = 1,
	textureMap2_tile_V = 1,
	blendMode = 1,
	blendNoise = .5,
	blendMap1,
	bakeEnabled, -- default = undefined
	bakeChannel = 1,
	bakeResolution = 2048,
	bakeDestination = @"C:\",
	bakeToMap = true
)

-- Functions for operation
struct uvwFun 
(
	-- apply uvw map modifiers for a cappedSphere
	function cappedSphere arg_OBJ =
	(
		rotRandom = (eulertoquat (eulerAngles (random 0 360) (random 0 360) (random 0 360)))		
		
		uvwMap1 = (Uvwmap maptype:2 wtile:1 vtile:1 utile:1 mapChannel:1 name:"CappedSphere - 1")
		uvwMap2 = (Uvwmap maptype:0 wtile:1 vtile:1 utile:1 mapChannel:2 name:"CappedSphere - 2")

		addmodifier arg_OBJ uvwMap1
		addmodifier arg_OBJ uvwMap2
		
		validmodifier arg_OBJ uvwMap1
		validmodifier arg_OBJ uvwMap2
		
		uvwMap1.gizmo.rotation = rotRandom
		uvwMap2.gizmo.rotation = rotRandom

		uvwFun.UVWMapFit arg_OBJ uvwMap2 2

		arg_OBJ.modifiers[2].gizmo.transform = arg_OBJ.modifiers[1].gizmo.transform
	),

	-- apply uvw map modifiers for a cappedShrinkwrap
	function cappedShrinkwrap arg_OBJ =
	(
		rotRandom = (eulertoquat (eulerAngles (random 0 360) (random 0 360) (random 0 360)))		
		
		uvwMap1 = (Uvwmap maptype:3 wtile:1 vtile:1 utile:1 mapChannel:1 name:"cappedShrinkwrap - 1")
		uvwMap2 = (Uvwmap maptype:0 wtile:1 vtile:1 utile:1 mapChannel:2 name:"cappedShrinkwrap - 2")

		addmodifier arg_OBJ uvwMap1
		addmodifier arg_OBJ uvwMap2
		
		validmodifier arg_OBJ uvwMap1
		validmodifier arg_OBJ uvwMap2
		
		uvwMap1.gizmo.rotation = rotRandom
		uvwMap2.gizmo.rotation = rotRandom

		uvwFun.UVWMapFit arg_OBJ uvwMap2 2

		arg_OBJ.modifiers[2].gizmo.transform = arg_OBJ.modifiers[1].gizmo.transform
	),	

	-- apply uvw map modifiers for a polarBlendSphere
	function polarBlendSphere arg_OBJ =
	(
		rotRandom = (eulertoquat (eulerAngles 0 0 0))
		rotRandom2 = (eulertoquat (eulerAngles 90 0 0))
		
		uvwMap1 = (Uvwmap maptype:2 wtile:1 vtile:1 utile:1 mapChannel:1 name:"polarBlendSphere - 1")
		uvwMap2 = (Uvwmap maptype:2 wtile:1 vtile:1 utile:1 mapChannel:2 name:"polarBlendSphere - 2")

		addmodifier arg_OBJ uvwMap1
		addmodifier arg_OBJ uvwMap2
		
		validmodifier arg_OBJ uvwMap1
		validmodifier arg_OBJ uvwMap2
		
 		uvwMap1.gizmo.rotation = rotRandom
 		uvwMap2.gizmo.rotation = rotRandom2

 		uvwFun.UVWMapFit arg_OBJ uvwMap1 2
 		uvwFun.UVWMapFit arg_OBJ uvwMap2 2
	),

	-- apply uvw map modifiers for a polarBlendShrinkwrap
	function polarBlendShrinkwrap arg_OBJ =
	(
		rotRandom = (eulertoquat (eulerAngles 0 0 0))
		rotRandom2 = (eulertoquat (eulerAngles 90 0 0))
		
		uvwMap1 = (Uvwmap maptype:3 wtile:1 vtile:1 utile:1 mapChannel:1 name:"polarBlendShrink - 1")
		uvwMap2 = (Uvwmap maptype:3 wtile:1 vtile:1 utile:1 mapChannel:2 name:"polarBlendShrink - 2")
		uvwMap3 = (Uvwmap maptype:1 wtile:1 vtile:1 utile:1 mapChannel:3 name:"polarBlendShrink - 3")

		addmodifier arg_OBJ uvwMap1
		addmodifier arg_OBJ uvwMap2
		addmodifier arg_OBJ uvwMap3
		
		validmodifier arg_OBJ uvwMap1
		validmodifier arg_OBJ uvwMap2
		validmodifier arg_OBJ uvwMap3
		
 		uvwMap1.gizmo.rotation = rotRandom
 		uvwMap2.gizmo.rotation = rotRandom2
 		uvwMap3.gizmo.rotation = rotRandom2

 		uvwFun.UVWMapFit arg_OBJ uvwMap1 2
 		uvwFun.UVWMapFit arg_OBJ uvwMap2 2
 		uvwFun.UVWMapFit arg_OBJ uvwMap3 2
	),

	-- apply uvw map modifiers for a wrappedPlane
	function wrappedPlane arg_OBJ =
	(
		rotRandom = (eulertoquat (eulerAngles (random 0 360) (random 0 360) (random 0 360)))		
		
		uvwMap1 = (Uvwmap maptype:0 wtile:1 vtile:1 utile:1 mapChannel:1 name:"WrappedPlane - 1")
		uvwMap2 = (Uvwmap maptype:1 wtile:1 vtile:1 utile:1 mapChannel:2 name:"WrappedPlane - 2")

		addmodifier arg_OBJ uvwMap1
		addmodifier arg_OBJ uvwMap2
		
		validmodifier arg_OBJ uvwMap1
		validmodifier arg_OBJ uvwMap2
		
		uvwMap1.gizmo.rotation = rotRandom
		uvwMap2.gizmo.rotation = rotRandom

		uvwFun.UVWMapFit arg_OBJ uvwMap1 2
		uvwFun.UVWMapFit arg_OBJ uvwMap2 2
	),

	-- Build a layered composite map and material for it
	function Material_NewMltichannel =
	(
		bitmap1 	= undefined
		bitmap2 	= undefined
		bitmapBlend = undefined

		mapCount = 0
	
		-- SET THE BITMAP TEXTURES			
		if lazyUVW_Def.textureMap1 != undefined then(mapCount += 1)
		if lazyUVW_Def.textureMap2 != undefined then(mapCount += 1)

		case mapCount of
		(
			-- User loaded no maps
			0:(
				bitmap1 = checker()
			
				bitmap1.color1 = color 150 10 10
				bitmap1.color2 = color 100 100 100
		 		bitmap1.coords.U_Tile = true
		 		bitmap1.coords.V_Tile = true
		 		bitmap1.coords.U_Tiling = 15
		 		bitmap1.coords.V_Tiling = 15
			
				bitmap2 = checker()
				bitmap2.color1 = color 10 150 10
				bitmap2.color2 = color 100 100 100
		 		bitmap2.coords.U_Tile = true
		 		bitmap2.coords.V_Tile = true
		 		bitmap2.coords.U_Tiling = 15
		 		bitmap2.coords.V_Tiling = 15
			)
			
			-- User selected only 1 map
			1:(
				if lazyUVW_Def.textureMap1 != undefined
				then
				(
					bitmap1 = Bitmaptexture fileName:lazyUVW_Def.textureMap1
					bitmap1.coords.U_Tiling = lazyUVW_Def.textureMap1_tile_U
			 		bitmap1.coords.V_Tiling = lazyUVW_Def.textureMap1_tile_V
				)
				else
				(
					bitmap1 = Bitmaptexture fileName:lazyUVW_Def.textureMap2
					bitmap1.coords.U_Tiling = lazyUVW_Def.textureMap2_tile_U
			 		bitmap1.coords.V_Tiling = lazyUVW_Def.textureMap2_tile_V
				)

				bitmap1.alphaSource 	= 2
			 	bitmap1.coords.U_Tile 	= true
		 		bitmap1.coords.V_Tile 	= true

		 		bitmap2 = copy bitmap1
			)
			
			-- User selected 2 maps
			2:(
				bitmap1 = Bitmaptexture fileName:lazyUVW_Def.textureMap1
			 	bitmap1.alphaSource 	= 2
			 	bitmap1.coords.U_Tile 	= true
		 		bitmap1.coords.V_Tile 	= true
				bitmap1.coords.U_Tiling = lazyUVW_Def.textureMap1_tile_U
			 	bitmap1.coords.V_Tiling = lazyUVW_Def.textureMap1_tile_V

				bitmap2 = Bitmaptexture fileName:lazyUVW_Def.textureMap2
			 	bitmap2.alphaSource 	= 2
			 	bitmap2.coords.U_Tile 	= true
		 		bitmap2.coords.V_Tile 	= true
				bitmap2.coords.U_Tiling = lazyUVW_Def.textureMap2_tile_U
			 	bitmap2.coords.V_Tiling = lazyUVW_Def.textureMap2_tile_V
			)
		)

		-- SET THE BLEND MAP

		-- If no map is loaded, set blendmode to procedural map mode
		if lazyUVW_Def.blendMap1 == undefined then ( lazyUVW_Def.blendMode = 1 ) else()
		
		print lazyUVW_Def.blendMode

		case lazyUVW_Def.blendMode of
		(
			-- User has chosen the procedural map
			1:(

				-- Set the mode of procedural blend map to create
				bitmapBlendMode = undefined

				case lazyUVW_Def.mode of
				(
					1:(bitmapBlendMode = 1) -- decal
					2:(bitmapBlendMode = 1) -- decal
					3:(bitmapBlendMode = 2) -- band
					4:(bitmapBlendMode = 2) -- band polar
					5:(bitmapBlendMode = 2) -- band
				)

				-- Build different types of procedural blend maps depending on case
				case bitmapBlendMode of
				(	
					-- Make Procedural Decal ( circle )
					1:(
						bitmapBlend = Gradient_Ramp ()
						bitmapBlend.Gradient_Type = 8

						bitmapBlend.Gradient_Ramp.flag__1.color = [255,255,255]
						bitmapBlend.Gradient_Ramp.flag__2.color = [0,0,0]
						bitmapBlend.Gradient_Ramp.flag__3.color = [0,0,0]

						bitmapBlend.amount = lazyUVW_Def.blendNoise
						bitmapBlend.size = 2
						bitmapBlend.Noise_Type = 1
						bitmapBlend.High_Threshold = 0.5
						bitmapBlend.phase = (random 1.00 5.00 )

						bitmapBlend.Coordinates.mapChannel = 2
					)

					-- Make Procedural band ( gradient )
					2:(
						bitmapBlend = Gradient_Ramp ()
						bitmapBlend.Gradient_Type = 4

						bitmapBlend.Gradient_Ramp.flag__1.color = [0,0,0]
						bitmapBlend.Gradient_Ramp.flag__2.color = [0,0,0]
						bitmapBlend.Gradient_Ramp.flag__3.color = [255,255,255]

						bitmapBlend.amount = lazyUVW_Def.blendNoise
						bitmapBlend.size = 2
						bitmapBlend.Noise_Type = 1
						bitmapBlend.High_Threshold = 1
						bitmapBlend.phase = (random 1.00 5.00 )

						bitmapBlend.Coordinates.mapChannel = 2

						bitmapBlend.Coordinates.U_Tile = false
						bitmapBlend.Coordinates.U_Tiling = 1.5
						bitmapBlend.Coordinates.W_Angle = 90
					)
				)
			)

			-- User has chosen a bitmap file
			2:(
				bitmapBlend						= Bitmaptexture fileName:lazyUVW_Def.blendMap1
				bitmapBlend.coords.mapChannel 	= 2
			)
		)

		-- build the new composite map
		newCompMap = CompositeTexturemap ()
		newCompMap.mapEnabled.count = 2

		-- apply the bitmap into the first map channel
		newCompMap.layername[1] = "MapChannel 1 -"
		newCompMap.mapList[1] = bitmap1
		newCompMap.mapList[1].coords.mapChannel = 1

		-- apply the bitmap into the second map channel
		newCompMap.layername[2] = "MapChannel 2 -"
		newCompMap.mapList[2] = bitmap2
		newCompMap.mapList[2].coords.mapChannel = 2

		-- apply the mask
		newCompMap.Mask[2] = bitmapBlend
		if lazyUVW_Def.mode == 4
		then (newCompMap.Mask[2].Coordinates.mapChannel = 3)
		else()

		-- Build the new material
		newMat = Standardmaterial()
		newMat.diffuseMapEnable = on
		newMat.diffuseMap = newCompMap
		newMat.showInViewport = true

		-- return the new material
		return newMat
	),

	-- Function for creating and applying a material
	function Material_NewBaked arg_OBJ arg_MAP =
	(
		newMat = Standardmaterial()
		newMat.diffuseMap = Bitmaptexture fileName:arg_MAP
		newMat.diffuseMap.alphaSource = 2
		newMat.showInViewport = true
		newMat.name = ( arg_OBJ.name + "_bake" )
		
		arg_OBJ.material = newMat
	),

	-- function for fitting uvwMap modifiers to the dimensions of the object
	function UVWMapFit theObj theMap theFitMode useSel:#none = -- theFitMode 1:snug boundaries 2:proportional boundaries
	(
		theMap.gizmo.transform *= inverse (scaleMatrix theMap.gizmo.transform.scalepart)
		theMesh = theObj.mesh 
		minX = minY = minZ = 100000000 
		maxX = maxY = maxZ = -100000000
		theTM = theMap.gizmo.transform
		theTMInv = inverse theTM 

		theVerts = case useSel of
		(
		#none: #{1..theMesh.numverts}
		#verts: (getVertSelection theMesh)
		#edges: (meshop.getVertsUsingEdge theMesh (getEdgeSelection theMesh))
		#faces: (meshop.getVertsUsingFace theMesh (getFaceSelection theMesh))
		)

		for v in theVerts do
		(
		  theVert = (getVert theMesh v) * theTMInv

		  if theVert.x > maxX do maxX = theVert.x 
		  if theVert.y > maxY do maxY = theVert.y
		  if theVert.z > maxZ do maxZ = theVert.z
		  if theVert.x < minX do minX = theVert.x 
		  if theVert.y < minY do minY = theVert.y
		  if theVert.z < minZ do minZ = theVert.z
		)

		delete theMesh

		case theMap.axis of
		(
		  0: (
			X = maxZ - minZ 
			Y = maxY - minY
			Z =maxX - minX
		  )
		  1: (
			X = maxX - minX
			Y = maxZ - minZ
			Z =maxY - minY
		  )
		  2: (
			X = maxX - minX
			Y = maxY - minY
			Z = maxZ - minZ
		  ) 
		)

		if theVerts.numberset == 0
		then
		(
			X = Y = Z = 10
		)
		else
		(
		  X += 0.001*X
		  Y += 0.001*Y
		  Z += 0.001*Z
		)

		case theFitMode of
		(
			1:(
			theMap.length = Y 
			theMap.width = X 
			theMap.height= Z 
			)
			
			2:(
			curMax = ( amax #((abs X),(abs Y),(abs Z)) )
			theMap.length = curMax
			theMap.width = curMax
			theMap.height= curMax
			)
			
		)

		case theMap.maptype of
		(
		  default: theMap.width = theMap.length = amax #(X,Y)
		  0: () 
		  1: (
			case theMap.axis of
			(
			  0: (theMap.width = theMap.length = amax #(X,Z); theMap.height = Y)
			  1: (theMap.width = theMap.length = amax #(Y,Z); theMap.height = X)
			  2: (theMap.width = theMap.length = amax #(X,Y); theMap.height = Z)
			)
		  ) 
		  2: theMap.width = theMap.length = theMap.height = amax #(X,Y,Z)
		  3: theMap.width = theMap.length = theMap.height = amax #(X,Y,Z)
		  4: ()
		)

		theCenter = ([maxX,maxY,maxZ] + [minX,minY,minZ])/2.0 
		theCenter *= theTM 
		theTM.row4 = theCenter
		theMap.gizmo.transform = theTM
	),

	-- function for baking diffuse map
	function bakeToMap arg_OBJ arg_ITERATION = 
	(
		-- setup variables
		obj 			= arg_OBJ
		size 			= lazyUVW_Def.bakeResolution
		bakeChannel 	= lazyUVW_Def.bakeChannel
		indexSTR		= ("bake_" + (substring ( ( arg_ITERATION + 10000 ) as string ) 2 999 ) + "_")
		select arg_OBJ	

		-- set bake options
		obj.INodeBakeProperties.bakeEnabled = true
		obj.INodeBakeProperties.bakeChannel = 10
		obj.INodeBakeProperties.nDilations = 4 		-- padding distance

		-- create a bitmap, to store the bake into
		bitm = bitmap size size

		-- create a bake diffuse map operation
		map = DiffuseMap()
		map.enabled = true
		map.outputSzX = size	
		map.outputSzY = size
		map.filenameUnique = false
		map.elementname = "test"
		map.filetype = (lazyUVW_Def.bakeDestination + indexSTR + obj.name + ".tga")		-- filetype needed to render to

		-- remove any previous bake operations, and add our new one
		obj.removeAllBakeElements()
		obj.addBakeElement map

		-- Render the diffuse map to the previously created bitmap, and save it
		undisplay (
			render rendertype:#bakeSelected vfb:on outputSize:[size,size] to:bitm --outputFile:(@"C:\"+obj.name+".tga") 
			)

		-- clear the bake definition, and clear selection
 		obj.removeAllBakeElements()
		clearselection()

		-- move uvws from channel 10 to the desired channel
		obj.modifiers[1].unwrap.setMapChannel bakeChannel

		return map.filetype
	),

	-- function for creating automatic uvws
	function automaticUnwrap arg_OBJ =
	(
		print "function automaticUnwrap"

		max modify mode 
		select arg_OBJ										
			
		-- add volumeselect
		newVolSel = Vol__Select	level:2 method:0
		addModifier arg_OBJ newVolSel

		-- add automaticUnwrap
		addModifier arg_OBJ (uvwunwrap())					
		arg_OBJ.modifiers[1].name = "Automatic Flatten UVs"	
		arg_OBJ.modifiers[1].unwrap.setMapChannel 10

		-- flatten uvws
		tw_modpanel = modpanel.getcurrentobject()	
		tw_modpanel.flattenMapNoParams()

		-- remove the volumeselect
		deleteModifier arg_OBJ 2
		
		clearselection()
	),

	-- Main action, performs the chosen actions
	function applyUVW = 
	(
		disablesceneredraw()
		timerStart = timeStamp()

		-- Store your selection as an array
		selArr = #()
		selArr = selection as array

		-- Create a material for all the objects
 		curMaterial = uvwFun.Material_NewMltichannel()

 		bankRenderer = renderers.current
		renderers.current = Default_Scanline_Renderer ()

		-- loop through selection array
		for i in 1 to selArr.count do
		(
			lazyUVW_UI.prog_main.value = (( (i - 1) / (selArr.count as float ) ) * 100 )
			lazyUVW_UI.lab_status.text = ( " processing " + selArr[i].name )

			-- Poison pill
			if keyboard.escPressed do
			(
				lazyUVW_UI.lab_status.text =  (" Process terminated")
				exit
			)

			-- skip objects that are not geometry
			if (superclassof selArr[i]) == GeometryClass
			then
			(
				-- skip objects that are in a group
				if ( isgroupmember selArr[i] ) == false
				then
				(
  					try(

						print curMaterial

						-- Apply chosen mapping mode to current object
						lazyUVW_UI.lab_status.text = ( " Applying uvws " + selArr[i].name )

						case lazyUVW_Def.mode of
						(
							1: (uvwFun.cappedSphere				selArr[i])
							2: (uvwFun.cappedShrinkwrap			selArr[i])
							3: (uvwFun.polarBlendSphere			selArr[i])
							4: (uvwFun.polarBlendShrinkwrap		selArr[i])
 							5: (uvwFun.wrappedPlane				selArr[i])
						)

						-- apply the material
 						selArr[i].material = curMaterial

						-- Bake map if chosen to do so
						if lazyUVW_Def.bakeEnabled == true
						then
						(
							selArr[i].material.selfIllumAmount = 100

							lazyUVW_UI.lab_status.text = ( " Unwrapping " + selArr[i].name )
							uvwFun.automaticUnwrap		selArr[i]

							lazyUVW_UI.lab_status.text = ( " Baking " + selArr[i].name )
							curMap = uvwFun.bakeToMap			selArr[i] i

							if lazyUVW_Def.bakeToMap then
							(
								uvwFun.Material_NewBaked selArr[i] curMap
							)
							else()
						)
						else()
  					)
  					catch( Print ("Problem with object: " + selArr[i].name + ", Unable to perform operations"))
				)
				else(Print ("Problem with object: " + selArr[i].name + ", it is inside a group"))
			)
			else(Print ("Problem with object: " + selArr[i].name + ", it is not a valid piece of geometry"))
		)

		select selArr
		renderers.current = bankRenderer

		lazyUVW_UI.prog_main.value = 100
		timerEnd = timeStamp()
		lazyUVW_UI.lab_status.text =  ("Processing took : " + (((timerEnd - timerStart) / 1000.0) as string) + " s")
		enablesceneredraw()
		redrawviews()
	),

	-- Set the UI to the values in the definition
	function updateUI arg_UI =
	(
		arg_UI.ddl_mode.selection		= lazyUVW_Def.mode
		arg_UI.spn_blendmap_noise.value = lazyUVW_Def.blendNoise
		arg_UI.spn_bakeChannel.value	= lazyUVW_Def.bakeChannel
		arg_UI.spn_bakeResolution.value = lazyUVW_Def.bakeResolution
		arg_UI.chk_bakeToMap.checked	= lazyUVW_Def.bakeToMap
	)
)

-- Complete UI and UI functions
struct uvwUI
(
	function ui ui_name =
	(
		rollout rollout_ui ui_name width:200 height:505
		(
			groupbox grp_mode "Mode" width:(rollout_ui.width - 20) height:42 align:#left offset:[-4,0]
				dropdownlist ddl_mode "" items:#(" Capped Sphere"," Capped Shrinkwrap", " Polar Blend Sphere", " Polar Blend Shrinkwrap", " Wrapped Plane") align:#left offset:[0,(grp_mode.height * -1 + 10)] width:(rollout_ui.width - 30)

			groupbox grp_map "Texture Map(s)" width:(rollout_ui.width - 20) height:93 align:#left offset:[-4,3]
				button btn_loadMaps "load map" 		width:80 height:15 align:#left offset:[5,(grp_map.height * -1 + 10)]
				button btn_clearMaps "clear map"	width:80 height:15 align:#left offset:[87,-20]
				listbox lst_maps height:2 width:(rollout_ui.width - 38) align:#left offset:[5,-3] items:#("1:","2:")
				spinner spn_map1_tileU "Tile U:" type:#float width:60 range:[1,10,1] align:#left offset:[2,0]
				checkbutton chk_mapTileLock "L" width:17 height:17 align:#left offset:[79,-21] checked:true
				spinner spn_map1_tileV "Tile V:" type:#float width:60 range:[1,10,1] align:#left offset:[97,-21] enabled:false

			groupbox grp_blend "Blend Map" width:(rollout_ui.width - 20) height:120 align:#left offset:[-4,5] 
				checkbox chk_blendmap "Procedural Map" offset:[3,(grp_blend.height * -1 + 10)] checked:true
					spinner spn_blendmap_noise "Irregularity:" range:[0.00, 1.00, .5] width:80 align:#left offset:[5,0]

				checkbox chk_blendtex "Texture File" offset:[3,0]
					button btn_loadBlend "load map" 		width:80 height:15 align:#left offset:[5,0]									enabled:false
					button btn_clearBlend "clear map"	width:80 height:15 align:#left offset:[87,-20]									enabled:false
					listbox lst_blend height:1 width:(rollout_ui.width - 38) align:#left offset:[5,-3] items:#("...") readOnly:true		enabled:false

			groupbox grp_bake "Bake" width:(rollout_ui.width - 20) height:140 align:#left offset:[-4,10]
				checkbox chk_bakeToggle "Bake to map" checked:false offset:[3,(grp_bake.height * -1 + 10)]
				spinner spn_bakeChannel "Bake to map channel:" type:#integer width:130 align:#left offset:[4,0] range:[1, 20, 1 ] 				enabled:false
				spinner spn_bakeResolution "Baked map resolution" type:#integer width:131 align:#left offset:[4,0] range:[128, 4096, 1024 ] 	enabled:false
				button btn_BakeSave "Map(s) destination" width:(rollout_ui.width - 38) height:15 align:#left offset:[5,0]						enabled:false	
				listbox lst_BakeSave height:1 width:(rollout_ui.width - 38) align:#left offset:[5,-3] items:#("...") readOnly:true				enabled:false
				checkbox chk_bakeToMap "Load map into applied material" 																		enabled:false

			button btn_createUVW "Apply UVWs to selection" height:30 width:(rollout_ui.width - 20) offset:[0,5]

			progressbar prog_main width:(rollout_ui.width - 20) height:8 offset:[-3,0]
			label lab_status  " status: ready" style_sunkenedge:true width:(rollout_ui.width - 20) height:15 offset:[0,0]

			hyperLink aaronDabelow "© 2014 Aaron Dabelow" address:"http://aarondabelow.com/" align:#center

			on ddl_mode selected arg do ( lazyUVW_Def.mode = arg) 

			on btn_loadMaps pressed do
			(
				curMapSlot = lst_maps.selection

				newFile = undefined
				newFile = getOpenFileName()

				if newFile == undefined 
				then()
				else
				(
					curItems = lst_maps.items
					newFilename = (filenamefrompath newFile)

					case curMapSlot of
					(
						1:
						(
							headder = "1: "
							lazyUVW_Def.textureMap1 = newFile
						)

						2:
						(
							headder = "2: "
							lazyUVW_Def.textureMap2 = newFile
						)
					)

					curItems[curMapSlot] = (headder + newFilename)
					lst_maps.items = curItems
				)
			)

			on btn_clearMaps pressed do
			(
				curMapSlot 	= lst_maps.selection
				curItems 	= lst_maps.items

				case curMapSlot of
				(
					1:
					(
						curItems[1] = "1: "
						lazyUVW_Def.textureMap1 = undefined
					)

					2:
					(
						curItems[2] = "2: "
						lazyUVW_Def.textureMap2 = undefined
					)
				)

				lst_maps.items = curItems
			)

			on lst_maps selected state do
			(
				case state of
				(
					1:
					(
						spn_map1_tileU.value = lazyUVW_Def.textureMap1_tile_U
						spn_map1_tileV.value = lazyUVW_Def.textureMap1_tile_V
					)

					2:
					(
						spn_map1_tileU.value = lazyUVW_Def.textureMap2_tile_U
						spn_map1_tileV.value = lazyUVW_Def.textureMap2_tile_V
					)
				)
			)

			on chk_mapTileLock changed state do
			(
				if state then (stateINV = false) else(stateINV = true)

				spn_map1_tileV.enabled = stateINV
			)

			on spn_map1_tileU changed state do
			(
				curMapSlot 	= lst_maps.selection

				if chk_mapTileLock.checked
				then(spn_map1_tileV.value = state)
				else()

				case curMapSlot of
				(
					1:
					(
						lazyUVW_Def.textureMap1_tile_U = spn_map1_tileU.value
						lazyUVW_Def.textureMap1_tile_V = spn_map1_tileV.value
					)

					2:
					(
						lazyUVW_Def.textureMap2_tile_U = spn_map1_tileU.value
						lazyUVW_Def.textureMap2_tile_V = spn_map1_tileV.value
					)
				)
			)

			on spn_map1_tileV changed state do
			(
				curMapSlot 	= lst_maps.selection

				case curMapSlot of
				(
					1:
					(
						lazyUVW_Def.textureMap1_tile_V = spn_map1_tileV.value
					)

					2:
					(
						lazyUVW_Def.textureMap2_tile_V = spn_map1_tileV.value
					)
				)
			)

			on chk_blendmap changed state do
			(
			 	if state == true
			 	then
			 	(
			 		stateINV = false
			 		lazyUVW_Def.blendmode = 1
			 	)
			 	else
			 	(
			 		stateINV = true
			 		lazyUVW_Def.blendmode = 2
			 	)

			 	chk_blendmap.checked		= state
			 	chk_blendtex.checked		= stateINV
			 	spn_blendmap_noise.enabled 	= state
			 	btn_loadBlend.enabled		= stateINV
			 	btn_clearBlend.enabled		= stateINV
			 	lst_blend.enabled			= stateINV
			)

			on spn_blendmap_noise changed state do ( lazyUVW_Def.blendNoise = spn_blendmap_noise.value )

			on chk_blendtex changed state do
			(
			 	if state == true
			 	then
			 	(
			 		stateINV = false
			 		lazyUVW_Def.blendmode = 2
			 	)
			 	else
			 	(
			 		stateINV = true
			 		lazyUVW_Def.blendmode = 1
			 	)
			 	chk_blendtex.checked		= state
			 	chk_blendmap.checked		= stateINV
			 	spn_blendmap_noise.enabled 	= stateINV
			 	btn_loadBlend.enabled		= state
			 	btn_clearBlend.enabled		= state
			 	lst_blend.enabled			= state

			 	lazyUVW_Def.blendmode = 2
			)			

			on btn_loadBlend pressed do
			(
				newFile = undefined
				newFile = getOpenFileName()
				if newFile == undefined
				then()
				else
				(
					lazyUVW_Def.blendMap1 = newFile
					lst_blend.items = #(filenamefrompath newFile)
				)
			)

			on btn_clearBlend pressed do
			(
				lazyUVW_Def.blendMap1 = undefined
				lst_blend.items = #("...")
			)

			on chk_bakeToggle changed state do
			(
				spn_bakeChannel.enabled 	= state
				spn_bakeResolution.enabled	= state
				btn_BakeSave.enabled 		= state
				lst_BakeSave.enabled 		= state
				chk_bakeToMap.enabled 		= state

				lazyUVW_Def.bakeEnabled 	= state
			)

			on spn_bakeChannel changed state 	do (lazyUVW_Def.bakeChannel = state)

			on spn_bakeResolution changed state do (lazyUVW_Def.bakeResolution = state)

			on btn_BakeSave pressed do
			(
				targetDir = undefined
				targetDir = getSavePath()
				if targetDir == undefined
				then (lazyUVW_Def.bakeDestination = @"C:\" )
				else (lazyUVW_Def.bakeDestination = (targetDir + @"\") )

				uvwUI.set_BakeSave_Text()
			)

			on chk_bakeToMap changed state do ( lazyUVW_Def.bakeToMap = state )

			on btn_createUVW pressed do (uvwFun.applyUVW())
		)

		createdialog rollout_ui
		return rollout_ui
	),

	function set_BakeSave_Text =
	(
		if lazyUVW_Def.bakeDestination.count > 25
		then (lst_text = ("..." + (substring lazyUVW_Def.bakeDestination (lazyUVW_Def.bakeDestination.count - 23) 9999)))
		else (lst_text = (lazyUVW_Def.bakeDestination ))

		lazyUVW_UI.lst_BakeSave.items = #(lst_text)
	)
)

-- Create a new definition of the actions to perform
lazyUVW_Def = uvwDefinition()

-- Build new dialog, and set its properties to match the definition preset
try(destroydialog lazyUVW_UI)catch()
lazyUVW_UI = uvwUI.ui ("Lazy UVWs " + versionNumber as string)
uvwFun.updateUI lazyUVW_UI