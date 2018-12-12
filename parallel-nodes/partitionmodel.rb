module PartitionModel
	state do
		scratch :range_vert, [:rg_ini, :rg_final, :rg_node]
		table :part_model, [:pm_elm, :pm_ref ,:pm_type, :pm_node]
		scratch :cluster, [:vert_elm, :cluster_nr]
  end

	def range_vertices
		puts " Enter Number of Secondary Nodes "
		nn = gets.to_i
		imap = File.open('../Infomap/extractg.net', 'w')
		imap.write("*Vertices #{pc.node.count} \n")
		pc.vertice {|n| imap.write("#{n.node_nr} \"node #{n.node_nr}\"\n")}
		imap.write("*Edges #{pc.edge.count} \n")
		pc.edge {|e| imap.write("#{e.vert_i} #{e.vert_j} 1 \n")}
		system("../Infomap ./Infomap extractg.net output/ -N 10 --directed --clu")

		File.foreach( '../Infomap/output/extractg.clu' ) do |line|
			arr = line.split(' ')
			pc.cluster <+ [[arr[0].to_i, arr[1].to_i]] if arr[0] != "#"
		end
		pc.tick
		arr2 = pc.cluster {|c| [c.cluster_nr]}
		part = arr2.last[0]/nn.to_i
		1.upto(nn) do |x|
			Int int_vert, fin_vert, nbr_node
			if (x == 1)
			  int_vert = 0
        fin_vert = part
        nbr_node = x
      else
        int_vert = (part * (x-1))
        fin_vert = part * x
        nbr_node = x
      end
    range_vert <+ [[ int_vert , fin_vert , nbr_node ]]
	end
  bloom :partition do
    part_model <= (range_vert * vertice).pairs {|r, v|[v.vert_elm, v.vert_ref, v.vert_type, r.rg_node]
      if (v.vert_nr >= r.rg_ini and v.vert_nr <= r.rg_final)}
        part_model <= (part_model * input_model_prop).pairs (:pm_elm = > :in_elm_pref){|p, i| [i, p.pm_node]}
      end
  end
  bloom :send_chunk do
    pipe_chan <~ (sn_connected * part_model).pairs (:id_sn =>:pm_node){|s, p| [s.addr_sn,
      $id_msg+=1, p.pm_elm, p.pm_ref, p.pm_type]}
  end
end
