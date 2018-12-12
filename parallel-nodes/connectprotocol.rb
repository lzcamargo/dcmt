module ConnectProtocol
	state do
		channel :connect, [:@addr, :slave]
	  table :slaveslist, [:slave_port, :master_port]
		table :rcvm, [:slave, :addr_count]
	end
	PN_ADDR = "127.0.0.1:12345"
	$num_slaves = 0
	$id_msg = 0
end
