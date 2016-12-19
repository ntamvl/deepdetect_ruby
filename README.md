# DeepDetect for Ruby
DeepDetect is a Deep Learning API and server written in C++11. It makes the state-of-the-art Deep Learning easy to work with and can easily be integrated into existing applications.

## DeepDetect supports the following features:
### General
+ High level & generic API for machine learning & deep learning
+ JSON communication format
+ Remote Python client library
+ Embedded server with support for asynchronous training calls
+ High performance, benefits from multicores and GPU
+ Flexible input / output connectors
+ Flexible template output format to simplify connection with external applications
+ Removal of database dependency and sync, as everything is organized on the filesystem

### Machine Learning / Deep Learning
+ Support for state-of-the-art Deep Learning via Caffe library
+ Templates for the most useful neural architectures (e.g. Googlenet, Alexnet, NiN, mlp, convnet, logistic regression)
+ Range of built-in model assessment measures (e.g. F1, multiclass log loss, …)
+ Support for multiple Machine Learning services, training and prediction calls in parallel
+ Optimization for CPUs and GPUs
+ Supervised learning, regression and prediction over images and other numerical and textual data

### Data
+ Built-in input connectors to ease the setup of a machine learning pipeline
+ Easy management for large datasets of images
+ Easy management and preprocessing for CSV data files
+ Connector to handle large collections of images with on-the-fly data augmentation (e.g. rotations, mirroring)
+ Connector to handle CSV files with preprocessing capabilities
+ Connector to handle text files
+ Output connectors for various external applications being able to be set up through templates via the API, without code (e.g. for Elasticsearch, XML, SQL, …)

# Architecture Diagram
![DeepDetect Ruby App Diagram](https://c4.staticflickr.com/6/5479/30255507155_10d1fdc799_b.jpg)

## Requirements
- Ubuntu 14.04 LTS
- Ruby 2.2.1 or above
- Rails 4.2.5 or above
- DeepDetect
- DeepDetect Dependencies:
    - C++, gcc >= 4.8 or clang with support for C++11 (there are issues with Clang + Boost)
    - eigen for all matrix operations
    - glog for logging events and debug
    - gflags for command line parsing
    - OpenCV >= 2.4
    - cppnetlib
    - Boost
    - curl
    - curlpp
    - utfcpp
    - gtest for unit testing (optional)
- Caffe Dependencies:
    - CUDA 7 or 6.5 is required for GPU mode.
    - BLAS via ATLAS, MKL, or OpenBLAS.
    - protobuf
    - IO libraries hdf5, leveldb, snappy, lmdb

## Installation
Welcome to your new gem! In this directory, you'll find the files you need in order to package your Ruby library into a gem.

Put your Ruby code in the file `lib/deepdetect_ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

**Add this line to your application's Gemfile:**

```ruby
gem 'deepdetect_ruby', git: "git@github.com:ntamvl/deepdetect_ruby.git"
```
And then execute:
```
$ bundle
```
Or install it yourself as:
```
$ gem install deepdetect_ruby
```

## Build DeepDetect
- On Ubuntu Linux, do:
```
sudo apt-get install build-essential libgoogle-glog-dev libgflags-dev libeigen3-dev libopencv-dev libcppnetlib-dev libboost-dev libboost-iostreams-dev libcurlpp-dev libcurl4-openssl-dev protobuf-compiler libopenblas-dev libhdf5-dev libprotobuf-dev libleveldb-dev libsnappy-dev liblmdb-dev libutfcpp-dev cmake
```
- Build from source code:
```
cd
git clone git@github.com:beniz/deepdetect.git && cd deepdetect
mkdir build && cd build
cmake ..
make
```

## Usage
Configure on Rails at `config/application.rb`

*for single server*
```ruby
DeepdetectRuby.configure do |config|
    config.host = "http://deepdetect_server_ip_or_domain:8080"
    config.model_path = "/home/tamnguyen/models"
end
```

*for multiple servers*
```ruby
DeepdetectRuby.configure do |config|
    config.model_path = "/home/tamnguyen/models"
    config.is_scaling = true
    config.servers = "http://deepdetect_server_ip_or_domain_1:8080, http://deepdetect_server_ip_or_domain_2:8080"
end
```

**Example config at `config/application.rb`**
```ruby
# begin load DeepDetect config
config_file_path = "#{Rails.root}/config/deepdetect.json"
model_hash = JSON.parse(File.read(config_file_path))
model_path = model_hash["model_path"]
DeepdetectRuby.configure do |config|
    # config.host = "http://127.0.0.1:8080"
    config.model_path = "#{model_path}"
    config.debug = false
    config.is_scaling = true
    config.servers = "http://deepdetect_server_ip_or_domain_1:8080, http://deepdetect_server_ip_or_domain_2:8080"
end
# end load DeepDetect config
```
*with `deepdetect.json` at `config/deepdetect.json`*
```ruby
{
  "model_path": "/home/ubuntu/projects/deepdetect/models"
}
```
## Create a deepdetect service
Example: Test creating a service
```ruby
options = {
            "name": "tress",
            "mllib": "caffe",
            "description": "trees classification",
            "type": "supervised",
            "connector": "image",
            "height": 224,
            "width": 224,
            "nclasses": 304,
            "repository": "/home/tamnguyen/models/trees"
            }

DeepdetectRuby::Service.create(options)
```
*with default options*
```ruby
options = {
           :name => "[name of service]",
          :mllib => "caffe",
    :description => "",
           :type => "supervised",
      :connector => "image",
          :width => 224,
         :height => 224,
       :nclasses => 2,
     :model_path => "[path to models on server]"
}
```

## Launch a training job
```ruby
DeepdetectRuby::Train.launch(options = {}, is_custom_data = false)
```

## Get information on a training job
```ruby
DeepdetectRuby::Train.get_status(options = {})
```
*with default options*
```ruby
options = {
        :job => 1,
    :timeout => 20,
    :service => "[name of service]"
}
```

## Delete a training job
```ruby
DeepdetectRuby::Train.delete(options = {})
```
*with default options*
```ruby
options = {
        :job => 1,
    :service => "[name of service]"
}
```

## Prediction
```ruby
DeepdetectRuby::Predict.predict(options)
```
*with default options*
```ruby
options = {
         :best => 2,
          :gpu => true,
      :service => "[name of service]",
    :image_url => "[image url]",
     :template => "[output template]"
}
```

## Fine tune model
```ruby
DeepdetectRuby::Service.finetune(options)
```
*with options*
```ruby
options = {
               :name => "[string - service name]",
            :weights => "[filename of caffe model]",
         :repository => "[repo path]",
                :gpu => true,
         :iterations => 10000,
      :test_interval => 500,
           :nclasses => 2,
      :measure_index => 1,
         :batch_size => 32,
    :test_batch_size => 32
}
```

## Suggestion for Diagram of neural network models

In order to receive results with high accuracy, when applied to Pixai, this diagram of neural network models should be used as suggested below:
![Chain of Models Diagram](https://c2.staticflickr.com/6/5492/29641623713_c43b64d5e3_b.jpg)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow experimentation.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contribution
DeepDetect Ruby gem is designed and implemented by Tam Nguyen ntamvl@gmail.com](ntamvl@gmail.com)
Bug reports and pull requests are welcome on GitHub at https://github.com/ntamvl/deepdetect_ruby.

## License
The gem is available as a private repository under MIT License
