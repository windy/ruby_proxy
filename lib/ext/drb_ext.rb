require 'drb'
module DRb
  class DRbObject
    undef :type
  end
end