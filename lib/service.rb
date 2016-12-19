module DeepdetectRuby
  class Service
    def self.create(options = {})
      begin
        debug = DeepdetectRuby.options[:debug]
        server_index = options[:server_index] || 1
        dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
        dede_api_url = "#{dede_host}/services/#{options[:name]}"
        puts "\n-------------> Starting to create DeepDetect service #{dede_api_url}....\n" if debug

        description = "#{options[:name]} classification service"
        options[:mllib] = !options[:mllib].nil? ? options[:mllib] : "caffe"
        options[:description] = !options[:description].nil? ? options[:description] : description
        options[:type] = !options[:type].nil? ? options[:type] : "supervised"
        options[:connector] = !options[:connector].nil? ? options[:connector] : "image"
        options[:width] = !options[:width].nil? ? options[:width] : 224
        options[:height] = !options[:height].nil? ? options[:height] : 224
        options[:nclasses] = !options[:nclasses].nil? ? options[:nclasses] : 2
        options[:gpu] = !options[:gpu].nil? ? options[:gpu] : true

        # for finetuning
        options[:finetuning] = !options[:finetuning].nil? ? options[:finetuning] : false
        options[:template] = !options[:template].nil? ? options[:template] : "googlenet"
        options[:weights] = !options[:weights].nil? ? options[:weights] : nil
        options[:rotate] = !options[:rotate].nil? ? options[:rotate] : false
        options[:mirror] = !options[:mirror].nil? ? options[:mirror] : false
        options[:mirror] = options[:finetuning]

         if !DeepdetectRuby.options[:model_path].nil? && !DeepdetectRuby.options[:model_path].empty?
          options[:repository] = "#{DeepdetectRuby.options[:model_path]}/#{options[:name]}"
        end

        # for different model name
        if !options[:model_name].nil? && !options[:model_name].empty?
          options[:repository] = "#{DeepdetectRuby.options[:model_path]}/#{options[:model_name]}"
        end

        data = {
          "mllib" => "#{options[:mllib]}",
          "description" => "#{options[:description]}",
          "type" => "#{options[:type]}",
          "parameters" => {
            "input" => {
              "connector" => "#{options[:connector]}",
              "height" => options[:height],
              "width" => options[:width]
            },
            "mllib" => {
              "nclasses" => options[:nclasses],
              "gpu" => options[:gpu]
            }
          },
          "model" => {
            "repository" => "#{options[:repository]}"
          }
        }

        if options[:finetuning] && !options[:weights].nil?
          data = {
                    "mllib" => "#{options[:mllib]}",
                    "description" => "#{options[:description]}",
                    "type" => "#{options[:type]}",
                    "parameters" => {
                      "input" => {
                        "connector" => "#{options[:connector]}",
                        "height" => options[:height],
                        "width" => options[:width]
                      },
                      "mllib" => {
                        "nclasses" => options[:nclasses],
                        "gpu" => options[:gpu],
                        "weights" => options[:weights],
                        "finetuning" => options[:finetuning],
                        "rotate" => options[:rotate],
                        "mirror" => options[:mirror]
                      }
                    },
                    "model" => {
                      "repository" => "#{options[:repository]}"
                    }
                  }
        end

        puts "\nparams data: #{data.to_json} \n" if debug
        dede_body = {
          :body => data.to_json,
          :headers => { "Content-Type" => 'application/json' }
        }
        object = HTTParty.put(dede_api_url, dede_body)
        object_info = JSON.parse(object.body)
        object_info.extend DeepSymbolizable
        return object_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby Service]. #{e.to_s} \n"
      end

    end

    def self.get_info(service_name = "", server_index = 1)
      begin
        debug = DeepdetectRuby.options[:debug]
        dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
        dede_api_url = "#{dede_host}/services/#{service_name}"
        puts "\n-------------> Starting to get information DeepDetect service #{dede_api_url}....\n" if debug
        object = HTTParty.get(dede_api_url)
        object_info = JSON.parse(object.body)
        object_info.extend DeepSymbolizable
        return object_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby Service get information]. #{e.to_s} \n"
      end
    end

    def self.delete(service_name = "", server_index = 1)
      begin
        debug = DeepdetectRuby.options[:debug]
        dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
        dede_api_url = "#{dede_host}/services/#{service_name}"
        puts "\n-------------> Starting to delete DeepDetect service #{dede_api_url}....\n" if debug
        object = HTTParty.delete(dede_api_url)
        object_info = JSON.parse(object.body)
        object_info.extend DeepSymbolizable
        return object_info.deep_symbolize
      rescue Exception => e
        puts "\n[DeepdetectRuby delete service]. #{e.to_s} \n"
      end
    end

    def self.load_all_models(options = {})
      debug = DeepdetectRuby.options[:debug]
      server_index = options[:server_index] || 1
      dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
      puts "\n-----------> Starting to load_all_models..." if debug
      model_path = DeepdetectRuby.options[:model_path]
      dirs = Dir.glob("#{model_path}/*").select{ |e| File.directory? e }
      dirs.each_with_index do |dir, index|
        model_name = File.basename(dir)
        dede_opts = { repository: dir, name: model_name, server_index: server_index }
        DeepdetectRuby::Service.create(dede_opts)
        puts "Index: #{index} - model name: #{model_name} in #{dir}" if debug
      end
      puts "\n-----------> End to load_all_models..." if debug
    end

    def self.reload_models(options = {})
      debug = DeepdetectRuby.options[:debug]
      server_index = options[:server_index] || 1
      dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
      puts "\n-----------> Starting to reload models..." if debug
      model_path = DeepdetectRuby.options[:model_path]
      dirs = Dir.glob("#{model_path}/*").select{ |e| File.directory? e }
      dirs.each_with_index do |dir, index|
        model_name = File.basename(dir)
        DeepdetectRuby::Service.delete(model_name, server_index)
      end
      DeepdetectRuby::Service.load_all_models(server_index)
      puts "\n-----------> End to reload models..." if debug
    end

    def self.list_models
      debug = DeepdetectRuby.options[:debug]
      puts "\n-----------> Starting to reload models..." if debug
      model_path = DeepdetectRuby.options[:model_path]
      dirs = Dir.glob("#{model_path}/*").select{ |e| File.directory? e }
      list = []
      dirs.each_with_index do |dir, index|
        model_name = File.basename(dir)
        list << model_name
      end
      puts "\nList models: #{list.to_json}" if debug
      return list
    end

    def self.list_models_running(options = {})
      dede = DeepdetectRuby.info(options)
      services = dede[:head][:services]
      return services
    end

    def self.finetuning(options = {})
      puts "\n-----> Starting to create service and train for finetuning \n"
      server_index = options[:server_index] || 1
      dede_host = DeepdetectRuby::DedeServer.get_server(server_index)
      options[:name] = !options[:name].nil? ? options[:name] : ""
      # weights is called the caffe filename model, example: model_iter_16368.caffemodel
      options[:weights] = !options[:weights].nil? ? options[:weights] : ""
      options[:repository] = !options[:repository].nil? ? options[:repository] : ""
      options[:gpu] = !options[:gpu].nil? ? options[:gpu] : true
      options[:iterations] = !options[:iterations].nil? ? options[:iterations] : 10000
      options[:test_interval] = !options[:test_interval].nil? ? options[:test_interval] : 500
      options[:nclasses] = !options[:nclasses].nil? ? options[:nclasses] : 2
      options[:measure_index] = !options[:measure_index].nil? ? options[:measure_index] : 1
      options[:batch_size] = !options[:batch_size].nil? ? options[:batch_size] : 32
      options[:test_batch_size] = !options[:test_batch_size].nil? ? options[:test_batch_size] : 32

      if !options[:name].empty? && !options[:weights].empty? && !options[:repository].empty?
        # Create a service for finetuning
        service_options = { name: "#{options[:name]}",
                            finetuning: true,
                            weights: "#{options[:weights]}",
                            nclasses: options[:nclasses],
                            server_index: server_index
                          }
        DeepdetectRuby::Service.create(service_options)

        puts "\nWaiting to start function fine tune..."
        sleep(3)

        # Train a new updated service for finetuning
        train_options = { service: "#{options[:name]}",
                          repository: "#{options[:repository]}",
                          gpu: true,
                          iterations: options[:iterations],
                          test_interval: options[:test_interval],
                          finetuning: true,
                          measure_index: options[:measure_index],
                          batch_size: options[:batch_size],
                          test_batch_size: options[:test_batch_size],
                          server_index: server_index
                        }
        DeepdetectRuby::Train.launch(train_options)
      else
        puts "\nMissing options :name or :weights or :repository. Please check. :) \n"
      end
    end

  end
end
