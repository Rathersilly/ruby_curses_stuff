# with this file want to send http request to server and view
# response - esp header

require 'socket'
require 'net/http'

hostname = 'http://localhost'
port = 4000
uri = URI("#{hostname}:#{port}")
p uri
$stdout.flush
req = Net::HTTP::Get.new(uri)
req[:this_header] = "this value"

p uri
p req
$stdout.flush
res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end
puts res.header
puts res.body

#s = TCPSocket.open(hostname, port)
s = TCPSocket.open('localhost', port)
header = ""

s.print "GET / HTTP1.1\r\n"
while line = s.gets
  puts line.chomp
end
s.close
