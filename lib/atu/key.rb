require 'java'
require 'iconv'
#require 'drb'
java_import 'java.awt.event.InputEvent'
class String
  def to_unicode
    begin
      Iconv.iconv("UNICODEBIG//", "utf-8", self)[0]
    rescue Exception
      puts $!.class
      puts $!.message
      self
    end
  end
end

module ATU
##
# The Shift key modifier constant.
# This equals to java.awt.event.InputEvent.SHIFT_MASK.
  KEY_SHIFT = InputEvent::SHIFT_MASK
##
# The Ctrl key modifier constant.
# This equals to java.awt.event.InputEvent.CTRL_MASK.
  KEY_CTRL = InputEvent::CTRL_MASK
##
# The Meta/Windows/Apple key modifier constant.
# This equals to java.awt.event.InputEvent.META_MASK.
  KEY_META = InputEvent::META_MASK
##
# The Apple(Command) key modifier constant.
# This equals to java.awt.event.InputEvent.META_MASK.
  KEY_CMD = InputEvent::META_MASK
##
# The Windows key modifier constant.
# This equals to java.awt.event.InputEvent.META_MASK.
  KEY_WIN = InputEvent::META_MASK
##
# The Alt key modifier constant.
# This equals to java.awt.event.InputEvent.ALT_MASK.
  KEY_ALT = InputEvent::ALT_MASK

##
# class Key contains the constants of all special keys.
  class Key
    include DRb::DRbUndumped
    ##
    # ENTER
    ENTER = "\n"
    ##
    # BACKSPACE
    BACKSPACE = "\b"
    ##
    # TAB
    TAB = "\t"
    ##
    # ESC
    ESC = "\u001b".to_unicode
    ##
    # UP
    UP = "\ue000".to_unicode
    ##
    # RIGHT
    RIGHT = "\ue001".to_unicode
    ##
    # DOWN
    DOWN = "\ue002".to_unicode
    ##
    # LEFT
    LEFT = "\ue003".to_unicode
    ##
    # PAGE_UP
    PAGE_UP = "\ue004".to_unicode
    ##
    # PAGE_DOWN
    PAGE_DOWN = "\ue005".to_unicode
    ##
    # DELETE
    DELETE = "\ue006".to_unicode
    ##
    # END
    KEY_END = "\ue007".to_unicode
    ##
    # HOME
    HOME = "\ue008".to_unicode
    ##
    # INSERT
    INSERT = "\ue009".to_unicode
    ##
    # F1
    F1 = "\ue011".to_unicode
    ##
    # F2
    F2 = "\ue012".to_unicode
    ##
    # F3
    F3 = "\ue013".to_unicode
    ##
    # F4
    F4 = "\ue014".to_unicode
    ##
    # F5
    F5 = "\ue015".to_unicode
    ##
    # F6
    F6 = "\ue016".to_unicode
    ##
    # F7
    F7 = "\ue017".to_unicode
    ##
    # F8
    F8 = "\ue018".to_unicode
    ##
    # F9
    F9 = "\ue019".to_unicode
    ##
    # F10
    F10 = "\ue01A".to_unicode
    ##
    # F11
    F11 = "\ue01B".to_unicode
    ##
    # F12
    F12 = "\ue01C".to_unicode
    ##
    # F13
    F13 = "\ue01D".to_unicode
    ##
    # F14
    F14 = "\ue01E".to_unicode
    ##
    # F15
    F15 = "\ue01F".to_unicode
    ##
    # SHIFT
    SHIFT = "\ue020".to_unicode
    ##
    # CTRL
    CTRL = "\ue021".to_unicode
    ##
    # ALT
    ALT = "\ue022".to_unicode
    ##
    # META
    META = "\ue023".to_unicode
    ##
    # META
    CMD = "\ue023".to_unicode
    ##
    # META
    WIN = "\ue023".to_unicode

    ##
    # PRINTSCREEN
    PRINTSCREEN = "\ue024".to_unicode
    ##
    # SCROLL_LOCK
    SCROLL_LOCK = "\ue025".to_unicode
    ##
    # PAUSE
    PAUSE = "\ue026".to_unicode
    ##
    # CAPS_LOCK
    CAPS_LOCK = "\ue027".to_unicode

    ##
    # NUM0
    NUM0 = "\ue030".to_unicode
    ##
    # NUM1
    NUM1 = "\ue031".to_unicode
    ##
    # NUM2
    NUM2 = "\ue032".to_unicode
    ##
    # NUM3
    NUM3 = "\ue033".to_unicode
    ##
    # NUM4
    NUM4 = "\ue034".to_unicode
    ##
    # NUM5
    NUM5 = "\ue035".to_unicode
    ##
    # NUM6
    NUM6 = "\ue036".to_unicode
    ##
    # NUM7
    NUM7 = "\ue037".to_unicode
    ##
    # NUM8
    NUM8 = "\ue038".to_unicode
    ##
    # NUM9
    NUM9 = "\ue039".to_unicode
    ##
    # SEPARATOR (numpad)
    SEPARATOR = "\ue03A".to_unicode
    ##
    # NUM_LOCK
    NUM_LOCK = "\ue03B".to_unicode
    ##
    # ADD (numpad)
    ADD = "\ue03C".to_unicode
    ##
    # MINUS (numpad)
    MINUS = "\ue03D".to_unicode
    ##
    # MULTIPLY (numpad)
    MULTIPLY = "\ue03E".to_unicode
    ##
    # DIVIDE (numpad)
    DIVIDE = "\ue03F".to_unicode
  end
end

if __FILE__ == $0
end