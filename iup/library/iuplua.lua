---@meta
---@class iup
local iup = {}

---@class ihandle: userdata
---@field size string
---@field expand string
local ihandle = {}

-- Callbacks start

---Action called when a file is "dropped" into the control. When several files are dropped at once, the callback is called several times, once for each file.
---If defined after the element is mapped then the attribute DROPFILESTARGET must be set to YES.
---[Windows and GTK Only] (GTK 2.6)
---@param self ihandle -- identifier of the element that activated the event
---@param filename string -- Name of the dropped file
---@param num integer -- Number index of the dropped file. If several files are dropped, num is the index of the dropped file starting from `total-1` to `0`
---@param x integer -- X coordinate of the point where the user released the mouse button
---@param y integer -- Y coordinate of the point where the user released the mouse button
local function dropfiles_cb(self, filename, num, x, y) end

---Called just before a dialog is closed when the user clicks the close button of the title bar or an equivalent action.
---@param self ihandle
---@return integer `iup.IGNORE`|`iup.CLOSE`
local function close_cb(self) end


---[Windows Only]: Called at the first instance, when a second instance is running. Must set the global attribute SINGLEINSTANCE to be called. (since 3.2)
---@param self ihandle
---@param cmdLine string -- command line of the second instance
---@param size integer -- size of the command line string including the null character
---@return integer
local function copydata_cb(self, cmdLine, size) end

---[Windows Only]: Called when the dialog must be redraw. Although it is designed for drawing the frame elements, all the dialog must be painted. Works only when CUSTOMFRAME or CUSTOMFRAMEEX is defined. The dialog can be used just like an IupCanvas to draw its elements, the HDC_WMPAINT and CLIPRECT attributes are defined during the callback. For mouse callbacks use the same callbacks as IupCanvas, such as BUTTON_CB and MOTION_CB. (since 3.18)
---@param self ihandle
---@return integer
local function customframe_cb(self) end

---@param self ihandle
---@param active integer
---@return integer
local function customframeactivate_cb(self, active) end

---Called when the dialog or any of its children gets the focus, or when another dialog or any control in another dialog gets the focus. It is called after the common callbacks GETFOCUS_CB and KILL_FOCUS_CB. (since 3.21)
---@param self ihandle
---@param focus integer
---@return integer
local function focus_cb(self, focus) end

---[Windows Only]: Called when a MDI child window is activated. Only the MDI child receive this message. It is not called when the child is shown for the first time.
---@param self ihandle
---@return integer
local function mdiactivate_cb(self) end

---@param self ihandle
---@param x integer
---@param y integer
---@return integer
local function move_cb(self, x, y) end

---Action generated when the dialog size is changed. If returns IUP_IGNORE the dialog layout is NOT recalculated. (since 3.0)
---@param self ihandle
---@param width integer
---@param height integer
---@return integer
local function resize_cb(self, width, height) end

---Called right after the dialog is showed, hidden, maximized, minimized or restored from minimized/maximized. This callback is called when those actions were performed by the user or programmatically by the application.
---@param self ihandle
---@param state integer
---@return integer
local function show_cb(self, state) end

---[Windows and GTK Only]: Called right after the mouse button is pressed or released over the tray icon. (GTK 2.10)
---@param self ihandle
---@param but integer -- identifies the activated mouse button. Can be: 1, 2 or 3. Note that this is different from the BUTTON_CB canvas callback definition. GTK does not get button=2 messages
---@param pressed integer -- indicates the state of the button. Always 1 in GTK
---@param dclick integer -- indicates a double click. In GTK double click is simulated
---@return integer|`iup.CLOSE` -- IUP_CLOSE will be processed.
local function trayclick_cb(self, but, pressed, dclick) end

---Called right after an element is mapped and its attributes updated in IupMap.
---
---When the element is a dialog, it is called after the layout is updated. For all other elements is called before the layout is updated, so the element current size will still be 0x0 during MAP_CB (since 3.14)
---@param self ihandle
---@return integer
local function map_cb(self) end

---Called right before an element is unmapped in IupUnmap.
---@param self ihandle
---@return integer
local function unmap_cb(self) end

---Called right before an element is destroyed.
---@param self ihandle
---@return integer
---
---If the dialog is visible then it is hidden before it is destroyed. The callback will be called right after it is hidden.
---The callback will be called before all other destroy procedures.
---For instance, if the element has children then it is called before the children are destroyed. If the element is mapped, it is called before the element is unmapped, so before UNMAP_CB.
---For language binding implementations use the callback LDESTROY_CB.
local function destroy_cb(self) end

---Action generated when an element is given keyboard focus. This callback is called after the KILLFOCUS_CB of the element that lost the focus. The IupGetFocus function during the callback returns the element that lost the focus.
---@param self ihandle
---@return integer
local function getfocus_cb(self) end

---Action generated when an element loses keyboard focus. This callback is called before the GETFOCUS_CB of the element that gets the focus.
---@param self ihandle
---@return integer
local function killfocus_cb(self) end

---Action generated when the mouse enters the native element.
---@param self ihandle
---@return integer
---
---When the cursor is moved from one element to another, the call order in all platforms will be first the LEAVEWINDOW_CB callback of the old control followed by the ENTERWINDOW_CB callback of the new control. (since 3.14)
---
---If the mouse button is hold pressed and the cursor moves outside the element the behavior is system dependent. In Windows the LEAVEWINDOW_CB/ENTERWINDOW_CB callbacks are NOT called, in GTK the callbacks are called.
local function enterwindow_cb(self) end

---Action generated when the mouse leaves the native element.
---@param self ihandle
---@return integer
---
---When the cursor is moved from one element to another, the call order in all platforms will be first the LEAVEWINDOW_CB callback of the old control followed by the ENTERWINDOW_CB callback of the new control. (since 3.14)
---
---If the mouse button is hold pressed and the cursor moves outside the element the behavior is system dependent. In Windows the LEAVEWINDOW_CB/ENTERWINDOW_CB callbacks are NOT called, in GTK the callbacks are called.
local function leavewindow_cb(self) end

---@param self ihandle
---@param c integer -- identifier of typed key. $TODO: Do alias keys, or enums keys
---@return integer
---
---Keyboard callbacks depend on the keyboard usage of the control with the focus. So if you return IUP_IGNORE the control will usually not process the key. But be aware that sometimes the control process the key in another event so even returning IUP_IGNORE the key can get processed. Although it will not be propagated.
---
---IMPORTANT: The callbacks "K_*" of the dialog or native containers depend on the IUP_CONTINUE return value to work while the control is in focus.
---
---If the callback does not exists it is automatically propagated to the parent of the element.
---
---K_* callbacks
---All defined keys are also callbacks of any element, called when the respective key is activated. For example: "K_cC" is also a callback activated when the user press Ctrl+C, when the focus is at the element or at a children with focus. This is the way an application can create shortcut keys, also called hot keys. These callbacks are not available in IupLua.
local function k_any(self, c) end

---Action generated when the user press F1 at a control. In Motif is also activated by the Help button in some workstations keyboard.
---@param self ihandle
---@return integer -- IUP_CLOSE will be processed
local function help_cb(self) end

---Notifies source that drag started. It is called when the mouse starts a drag operation.
---@param self ihandle
---@param x integer
---@param y integer
---@return integer -- If IUP_IGNORE is returned the drag is aborted
local function dragbegin_cb(self, x, y) end

---@param self ihandle
---@param type string
---@return integer -- The size in bytes for the data. It will be used to allocate the buffer size for the data in transfer
local function dragdatasize_cb(self, type) end

---@param self ihandle
---@param type string
---@param data userdata
---@param size integer
---@return integer
local function dragdata_cb(self, type, data, size) end

---@param self ihandle
---@param action integer
---@return integer
local function dragend_cb(self, action) end

---@param self ihandle
---@param type string
---@param data userdata
---@param size integer
---@param x integer
---@param y integer
---@return integer
local function dropdata_cb(self, type, data, size, x, y) end

---@param self ihandle
---@param x integer
---@param y integer
---@param status string
---@return integer
local function dropmotion_cb(self, x, y, status) end

---Action generated when a mouse button is pressed or released.
---@param self ihandle
---@param button `iup.BUTTON1`|`iup.BUTTON2`|`iup.BUTTON3` -- LBM|MBM|RBM
---@param pressed `0`|`1` -- 0 -- released; 1 -- pressed
---@param x integer -- position in the canvas where the event has occurred, in pixels.
---@param y integer -- position in the canvas where the event has occurred, in pixels.
---@param status string -- status of the mouse buttons and some keyboard keys at the moment the event is generated. The following macros must be used for verification: iup.isshift(status), iup.iscontrol(status), iup.isbutton1(status), iup.isbutton2(status), iup.isbutton3(status), iup.isbutton4(status), iup.isbutton5(status), iup.isdouble(status), iup.isalt(status), iup.issys(status)
---@return integer|`iup.CLOSE` -- IUP_CLOSE will be processed
---
---This callback can be used to customize a button behavior. For a standard button behavior use the ACTION callback of the IupButton.
---
---For a single click the callback is called twice, one for pressed=1 and one for pressed=0. Only after both calls the ACTION callback is called. In Windows, if a dialog is shown or popup in any situation there could be unpredictable results because the native system still has processing to be done even after the callback is called.
---
---A double click is preceded by two single clicks, one for pressed=1 and one for pressed=0, and followed by a press=0, all three without the double click flag set. In GTK, it is preceded by an additional two single clicks sequence. For example, for one double click all the following calls are made:
---
---Between press and release all mouse events are redirected only to this control, even if the cursor moves outside the element. So the BUTTON_CB callback when released and the MOTION_CB callback can be called with coordinates outside the element rectangle.
local function button_cb(self, button, pressed, x, y, status) end

---Action generated when the mouse moves.
---@param self ihandle
---@param x integer -- position in the canvas where the event has occurred, in pixels.
---@param y integer -- position in the canvas where the event has occurred, in pixels.
---@param status string -- status of the mouse buttons and some keyboard keys at the moment the event is generated. The following macros must be used for verification: iup.isshift(status), iup.iscontrol(status), iup.isbutton1(status), iup.isbutton2(status), iup.isbutton3(status), iup.isbutton4(status), iup.isbutton5(status), iup.isdouble(status), iup.isalt(status), iup.issys(status)
---@return integer
---
---Between press and release all mouse events are redirected only to this control, even if the cursor moves outside the element. So the BUTTON_CB callback when released and the MOTION_CB callback can be called with coordinates outside the element rectangle.
local function motion_cb(self,  x, y, status) end

---Action generated when the button 1 (usually left) is selected. This callback is called only after the mouse is released and when it is released inside the button area.
---@param self ihandle
---@return integer
---
---In some elements, this callback may receive more parameters, apart from ih. Please refer to each element's documentation.
local function action(self) end

---Called after the value was interactively changed by the user.
---@param self ihandle
---@return integer
local function valuechanged_cb(self) end

---Called when the user double clicks a color cell to change its value.
---@param self ihandle
---@param cell integer -- index of the selected cell. If the user double click a preview cell, the respective index is returned
---@return string|nil  -- a new color or nil to ignore the change. By default nothing is changed
local function cell_cb(self, cell) end

