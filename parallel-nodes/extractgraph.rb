module ExtractGraph
  $vertice = 0
	state do
		scratch :vertice, [:vert_elm, :vert_ref, :vert_nr]
		scratch :edge, [:vert_i, :vert_j]
	end
	
	bloom :graph do
		vertice <= input_model {|i| [i.in_elm_name, i.in_elm_ref, $vertice+=1] if i.in_elm_type == "Family"}  
		vertice <= (vertice * input_model).pairs(:vert_elm => :in_elm_ref){|v,i| [i.in_elm_name, i.in_elm_ref, $vertice+=1]}
	  edge <= (vertice * vertice).pairs(:vert_elm => :vert_ref){|v1, v2| [v1.vert_nr, v2.vert_nr]}  
  end		
end	
