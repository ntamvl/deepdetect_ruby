# Finetuning
```
DeepdetectRuby::Service.create({name: "selfie_finetuning", model_name: "selfie_finetuning", finetuning: true, weights: "model_iter_16368.caffemodel"})

DeepdetectRuby::Service.create({name: "selfie_finetuning_t1", finetuning: true, weights: "model_iter_16368.caffemodel"})

DeepdetectRuby::Service.create({name: "selfie_finetuning_t2", finetuning: true, weights: "model_iter_16368.caffemodel"})

DeepdetectRuby::Service.delete("selfie_finetuning")

DeepdetectRuby::Train.get_status(service: "selfie_finetuning")

DeepdetectRuby::Train.get_status(service: "selfie_finetuning_t1")

DeepdetectRuby::Service.finetuning({name: "selfie_finetuning", finetuning: true, weights: "model_iter_16368.caffemodel", repository: "/home/ubuntu/training/finetuning/selfie", gpu: true, iterations: 16368, test_interval: 500})

DeepdetectRuby::Service.finetuning({name: "person_yes_no_f1", finetuning: true, weights: "model_iter_5213.caffemodel", repository: "/home/ubuntu/training/finetuning/person_yes_no", gpu: true, iterations: 10000, test_interval: 500})

DeepdetectRuby::Service.finetuning({name: "selfie_f1", finetuning: true, weights: "model_iter_16368.caffemodel", repository: "/home/ubuntu/training/finetuning/selfie", gpu: true, iterations: 18000, test_interval: 500})

DeepdetectRuby::Service.finetuning({name: "selfie_f2", finetuning: true, weights: "model_iter_18000.caffemodel", repository: "/home/ubuntu/training/finetuning/selfie_f2", gpu: true, iterations: 18000, test_interval: 500})

DeepdetectRuby::Service.finetuning({name: "more_than_one_f1", finetuning: true, weights: "model_iter_15000.caffemodel", repository: "/home/ubuntu/training/finetuning/more_than_one", gpu: true, iterations: 18000, test_interval: 500})

DeepdetectRuby::Service.finetuning({name: "selfie_f2_1", finetuning: true, weights: "model_iter_18000.caffemodel", repository: "/home/ubuntu/training/finetuning/selfie_f2", gpu: true, iterations: 18000, test_interval: 500})

DeepdetectRuby::Service.finetuning({name: "selfie_f3", finetuning: true, weights: "model_iter_16368.caffemodel", repository: "/home/ubuntu/training/finetuning/selfie_f2", gpu: true, iterations: 10230, test_interval: 500, measure_index: 2})

DeepdetectRuby::Service.finetuning({name: "selfie_f4", finetuning: true, weights: "model_iter_16368.caffemodel", repository: "/home/ubuntu/training/finetuning/selfie_f4", gpu: true, iterations: 20002, test_interval: 500, measure_index: 1, batch_size: 32, test_batch_size: 32})

```
## Training new updated models with finetuning
```
DeepdetectRuby::Train.launch({service: "selfie_finetuning", repository: "/home/ubuntu/training/finetuning/selfie", gpu: true, iterations: 16368})

DeepdetectRuby::Train.launch({service: "selfie_finetuning_t1", repository: "/home/ubuntu/training/finetuning/selfie", gpu: true, iterations: 16368, test_interval: 500})

DeepdetectRuby::Train.launch({service: "selfie_finetuning_t2", repository: "/home/ubuntu/training/finetuning/selfie", gpu: true, iterations: 16368, test_interval: 500, finetuning: true})
```
--------------------------------------------------------------
Create a service
curl -X PUT "http://localhost:8080/services/selfie" -d "{\"mllib\":\"caffe\",\"description\":\"selfie classification\",\"type\":\"supervised\",\"parameters\":{\"input\":{\"connector\":\"image\",\"height\":224,\"width\":224},\"mllib\":{\"nclasses\":304}},\"model\":{\"repository\":\"/home/ubuntu/projects/deepdetect_u1/models/selfie_f40\"}}"
--------------------------------------------------------------
Finetuning model selfie_f3
curl -X PUT "http://localhost:8080/services/selfie" -d "{\"mllib\":\"caffe\",\"description\":\"selfie classification\",\"type\":\"supervised\",\"parameters\":{\"input\":{\"connector\":\"image\",\"height\":224,\"width\":224},\"mllib\":{\"nclasses\":2, \"mirror\":true, \"weights\":\"model_iter_16368.caffemodel\",\"finetuning\":true, \"gpu\":true}},\"model\":{\"repository\":\"/home/ubuntu/projects/deepdetect_u1/models/selfie_f40\"}}"