---Called when the user right click a cell with the Shift key pressed. It is independent of the SHOW_SECONDARY attribute.
---@param self ihandle
---@param cell integer                -- index of the selected cell
---@return `iup.DEFAULT`|`iup.IGNORE` -- If IUP_IGNORE the cell is not redrawn. By default the cell is always redrawn
local function extended_cb(self, cell) end

---Called when a color is selected. The primary color is selected with the left mouse button, and if existent the secondary is selected with the right mouse button.
---@param self ihandle
---@param cell integer                       -- index of the selected cell
---@param type `iup.PRIMARY`|`iup.SECONDARY` -- indicates if the user selected a primary or secondary color. In can be: IUP_PRIMARY(-1) or IUP_SECONDARY(-2)
---@return `iup.DEFAULT`|`iup.IGNORE` -- If IUP_IGNORE the selection is not accepted. By default the selection is always accepted
local function select_cb(self, cell, type) end

---Called when a color is selected. The primary color is selected with the left mouse button, and if existent the secondary is selected with the right mouse button.
---@param self ihandle
---@param prim_cell integer -- index of the actual primary cell
---@param sec_cell  integer -- index of the actual secondary cell
---@return `iup.DEFAULT`|`iup.IGNORE` -- If IUP_IGNORE the selection is not accepted. By default the selection is always accepted
local function switch_cb(self, prim_cell, sec_cell) end

---Called when the user releases the left mouse button over the control, defining the selected color.
---@param self ihandle
---@param r integer
---@param g integer
---@param b integer
---@return integer|`iup.DEFAULT`
local function change_cb(self, r, g, b) end

---Called several times while the color is being changed by dragging the mouse over the control.
---@param self ihandle
---@param r integer
---@param g integer
---@param b integer
---@return integer|`iup.DEFAULT`
local function drag_cb(self, r, g, b) end

---Called when the user presses the left mouse button over the dial. The angle here is always zero, except for the circular dial.
---@param self ihandle
---@param angle number -- the dial value converted according to UNIT
---@return integer|`iup.DEFAULT`
local function button_press_cb(self, angle) end

---Called when the user releases the left mouse button after pressing it over the dial.
---@param self ihandle
---@param angle number -- the dial value converted according to UNIT
---@return integer|`iup.DEFAULT`
local function button_release_cb(self, angle) end

---Called each time the user moves the dial with the mouse button pressed. The angle the dial rotated since it was initialized is passed as a parameter.
---@param self ihandle
---@param angle number -- the dial value converted according to UNIT
---@return integer|`iup.DEFAULT`
local function mousemove_cb(self, angle) end

---Action generated when the caret/cursor position is changed.  Valid only when EDITBOX=YES.
---@param self ihandle
---@param lin integer -- line and column number (start at `1`)
---@param col integer -- line and column number (start at `1`)
---@param pos integer -- `0` based character position
---@return integer|`iup.DEFAULT`
local function caret_cb(self, lin, col, pos) end

---Action generated when the user double click an item. Called only when DROPDOWN=NO. (since 3.0)
---@param self ihandle
---@param item integer -- Number of the selected item (start at `1`)
---@param text string  -- Text of the selected item
---@return integer|`iup.DEFAULT`
local function dblclick_cb(self, item, text) end

---Action generated when an internal drag and drop is executed. Only active if SHOWDRAGDROP=YES. (since 3.7)
---@param self ihandle
---@param drag_id integer   -- Identifier of the clicked item where the drag start
---@param drop_id integer   -- Identifier of the clicked item where the drop were executed. -1 indicates a drop in a blank area
---@param isshift integer   -- flag indicating the shift key state
---@param iscontrol integer -- flag indicating the control key state
---@return integer|`iup.DEFAULT`|`iup.CONTINUE` -- if returns IUP_CONTINUE, or if the callback is not defined and SHOWDRAGDROP=YES, then the item is moved to the new position. If Ctrl is pressed then the item is copied instead of moved
local function dragdrop_cb(self, drag_id, drop_id, isshift, iscontrol) end

---Action generated when the list of a dropdown is shown or hidden. Called only when DROPDOWN=YES. (since 3.0)
---@param self ihandle
---@param state boolean -- state of the list `1`=shown, `0`=hidden
---@return integer|`iup.DEFAULT`
local function dropdown_cb(self, state) end

---Action generated when the list of a dropdown is shown or hidden. Called only when DROPDOWN=YES. (since 3.0)
---@param self ihandle
---@param c integer -- Valid alpha numeric character or `0`
---@param new_value string -- Represents the new text value
---@return integer|`iup.DEFAULT`|`iup.CLOSE`|`iup.IGNORE` -- `iup.CLOSE` will be processed, but the change will be ignored. If `iup.IGNORE`, the system will ignore the new value. If c is valid and returns a valid alpha numeric character, this new character will be used instead. The VALUE attribute can be changed only if `iup.IGNORE` is returned
local function edit_cb(self, c, new_value) end

---Action generated when the list of a dropdown is shown or hidden. Called only when DROPDOWN=YES. (since 3.0)
---@param self ihandle
---@param value string -- Similar to the VALUE attribute for a multiple selection list. Items selected are marked with `+`, items deselected are marked with `-`, and non changed items are marked with an `x`
---@return integer|`iup.DEFAULT`
---
---This callback is called only when MULTIPLE=YES. If this callback is defined the ACTION callback will not be called.
---
---The non changed items marked with `x` are simulated internally by IUP in all systems. If you add or remove items to/from the list and you count on the `x` values, then after adding/removing items set the VALUE attribute to ensure proper `x` values.
local function multiselect_cb(self, value) end

---Called each time the user clicks in the buttons. It will increment 1 and decrement -1 by default. Holding the Shift key will set a factor of 2, holding Ctrl a factor of 10, and both a factor of 100.
---@param self ihandle
---@param inc integer
---@return integer|`iup.DEFAULT`
local function spin_cb(self, inc) end



-- Callbacks end

-- Ihandle methods start

-- ihandle.postmessage_cb = iup.PostMessage

-- Ihandle methods end

-- Event functions start

---Executes the user interaction until a callback returns `iup.Close`, `iup.ExitLoop` is called, or hiding the last visible dialog.
---
---When this function is called, it will interrupt the program execution until a callback returns IUP_CLOSE, IupExitLoop is called, or there are no visible dialogs.
---If you cascade many calls to IupMainLoop there must be a "return IUP_CLOSE" or IupExitLoop call for each cascade level, hiddinh all dialogs will close only one level. Call IupMainLoopLevel to obtain the current level.
---If IupMainLoop is called without any visible dialogs and no active timers, the application will hang and will not be possible to close the main loop. The process will have to be interrupted by the system.
---When the last visible dialog is hidden the IupExitLoop function is automatically called, causing the IupMainLoop to return. To avoid that set LOCKLOOP=YES before hiding the last dialog.
---@return integer|`iup.NOERROR`
function iup.MainLoop() end

---Ends the IUP toolkit and releases internal memory. It will also automatically destroy all dialogs and all elements that have names.
function iup.Close() end

---Returns the current cascade level of `IupMainLoop`. When no calls were done, return value is `0`.
---
---You can use this function to check if `IupMainLoop` was already called and avoid calling it again.
---A call to `iup.popup` will increase one level.
---@return integer
function iup.MainLoopLevel() end

---Runs one iteration of the message loop.
---
---This function is useful for allowing a second message loop to be managed by the application itself. This means that messages can be intercepted and callbacks can be processed inside an application loop.
---IupLoopStep returns immediately after processing any messages or if there are no messages to process. IupLoopStepWait put the system in idle until a message is processed (since 3.0).
---@return integer|`iup.CLOSE`|`iup.DEFAULT`
function iup.LoopStep() end

---Runs one iteration of the message loop.
---
---IupLoopStep returns immediately after processing any messages or if there are no messages to process. IupLoopStepWait put the system in idle until a message is processed (since 3.0).
---@return integer|`iup.CLOSE`|`iup.DEFAULT`
function iup.LoopStepWait() end

---Terminates the current message loop. It has the same effect of a callback returning `iup.CLOSE`.
function iup.ExitLoop() end

---Sends data to an element, that will be received by a callback when the main loop regain control.
---
---It is expected to be thread safe.
---
---The variables are stored when the function is called, to be later passed to the callback. It will work even for non native elements.
---If IupPostMessage is called, the callback must be defined or there will be a memory leak.
---it can call as ih:postmessage
---@param ih ihandle
---@param s string|nil
---@param i integer
---@param d number
---@param p "generic pointer"
function iup.PostMessage(ih, s, i, d, p) end

---Processes all pending messages in the message queue.
---
---
---When you change an attribute of a certain element, the change may not take place immediately. For this update to occur faster than usual, call `iup.Flush` after the attribute is changed.
---
---Important: A call to this function may cause other callbacks to be processed before it returns.
---
---In Motif, if the X server sent an event which is not yet in the event queue, after a call to IupFlush the queue might not be empty.
function iup.Flush() end

---Records all mouse and keyboard input in a file for later reproduction.
---@param filename string|nil name of the file to be saved. NULL will stop recording
---@param mode integer|`iup.RECBINARY`|`iup.RECTEXT` flag for controlling the file generation.
---@return integer|`iup.NOERROR`|`iup.ERROR`
---
---Any existing file will be replaced.
---Must stop recording before exiting the application.
---It uses the global callbacks enabled by the INPUTCALLBACKS global attribute.
---Mouse position is relative to the top left corner of the screen and it is independent from the controls and dialogs being manipulated.
---The generated file can be used by IupPlayInput to reproduce the same events.
function iup.RecordInput(filename, mode) end

---Reproduces all mouse and keyboard input from a given file.
---@overload fun(filename: nil)
---@overload fun(filename: string)
---@overload fun(filename: "")
---@param filename string|nil|"" name of the file to be played. NULL will stop playing. "" will pause and restart a file already being played
---@return integer|`iup.NOERROR`|`iup.ERROR`
---The file must had been saved using the IupRecordInput function. Record mode will be automatically detected.
---This function will start the play and return the control to the application. If the file ends all internal memory used to play the file will be automatically released.
---It uses the MOUSEBUTTON global attribute to reproduce the events. IMPORTANT: See the documentation of the MOUSEBUTTON attribute for further details and current limitations.
---The file must had been generated in the same operating system. Screen size differences can exist, but if different themes are used then mouse precision will be affected.
function iup.PlayInput(filename) end

-- Event functions end

-- Dialogue classes start

