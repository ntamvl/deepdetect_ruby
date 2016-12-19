module DeepdetectRuby
  class Predict
    def self.predict(options = {})
      begin
        debug = DeepdetectRuby.options[:debug]
        server_index = options[:server_index] || 1
        dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
        dede_api_url = "#{dede_host}/predict"
        puts "\n-------------> Starting to predict an image #{dede_api_url}....\n" if debug
        best = options[:best] || 2
        gpu = options[:gpu] || true
        width = options[:width] || 224
        height = options[:height] || 224

        data = {
          "service" => "#{options[:service]}",
          "parameters" => {
            "input" => {
              "width" => width,
              "height" => height
            },
            "output" => {
              "best" => best
            },
            "mllib" => { "gpu" => gpu }
          },
          "data" => [
            "#{options[:image_url]}"
          ]
        }
        if !options[:template].nil?
          data["parameters"]["output"]["template"] = options[:template]
        end

        puts "\nData: #{data.to_json} \n" if debug

        dede_body = {
          :body => data.to_json,
          :headers => { "Content-Type" => 'application/json' }
        }
        object = HTTParty.post(dede_api_url, dede_body)
        predict_info = JSON.parse(object.body)
        predict_info.extend DeepSymbolizable
        return predict_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby Predict - predict]. #{e.to_s} \n"
      end
    end # end predict
  end
end
