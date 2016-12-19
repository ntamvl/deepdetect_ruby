from dd_client import DD

model_repo = '/home/me/models/sent_en_char'
nclasses = 2

# setting up DD client
host = '127.0.0.1'
sname = 'sent_en'
description = 'English sentiment classification'
mllib = 'caffe'
dd = DD(host)
dd.set_return_format(dd.RETURN_PYTHON)

# creating ML service
model = {'repository':model_repo}
parameters_input = {'connector':'txt','characters':True,'sequence':140,'alphabet':"abcdefghijklmnopqrstuvwxyz0123456789,;.!?'"}
parameters_mllib = {'nclasses':nclasses}
parameters_output = {}
dd.put_service(sname,model,description,mllib,
               parameters_input,parameters_mllib,parameters_output)

# classifying a single piece of text:
parameters_input = {}
parameters_mllib = {}
parameters_output = {}
data = ['Chilling in the West Indies']
classif = dd.post_predict(sname,data,parameters_input,parameters_mllib,parameters_output)
print classif