---@class dialog: ihandle
---@field background string (non inheritable): Dialog background color or image. Can be a non inheritable alternative to BGCOLOR or can be the name of an image to be tiled on the background. See also the screenshots of the sample.c results with normal background, changing the dialog BACKGROUND, the dialog BGCOLOR and the children BGCOLOR. Not working in GTK 3. (since 3.0)
---@field border string (non inheritable) (creation only): Shows a resize border around the dialog. Default: "YES". BORDER=NO is useful only when RESIZE=NO, MAXBOX=NO, MINBOX=NO, MENUBOX=NO and TITLE=NULL, if any of these are defined there will be always some border.
---@field cursor string (non inheritable): Defines a cursor for the dialog.
---@field nactive string (non inheritable): same as ACTIVE but does not affects the controls inside the dialog. (since 3.13)
---@field title string Dialog’s title. Default: NULL. If you want to remove the title bar you must also set MENUBOX=NO, MAXBOX=NO and MINBOX=NO, before map. But in Motif and GTK it will hide it only if RESIZE=NO also.
---@field visible string Simply call IupShow or IupHide for the dialog.
---@field bordersize number (non inheritable) (read only): returns the border size. (since 3.18)
---@field simulatemodal string disable all other visible dialogs, just like when the dialog is made modal. (since 3.21)
local dialog = {}
dialog.close_cb = close_cb
dialog.copydata_cb = copydata_cb
dialog.dropfiles_cb = dropfiles_cb
dialog.customframe_cb = customframe_cb
dialog.customframeactivate_cb = customframeactivate_cb
dialog.focus_cb = focus_cb
dialog.mdiactivate_cb = mdiactivate_cb
dialog.move_cb = move_cb
dialog.resize_cb = resize_cb
dialog.show_cb = show_cb
dialog.trayclick_cb = trayclick_cb
dialog.map_cb = map_cb
dialog.unmap_cb = unmap_cb
dialog.destroy_cb = destroy_cb
dialog.getfocus_cb = getfocus_cb
dialog.killfocus_cb = killfocus_cb
dialog.enterwindow_cb = enterwindow_cb
dialog.leavewindow_cb = leavewindow_cb
dialog.k_any = k_any
dialog.help_cb = help_cb
dialog.dragbegin_cb = dragbegin_cb
dialog.dragdatasize_cb = dragdatasize_cb
dialog.dragdata_cb = dragdata_cb
dialog.dragend_cb = dragend_cb
dialog.dropdata_cb = dropdata_cb
dialog.dropmotion_cb = dropmotion_cb

-- Dialogue classes end
-- Dialogue functions start

---Creates a dialog element.
---@param ihandleDialog {
---  size: integer|string;
---  expand: string;
---  background: string;
---  border: string;
---  cursor: string;
---  nactive: string;
---  title: string;
---  visible: string;
---  bordersize: number;
---  simulatemodal: string;
---  sort: string;
---  [integer]: ihandle;
---}
---@return dialog
function iup.dialog(ihandleDialog) end

---@alias iup_coord integer|`iup.CENTER`|`iup.CENTERPARENT`|`iup.MOUSEPOS`|`iup.CURRENT`
---@alias iup_coord_x iup_coord|`iup.LEFT`|`iup.RIGHT`|`iup.LEFTPARENT`|`iup.RIGHTPARENT`
---@alias iup_coord_y iup_coord|`iup.TOP`|`iup.BOTTOM`|`iup.TOPPARENT`|`iup.BOTTOMPARENT`
---@param x iup_coord_x
---@param y iup_coord_y
---@return integer
function dialog:popup(x, y) end

---@return integer
function dialog:show() end

---@param x iup_coord_x
---@param y iup_coord_y
---@return integer
function dialog:showxy(x, y) end

---@return integer
function dialog:hide() end

-- Dialogue functions end



-- Controls containers classes start


---@class fill: ihandle
local fill = {}

---@class space: ihandle
local space = {}

---@class cbox: ihandle
local cbox = {}

---@class gridbox: ihandle
local gridbox = {}

---@class multibox: ihandle
local multibox = {}

---@class hbox: ihandle
local hbox = {}

---@class vbox: ihandle
local vbox = {}

---@class zbox: ihandle
local zbox = {}

---@class radio: ihandle
local radio = {}

---@class normalizer: ihandle
local normalizer = {}

---@class frame: ihandle
local frame = {}

---@class flatframe: ihandle
local flatframe = {}

---@class tabs: ihandle
local tabs = {}

---@class flattabs: ihandle
local flattabs = {}

---@class backgroundbox: ihandle
local backgroundbox = {}

---@class scrollbox: ihandle
local scrollbox = {}

---@class flatscrollbox: ihandle
local flatscrollbox = {}

---@class detachbox: ihandle
local detachbox = {}

---@class expander: ihandle
local expander = {}

---@class sbox: ihandle
local sbox = {}

---@class split: ihandle
local split = {}



-- Controls containers classes end

-- Controls containers functions start

---@param ihandlefill {}
---@return fill
function iup.fill(ihandlefill) end

---@param ihandlespace {}
---@return space
function iup.space(ihandlespace) end

---@param ihandlecbox {}
---@return cbox
function iup.cbox(ihandlecbox) end

---@param ihandlegridbox {}
---@return gridbox
function iup.gridbox(ihandlegridbox) end

---@param ihandlemultibox {}
---@return multibox
function iup.multibox(ihandlemultibox) end

---@param ihandlehbox {}
---@return hbox
function iup.hbox(ihandlehbox) end

---@param ihandlevbox {}
---@return vbox
function iup.vbox(ihandlevbox) end

---@param ihandlezbox {}
---@return zbox
function iup.zbox(ihandlezbox) end

---@param ihandleradio {}
---@return radio
function iup.radio(ihandleradio) end

---@param ihandlenormalizer {}
---@return normalizer
function iup.normalizer(ihandlenormalizer) end

---@param ihandleframe {}
---@return frame
function iup.frame(ihandleframe) end

---@param ihandleflatframe {}
---@return flatframe
function iup.flatframe(ihandleflatframe) end

---@param ihandletabs {}
---@return tabs
function iup.tabs(ihandletabs) end

---@param ihandleflattabs {}
---@return flattabs
function iup.flattabs(ihandleflattabs) end

---@param ihandlebackgroundbox {}
---@return backgroundbox
function iup.backgroundbox(ihandlebackgroundbox) end

---@param ihandlescrollbox {}
---@return scrollbox
function iup.scrollbox(ihandlescrollbox) end

---@param ihandleflatscrollbox {}
---@return flatscrollbox
function iup.flatscrollbox(ihandleflatscrollbox) end

---@param ihandledetachbox {}
---@return detachbox
function iup.detachbox(ihandledetachbox) end

---@param ihandleexpander {}
---@return expander
function iup.expander(ihandleexpander) end

---@param ihandlesbox {}
---@return sbox
function iup.sbox(ihandlesbox) end

---@param ihandlesplit {}
---@return split
function iup.split(ihandlesplit) end

-- Controls containers functions end

-- Controls Standart classes start

---@class animatedlabel: ihandle
local animatedlabel = {}
animatedlabel.button_cb = button_cb
animatedlabel.motion_cb = motion_cb
animatedlabel.dropfiles_cb = dropfiles_cb
animatedlabel.map_cb = map_cb
animatedlabel.unmap_cb = unmap_cb
animatedlabel.destroy_cb = destroy_cb
animatedlabel.enterwindow_cb = enterwindow_cb
animatedlabel.leavewindow_cb = leavewindow_cb

---@class button: ihandle
local button = {}
---Action generated when any mouse button is pressed and when it is released. Both calls occur before the ACTION callback when button 1 is being used.
---@param self ihandle
---@return `iup.DEFAULT`|`iup.CLOSE` -- IUP_CLOSE will be processed.
button.action = function (self) end
---Action generated when the button 1 (usually left) is selected. This callback is called only after the mouse is released and when it is released inside the button area.
---@param self ihandle
---@param button `iup.BUTTON1`|`iup.BUTTON2`|`iup.BUTTON3` -- LBM|MBM|RBM
---@param pressed `0`|`1` -- 0 -- released; 1 -- pressed
---@param x integer -- position in the canvas where the event has occurred, in pixels.
---@param y integer -- position in the canvas where the event has occurred, in pixels.
---@param status string -- status of the mouse buttons and some keyboard keys at the moment the event is generated. The following macros must be used for verification: iup.isshift(status), iup.iscontrol(status), iup.isbutton1(status), iup.isbutton2(status), iup.isbutton3(status), iup.isbutton4(status), iup.isbutton5(status), iup.isdouble(status), iup.isalt(status), iup.issys(status)
---@return integer|`iup.CLOSE` -- IUP_CLOSE will be processed
button.button_cb = function (self, button, pressed, x, y, status) end
button.map_cb = map_cb
button.unmap_cb = unmap_cb
button.destroy_cb = destroy_cb
button.getfocus_cb = getfocus_cb
button.killfocus_cb = killfocus_cb
button.enterwindow_cb = enterwindow_cb
button.leavewindow_cb = leavewindow_cb
button.k_any = k_any
button.help_cb = help_cb

---@class flatbutton: ihandle
local flatbutton = {}

---@class dropbutton: ihandle
local dropbutton = {}

---@class calendar: ihandle
---@field today string
---@field value string
---@field weeknumbers "NO"|"YES" -- default "NO"
local calendar = {}
calendar.valuechanged_cb = valuechanged_cb
calendar.map_cb = map_cb
calendar.unmap_cb = unmap_cb
calendar.destroy_cb = destroy_cb
calendar.getfocus_cb = getfocus_cb
calendar.killfocus_cb = killfocus_cb
calendar.enterwindow_cb = enterwindow_cb
calendar.leavewindow_cb = leavewindow_cb
calendar.k_any = k_any
calendar.help_cb = help_cb

---@class canvas: ihandle
local canvas = {}

---@class colorbar: ihandle
local colorbar = {}
colorbar.cell_cb = cell_cb
colorbar.extended_cb = extended_cb
colorbar.select_cb = select_cb
colorbar.switch_cb = switch_cb
colorbar.map_cb = map_cb
colorbar.unmap_cb = unmap_cb
colorbar.destroy_cb = destroy_cb
colorbar.getfocus_cb = getfocus_cb
colorbar.killfocus_cb = killfocus_cb
colorbar.enterwindow_cb = enterwindow_cb
colorbar.leavewindow_cb = leavewindow_cb
colorbar.k_any = k_any
colorbar.help_cb = help_cb

---@class colorbrowser: ihandle
local colorbrowser = {}
colorbrowser.change_cb = change_cb
colorbrowser.drag_cb = drag_cb
---Called after the value was interactively changed by the user. It is called whenever a CHANGE_CB or a DRAG_CB would also be called, it is just  called after them. (since 3.0)
---@param self ihandle
---@return integer
colorbrowser.valuechanged_cb =  function (self) end
colorbrowser.map_cb = map_cb
colorbrowser.unmap_cb = unmap_cb
colorbrowser.destroy_cb = destroy_cb
colorbrowser.getfocus_cb = getfocus_cb
colorbrowser.killfocus_cb = killfocus_cb
colorbrowser.enterwindow_cb = enterwindow_cb
colorbrowser.leavewindow_cb = leavewindow_cb
colorbrowser.k_any = k_any
colorbrowser.help_cb = help_cb

