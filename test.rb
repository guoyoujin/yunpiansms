lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
@yunpiansms_service = Yunpiansms::Service.config do |s|
  s.apikey             = ""
  s.connection_adapter = :net_http # default
end
content = {
  apikey: "",
  mobile: "",
  text:   "123",
  uid:    "15279"
}
result = @yunpiansms_service.send_to(content,"")
content = {
  apikey: "",
  mobile: "",
  tpl_value:   {key:"1245",key1:"23"},
  uid:    "15279"
}
result = @yunpiansms_service.tpl_send_to(content,"",1,nil)
content = {
  apikey: "",
  mobile: "",
  text:   {key:"1245",key1:"23"},
  uid:    "15279"
}
result = @yunpiansms_service.send_to(content,"")