curl -X POST "http://localhost:8080/train" -d "{\"service\":\"selfie\",\"async\":true,\"parameters\":{\"mllib\":{\"gpu\":true,\"net\":{\"batch_size\":32},\"solver\":{\"test_interval\":500,\"iterations\":18000,\"base_lr\":0.0001,\"stepsize\":1000,\"gamma\":0.9}},\"input\":{\"connector\":\"image\",\"test_split\":0.1,\"shuffle\":true,\"width\":224,\"height\":224},\"output\":{\"measure\":[\"acc-5\",\"mcll\",\"f1\"]}},\"data\":[\"/home/ubuntu/training/finetuning/selfie_f4\"]}"
--------------------------------------------------------------

curl -X POST "http://localhost:8080/train" -d "{\"service\":\"selfie_finetuning\",\"async\":true,\"parameters\":{\"mllib\":{\"gpu\":true,\"net\":{\"batch_size\":32},\"solver\":{\"test_interval\":500,\"iterations\":10000,\"base_lr\":0.001,\"stepsize\":1000,\"gamma\":0.9}},\"input\":{\"connector\":\"image\",\"test_split\":0.1,\"shuffle\":true,\"width\":224,\"height\":224},\"output\":{\"measure\":[\"acc\",\"mcll\",\"f1\"]}},\"data\":[\"/home/ubuntu/training/finetuning/selfie\"]}"

--------------------------
DeepdetectRuby::Predict.predict({service: "selfie_finetuning", image_url: "http://cdn.feels.com/instagram/asos/1246490803437553418_1557663056.jpg"})

DeepdetectRuby::Predict.predict({service: "person_yes_no_f1", image_url: "http://cdn.feels.com/instagram/asos/1246490803437553418_1557663056.jpg"})
## Before finetuning
:predictions => {
                :uri => "http://cdn.feels.com/instagram/asos/1246490803437553418_1557663056.jpg",
            :classes => [
                [0] {
                    :prob => 0.5820828080177307,
                     :cat => "selfie"
                },
                [1] {
                    :last => true,
                    :prob => 0.4179171919822693,
                     :cat => "no_selfie"
                }
            ]
        }

## After finetuning
:predictions => {
                :uri => "http://cdn.feels.com/instagram/asos/1246490803437553418_1557663056.jpg",
            :classes => [
                [0] {
                    :prob => 0.9999997615814209,
                     :cat => "selfie"
                },
                [1] {
                    :last => true,
                    :prob => 2.4337700210708135e-07,
                     :cat => "no_selfie"
                }
            ]
        }

-----------------------------
http://feels.imgix.net/instagram/asos/1252542985950992360_2206765260.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top
Origin:
https://www.instagram.com/p/BFh7TWfhBfo/
{"normal_resolution":0.990632,"bad_resolution":0.00936781,"normal_lighting":0.987771,"poor_lighting":0.0122286,"someone":0.901468,"no_one":0.0985324,"less_than_one":0.998956,"more_than_one":0.0010435,"men":0.562763,"women":0.437237,"age_above_30":0.40452,"selfie":0.880388,"no_selfie":0.119612,"no_mirrorshot":0.962171,"mirrorshot":0.0378293}

After finetuning:
---> DeepdetectRuby::Predict.predict({service: "selfie_finetuning_t1", image_url: "http://feels.imgix.net/instagram/asos/1252542985950992360_2206765260.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top"})