---@class datepick: ihandle
local datepick = {}
datepick.valuechanged_cb = valuechanged_cb
datepick.map_cb = map_cb
datepick.unmap_cb = unmap_cb
datepick.destroy_cb = destroy_cb
datepick.getfocus_cb = getfocus_cb
datepick.killfocus_cb = killfocus_cb
datepick.enterwindow_cb = enterwindow_cb
datepick.leavewindow_cb = leavewindow_cb
datepick.k_any = k_any
datepick.help_cb = help_cb

---@class dial: ihandle
local dial = {}
dial.button_press_cb = button_press_cb
dial.button_release_cb = button_release_cb
dial.mousemove_cb = mousemove_cb
---Called after the value was interactively changed by the user. It is called whenever a BUTTON_PRESS_CB, a BUTTON_RELEASE_CB or a MOUSEMOVE_CB would also be called, but if defined those callbacks will not be called. (since 3.0)
---@param self ihandle
---@return integer
dial.valuechanged_cb = function (self) end
dial.map_cb = map_cb
dial.unmap_cb = unmap_cb
dial.destroy_cb = destroy_cb
dial.getfocus_cb = getfocus_cb
dial.killfocus_cb = killfocus_cb
dial.enterwindow_cb = enterwindow_cb
dial.leavewindow_cb = leavewindow_cb
dial.k_any = k_any
dial.help_cb = help_cb

---@class gauge: ihandle
local gauge = {}
gauge.map_cb = map_cb
gauge.unmap_cb = unmap_cb
gauge.destroy_cb = destroy_cb

---@class label: ihandle
local label = {}
label.button_cb = button_cb
label.motion_cb = motion_cb
label.dropfiles_cb = dropfiles_cb
label.map_cb = map_cb
label.unmap_cb = unmap_cb
label.destroy_cb = destroy_cb
label.enterwindow_cb = enterwindow_cb
label.leavewindow_cb = leavewindow_cb

---@class flatlabel: ihandle
local flatlabel = {}
--TODO: iupcnavas callbacks write
flatlabel.button_cb = button_cb
flatlabel.motion_cb = motion_cb
flatlabel.dropfiles_cb = dropfiles_cb
flatlabel.map_cb = map_cb
flatlabel.unmap_cb = unmap_cb
flatlabel.destroy_cb = destroy_cb
flatlabel.enterwindow_cb = enterwindow_cb
flatlabel.leavewindow_cb = leavewindow_cb

---@class flatseparator: ihandle
local flatseparator = {}
--TODO: iupcnavas callbacks write

---@class link: ihandle
local link = {}
---Action generated when the link is activated.
---@param self ihandle
---@param url string -- The destination address of the link
---@return `iup.CLOSE`|`iup.DEFAULT` -- `iup.CLOSE` will be processed. If returns `iup.DEFAULT` or it is not defined, the IupHelp function will be called
link.action = function (self, url) end

---@class list: ihandle
local list = {}
---Action generated when the link is activated.
---@param self ihandle
---@param text string -- Text of the changed item
---@param item integer -- Number of the changed item starting at `1`
---@param state 1|0 -- Equal to `1` if the option was selected or to `0` if the option was deselected
---@return `iup.CLOSE`|`iup.DEFAULT` -- IUP_CLOSE will be processed. If returns IUP_DEFAULT or it is not defined, the IupHelp function will be called
list.action = function (self, text, item, state) end

---Action generated when any mouse button is pressed or released inside the list. Called only when DROPDOWN=NO. If the list has an editbox the message is called when cursor is at the listbox only (ignored at the editbox). Use IupConvertXYToPos to convert (x,y) coordinates in item position. (since 3.0)
---@param self ihandle
---@param button `iup.BUTTON1`|`iup.BUTTON2`|`iup.BUTTON3` -- LBM|MBM|RBM
---@param pressed 0|1 -- `0` -- released; `1` -- pressed
---@param x integer -- position in the canvas where the event has occurred, in pixels.
---@param y integer -- position in the canvas where the event has occurred, in pixels.
---@param status string -- status of the mouse buttons and some keyboard keys at the moment the event is generated. The following macros must be used for verification: iup.isshift(status), iup.iscontrol(status), iup.isbutton1(status), iup.isbutton2(status), iup.isbutton3(status), iup.isbutton4(status), iup.isbutton5(status), iup.isdouble(status), iup.isalt(status), iup.issys(status)
---@return `iup.DEFAULT`|`iup.CLOSE` -- IUP_CLOSE will be processed
---
---This callback can be used to customize a button behavior. For a standard button behavior use the ACTION callback of the IupButton.
---
---For a single click the callback is called twice, one for pressed=1 and one for pressed=0. Only after both calls the ACTION callback is called. In Windows, if a dialog is shown or popup in any situation there could be unpredictable results because the native system still has processing to be done even after the callback is called.
---
---A double click is preceded by two single clicks, one for pressed=1 and one for pressed=0, and followed by a press=0, all three without the double click flag set. In GTK, it is preceded by an additional two single clicks sequence. For example, for one double click all the following calls are made:
---
---Between press and release all mouse events are redirected only to this control, even if the cursor moves outside the element. So the BUTTON_CB callback when released and the MOTION_CB callback can be called with coordinates outside the element rectangle.
list.button_cb = function (self, button, pressed, x, y, status) end
list.caret_cb = caret_cb
list.dblclick_cb = dblclick_cb
list.dragdrop_cb = dragdrop_cb
list.dropdown_cb = dropdown_cb
list.dropfiles_cb = dropfiles_cb
list.edit_cb = edit_cb
---Action generated when the mouse is moved over the list. Called only when DROPDOWN=NO. If the list has an editbox the message is called when cursor is at the listbox only (ignored at the editbox). Use IupConvertXYToPos to convert (x,y) coordinates in item position. (since 3.0)
---@param self ihandle
---@param x integer -- position in the canvas where the event has occurred, in pixels.
---@param y integer -- position in the canvas where the event has occurred, in pixels.
---@param status string -- status of the mouse buttons and some keyboard keys at the moment the event is generated. The following macros must be used for verification: iup.isshift(status), iup.iscontrol(status), iup.isbutton1(status), iup.isbutton2(status), iup.isbutton3(status), iup.isbutton4(status), iup.isbutton5(status), iup.isdouble(status), iup.isalt(status), iup.issys(status)
---@return integer
---
---Between press and release all mouse events are redirected only to this control, even if the cursor moves outside the element. So the BUTTON_CB callback when released and the MOTION_CB callback can be called with coordinates outside the element rectangle.
list.motion_cb = function (self,  x, y, status) end
list.multiselect_cb = multiselect_cb
list.valuechanged_cb = valuechanged_cb
list.map_cb = map_cb
list.unmap_cb = unmap_cb
list.destroy_cb = destroy_cb
list.getfocus_cb = getfocus_cb
list.killfocus_cb = killfocus_cb
list.enterwindow_cb = enterwindow_cb
list.leavewindow_cb = leavewindow_cb
list.k_any = k_any
list.help_cb = help_cb
--TODO: drag&drop atrributes all

---@class flatlist: ihandle
local flatlist = {}
--TODO:

---@class progressbar: ihandle
local progressbar = {}
progressbar.map_cb = map_cb
progressbar.unmap_cb = unmap_cb
progressbar.destroy_cb = destroy_cb

---@class spin: ihandle
local spin = {}
spin.spin_cb = spin_cb

---@class text: ihandle
local text = {}
---Action generated when the text is edited, but before its value is actually changed. Can be generated when using the keyboard, undo system or from the clipboard.
---@param self ihandle
---@param c integer        -- valid alpha numeric character or `0`
---@param new_value string -- Represents the new text value
---@return integer|`iup.DEFAULT`|`iup.CLOSE`|`iup.IGNORE` -- IUP_CLOSE will be processed, but the change will be ignored. If IUP_IGNORE, the system will ignore the new value. If c is valid and returns a valid alpha numeric character, this new character will be used instead. The VALUE attribute can be changed only if IUP_IGNORE is returned
text.action = function (self, c, new_value) end
text.button_cb = button_cb
text.caret_cb = caret_cb
text.dropfiles_cb = dropfiles_cb
text.motion_cb = motion_cb
---Action generated when a spin button is pressed. Valid only when SPIN=YES. When this callback is called the ACTION callback is not called. The VALUE attribute can be changed during this callback only if SPINAUTO=NO. (since 3.0)
---@param self ihandle
---@param pos integer -- the value of the spin (after it was incremented)
---@return integer|`iup.DEFAULT`|`iup.IGNORE` -- `iup.IGNORE` is processed in Windows and Motif
text.spin_cb = function (self, pos) end
text.valuechanged_cb = valuechanged_cb
text.map_cb = map_cb
text.unmap_cb = unmap_cb
text.destroy_cb = destroy_cb
text.getfocus_cb = getfocus_cb
text.killfocus_cb = killfocus_cb
text.enterwindow_cb = enterwindow_cb
text.leavewindow_cb = leavewindow_cb
text.k_any = k_any
text.help_cb = help_cb
-- TODO: drag&drop

---@class toggle: ihandle
local toggle = {}
---Action generated when the toggle's state (on/off) was changed. The callback also receives the toggle's state.
---@param self ihandle
---@param state integer -- `1` if the toggle's state was shifted to on; `0` if it was shifted to off
---@return integer|`iup.CLOSE`|`iup.DEFAULT` -- IUP_CLOSE will be processed
toggle.action = function (self, state) end
toggle.valuechanged_cb = valuechanged_cb
toggle.map_cb = map_cb
toggle.unmap_cb = unmap_cb
toggle.destroy_cb = destroy_cb
toggle.getfocus_cb = getfocus_cb
toggle.killfocus_cb = killfocus_cb
toggle.enterwindow_cb = enterwindow_cb
toggle.leavewindow_cb = leavewindow_cb
toggle.k_any = k_any
toggle.help_cb = help_cb

---@class flattoggle: ihandle
local flattoggle = {}
-- TODO: canvas

---@class tree: ihandle
local tree = {}
-- TODO:
tree.button_cb = button_cb
tree.motion_cb = motion_cb
tree.dropfiles_cb = dropfiles_cb
tree.map_cb = map_cb
tree.unmap_cb = unmap_cb
tree.destroy_cb = destroy_cb
tree.getfocus_cb = getfocus_cb
tree.killfocus_cb = killfocus_cb
tree.enterwindow_cb = enterwindow_cb
tree.leavewindow_cb = leavewindow_cb
tree.k_any = k_any
tree.help_cb = help_cb

---@class flattree: ihandle
local flattree = {}
-- TODO: canvas

---@class val: ihandle
local val = {}
val.valuechanged_cb = valuechanged_cb
val.map_cb = map_cb
val.unmap_cb = unmap_cb
val.destroy_cb = destroy_cb
val.getfocus_cb = getfocus_cb
val.killfocus_cb = killfocus_cb
val.enterwindow_cb = enterwindow_cb
val.leavewindow_cb = leavewindow_cb
val.k_any = k_any
val.help_cb = help_cb

