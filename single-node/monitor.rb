require 'rubygems'
require 'bud'
require 'crack'
require 'builder'
require 'gyoku' 
require_relative 'family2person'
require_relative 'injector'
require_relative 'loadmodels'
require_relative 'extractprotocol'
require_relative 'metamodelsprotocol'

include MetamodelsProtocol

class BloomInstances
	include Bud
	include Family2Person

	def instances(a,b,c)
		family <+ [[a,b,c]]
	end

end

class MonitorF2P
	include Bud
	include ExtractProtocol
	include MetamodelsProtocol
	include LoadModels
	include Injector

end

m = MonitorF2P.new
m.modelstobloom
m.tick

tgtmodel =""
xml = Builder::XmlMarkup.new(:target=>tgtmodel, :indent=>2)  
xml.instruct! :xmi, :version => "1.1", :encoding => "US-ASCII"

m.family_name do |i|
  m.family_members.each do |m|
   	if i.fn_elm_ref == m.fm_elm_ref
			f = Family.new()
		  f.lastName = i.fn_elm_name
			f.members = [m.fm_elm_name, m.fm_elm_type]
			b = BloomInstances.new()
			b.instances(f.lastName, f.members[0], f.members[1])
			b.tick

			b.male do |l|
        pm = Male.new
				pm.fullName = l.fullName
        xml.Male("fullName"=> l.fullName) 
			end
			b.female do |f|
				pf = Female.new
				pf.fullName = f.fullName
				xml.Male("fullName"=> f.fullName)
			end
		end
		#writes XML Person file from male and female collections    
		File.open( "person.xmi", "w+" ) {|f| f.write(tgtmodel)}
	end
end


