module Injector #module for extracting transformation domain elements from the extractor collections
	state do
		table :family_name, [:fn_elm_name, :fn_elm_ref, :fn_elm_type]
		scratch :family_member, [:fm_elm_name, :fm_elm_ref, :fm_elm_type]
		table :family_members, [:fm_elm_name, :fm_elm_ref, :fm_elm_type]
	end

	bloom :extract_domain do 
		family_name <= input_model_prop {|p| p if p.in_elm_ptype == "lastName"}
		family_member <= (family_name * input_model).pairs(:fn_elm_ref => :in_elm_ref){|f,i| i}
	  family_member <= (family_member * input_model).pairs(:fm_elm_name => :in_elm_ref){|f,i| [i.in_elm_name, f.fm_elm_ref, f.fm_elm_type] if f.fm_elm_type == "sons" or f.fm_elm_type == "daughters"}
	  family_members <= (family_member * input_model_prop).pairs(:fm_elm_name => :in_elm_pref){|f,p| [f.fm_elm_type, f.fm_elm_ref, p.in_elm_pname]}
	end
end