---@class flatval: ihandle
local flatval = {}
-- TODO: canvas
flatval.valuechanged_cb = valuechanged_cb
flatval.map_cb = map_cb
flatval.unmap_cb = unmap_cb
flatval.destroy_cb = destroy_cb
flatval.getfocus_cb = getfocus_cb
flatval.killfocus_cb = killfocus_cb
flatval.enterwindow_cb = enterwindow_cb
flatval.leavewindow_cb = leavewindow_cb
flatval.k_any = k_any
flatval.help_cb = help_cb

---@class cells: ihandle
local cells = {}
-- TODO:

---@class matrix: ihandle
local matrix = {}
-- TODO:

---@class matrixex: ihandle
local matrixex = {}
-- TODO:

---@class matrixlist: ihandle
local matrixlist = {}
-- TODO:

---@class glcanvas: ihandle
local glcanvas = {}
-- TODO:

---@class glbackgroundbox: ihandle
local glbackgroundbox = {}
-- TODO:

---@class glcontrols: ihandle
local glcontrols = {}
-- TODO:

---@class plot: ihandle
local plot = {}
-- TODO:

---@class olecontrol: ihandle
local olecontrol = {}
-- TODO:

---@class scintilla: ihandle
local scintilla = {}
-- TODO:

---@class webbrowser: ihandle
local webbrowser = {}
-- TODO:

-- Controls Standart classes end


-- Controls Standart functions start

---@param ihandleAnimatedlabel {}
---@return animatedlabel
function iup.animatedlabel(ihandleAnimatedlabel) end

---@param ihandleButton {}
---@return button
function iup.button(ihandleButton) end

---@param ihandleflatbutton {}
---@return flatbutton
function iup.flatbutton(ihandleflatbutton) end

---@param ihandledropbutton {}
---@return dropbutton
function iup.dropbutton(ihandledropbutton) end

---@param ihandlecalendar {}
---@return calendar
function iup.calendar(ihandlecalendar) end

---@param ihandlecanvas {}
---@return canvas
function iup.canvas(ihandlecanvas) end

---@param ihandlecolorbar {}
---@return colorbar
function iup.colorbar(ihandlecolorbar) end

---@param ihandlecolorbrowser {}
---@return colorbrowser
function iup.colorbrowser(ihandlecolorbrowser) end

---@param ihandledatepick {}
---@return datepick
function iup.datepick(ihandledatepick) end

---@param ihandledial {}
---@return dial
function iup.dial(ihandledial) end

---@param ihandlegauge {}
---@return gauge
function iup.gauge(ihandlegauge) end

---@param ihandlelabel {}
---@return label
function iup.label(ihandlelabel) end

---@param ihandleflatlabel {}
---@return flatlabel
function iup.flatlabel(ihandleflatlabel) end

---@param ihandleflatseparator {}
---@return flatseparator
function iup.flatseparator(ihandleflatseparator) end

---@param ihandlelink {}
---@return link
function iup.link(ihandlelink) end

---Creates a list element.
---@param ihandleList {
---  size: integer|string;
---  sort: string;
---  visiblelines: integer|string;
---  canfocus: string;
---  [integer]: string;
---}
---@return list
function iup.list(ihandleList) end

---@param ihandleflatlist {}
---@return flatlist
function iup.flatlist(ihandleflatlist) end

---@param ihandleprogressbar {}
---@return progressbar
function iup.progressbar(ihandleprogressbar) end

---@param ihandlespin {}
---@return spin
function iup.spin(ihandlespin) end

---@param ihandlespinbox {
---  [integer]: ihandle;
---}
---@return hbox -- hbox{spin}
function iup.spinbox(ihandlespinbox) end

---@param ihandletext {}
---@return text
function iup.text(ihandletext) end

---@param ihandlemultiline {}
---@return text
function iup.multiline(ihandlemultiline) end

---@param ihandletoggle {}
---@return toggle
function iup.toggle(ihandletoggle) end

---@param ihandleflattoggle {}
---@return flattoggle
function iup.flattoggle(ihandleflattoggle) end

---@param ihandletree {}
---@return tree
function iup.tree(ihandletree) end

---@param ihandleflattree {}
---@return flattree
function iup.flattree(ihandleflattree) end

---@param ihandleval {}
---@return val
function iup.val(ihandleval) end

---@param ihandleflatval {}
---@return flatval
function iup.flatval(ihandleflatval) end

---@param ihandlecells {}
---@return cells
function iup.cells(ihandlecells) end

---@param ihandlematrix {}
---@return matrix
function iup.matrix(ihandlematrix) end

---@param ihandlematrixex {}
---@return matrixex
function iup.matrixex(ihandlematrixex) end

---@param ihandlematrixlist {}
---@return matrixlist
function iup.matrixlist(ihandlematrixlist) end

---@param ihandleglcanvas {}
---@return glcanvas
function iup.glcanvas(ihandleglcanvas) end

---@param ihandleglbackgroundbox {}
---@return glbackgroundbox
function iup.glbackgroundbox(ihandleglbackgroundbox) end

---@param ihandleglcontrols {}
---@return glcontrols
function iup.glcontrols(ihandleglcontrols) end

---@param ihandleplot {}
---@return plot
function iup.plot(ihandleplot) end

---@param ihandleolecontrol {}
---@return olecontrol
function iup.olecontrol(ihandleolecontrol) end

---@param ihandlescintilla {}
---@return scintilla
function iup.scintilla(ihandlescintilla) end

---@param ihandlewebbrowser {}
---@return webbrowser
function iup.webbrowser(ihandlewebbrowser) end

---@param ihtimer {}
---@return timer
function iup.timer(ihtimer) end


-- Controls Standart functions end

-- Utility functions start

---@return string -- version
function iup.Version() end

---@return number -- version
function iup.VersionNumber() end

---Shows a popup dialog with IUP version information and more. This is a debug dialog with lots of information of additional libraries too. (since 3.28)
function iup.VersionShow() end

---Sets an interface element attribute.
---@param ih ihandle
---@param name string
---@param value any
function iup.SetAttribute(ih, name, value) end

---Sets an interface element attribute.
---@param ih ihandle
---@param name string
---@param id integer
---@param value any
function iup.SetAttributeId(ih, name, id, value) end

---Sets an interface element attribute.
---@param ih ihandle
---@param name string
---@param lin integer
---@param col integer
---@param value any
function iup.SetAttributeId2(ih, name, lin, col, value) end

---Sets several attributes of an interface element.
---@param ih ihandle -- Identifier of the interface element.
---@param str string -- string with the attributes in the format "v1=a1, v2=a2,..." where vi is the name of an attribute and ai is its value.
---@return ihandle -- same `ih`
function iup.SetAttributes(ih, str) end

---Removes an attribute from the hash table of the element, and its children if the attribute is inheritable. It is useful to reset the state of inheritable attributes in a tree of elements.
---@param ih ihandle -- Identifier of the interface element. If NULL will set in the global environment.
---@param name string -- name of the attribute.
function iup.ResetAttribute(ih, name) end

---Returns the name of an interface element attribute.
---@param ih ihandle
---@param name string
---@return string|ihandle|userdata value
function iup.GetAttribute(ih, name) end

---Returns the name of an interface element attribute.
---@param ih ihandle
---@param name string
---@param id integer
---@return string|ihandle|userdata value
function iup.GetAttributeId(ih, name, id) end

---Returns the name of an interface element attribute.
---@param ih ihandle
---@param name string
---@param lin integer
---@param col integer
---@return string|ihandle|userdata value
function iup.GetAttributeId2(ih, name, id, lin, col) end

---Returns the names of all attributes of an element that are set in its internal hash table only.
---@param ih ihandle -- identifier of the interface element
---@param max_n? integer -- maximum number of names the table can receive
---@return table names -- table receiving the names. Only the list of names need to be allocated. Each name will point to an internal string.
---@return integer n --  If names==NULL or max_n==0 or -1 then returns the maximum number of names.
function iup.GetAllAttributes(ih, max_n) end

---Copies all hash table attributes from one element to another.
---Internal attributes or non string attributes are not copied.
---@param src_ih ihandle -- identifier of the source element
---@param dst_ih ihandle -- identifier of the destiny element
function iup.CopyAttributes(src_ih, dst_ih) end

---Instead of using IupGetAttribute and IupGetHandle, this function directly returns the associated handle.
---@param name string -- name of the attribute
---@return ihandle ih -- identifier of the interface element
function iup.GetAttributeHandleHandle(name) end

---@alias global_name string|"UTF8MODE"|"UTF8MODE_FILE"|"DEFAULTPRECISION"|"DEFAULTDECIMALSYMBOL"|"SB_BGCOLOR"|"IUPLUA_THREADED"
---@alias yes_no string|"YES"|"NO"
---Sets an attribute in the global environment. If the driver process the attribute then it will not be stored internally.
---@param name global_name
---@param value yes_no|nil -- value of the attribute. If it equals nil, the attribute will be removed
function iup.SetGlobal(name, value) end

---Returns an attribute value from the global environment. The value can be returned from the driver or from the internal storage.
---@param name global_name
---@return any value -- If the attribute does not exist, nil is returned
function iup.GetGlobal(name) end


---@param str1 string
---@param str2 string
---@param casesensitive? `0`|`1` -- default is `0`
---@param lexicographic? `0`|`1` -- default is `1`
---@return integer `0`|`1`|`-1` -- `0` str1 == str2 ; `1` str1 > str2 ; `-1` str1 < str2
function iup.StringCompare(str1, str2, casesensitive, lexicographic) end

-- Utility functions end

-- CONSTS start

---@type integer
iup.CENTER = 65535

---@type integer
iup.CENTERPARENT = 65530

---@type integer
iup.LEFTPARENT = 65529

---@type integer
iup.RIGHTPARENT = 65528

---@type integer
iup.LEFT = 65534

---@type integer
iup.RIGHT = 65533

---@type integer
iup.MOUSEPOS = 65532

---@type integer
iup.CURRENT = 65531

---@type integer
iup.TOP = 65534

---@type integer
iup.BOTTOM = 65533

---@type integer
iup.TOPPARENT = 65529

---@type integer
iup.BOTTOMPARENT = 65528

---@type integer
iup.NOERROR = 0

---@type integer
iup.ERROR = 1

