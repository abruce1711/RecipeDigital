string = '["these","are","test","tags"]'
string = string.split(',')
string.each do |i|
	puts i.gsub(/[\W]/, '')
end