require 'yunpiansms/version'
require 'yunpiansms/sms_resources'
require 'yunpiansms/http_base'


module Yunpiansms
  class Service
    attr_accessor :apikey, :connection_adapter,:debug_flg

    def initialize(apikey: "", connection_adapter: :net_http, debug_flg: false)
      @apikey = apikey
      @connection_adapter = connection_adapter
      @debug_flg = debug_flg
    end

    def self.config
      yield service = new; service
    end

    def send_to(content, mobiles = nil)
      http.post(Yunpiansms::SmsResources::SEND_URL,params_data(content, mobiles))
    end

    def tpl_send_to(content, mobiles = nil, tpl_id = nil, tpl_value=nil)
      http.post(Yunpiansms::SmsResources::TPL_SEND_URL,params_data_tpl(content, mobiles, tpl_id,tpl_value))
    end

    private

    def params_data(content, mobiles)
      content          = format_content(content,mobiles)
      content[:text]   = "#{format_tpl_value(content[:text])}"
      content
    end

    def params_data_tpl(content, mobiles = nil, tpl_id = nil, tpl_value=nil)
      content               = format_content(content,mobiles)
      content[:tpl_id]      = tpl_id || content.delete(:tpl_id)
      content[:tpl_value]   = "#{format_tpl_value(content[:tpl_value])}"
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

    def format_tpl_value(tpl_value)
      if tpl_value.is_a?(Hash)
        tpl_value = parse_tpl_value(tpl_value)
      else
        tpl_value
      end
    end

    def parse_tpl_value tpl_value
      tpl_value.map { |k, v| "##{k}#=#{v}" }.join('&')
    end
  end
end