---@type integer
iup.SECONDARY = -2
---@type integer
iup.PRIMARY = -1
---@type integer
iup.CONTINUE = -4
---@type integer
iup.SBUP = 0
---@type integer
iup.SBDN = 1
---@type integer
iup.SBPGUP = 2
---@type integer
iup.SBPGDN = 3
---@type integer
iup.SBPOSV = 4
---@type integer
iup.SBDRAGV = 5
---@type integer
iup.SBLEFT = 6
---@type integer
iup.SBRIGHT = 7
---@type integer
iup.SBPGLEFT = 8
---@type integer
iup.SBPGRIGHT = 9
---@type integer
iup.SBPOSH = 10
---@type integer
iup.SBDRAGH = 11
---@type integer
iup.SHOW = 0
---@type integer
iup.RESTORE = 1
---@type integer
iup.MINIMIZE = 2
---@type integer
iup.MAXIMIZE = 3
---@type integer
iup.HIDE = 4
---@type integer
iup.BUTTON1 = 49
---@type integer
iup.BUTTON2 = 50
---@type integer
iup.BUTTON3 = 51
---@type integer
iup.BUTTON4 = 52
---@type integer
iup.BUTTON5 = 53
---@type integer
iup.RECBINARY = 0
---@type integer
iup.RECTEXT = 1
---@type integer
iup.GETPARAM_BUTTON1 = -1
---@type integer
iup.GETPARAM_INIT = -2
---@type integer
iup.GETPARAM_BUTTON2 = -3
---@type integer
iup.GETPARAM_BUTTON3 = -4
---@type integer
iup.GETPARAM_CLOSE = -5
---@type integer
iup.GETPARAM_MAP = -6
---@type integer
iup.GETPARAM_OK = -1
---@type integer
iup.GETPARAM_CANCEL = -3
---@type integer
iup.GETPARAM_HELP = -4
---@type integer
iup.OPENED = -1
---@type integer
iup.INVALID = -1
---@type integer
iup.INVALID_ID = -10
---@type integer
iup.IGNORE = -1
---@type integer
iup.DEFAULT = -2
---@type integer
iup.CLOSE = -3



---@type string
iup.MASK_FLOAT = "[+/-]?(/d+/.?/d*|/./d+)"

---@type string
iup.MASK_UFLOAT = "(/d+/.?/d*|/./d+)"

---@type string
iup.MASK_EFLOAT = "[+/-]?(/d+/.?/d*|/./d+)([eE][+/-]?/d+)?"

---@type string
iup.MASK_FLOATCOMMA = "[+/-]?(/d+/,?/d*|/,/d+)"

---@type string
iup.MASK_UFLOATCOMMA = "(/d+/,?/d*|/,/d+)"

---@type string
iup.MASK_INT = "[+/-]?/d+"

---@type string
iup.MASK_UINT = "/d+"


---@type string
iup._NAME = "IUP - Portable User Interface"

---@type string
iup._DESCRIPTION = "Multi-platform Toolkit for Building Graphical User Interfaces"

---@type string
iup._COPYRIGHT = "Copyright (C) 1994-2023 Tecgraf/PUC-Rio"

---@type string
iup._VERSION = "3.31"

---@type integer
iup._VERSION_NUMBER = 331000

---@type string
iup._VERSION_DATE = "2023/10/13"

---@type string
iup._IUPOPEN_CALL = "INTERNAL"

---@type string
iup._PACKAGE = "iuplua"

-- KEYS

