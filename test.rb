lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
@yunpiansms_service = Yunpiansms::Service.config do |s|
  s.apikey             = ""
  s.signature          = "TryCatch"
  s.connection_adapter = :net_http # default
end
content = {
  apikey: "",
  mobile: "15279058411",
  text:   "测试一下短信发送",
  uid:    "15279"
}
result = @yunpiansms_service.send_to(content,"15279058411")