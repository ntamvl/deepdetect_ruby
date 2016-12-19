module DeepdetectRuby
  class Train
    def self.launch(options = {}, is_custom_data = false)
      begin
        debug = DeepdetectRuby.options[:debug]
        server_index = options[:server_index] || 1
        dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
        dede_api_url = "#{dede_host}/train"
        puts "\n-------------> Starting to launch DeepDetect training #{dede_api_url}....\n" if debug

        options[:service] = !options[:service].nil? ? options[:service] : ""
        options[:async] = !options[:async].nil? ? options[:async] : true
        options[:gpu] = !options[:gpu].nil? ? options[:gpu] : true
        options[:batch_size] = !options[:batch_size].nil? ? options[:batch_size] : 128
        options[:test_batch_size] = !options[:test_batch_size].nil? ? options[:test_batch_size] : 64
        options[:test_interval] = !options[:test_interval].nil? ? options[:test_interval] : 500
        options[:iterations] = !options[:iterations].nil? ? options[:iterations] : 10001
        options[:base_lr] = !options[:base_lr].nil? ? options[:base_lr] : 0.0001
        options[:stepsize] = !options[:stepsize].nil? ? options[:stepsize] : 1000
        options[:gamma] = !options[:gamma].nil? ? options[:gamma] : 0.9
        options[:connector] = !options[:connector].nil? ? options[:connector] : "image"
        options[:test_split] = !options[:test_split].nil? ? options[:test_split] : 0.1
        options[:shuffle] = !options[:shuffle].nil? ? options[:shuffle] : true
        options[:width] = !options[:width].nil? ? options[:width] : 224
        options[:height] = !options[:height].nil? ? options[:height] : 224
        options[:repository] = !options[:repository].nil? ? options[:repository] : ""

        options[:finetuning] = !options[:finetuning].nil? ? options[:finetuning] : false
        options[:solver_type] = !options[:solver_type].nil? ? options[:solver_type] : "SGD"
        # options[:solver_type] = "NESTEROV" if options[:finetuning]
        options[:snapshot] = !options[:snapshot].nil? ? options[:snapshot] : 2000
        options[:measure_index] = !options[:measure_index].nil? ? options[:measure_index] : 1

        measure = ["acc", "mcll", "f1"]
        if options[:measure_index] == 1
          measure = ["acc-5", "mcll", "f1"]
        elsif options[:measure_index] == 2
          measure = ["acc", "mcll", "cmdiag"]
        end

        data = {
          "service" => "#{options[:service]}",
          "async" => options[:async],
          "parameters" => {
            "mllib" => {
              "gpu" => options[:gpu],
              "net" => {
                "batch_size" => options[:batch_size],
                "test_batch_size" => options[:test_batch_size]
              },
              "solver" => {
                "test_interval" => options[:test_interval],
                "iterations" => options[:iterations],
                "base_lr" => options[:base_lr],
                "stepsize" => options[:stepsize],
                "gamma" => options[:gamma],
                "test_initialization" => true,
                "solver_type" => "#{options[:solver_type]}",
                "snapshot" => options[:snapshot]
              }
            },
            "input" => {
              "connector" => "#{options[:connector]}",
              "test_split" => options[:test_split],
              "shuffle" => options[:shuffle],
              "width" => options[:width],
              "height" => options[:height]
            },
            "output" => {
              "measure" => measure
            }
          },
          "data" => [
            "#{options[:repository]}"
          ]
        }
        puts "\nparams data: #{data.to_json} \n" if debug
        data = options if is_custom_data
        dede_body = {
          :body => data.to_json,
          :headers => { "Content-Type" => 'application/json' }
        }
        object = HTTParty.post(dede_api_url, dede_body)
        object_info = JSON.parse(object.body)
        object_info.extend DeepSymbolizable
        return object_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby Train - launch training]. #{e.to_s} \n"
      end
    end # end launch

    def self.get_status(options = {})
      debug = DeepdetectRuby.options[:debug]
      server_index = options[:server_index] || 1
      dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
      options[:job] = !options[:job].nil? ? options[:job] : 1
      options[:timeout] = !options[:timeout].nil? ? options[:timeout] : 20
      dede_api_url = "#{dede_host}/train?service=#{options[:service]}"
      dede_api_url = "#{dede_api_url}&job=#{options[:job]}"
      dede_api_url = "#{dede_api_url}&timeout=#{options[:timeout]}"

      puts "\n-------------> Starting to get_status DeepDetect training #{dede_api_url}....\n" if debug

      begin
        object = HTTParty.get(dede_api_url)
        object_info = JSON.parse(object.body)
        object_info.extend DeepSymbolizable
        return object_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby Train - get_status]. #{e.to_s} \n"
      end
    end # end get_status

    # options = { service: "service name", job: 1 }
    def self.delete_job(options = {})
      debug = DeepdetectRuby.options[:debug]
      server_index = options[:server_index] || 1
      dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
      options[:job] = !options[:job].nil? ? options[:job] : 1
      dede_api_url = "#{dede_host}/train?service=#{options[:service]}"
      dede_api_url = "#{dede_api_url}&job=#{options[:job]}"
      puts "\n-------------> Starting to delete_job DeepDetect training #{dede_api_url}....\n" if debug
      begin
        object = HTTParty.delete(dede_api_url)
        object_info = JSON.parse(object.body)
        object_info.extend DeepSymbolizable
        return object_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby Train - delete_job]. #{e.to_s} \n"
      end
    end
  end
end
