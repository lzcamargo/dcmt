module MetamodelsProtocol
  state do #collection used for seting source and target object specifications
    table :family, [:lastName, :role, :firstName]
		table :male, [:fullName]
		table :female, [:fullName]
	end

	class Family
		attr_accessor :members, :lastName

		def initialize
			@members = []
			@lastName = lastName
		end

		def add_member(role, firstName)
			@members = Member.new(role, firstName)
		end
	end

	class Member
		attr_accessor :role, :firstName

		def initialize(role, firstName)
			@role = role
			@firstName = firstName
		end
	end

	class Person
		attr_accessor :fullName
		def initialize
			@fullName = fullName
		end
	end

	class Male < Person
	end

	class Female < Person
	end
end
