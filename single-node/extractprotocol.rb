module ExtractProtocol
 state do #collections used for extracting input models (source)
		table :input_model,[:in_elm_name, :in_elm_ref, :in_elm_type]
		table :input_model_prop,[:in_elm_pname, :in_elm_pref, :in_elm_ptype]
	end	
end  

