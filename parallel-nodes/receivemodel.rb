require_relative 'connectprotocol'
module ReceiveModel
	include ConnectProtocol

	state do
    channel :pipe_chan, [:@dst, :ident] => [:fm_elm_name, :fm_elm_ref, :fm_elm_type]
	end

  state do
		table :rcv_model, [:rc_name, :rc_ref, :rc_type]
	end

	bootstrap do
		connect <~ [[PN_ADDR, ip_port]]
	end

	bloom :rcv_model do
		rcv_model <= pipe_chan {|p| [p.pc_name, p.pc_ref, p.pc_type]}
	end

end