:predictions => {
                :uri => "http://feels.imgix.net/instagram/asos/1252542985950992360_2206765260.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top",
            :classes => [
                [0] {
                    :prob => 0.9978917241096497,
                     :cat => "no_selfie"
                },
                [1] {
                    :last => true,
                    :prob => 0.002108336426317692,
                     :cat => "selfie"
                }
            ]
        }

-----------------------------
http://feels.imgix.net/instagram/asos/1252353525430668710_1814295050.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top
Origin: https://www.instagram.com/p/BFhQOVogM2m/
{"normal_resolution":0.825466,"bad_resolution":0.174534,"normal_lighting":0.884736,"poor_lighting":0.115264,"someone":0.999343,"no_one":0.000656711,"more_than_one":0.845909,"less_than_one":0.154091,"men":1,"women":1.60751e-10,"age_under_16":0.917247,"selfie":0.976695,"no_selfie":0.0233054,"no_mirrorshot":0.996792,"mirrorshot":0.00320824}

After finetuning:
---> DeepdetectRuby::Predict.predict({service: "selfie_finetuning_t1", image_url: "http://feels.imgix.net/instagram/asos/1252353525430668710_1814295050.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top"})
------------------------------
http://feels.imgix.net/instagram/asos/1251924354355760960_14740578.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top
{"normal_resolution":0.996735,"bad_resolution":0.00326459,"normal_lighting":0.971896,"poor_lighting":0.0281036,"someone":0.878907,"no_one":0.121093,"less_than_one":0.935041,"more_than_one":0.0649591,"women":0.999993,"men":0.00000736875,"age_above_30":0.567047,"selfie":0.863574,"no_selfie":0.136426,"no_mirrorshot":0.996853,"mirrorshot":0.00314677}
DeepdetectRuby::Predict.predict({service: "selfie_finetuning_t1", image_url: "http://feels.imgix.net/instagram/asos/1251924354355760960_14740578.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top"})
:predictions => {
                :uri => "http://feels.imgix.net/instagram/asos/1251924354355760960_14740578.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top",
            :classes => [
                [0] {
                    :prob => 1.0,
                     :cat => "selfie"
                },
                [1] {
                    :last => true,
                    :prob => 5.714219852848146e-08,
                     :cat => "no_selfie"
                }
            ]
        }
-------------------------------------
http://feels.imgix.net/instagram/asos/1251985366878743528_10194825.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top
https://www.instagram.com/p/BFf8g7Qy2vo/
{"someone":1,"no_one":0,"selfie":1,"women":1,"men":0,"no_selfie":0,"normal_resolution":0.999719,"bad_resolution":0.000280655,"normal_lighting":0.998396,"poor_lighting":0.00160362,"less_than_one":0.912216,"more_than_one":0.0877836,"age_above_30":0.469602}

DeepdetectRuby::Predict.predict({service: "selfie_finetuning_t1", image_url: "http://feels.imgix.net/instagram/asos/1252033944498407117_1223425960.jpg?w=530&h=530&dpr=2&fit=crop&crop=faces,top"})

DeepdetectRuby::Predict.predict({service: "selfie_finetuning_t2", image_url: "http://feels.imgix.net/instagram/asos/1252404500268043866_27876266.jpg"})

