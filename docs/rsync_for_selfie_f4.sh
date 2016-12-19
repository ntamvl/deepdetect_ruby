# rsync for selfie f40
echo "---> sync selfie #0"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_f40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie/

echo "---> sync selfie #1"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_f40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_1/

echo "---> sync selfie #2"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_2/

echo "---> sync selfie #3"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_f40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_3/

echo "---> sync selfie #4"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_f40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_4/

echo "---> sync selfie #5"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_f40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_5/

echo "---> sync selfie #reanalyze"
rsync -arvu --delete /home/ubuntu/projects/deepdetect_u1/models/selfie_f40/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_reanalyze/

echo -e "\nsync fine-tuned selfie f40 done! \n"
