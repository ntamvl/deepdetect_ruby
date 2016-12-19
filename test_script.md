{
    "mllib": "caffe",
    "description": "trees classification",
    "type": "supervised",
    "parameters": {
        "input": {
            "connector": "image",
            "height": 224,
            "width": 224
        },
        "mllib": {
            "nclasses": 304
        }
    },
    "model": {
        "repository": "/home/tamnguyen/models/trees"
    }
}

{
    "mllib": "caffe",
    "description": "trees classification",
    "type": "supervised",
    "parameters": {
        "input": {
            "connector": "image",
            "height": 224,
            "width": 224
        },
        "mllib": {
            "nclasses": 304
        }
    },
    "model": {
        "repository": "/home/tamnguyen/models/trees"
    }
}
------------------------------------
Post training
{
    "service": "trees",
    "async": true,
    "parameters": {
        "mllib": {
            "gpu": true,
            "net": {
                "batch_size": 32
            },
            "solver": {
                "test_interval": 500,
                "iterations": 200,
                "base_lr": 0.001,
                "stepsize": 1000,
                "gamma": 0.9
            }
        },
        "input": {
            "connector": "image",
            "test_split": 0.1,
            "shuffle": true,
            "width": 224,
            "height": 224
        },
        "output": {
            "measure": [
                "acc",
                "mcll",
                "f1"
            ]
        }
    },
    "data": [
        "/home/ubuntu/projects/docs/category/tree_3"
    ]
}
------------------------------------
Test create a service
DeepdetectRuby::Service.create({"name": "trees", "mllib": "caffe", "description": "trees classification", "type": "supervised", "connector": "image", "height": 224, "width": 224, "nclasses": 890, "repository": "/home/tamnguyen/models/trees"})

Test get a service information
DeepdetectRuby::Service.get_info("trees")

Test delete a service information
DeepdetectRuby::Service.get_info("trees")

Test predict
DeepdetectRuby::Predict.predict({service: "trees", image_url: "http://mamnonhanhphuc.edu.vn/upload/images/THOTRUYENTHIEUNHI/2012/su-tich-cay-chuoi1.jpg"})