---@type integer
iup.K_sSP = 268435488
---@type integer
iup.K_cSP = 536870944
---@type integer
iup.K_mSP = 1073741856
---@type integer
iup.K_ySP = -2147483616
---@type integer
iup.K_exclam = 33
---@type integer
iup.K_cExclam = 536870945
---@type integer
iup.K_mExclam = 1073741857
---@type integer
iup.K_yExclam = -2147483615
---@type integer
iup.K_quotedbl = 34
---@type integer
iup.K_cQuotedbl = 536870946
---@type integer
iup.K_mQuotedbl = 1073741858
---@type integer
iup.K_yQuotedbl = -2147483614
---@type integer
iup.K_numbersign = 35
---@type integer
iup.K_cNumbersign = 536870947
---@type integer
iup.K_mNumbersign = 1073741859
---@type integer
iup.K_yNumbersign = -2147483613
---@type integer
iup.K_dollar = 36
---@type integer
iup.K_cDollar = 536870948
---@type integer
iup.K_mDollar = 1073741860
---@type integer
iup.K_yDollar = -2147483612
---@type integer
iup.K_percent = 37
---@type integer
iup.K_cPercent = 536870949
---@type integer
iup.K_mPercent = 1073741861
---@type integer
iup.K_yPercent = -2147483611
---@type integer
iup.K_ampersand = 38
---@type integer
iup.K_cAmpersand = 536870950
---@type integer
iup.K_mAmpersand = 1073741862
---@type integer
iup.K_yAmpersand = -2147483610
---@type integer
iup.K_apostrophe = 39
---@type integer
iup.K_cApostrophe = 536870951
---@type integer
iup.K_mApostrophe = 1073741863
---@type integer
iup.K_yApostrophe = -2147483609
---@type integer
iup.K_parentleft = 40
---@type integer
iup.K_cParentleft = 536870952
---@type integer
iup.K_mParentleft = 1073741864
---@type integer
iup.K_yParentleft = -2147483608
---@type integer
iup.K_parentright = 41
---@type integer
iup.K_cParentright = 536870953
---@type integer
iup.K_mParentright = 1073741865
---@type integer
iup.K_yParentright = -2147483607
---@type integer
iup.K_asterisk = 42
---@type integer
iup.K_sAsterisk = 268435498
---@type integer
iup.K_cAsterisk = 536870954
---@type integer
iup.K_mAsterisk = 1073741866
---@type integer
iup.K_yAsterisk = -2147483606
---@type integer
iup.K_plus = 43
---@type integer
iup.K_sPlus = 268435499
---@type integer
iup.K_cPlus = 536870955
---@type integer
iup.K_mPlus = 1073741867
---@type integer
iup.K_yPlus = -2147483605
---@type integer
iup.K_comma = 44
---@type integer
iup.K_sComma = 268435500
---@type integer
iup.K_cComma = 536870956
---@type integer
iup.K_cPeriod = 536870958
---@type integer
iup.K_mPeriod = 1073741870
---@type integer
iup.K_yPeriod = -2147483602
---@type integer
iup.K_slash = 47
---@type integer
iup.K_sSlash = 268435503
---@type integer
iup.K_cSlash = 536870959
---@type integer
iup.K_mSlash = 1073741871
---@type integer
iup.K_ySlash = -2147483601
---@type integer
iup.K_0 = 48
---@type integer
iup.K_c0 = 536870960
---@type integer
iup.K_m0 = 1073741872
---@type integer
iup.K_y0 = -2147483600
---@type integer
iup.K_1 = 49
---@type integer
iup.K_c1 = 536870961
---@type integer
iup.K_m1 = 1073741873
---@type integer
iup.K_y1 = -2147483599
---@type integer
iup.K_2 = 50
---@type integer
iup.K_c2 = 536870962
---@type integer
iup.K_m2 = 1073741874
---@type integer
iup.K_y2 = -2147483598
---@type integer
iup.K_3 = 51
---@type integer
iup.K_c3 = 536870963
---@type integer
iup.K_m3 = 1073741875
---@type integer
iup.K_y3 = -2147483597
---@type integer
iup.K_4 = 52
---@type integer
iup.K_c4 = 536870964
---@type integer
iup.K_m4 = 1073741876
---@type integer
iup.K_y4 = -2147483596
---@type integer
iup.K_5 = 53
---@type integer
iup.K_c5 = 536870965
---@type integer
iup.K_m5 = 1073741877
---@type integer
iup.K_y5 = -2147483595
---@type integer
iup.K_yCR = -2147483635
---@type integer
iup.K_SP = 32
---@type integer
iup.K_Q = 81
---@type integer
iup.K_yP = -2147483568
---@type integer
iup.K_cP = 536870992
---@type integer
iup.K_P = 80
---@type integer
iup.K_mO = 1073741903
---@type integer
iup.K_sDOWN = 268500820
---@type integer
iup.K_mK = 1073741899
---@type integer
iup.K_cK = 536870987
---@type integer
iup.K_K = 75
---@type integer
iup.K_yJ = -2147483574
---@type integer
iup.K_mJ = 1073741898
---@type integer
iup.K_cJ = 536870986
---@type integer
iup.K_J = 74
---@type integer
iup.K_yI = -2147483575
---@type integer
iup.K_mI = 1073741897
---@type integer
iup.K_cI = 536870985
---@type integer
iup.K_I = 73
---@type integer
iup.K_yH = -2147483576
---@type integer
iup.K_mH = 1073741896
---@type integer
iup.K_H = 72
---@type integer
iup.K_mG = 1073741895
---@type integer
iup.K_cG = 536870983
---@type integer
iup.K_yF = -2147483578
---@type integer
iup.K_E = 69
---@type integer
iup.K_mD = 1073741892
---@type integer
iup.K_cD = 536870980
---@type integer
iup.K_mC = 1073741891
---@type integer
iup.K_C = 67
---@type integer
iup.K_yB = -2147483582
---@type integer
iup.K_cB = 536870978
---@type integer
iup.K_mA = 1073741889
---@type integer
iup.K_A = 65
---@type integer
iup.K_mAt = 1073741888
---@type integer
iup.K_cAt = 536870976
---@type integer
iup.K_cPrint = 536936289
---@type integer
iup.K_sMenu = 268500839
---@type integer
iup.K_cDOWN = 536936276
---@type integer
iup.K_mHOME = 1073807184
---@type integer
iup.K_LEFT = 65361
---@type integer
iup.K_yF1 = -2147418178
---@type integer
iup.K_HOME = 65360
---@type integer
iup.K_cRIGHT = 536936275
---@type integer
iup.K_yRIGHT = -2147418285
---@type integer
iup.K_DOWN = 65364
---@type integer
iup.K_cPGUP = 536936277
---@type integer
iup.K_cPGDN = 536936278
---@type integer
iup.K_mEND = 1073807191
---@type integer
iup.K_INS = 65379
---@type integer
iup.K_Menu = 65383
---@type integer
iup.K_cMenu = 536936295
---@type integer
iup.K_yMenu = -2147418265
---@type integer
iup.K_cF1 = 536936382
---@type integer
iup.K_mF1 = 1073807294
---@type integer
iup.K_yF2 = -2147418177
---@type integer
iup.K_F3 = 65472
---@type integer
iup.K_sF3 = 268500928
---@type integer
iup.K_yF3 = -2147418176
---@type integer
iup.K_mF4 = 1073807297
---@type integer
iup.K_yF4 = -2147418175
---@type integer
iup.K_cF5 = 536936386
---@type integer
iup.K_mF5 = 1073807298
---@type integer
iup.K_mF7 = 1073807300
---@type integer
iup.K_cF8 = 536936389
---@type integer
iup.K_yF10 = -2147418169
---@type integer
iup.K_F11 = 65480
---@type integer
iup.K_cF11 = 536936392
---@type integer
iup.K_yF11 = -2147418168
---@type integer
iup.K_RSHIFT = 65506
---@type integer
iup.K_RCTRL = 65508
---@type integer
iup.K_ESC = 65307
---@type integer
iup.K_SCROLL = 65300
---@type integer
iup.K_yPAUSE = -2147418349
---@type integer
iup.K_cBar = 536871036
---@type integer
iup.K_s = 115
---@type integer
iup.K_m8 = 1073741880
---@type integer
iup.K_y8 = -2147483592
---@type integer
iup.K_c9 = 536870969
---@type integer
iup.K_F = 70
---@type integer
iup.K_equal = 61
---@type integer
iup.K_yLess = -2147483588
---@type integer
iup.K_mLess = 1073741884
---@type integer
iup.K_cLess = 536870972
---@type integer
iup.K_less = 60
---@type integer
iup.K_ySemicolon = -2147483589
---@type integer
iup.K_mSemicolon = 1073741883
---@type integer
iup.K_cSemicolon = 536870971
---@type integer
iup.K_semicolon = 59
---@type integer
iup.K_yColon = -2147483590
---@type integer
iup.K_mColon = 1073741882
---@type integer
iup.K_cColon = 536870970
---@type integer
iup.K_colon = 58
---@type integer
iup.K_y9 = -2147483591
---@type integer
iup.K_m9 = 1073741881
---@type integer
iup.K_9 = 57
---@type integer
iup.K_mComma = 1073741868
---@type integer
iup.K_c = 99
---@type integer
iup.K_e = 101
---@type integer
iup.K_v = 118
---@type integer
iup.K_cBraceleft = 536871035
---@type integer
iup.K_bar = 124
---@type integer
iup.K_yMIDDLE = -2147418357
---@type integer
iup.K_RALT = 65514
---@type integer
iup.K_LALT = 65513
---@type integer
iup.K_CAPS = 65509
---@type integer
iup.K_LCTRL = 65507
---@type integer
iup.K_LSHIFT = 65505
---@type integer
iup.K_yF12 = -2147418167
---@type integer
iup.K_mF12 = 1073807305
---@type integer
iup.K_cF12 = 536936393
---@type integer
iup.K_sF12 = 268500937
---@type integer
iup.K_F12 = 65481
---@type integer
iup.K_mF11 = 1073807304
---@type integer
iup.K_sF11 = 268500936
---@type integer
iup.K_mF10 = 1073807303
---@type integer
iup.K_cF10 = 536936391
---@type integer
iup.K_sF10 = 268500935
---@type integer
iup.K_F10 = 65479
---@type integer
iup.K_yF9 = -2147418170
---@type integer
iup.K_mF9 = 1073807302
---@type integer
iup.K_cF9 = 536936390
---@type integer
iup.K_sF9 = 268500934
---@type integer
iup.K_F9 = 65478
---@type integer
iup.K_yF8 = -2147418171
---@type integer
iup.K_mF8 = 1073807301
---@type integer
iup.K_sF8 = 268500933
---@type integer
iup.K_F8 = 65477
---@type integer
iup.K_yF7 = -2147418172
---@type integer
iup.K_cF7 = 536936388
---@type integer
iup.K_sF7 = 268500932
---@type integer
iup.K_F7 = 65476
---@type integer
iup.K_yF6 = -2147418173
---@type integer
iup.K_mF6 = 1073807299
---@type integer
iup.K_cF6 = 536936387
---@type integer
iup.K_sF6 = 268500931
---@type integer
iup.K_F6 = 65475
---@type integer
iup.K_yF5 = -2147418174
---@type integer
iup.K_sF5 = 268500930
---@type integer
iup.K_F5 = 65474
---@type integer
iup.K_cF4 = 536936385
---@type integer
iup.K_sF4 = 268500929
---@type integer
iup.K_F4 = 65473
---@type integer
iup.K_mF3 = 1073807296
---@type integer
iup.K_cF3 = 536936384
---@type integer
iup.K_mF2 = 1073807295
---@type integer
iup.K_cF2 = 536936383
---@type integer
iup.K_sF2 = 268500927
---@type integer
iup.K_F2 = 65471
---@type integer
iup.K_sF1 = 268500926
---@type integer
iup.K_F1 = 65470
---@type integer
iup.K_NUM = 65407
---@type integer
iup.K_mMenu = 1073807207
---@type integer
iup.K_BS = 8
---@type integer
iup.K_sBS = 268435464
---@type integer
iup.K_cBS = 536870920
---@type integer
iup.K_mBS = 1073741832
---@type integer
iup.K_yBS = -2147483640
---@type integer
iup.K_TAB = 9
---@type integer
iup.K_sTAB = 268435465
---@type integer
iup.K_cTAB = 536870921
---@type integer
iup.K_mTAB = 1073741833
---@type integer
iup.K_yTAB = -2147483639
---@type integer
iup.K_CR = 13
---@type integer
iup.K_sCR = 268435469
---@type integer
iup.K_cCR = 536870925
---@type integer
iup.K_mCR = 1073741837
---@type integer
iup.K_yINS = -2147418269
---@type integer
iup.K_mINS = 1073807203
---@type integer
iup.K_cINS = 536936291
---@type integer
iup.K_sINS = 268500835
---@type integer
iup.K_yPrint = -2147418271
---@type integer
iup.K_mPrint = 1073807201
---@type integer
iup.K_sPrint = 268500833
---@type integer
iup.K_Print = 65377
---@type integer
iup.K_yEND = -2147418281
---@type integer
iup.K_cEND = 536936279
---@type integer
iup.K_sEND = 268500823
---@type integer
iup.K_END = 65367
---@type integer
iup.K_yPGDN = -2147418282
---@type integer
iup.K_mPGDN = 1073807190
---@type integer
iup.K_sPGDN = 268500822
---@type integer
iup.K_PGDN = 65366
---@type integer
iup.K_yPGUP = -2147418283
---@type integer
iup.K_mPGUP = 1073807189
---@type integer
iup.K_sPGUP = 268500821
---@type integer
iup.K_PGUP = 65365
---@type integer
iup.K_yDOWN = -2147418284
---@type integer
iup.K_mDOWN = 1073807188
---@type integer
iup.K_mRIGHT = 1073807187
---@type integer
iup.K_sHOME = 268500816
---@type integer
iup.K_cHOME = 536936272
---@type integer
iup.K_yHOME = -2147418288
---@type integer
iup.K_sLEFT = 268500817
---@type integer
iup.K_6 = 54
---@type integer
iup.K_c6 = 536870966
---@type integer
iup.K_m6 = 1073741878
---@type integer
iup.K_y6 = -2147483594
---@type integer
iup.K_7 = 55
---@type integer
iup.K_c7 = 536870967
---@type integer
iup.K_m7 = 1073741879
---@type integer
iup.K_y7 = -2147483593
---@type integer
iup.K_8 = 56
---@type integer
iup.K_c8 = 536870968
---@type integer
iup.K_yC = -2147483581
---@type integer
iup.K_D = 68
---@type integer
iup.K_mT = 1073741908
---@type integer
iup.K_V = 86
---@type integer
iup.K_cV = 536870998
---@type integer
iup.K_mV = 1073741910
---@type integer
iup.K_yV = -2147483562
---@type integer
iup.K_W = 87
---@type integer
iup.K_cW = 536870999
---@type integer
iup.K_mW = 1073741911
---@type integer
iup.K_yW = -2147483561
---@type integer
iup.K_X = 88
---@type integer
iup.K_cX = 536871000
---@type integer
iup.K_mX = 1073741912
---@type integer
iup.K_yX = -2147483560
---@type integer
iup.K_Y = 89
---@type integer
iup.K_cY = 536871001
---@type integer
iup.K_mY = 1073741913
---@type integer
iup.K_yY = -2147483559
---@type integer
iup.K_Z = 90
---@type integer
iup.K_cZ = 536871002
---@type integer
iup.K_mZ = 1073741914
---@type integer
iup.K_yZ = -2147483558
---@type integer
iup.K_bracketleft = 91
---@type integer
iup.K_cBracketleft = 536871003
---@type integer
iup.K_mBracketleft = 1073741915
---@type integer
iup.K_yBracketleft = -2147483557
---@type integer
iup.K_backslash = 92
---@type integer
iup.K_cBackslash = 536871004
---@type integer
iup.K_mBackslash = 1073741916
---@type integer
iup.K_yBackslash = -2147483556
---@type integer
iup.K_bracketright = 93
---@type integer
iup.K_cBracketright = 536871005
---@type integer
iup.K_mBracketright = 1073741917
---@type integer
iup.K_yBracketright = -2147483555
---@type integer
iup.K_circum = 94
---@type integer
iup.K_cCircum = 536871006
---@type integer
iup.K_mCircum = 1073741918
---@type integer
iup.K_yCircum = -2147483554
---@type integer
iup.K_underscore = 95
---@type integer
iup.K_cUnderscore = 536871007
---@type integer
iup.K_mUnderscore = 1073741919
---@type integer
iup.K_yUnderscore = -2147483553
---@type integer
iup.K_grave = 96
---@type integer
iup.K_cGrave = 536871008
---@type integer
iup.K_mGrave = 1073741920
---@type integer
iup.K_yGrave = -2147483552
---@type integer
iup.K_a = 97
---@type integer
iup.K_b = 98
---@type integer
iup.K_d = 100
---@type integer
iup.K_f = 102
---@type integer
iup.K_g = 103
---@type integer
iup.K_h = 104
---@type integer
iup.K_i = 105
---@type integer
iup.K_j = 106
---@type integer
iup.K_k = 107
---@type integer
iup.K_l = 108
---@type integer
iup.K_m = 109
---@type integer
iup.K_n = 110
---@type integer
iup.K_o = 111
---@type integer
iup.K_p = 112
---@type integer
iup.K_q = 113
---@type integer
iup.K_r = 114
---@type integer
iup.K_t = 116
---@type integer
iup.K_u = 117
---@type integer
iup.K_w = 119
---@type integer
iup.K_x = 120
---@type integer
iup.K_y = 121
---@type integer
iup.K_z = 122
---@type integer
iup.K_braceleft = 123
---@type integer
iup.K_mBraceleft = 1073741947
---@type integer
iup.K_yBraceleft = -2147483525
---@type integer
iup.K_mBar = 1073741948
---@type integer
iup.K_yBar = -2147483524
---@type integer
iup.K_braceright = 125
---@type integer
iup.K_cBraceright = 536871037
---@type integer
iup.K_mBraceright = 1073741949
---@type integer
iup.K_yBraceright = -2147483523
---@type integer
iup.K_tilde = 126
---@type integer
iup.K_cTilde = 536871038
---@type integer
iup.K_mTilde = 1073741950
---@type integer
iup.K_yTilde = -2147483522
---@type integer
iup.K_MIDDLE = 65291
---@type integer
iup.K_sMIDDLE = 268500747
---@type integer
iup.K_cMIDDLE = 536936203
---@type integer
iup.K_mMIDDLE = 1073807115
---@type integer
iup.K_PAUSE = 65299
---@type integer
iup.K_sPAUSE = 268500755
---@type integer
iup.K_cPAUSE = 536936211
---@type integer
iup.K_mPAUSE = 1073807123
---@type integer
iup.K_sESC = 268500763
---@type integer
iup.K_cESC = 536936219
---@type integer
iup.K_mESC = 1073807131
---@type integer
iup.K_yESC = -2147418341
---@type integer
iup.K_cLEFT = 536936273
---@type integer
iup.K_mLEFT = 1073807185
---@type integer
iup.K_yLEFT = -2147418287
---@type integer
iup.K_UP = 65362
---@type integer
iup.K_sUP = 268500818
---@type integer
iup.K_cUP = 536936274
---@type integer
iup.K_mUP = 1073807186
---@type integer
iup.K_yUP = -2147418286
---@type integer
iup.K_RIGHT = 65363
---@type integer
iup.K_sRIGHT = 268500819
---@type integer
iup.K_DEL = 65535
---@type integer
iup.K_sDEL = 268500991
---@type integer
iup.K_cDEL = 536936447
---@type integer
iup.K_mDEL = 1073807359
---@type integer
iup.K_yDEL = -2147418113
---@type integer
iup.K_ccedilla = 231
---@type integer
iup.K_Ccedilla = 199
---@type integer
iup.K_cCcedilla = 536871111
---@type integer
iup.K_mCcedilla = 1073742023
---@type integer
iup.K_yCcedilla = -2147483449
---@type integer
iup.K_acute = 180
---@type integer
iup.K_diaeresis = 168
---@type integer
iup.K_yComma = -2147483604
---@type integer
iup.K_minus = 45
---@type integer
iup.K_sMinus = 268435501
---@type integer
iup.K_cMinus = 536870957
---@type integer
iup.K_mMinus = 1073741869
---@type integer
iup.K_yMinus = -2147483603
---@type integer
iup.K_period = 46
---@type integer
iup.K_sPeriod = 268435502
---@type integer
iup.K_cEqual = 536870973
---@type integer
iup.K_mEqual = 1073741885
---@type integer
iup.K_yEqual = -2147483587
---@type integer
iup.K_greater = 62
---@type integer
iup.K_cGreater = 536870974
---@type integer
iup.K_mGreater = 1073741886
---@type integer
iup.K_yGreater = -2147483586
---@type integer
iup.K_question = 63
---@type integer
iup.K_cQuestion = 536870975
---@type integer
iup.K_mQuestion = 1073741887
---@type integer
iup.K_yQuestion = -2147483585
---@type integer
iup.K_at = 64
---@type integer
iup.K_yAt = -2147483584
---@type integer
iup.K_cA = 536870977
---@type integer
iup.K_yA = -2147483583
---@type integer
iup.K_B = 66
---@type integer
iup.K_mB = 1073741890
---@type integer
iup.K_cC = 536870979
---@type integer
iup.K_yD = -2147483580
---@type integer
iup.K_cE = 536870981
---@type integer
iup.K_mE = 1073741893
---@type integer
iup.K_yE = -2147483579
---@type integer
iup.K_cF = 536870982
---@type integer
iup.K_mF = 1073741894
---@type integer
iup.K_G = 71
---@type integer
iup.K_yG = -2147483577
---@type integer
iup.K_cH = 536870984
---@type integer
iup.K_yK = -2147483573
---@type integer
iup.K_L = 76
---@type integer
iup.K_cL = 536870988
---@type integer
iup.K_mL = 1073741900
---@type integer
iup.K_yL = -2147483572
---@type integer
iup.K_M = 77
---@type integer
iup.K_cM = 536870989
---@type integer
iup.K_mM = 1073741901
---@type integer
iup.K_yM = -2147483571
---@type integer
iup.K_N = 78
---@type integer
iup.K_cN = 536870990
---@type integer
iup.K_mN = 1073741902
---@type integer
iup.K_yN = -2147483570
---@type integer
iup.K_O = 79
---@type integer
iup.K_cO = 536870991
---@type integer
iup.K_yO = -2147483569
---@type integer
iup.K_mP = 1073741904
---@type integer
iup.K_cQ = 536870993
---@type integer
iup.K_mQ = 1073741905
---@type integer
iup.K_yQ = -2147483567
---@type integer
iup.K_R = 82
---@type integer
iup.K_cR = 536870994
---@type integer
iup.K_mR = 1073741906
---@type integer
iup.K_yR = -2147483566
---@type integer
iup.K_S = 83
---@type integer
iup.K_cS = 536870995
---@type integer
iup.K_mS = 1073741907
---@type integer
iup.K_yS = -2147483565
---@type integer
iup.K_T = 84
---@type integer
iup.K_cT = 536870996
---@type integer
iup.K_yT = -2147483564
---@type integer
iup.K_U = 85
---@type integer
iup.K_cU = 536870997
---@type integer
iup.K_mU = 1073741909
---@type integer
iup.K_yU = -2147483563