DeepdetectRuby::Predict.predict({service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255170406470979359_3253319674.jpg"})

DeepdetectRuby::Predict.predict({service: "selfie_f1", image_url: "//feels.imgix.net/instagram/asos/1255355896542752718_27057010.jpg"})

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255266658690557670_11397328.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255271338485499066_775122576.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255424592408535294_185254919.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255390340978924420_15115085.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255662739004227204_330560670.jpg") --> not ok, must be selfie

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255602514657391462_15783947.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255622208398307634_317677827.jpg") --> not ok, must be selfie

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255534513632110008_553559664.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255455561021981994_197430064.jpg") --> not ok, must be selfie

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255399707491145944_1457907277.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255337649249306267_558272928.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://feels.imgix.net/instagram/asos/1255237247935534338_238585596.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://cdn.feels.com/instagram/asos/1256146576133469486_222484236.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f1", image_url: "http://cdn.feels.com/instagram/asos/1256146220572730237_30723063.jpg")

DeepdetectRuby::Predict.predict(service: "more_than_one_f1", image_url: "http://cdn.feels.com/instagram/asos/1256909233581381035_264705436.jpg")

DeepdetectRuby::Predict.predict(service: "more_than_one_f1", image_url: "http://cdn.feels.com/instagram/asos/1256902797330248703_3013321051.jpg")

DeepdetectRuby::Predict.predict(service: "more_than_one_f1", image_url: "http://feels.imgix.net/instagram/asos/1256951961487542817_1462068201.jpg")

DeepdetectRuby::Predict.predict(service: "selfie_f2_1", image_url: "http://feels.imgix.net/instagram/newlookfashion/1231213665197843799_1452988672.jpg") --> error

DeepdetectRuby::Predict.predict(service: "selfie_f3", image_url: "http://feels.imgix.net/instagram/newlookfashion/1231213665197843799_1452988672.jpg")

curl -X POST "http://localhost:8080/predict" -d "{\"service\":\"selfie_f3\",\"parameters\":{\"output\":{\"best\":2}},\"data\":[\"http://feels.imgix.net/instagram/newlookfashion/1231213665197843799_1452988672.jpg\"]}"
--------------------------
http://cdn.feels.com/instagram/newlookfashion/1221769581631587626_433120464.jpg
old predict: --> bad, wrong result
DeepdetectRuby::Predict.predict(service: "selfie", image_url: "http://cdn.feels.com/instagram/newlookfashion/1221769581631587626_433120464.jpg")
:predictions => {
                :uri => "http://cdn.feels.com/instagram/newlookfashion/1221769581631587626_433120464.jpg",
            :classes => [
                [0] {
                    :prob => 0.95999675989151,
                     :cat => "selfie"
                },
                [1] {
                    :last => true,
                    :prob => 0.040003255009651184,
                     :cat => "no_selfie"
                }
            ]
        }

new predict: --> better, more accuracy
DeepdetectRuby::Predict.predict(service: "selfie_f3", image_url: "http://cdn.feels.com/instagram/newlookfashion/1221769581631587626_433120464.jpg")
:predictions => {
      :uri => "https://feels.imgix.net/instagram/newlookfashion/1221769581631587626_433120464.jpg",
  :classes => [
      [0] {
          :prob => 0.8537927865982056,
           :cat => "no_selfie"
      },
      [1] {
          :last => true,
          :prob => 0.14620719850063324,
           :cat => "selfie"
      }
  ]
}

-------------------
OpenCV Error: Assertion failed (buf.data && buf.isContinuous()) in imdecode_, file /build/buildd/opencv-2.4.8+dfsg1/modules/highgui/src/loadsave.cpp, line 307

ERROR - 02:32:08 - service selfie_f3 mllib bad param: /build/buildd/opencv-2.4.8+dfsg1/modules/highgui/src/loadsave.cpp:307: error: (-215) buf.data && buf.isContinuous() in function imdecode_

------------------------
DeepdetectRuby::Predict.predict(service: "mirrorshot_f1", image_url: "http://cdn.feels.com/instagram/converse/1286789533837253555_412988956.jpg")
DeepdetectRuby::Predict.predict(service: "mirrorshot_f1", image_url: "http://cdn.feels.com/instagram/converse/1286744821742913513_1637327762.jpg")

------------------------
DeepdetectRuby::Predict.predict(service: "more_than_one_c", image_url: "http://feels.imgix.net/instagram/asos/1256951961487542817_1462068201.jpg")

DeepdetectRuby::Predict.predict(service: "more_than_one_c", image_url: "http://cdn.feels.com/instagram/missguided/1293683001124816735_215780245.jpg")


-------------------
## Rsync
