require 'drb'
module DRb
  class DRbObject
    undef :type rescue nil
  end
end