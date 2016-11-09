require "yunpiansms/version"
require "yunpiansms/sms_resources"
require "yunpiansms/http_base"


module Yunpiansms
  class Service
    attr_accessor :apikey, :signature, :connection_adapter,:debug_flg

    def initialize(apikey: "", signature: "", connection_adapter: :net_http, debug_flg: false)
      @apikey = apikey
      @signature = signature
      @connection_adapter = connection_adapter
      @debug_flg = debug_flg
    end

    def self.config
      yield service = new; service
    end

    def send_to(content, mobiles = nil, signature = nil)
      http.post(Yunpiansms::SmsResources::SEND_URL,params_data(content, mobiles , signature))
    end

    def tpl_send_to(content, mobiles = nil, tpl_id = nil, tpl_value=nil, signature = nil)
      http.post(Yunpiansms::SmsResources::TPL_SEND_URL,params_data_tpl(content, mobiles, tpl_id,tpl_value,signature))
    end

    private

    def params_data(content, mobiles, signature = nil)
      content          = format_content(content,mobiles)
      content[:text]   = "#{signature || @signature}#{content[:text]}"
      content
    end

    def params_data_tpl(content, mobiles = nil, tpl_id = nil, tpl_value=nil, signature = nil)
      content               = format_content(content,mobiles)
      content[:tpl_id]      = tpl_id || content.detele(:tpl_id)
      content[:tpl_value]   = "#{signature || @signature}#{content[:text]}"
      content
    end

    def http 
      host = Yunpiansms::SmsResources::SEND_DOMAIN
      Yunpiansms::HttpBase.new(host, @connection_adapter)
    end

    def mobile_format(mobiles = nil)
      if mobiles.is_a?(Array)
        mobiles = Array(mobiles).join(',')
      else
        mobiles = mobiles
      end
    end

    def format_content(content = {},mobiles)
      params = {}
      content.map do |k,v|
        params["#{k}".to_sym] = v
      end
      params[:apikey] = params.delete(:apikey) || @apikey
      params[:mobile] = mobile_format(mobiles || params[:mobile])
      params
    end
  end
end
