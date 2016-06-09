(define (domain upp)
(:requirements :typing :action-costs)
(:types  size_t location_t side_t color_t image_t resource_t sheet_t)
(:constants
		Letter - size_t

		Black
		Color - color_t

		Front
		Back - side_t

		Some_Feeder_Tray
		Some_Finisher_Tray
		EndCap_Entry-BlackContainer_Exit
		HtmOverBlack_Entry-EndCap_Exit
		HtmOverBlack_Exit-Down_TopEntry
		ColorContainer_Entry-Down_BottomExit
		ColorContainer_ExitToIME-ColorPrinter_Entry
		ColorPrinter_Exit-ColorContainer_EntryFromIME
		ColorContainer_Exit-Up_BottomEntry
		Down_BottomEntry-ColorFeeder_Exit
		BlackContainer_Entry-BlackFeeder_Exit
		Down_TopExit-HtmOverColor_Entry
		HtmOverColor_Exit-Up_TopEntry
		BlackContainer_ExitToIME-BlackPrinter_Entry
		BlackPrinter_Exit-BlackContainer_EntryFromIME
		Finisher1_Entry-Up_TopExit
		Finisher2_Entry-Finisher1_Exit
		Finisher1_Tray
		Finisher2_Exit
		Finisher2_Tray - location_t

		EndCap-RSRC
		HtmOverBlack-RSRC
		ColorContainer-RSRC
		ColorPrinter-RSRC
		ColorFeeder-RSRC
		BlackFeeder-RSRC
		Down-RSRC
		HtmOverColor-RSRC
		BlackContainer-RSRC
		BlackPrinter-RSRC
		Up-RSRC
		Finisher1-RSRC
		Finisher2-RSRC - resource_t
)
(:predicates
		(Sheetsize ?sheet - sheet_t ?size - size_t)
		(Location ?sheet - sheet_t ?location - location_t)
		(Hasimage ?sheet - sheet_t ?side - side_t ?image - image_t)
		(Sideup ?sheet - sheet_t ?side - side_t)
		(Stackedin ?sheet - sheet_t ?location - location_t)
		(Imagecolor ?image - image_t ?color - color_t)
		(Notprintedwith ?sheet - sheet_t ?side - side_t ?color - color_t)
		(Oppositeside ?side1 - side_t ?side2 - side_t)
		(Available ?resource - resource_t)
		(Prevsheet ?sheet1 - sheet_t ?sheet2 - sheet_t)
		(Uninitialized)

)
(:functions (total-cost) - number)
(:action initialize
 :parameters ()
 :precondition (and
		(Uninitialized))
 :effect (and
		(not (Uninitialized))
		(Available EndCap-RSRC)
		(Available HtmOverBlack-RSRC)
		(Available ColorContainer-RSRC)
		(Available ColorPrinter-RSRC)
		(Available ColorFeeder-RSRC)
		(Available BlackFeeder-RSRC)
		(Available Down-RSRC)
		(Available HtmOverColor-RSRC)
		(Available BlackContainer-RSRC)
		(Available BlackPrinter-RSRC)
		(Available Up-RSRC)
		(Available Finisher1-RSRC)
		(Available Finisher2-RSRC))
)
(:action EndCap-Move-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available EndCap-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet EndCap_Entry-BlackContainer_Exit))
 :effect (and
		(not (Available EndCap-RSRC))
		(Location ?sheet HtmOverBlack_Entry-EndCap_Exit)
		(not (Location ?sheet EndCap_Entry-BlackContainer_Exit))
		(Available EndCap-RSRC)
		(increase (total-cost) 2000))
)
(:action HtmOverBlack-Move-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available HtmOverBlack-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet HtmOverBlack_Entry-EndCap_Exit))
 :effect (and
		(not (Available HtmOverBlack-RSRC))
		(Location ?sheet HtmOverBlack_Exit-Down_TopEntry)
		(not (Location ?sheet HtmOverBlack_Entry-EndCap_Exit))
		(Available HtmOverBlack-RSRC)
		(increase (total-cost) 17999))
)
(:action ColorContainer-ToIME-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available ColorContainer-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet ColorContainer_Entry-Down_BottomExit))
 :effect (and
		(not (Available ColorContainer-RSRC))
		(Location ?sheet ColorContainer_ExitToIME-ColorPrinter_Entry)
		(not (Location ?sheet ColorContainer_Entry-Down_BottomExit))
		(Available ColorContainer-RSRC)
		(increase (total-cost) 8000))
)
(:action ColorContainer-FromIME-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available ColorContainer-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet ColorPrinter_Exit-ColorContainer_EntryFromIME))
 :effect (and
		(not (Available ColorContainer-RSRC))
		(Location ?sheet ColorContainer_Exit-Up_BottomEntry)
		(not (Location ?sheet ColorPrinter_Exit-ColorContainer_EntryFromIME))
		(Available ColorContainer-RSRC)
		(increase (total-cost) 8000))
)
(:action ColorPrinter-Simplex-Letter
 :parameters ( ?sheet - sheet_t ?face - side_t ?image - image_t)
 :precondition (and
		(Available ColorPrinter-RSRC)
		(Sheetsize ?sheet Letter)
		(Sideup ?sheet ?face)
		(Imagecolor ?image Color)
		(Location ?sheet ColorContainer_ExitToIME-ColorPrinter_Entry)
		(Notprintedwith ?sheet ?face Color))
 :effect (and
		(not (Available ColorPrinter-RSRC))
		(Location ?sheet ColorPrinter_Exit-ColorContainer_EntryFromIME)
		(Hasimage ?sheet ?face ?image)
		(not (Location ?sheet ColorContainer_ExitToIME-ColorPrinter_Entry))
		(not (Notprintedwith ?sheet ?face Color))
		(Available ColorPrinter-RSRC)
		(increase (total-cost) 224040))
)
(:action ColorPrinter-SimplexMono-Letter
 :parameters ( ?sheet - sheet_t ?face - side_t ?image - image_t)
 :precondition (and
		(Available ColorPrinter-RSRC)
		(Sheetsize ?sheet Letter)
		(Sideup ?sheet ?face)
		(Imagecolor ?image Black)
		(Location ?sheet ColorContainer_ExitToIME-ColorPrinter_Entry)
		(Notprintedwith ?sheet ?face Black))
 :effect (and
		(not (Available ColorPrinter-RSRC))
		(Location ?sheet ColorPrinter_Exit-ColorContainer_EntryFromIME)
		(Hasimage ?sheet ?face ?image)
		(not (Location ?sheet ColorContainer_ExitToIME-ColorPrinter_Entry))
		(not (Notprintedwith ?sheet ?face Black))
		(Available ColorPrinter-RSRC)
		(increase (total-cost) 224040))
)
(:action ColorFeeder-Feed-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available ColorFeeder-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Some_Feeder_Tray))
 :effect (and
		(not (Available ColorFeeder-RSRC))
		(Location ?sheet Down_BottomEntry-ColorFeeder_Exit)
		(Sideup ?sheet Front)
		(not (Location ?sheet Some_Feeder_Tray))
		(Available ColorFeeder-RSRC)
		(increase (total-cost) 8000))
)
(:action BlackFeeder-Feed-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available BlackFeeder-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Some_Feeder_Tray))
 :effect (and
		(not (Available BlackFeeder-RSRC))
		(Location ?sheet BlackContainer_Entry-BlackFeeder_Exit)
		(Sideup ?sheet Front)
		(not (Location ?sheet Some_Feeder_Tray))
		(Available BlackFeeder-RSRC)
		(increase (total-cost) 8000))
)
(:action Down-MoveTop-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Down-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet HtmOverBlack_Exit-Down_TopEntry))
 :effect (and
		(not (Available Down-RSRC))
		(Location ?sheet Down_TopExit-HtmOverColor_Entry)
		(not (Location ?sheet HtmOverBlack_Exit-Down_TopEntry))
		(Available Down-RSRC)
		(increase (total-cost) 2999))
)
(:action Down-MoveBottom-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Down-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Down_BottomEntry-ColorFeeder_Exit))
 :effect (and
		(not (Available Down-RSRC))
		(Location ?sheet ColorContainer_Entry-Down_BottomExit)
		(not (Location ?sheet Down_BottomEntry-ColorFeeder_Exit))
		(Available Down-RSRC)
		(increase (total-cost) 2999))
)
(:action Down-MoveDown-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Down-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet HtmOverBlack_Exit-Down_TopEntry))
 :effect (and
		(not (Available Down-RSRC))
		(Location ?sheet ColorContainer_Entry-Down_BottomExit)
		(not (Location ?sheet HtmOverBlack_Exit-Down_TopEntry))
		(Available Down-RSRC)
		(increase (total-cost) 9999))
)
(:action HtmOverColor-Move-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available HtmOverColor-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Down_TopExit-HtmOverColor_Entry))
 :effect (and
		(not (Available HtmOverColor-RSRC))
		(Location ?sheet HtmOverColor_Exit-Up_TopEntry)
		(not (Location ?sheet Down_TopExit-HtmOverColor_Entry))
		(Available HtmOverColor-RSRC)
		(increase (total-cost) 9999))
)
(:action BlackContainer-ToIME-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available BlackContainer-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet BlackContainer_Entry-BlackFeeder_Exit))
 :effect (and
		(not (Available BlackContainer-RSRC))
		(Location ?sheet BlackContainer_ExitToIME-BlackPrinter_Entry)
		(not (Location ?sheet BlackContainer_Entry-BlackFeeder_Exit))
		(Available BlackContainer-RSRC)
		(increase (total-cost) 2000))
)
(:action BlackContainer-FromIME-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available BlackContainer-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet BlackPrinter_Exit-BlackContainer_EntryFromIME))
 :effect (and
		(not (Available BlackContainer-RSRC))
		(Location ?sheet EndCap_Entry-BlackContainer_Exit)
		(not (Location ?sheet BlackPrinter_Exit-BlackContainer_EntryFromIME))
		(Available BlackContainer-RSRC)
		(increase (total-cost) 2000))
)
(:action BlackPrinter-Simplex-Letter
 :parameters ( ?sheet - sheet_t ?face - side_t ?image - image_t)
 :precondition (and
		(Available BlackPrinter-RSRC)
		(Sheetsize ?sheet Letter)
		(Sideup ?sheet ?face)
		(Imagecolor ?image Black)
		(Location ?sheet BlackContainer_ExitToIME-BlackPrinter_Entry)
		(Notprintedwith ?sheet ?face Black))
 :effect (and
		(not (Available BlackPrinter-RSRC))
		(Location ?sheet BlackPrinter_Exit-BlackContainer_EntryFromIME)
		(Hasimage ?sheet ?face ?image)
		(not (Location ?sheet BlackContainer_ExitToIME-BlackPrinter_Entry))
		(not (Notprintedwith ?sheet ?face Black))
		(Available BlackPrinter-RSRC)
		(increase (total-cost) 113013))
)
(:action BlackPrinter-SimplexAndInvert-Letter
 :parameters ( ?sheet - sheet_t ?face - side_t ?otherface - side_t ?image - image_t)
 :precondition (and
		(Available BlackPrinter-RSRC)
		(Sheetsize ?sheet Letter)
		(Oppositeside ?face ?otherface)
		(Imagecolor ?image Black)
		(Location ?sheet BlackContainer_ExitToIME-BlackPrinter_Entry)
		(Notprintedwith ?sheet ?face Black)
		(Sideup ?sheet ?face))
 :effect (and
		(not (Available BlackPrinter-RSRC))
		(Location ?sheet BlackPrinter_Exit-BlackContainer_EntryFromIME)
		(Sideup ?sheet ?otherface)
		(Hasimage ?sheet ?face ?image)
		(not (Location ?sheet BlackContainer_ExitToIME-BlackPrinter_Entry))
		(not (Notprintedwith ?sheet ?face Black))
		(not (Sideup ?sheet ?face))
		(Available BlackPrinter-RSRC)
		(increase (total-cost) 123013))
)
(:action Up-MoveTop-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Up-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet HtmOverColor_Exit-Up_TopEntry))
 :effect (and
		(not (Available Up-RSRC))
		(Location ?sheet Finisher1_Entry-Up_TopExit)
		(not (Location ?sheet HtmOverColor_Exit-Up_TopEntry))
		(Available Up-RSRC)
		(increase (total-cost) 2999))
)
(:action Up-MoveUp-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Up-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet ColorContainer_Exit-Up_BottomEntry))
 :effect (and
		(not (Available Up-RSRC))
		(Location ?sheet Finisher1_Entry-Up_TopExit)
		(not (Location ?sheet ColorContainer_Exit-Up_BottomEntry))
		(Available Up-RSRC)
		(increase (total-cost) 9999))
)
(:action Finisher1-PassThrough-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Finisher1-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Finisher1_Entry-Up_TopExit))
 :effect (and
		(not (Available Finisher1-RSRC))
		(Location ?sheet Finisher2_Entry-Finisher1_Exit)
		(not (Location ?sheet Finisher1_Entry-Up_TopExit))
		(Available Finisher1-RSRC)
		(increase (total-cost) 8000))
)
(:action Finisher1-Stack-Letter
 :parameters ( ?sheet - sheet_t ?prevsheet - sheet_t)
 :precondition (and
		(Available Finisher1-RSRC)
		(Prevsheet ?sheet ?prevsheet)
		(Location ?prevsheet Some_Finisher_Tray)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Finisher1_Entry-Up_TopExit))
 :effect (and
		(not (Available Finisher1-RSRC))
		(Location ?sheet Some_Finisher_Tray)
		(Stackedin ?sheet Finisher1_Tray)
		(not (Location ?sheet Finisher1_Entry-Up_TopExit))
		(Available Finisher1-RSRC)
		(increase (total-cost) 8000))
)
(:action Finisher2-PassThrough-Letter
 :parameters ( ?sheet - sheet_t)
 :precondition (and
		(Available Finisher2-RSRC)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Finisher2_Entry-Finisher1_Exit))
 :effect (and
		(not (Available Finisher2-RSRC))
		(Location ?sheet Finisher2_Exit)
		(not (Location ?sheet Finisher2_Entry-Finisher1_Exit))
		(Available Finisher2-RSRC)
		(increase (total-cost) 8000))
)
(:action Finisher2-Stack-Letter
 :parameters ( ?sheet - sheet_t ?prevsheet - sheet_t)
 :precondition (and
		(Available Finisher2-RSRC)
		(Prevsheet ?sheet ?prevsheet)
		(Location ?prevsheet Some_Finisher_Tray)
		(Sheetsize ?sheet Letter)
		(Location ?sheet Finisher2_Entry-Finisher1_Exit))
 :effect (and
		(not (Available Finisher2-RSRC))
		(Location ?sheet Some_Finisher_Tray)
		(Stackedin ?sheet Finisher2_Tray)
		(not (Location ?sheet Finisher2_Entry-Finisher1_Exit))
		(Available Finisher2-RSRC)
		(increase (total-cost) 8000))
)
)