-- CONSTS end

--- Attributes List:
--[===[
APPENDITEM (write-only): inserts an item after the last item. Ignored if set before map.
AUTOHIDE: scrollbars are shown only if they are necessary. Default: "YES".
AUTOREDRAW [Windows] (non inheritable): automatically redraws the list when something has change. Set to NO to add many items to the list without updating the display. Default: "YES".
BGCOLOR: Background color of the text. Default: the global attribute TXTBGCOLOR. In GTK does nothing when DROPDOWN=Yes.
CANFOCUS (creation only) (non inheritable): enables the focus traversal of the control. In Windows the control will still get the focus when clicked. Default: YES.
PROPAGATEFOCUS(non inheritable): enables the focus callback forwarding to the next native parent with FOCUS_CB defined. Default: NO.
COUNT (read-only) (non inheritable): returns the number of items. Before mapping it counts the number of non NULL items before the first NULL item.
DRAGDROPLIST (non inheritable): prepare the Drag & Drop callbacks to support drag and drop of items between lists (IupList or IupFlatList), in the same IUP application. Drag & Drop attributes still need to be set in order to activate the drag & drop support, so the application can control if this list will be source and/or target. Default: NO.
DROPFILESTARGET [Windows and GTK Only] (non inheritable): Enable or disable the drop of files. Default: NO, but if DROPFILES_CB is defined when the element is mapped then it will be automatically enabled.
DROPDOWN (creation only): Changes the appearance of the list for the user: only the selected item is shown beside a button with the image of an arrow pointing down. To select another option, the user must press this button, which displays all items in the list. Can be "YES" or "NO". Default "NO".
DROPEXPAND [Windows Only]: When DROPDOWN=Yes the size of the dropped list will expand to include the largest text. Can be "YES" or "NO". Default: "YES".
EDITBOX (creation only): Adds an edit box to the list. Can be "YES" or "NO". Default "NO".
FGCOLOR: Text color. Default: the global attribute TXTFGCOLOR.
IMAGEid (non inheritable) (write only) [Windows and GTK Only]: image name to be used in the specified item, where id is the specified item starting at 1. The item must already exist. Use IupSetHandle or IupSetAttributeHandle to associate an image to a name. See also IupImage. The image is always displayed at the left of the text and only when SHOWIMAGE=Yes. When EDITBOX=Yes the image is not display at the edit box. Images don't need to have the same size. In Windows, list items are limited to 255 pixels height.
INSERTITEMid (write-only): inserts an item before the given id position. id starts at 1. If id=COUNT+1 then it will append after the last item. Ignored if out of bounds. Ignored if set before map.
MULTIPLE (creation only): Allows selecting several items simultaneously (multiple list). Default: "NO". Only valid when EDITBOX=NO and DROPDOWN=NO.
REMOVEITEM (write-only): removes the given value. value starts at 1. If value is NULL or "ALL" removes all the items. Ignored if set before map.
SCROLLBAR (creation only): Associates automatic scrollbars to the list when DROPDOWN=NO. Can be: "YES" or "NO" (none). Default: "YES". For all systems, when SCROLLBAR=YES the natural size will always include its size even if the native system hides the scrollbars. If AUTOHIDE=YES scrollbars are shown only if they are necessary, by default AUTOHIDE=YES. In Motif, SCROLLBAR=NO is not supported and if EDITBOX=YES the horizontal scrollbar is never shown.
  When DROPDOWN=YES the scrollbars are system dependent, and do NOT depend on the SCROLLBAR or AUTOHIDE attributes. Usually the scrollbars are shown if necessary. In GTK, scrollbars are never shown and all items are always visible. In Motif, the horizontal scrollbar is never shown. In Windows, if DROPEXPAND=YES then the horizontal scrollbar is never shown.
SCROLLVISIBLE (read-only) [Windows Only]: Returns which scrollbars are visible at the moment. Can be: YES (both), VERTICAL, HORIZONTAL, NO.
SHOWDRAGDROP (creation only) (non inheritable): enables the internal drag and drop of items in the same list, and enables the DRAGDROP_CB callback. Default: "NO". Works only if DROPDOWN=NO and MULTIPLE=NO. Drag & Drop attributes are NOT used.
SHOWDROPDOWN (write-only): opens or closes the dropdown list. Can be "YES" or "NO". Valid only when DROPDOWN=YES. Ignored if set before map.
SHOWIMAGE (creation only) [Windows and GTK Only]: enables the use of an image for each item. Can be "YES" or "NO". Ignored if set after map. (since 3.6)
SIZE: Size of the list. The Natural Size is defined by the number of elements in the list and the with of the largest item, the default has room for 5 characters in 1 item. In IUP 3, the Natural Size ignores the list contents if VISIBLECOLUMNS or VISIBLELINES attributes are defined. The text in the edit box is ignored when considering the list contents.
SORT (creation only): force the list to be alphabetically sorted. When using INSERTITEMn or APPENDITEM the position will be ignored. (since 3.0)
TOPITEM (write-only): position the given item at the top of the list or near to make it visible. Valid only when DROPDOWN=NO. (since 3.0)
SPACING: internal padding for each item. Notice that vertically the distance between each item will be actually 2x the spacing. It also affects the horizontal margin of the item. In Windows, the text is aligned at the top left of the item always. Valid only when DROPDOWN=NO. (since 3.0)
CSPACING: same as SPACING but using the units of the vertical part of the SIZE attribute. It will actually set the SPACING attribute. (since 3.29)
VALUE (non inheritable): Depends on the DROPDOWN+EDITBOX combination:
  EDITBOX=YES: Text entered by the user.
  MULTIPLE=YES: Sequence of '+' and '-' symbols indicating the state of each item. When setting this value, the user must provide the same amount of '+' and '-' symbols as the amount of items in the list, otherwise the specified items will be deselected.
  Others: Integer number representing the selected item in the list (begins at 1). It can be zero if there is no selected item. (In Motif when DROPDOWN=YES there is always an item selected, except when the list is empty).
  Should return a non NULL value, even when the list is empty or the text box is empty. It can be NULL when no item selected (since 3.0).
VALUESTRING (non inheritable): changes or retrieves the value attribute using a string of an item. Works only when EDITBOX=NO and DROPDOWN=YES, or DROPDOWN=NO and MULTIPLE=NO. When set it will search for the first item with the same string. (since 3.12)
VALUEMASKED (non inheritable) (write-only): sets VALUE but first checks if it is validated by MASK. If not does nothing. Works only when EDITBOX=YES. (since 3.13)
VISIBLEITEMS [Windows and Motif Only]: Number of items that are visible when DROPDOWN=YES is used for the dropdown list. Default: 5.
VISIBLECOLUMNS: Defines the number of visible columns for the Natural Size, this means that will act also as minimum number of visible columns. It uses a wider character size then the one used for the SIZE attribute so strings will fit better without the need of extra columns. Set this attribute to speed Natural Size computation for very large lists. (since 3.0)
VISIBLELINES: When DROPDOWN=NO defines the number of visible lines for the Natural Size, this means that will act also as minimum number of visible lines. (since 3.0)

--]===]


return iup
