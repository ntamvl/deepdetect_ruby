module DeepdetectRuby
  def self.info(options = {})
    begin
      server_index = options[:server_index] || 1
      dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
      info_url = "#{dede_host}/info"
      dede_info = HTTParty.get(info_url)
      info = JSON.parse(dede_info.to_json)
      info.extend DeepSymbolizable
      return info.deep_symbolize
    rescue Exception => e
      puts "\n[DeepdetectRuby Info]. #{e.to_s} \n"
      return nil
    end
  end

  def self.status(options = {})
    info(options)
  end

  def self.get_server(server_index = 1)
    debug = DeepdetectRuby.options[:debug]
    if DeepdetectRuby.options[:is_scaling]
      servers = DeepdetectRuby.options[:servers].split(",").map{|s| s.strip}
      puts "\n[get_server] server #{server_index} is running. We have #{servers.count} server working together. \n" if debug
      if !servers.nil? && servers.present?
        dede_index = server_index - 1
        if dede_index >= 0
          return servers[dede_index]
        else
          puts "\n[DedeServer] server_index must be greater than 0 \n" if debug
        end
      else
        puts "\n[DedeServer] hosts must not be empty \n" if debug
      end
    else
      puts "\n[get_server] single server is running \n" if debug
      return DeepdetectRuby.options[:host]
    end
  end

end
