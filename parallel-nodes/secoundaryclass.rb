require 'rubygems'
require 'bud'
require 'backports'
require 'builder'
require_relative 'receivemodel'
require_relative 'injector'
require_relative 'family2person'

module SecundaryNodes

	class SecundaryClass
		include Bud
		include Receivemodel
    include Injector
    include Family2Person
	end

	sc = SecondaryNode.new
  sc.tick
	tgtmodel =""
  xml = Builder::XmlMarkup.new(:target=>tgtmodel, :indent=>2)
  xml.instruct! :xmi, :version => "1.1", :encoding => "US-ASCII"
  sc.male do |m|
    xml.male("fullName"=> m.fullName)
  end
  sc.female do |f|
    xml.male("fullName"=> f.fullName)
  end
  sc.run_fg()
  File.open( "person.xmi", "w+" ) {|p| p.write(tgtmodel)}
  sc.stop()
end
