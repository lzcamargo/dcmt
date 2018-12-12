require 'rubygems'
require 'bud'
require 'backports'
require_relative 'partitionmodel'
require_relative 'extractgraph'
require_relative 'connectprotocol'

class PrimaryNode
  include ConnectProtocol
  include Bud
	include ExtractGraph
	include PartitionModel
end

addrm = ARGV.first ? ARGV.first : ConnectProtocol::MASTER_ADDR
ip, port = addrm.split(":")

pc = PrimaryNode.new(:ip => ip, :port => port.to_i)
pc.range_vertices

pc.run_fg()
