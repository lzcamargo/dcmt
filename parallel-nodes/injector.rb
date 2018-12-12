module Injector #module for extracting transformation domain elements from the extractor collections
	state do
		table :family_name, [:fn_elm_name, :fn_elm_ref, :fn_elm_type]
		scratch :family_member, [:fm_elm_name, :fm_elm_ref, :fm_elm_type]
		table :family_members, [:fm_elm_name, :fm_elm_ref, :fm_elm_type]
	end

	bloom :extract_domain do
    family_name <= rec_model {|r| r if r.rc_type == "lastName"}
		family_member <= (family_name * rc_model).pairs(:fn_elm_ref => :rc_ref){|f,r| r}
	  family_member <= (family_member * rec_model).pairs(:fm_elm_name => :rec_ref){|f,r| [r.rc_name, f.fm_elm_ref, 			f.fm_elm_type] if f.fm_elm_type == "sons" or f.fm_elm_type == "daughters"}
	  family_members <= (family_member * rcv_model).pairs(:fm_elm_name => :rc_ref){|f,r| [f.fm_elm_type,f.fm_elm_ref, r.rc_name]}
	end
end



