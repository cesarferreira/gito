require 'json'

file = File.read('detector.json')
types = JSON.parse(file)
chosen = nil
types.each do |item|
	if File.exist? (item['file_requirement'])
		chosen = item
		break
	end
end

unless chosen.nil?
	puts "Found: " + chosen['type']
	puts "how to install: " + chosen['installation']
end
