module ObfuscateId
  module ClassMethods
    def find(*args)
      scope = args.slice!(0)
      options = args.slice!(0) || {}
      if has_obfuscated_id? && !options[:no_obfuscated_id]
        if scope.is_a?(Array)
          deobfuscated = scope.each { |a| deobfuscate_id(a).to_i }
        else
          deobfuscated = deobfuscate_id(scope)
        end
      end
      super(deobfuscated)

    rescue ActiveRecord::RecordNotFound
      super(scope)
    end

    def find_by(arg, *args)
      if arg.is_a?(Hash) && arg[:id]
        deobfuscated = deobfuscate_id(arg[:id])
        arg[:id] = deobfuscated if super(id: deobfuscated)
      end
      super(arg, *args)
    end

    def has_obfuscated_id?
      true
    end

    def deobfuscate_id(obfuscated_id)
      ObfuscateId.show(obfuscated_id, self.obfuscate_id_spin)
    end

    # Generate a default spin from the Model name
    # This makes it easy to drop obfuscate_id onto any model
    # and produce different obfuscated ids for different models
    def obfuscate_id_default_spin
      alphabet = Array("a".."z")
      number = name.split("").collect do |char|
        alphabet.index(char)
      end

      number.shift(12).join.to_i
    end
  end
end
