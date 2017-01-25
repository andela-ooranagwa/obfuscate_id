module ObfuscateId
  module InstanceMethods
    def to_param
      ObfuscateId.hide(self.id, self.class.obfuscate_id_spin)
    end

    # # Override ActiveRecord::Persistence#reload
    # # passing in an options flag with { no_obfuscated_id: true }
    # def reload(options = nil)
    #   options = (options || {}).merge(no_obfuscated_id: true)
    #
    #   clear_aggregation_cache
    #   clear_association_cache
    #
    #   fresh_object =
    #     if options && options[:lock]
    #       self.class.unscoped { self.class.lock(options[:lock]).find(id, options) }
    #     else
    #       self.class.unscoped { self.class.find(id, options) }
    #     end
    #
    #   @attributes = fresh_object.instance_variable_get('@attributes')
    #   @new_record = false
    #   self
    # end

    def deobfuscate_id(obfuscated_id)
      self.class.deobfuscate_id(obfuscated_id)
    end
  end
end
