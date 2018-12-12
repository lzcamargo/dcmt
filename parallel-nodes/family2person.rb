module Family2Person
	bloom :family2person do
		male <= family {|f| [[f.lastName, f.firstName].join(" ")] if (f.role == "father" or f.role == "sons")}
		female <= family {|f| [[f.lastName, f.firstName].join(" ")] if (f.role == "mother" or f.role == "daughters")}
	end
end



