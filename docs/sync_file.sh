# rsync -avh /home/ubuntu/downloads/test ubuntu@54.229.220.160:/home/ubuntu/downloads/test

# rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_f1/

echo "---> sync person_yes_no"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no/

echo "---> sync person_yes_no #1"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_1/

echo "---> sync person_yes_no #2"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_2/

echo "---> sync person_yes_no #3"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_3/

echo "---> sync person_yes_no #4"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_4/

echo "---> sync person_yes_no #5"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_5/

echo "---> sync person_yes_no #reanalyze"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_reanalyze/

# rsync for selfie f1
echo "---> sync selfie"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie/

echo "---> sync selfie #1"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_1/

echo "---> sync selfie #2"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_2/

echo "---> sync selfie #3"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_3/

echo "---> sync selfie #4"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_4/

echo "---> sync selfie #5"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_5/

echo "---> sync selfie #reanalyze"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_reanalyze/

echo -e "\nsync fine-tuned selfie done! \n"

# rsync for selfie f2
echo "---> sync selfie f2"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie/

echo "---> sync selfie #1"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_1/

echo "---> sync selfie #2"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_2/

echo "---> sync selfie #3"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_3/

echo "---> sync selfie #4"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_4/

echo "---> sync selfie #5"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_5/

echo "---> sync selfie #reanalyze"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/selfie_f2/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/selfie_reanalyze/

echo -e "\nsync fine-tuned selfie f2 done! \n"

# --------------------------------------------------
# rsync for more_than_one_f1
echo "---> sync more_than_one_f1"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one/

echo "---> sync more_than_one #1"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one_1/

echo "---> sync more_than_one #2"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one_2/

echo "---> sync more_than_one #3"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one_3/

echo "---> sync more_than_one #4"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one_4/

echo "---> sync more_than_one #5"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one_5/

echo "---> sync more_than_one #reanalyze"
rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/more_than_one_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/more_than_one_reanalyze/

echo -e "\nsync fine-tuned more_than_one_f1 done! \n"


rsync -arvu --delete /home/ubuntu/projects/deepdetect/models/person_yes_no_f1/ ubuntu@54.229.220.160:/home/ubuntu/projects/deepdetect/models/person_yes_no_1/