require_relative 'class_methods'
require_relative 'instance_methods'

module ObfuscateId
  def obfuscate_id(options = {})
    require 'scatter_swap'

    extend ClassMethods
    include InstanceMethods
    cattr_accessor :obfuscate_id_spin
    self.obfuscate_id_spin = (options[:spin] || obfuscate_id_default_spin)
  end

  def self.hide(id, spin)
    ScatterSwap.hash(id, spin)
  end

  def self.show(id, spin)
    ScatterSwap.reverse_hash(id, spin)
  end
end

ActiveRecord::Base.extend ObfuscateId
