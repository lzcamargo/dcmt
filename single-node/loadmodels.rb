#!/bin/env ruby
# encoding: utf-8
module LoadModels
  # function to identify the file kid (model), XMI or JSON and extracting to hash file.
  def modelstobloom
    fileext = File.extname(File.expand_path("../family-100000.xmi", __FILE__).to_s)
    filename = File.expand_path("../family-100000.xmi", __FILE__).to_s
		case fileext
			when ".xmi"
				hash = Crack::XML.parse(File.read(filename))
			when ".json"
				hash = JSON.parse(File.read(filename))
			else
				puts "The  #{fileext} extension is not yet suport to #{filename}!"
				exit
			end
     hashtobloom(hash, 0, "")
  end

  def genid()
    id = 0
    while id == 0
      id +=1
    end
    return id
  end

  #function to process Hash values
  def hashtobloom(h, parent, pkey)
    id = genid()
		input_model <+ [[id, parent, pkey ]]
		h.each do |k, v|
    	if v.is_a?(Hash)
        hashtobloom( v, id, k )
      elsif v.is_a?(Array)
        arraytobloom( v, id, k )
      else
				input_model_prop <+ [[ v, id, k ]]
      end
    end
  end

  #function to process Array values
  def arraytobloom(h, parent, pkey)
    id = genid()
		input_model <+ [[ id, parent, pkey ]]
		h.each do |v|
      if v.is_a?(Hash)
        hashtobloom( v, id, 0 )
      elsif v.is_a?(Array)
        arraytobloom( v, id, 0 )
      else
				input_model_prop <+ [[ v, id, 0 ]]
      end
    end
  end
end
