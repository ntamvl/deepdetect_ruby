from dd_client import DD

model_repo = '/home/me/models/mymodel'
height = width = 224
nclasses = 300

# setting up DD client
host = '127.0.0.1'
sname = 'imgserv'
description = 'image classification'
mllib = 'caffe'
dd = DD(host)
dd.set_return_format(dd.RETURN_PYTHON)

# creating ML service
model = {'repository':model_repo}
parameters_input = {'connector':'image','width':width,'height':height}
parameters_mllib = {'template':'googlenet','nclasses':nclasses,'finetuning':True,'rotate':False,'mirror':True,'weights':'bvlc_googlenet.caffemodel'}
parameters_output = {}
dd.put_service(sname,model,description,mllib,
               parameters_input,parameters_mllib,parameters_output)

# training / finetuning from pre-trained network
train_data = ['path/to/train/data']
parameters_input = {'test_split':0.1,'shuffle':True}
parameters_mllib = {'gpu':True,'net':{'batch_size':64,'test_batch_size':64},'solver':{'test_interval':4000,'iterations':50000,'snapshot':10000,'base_lr':0.01,'solver_type':'NESTEROV','test_initialization':True}}
parameters_output = {'measure':['mcll','f1','acc-5']}
dd.post_train(sname,train_data,parameters_input,parameters_mllib,parameters_output,async=True)

time.sleep(1)
train_status = ''
while True:
    train_status = dd.get_train(sname,job=1,timeout=10)
    if train_status['head']['status'] == 'running':
  print train_status['body']['measure']
    else:
  print train_status
  break

dd.delete_service(sname)
