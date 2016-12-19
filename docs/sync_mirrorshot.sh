# rsync for mirrorshot f1
echo "---> sync mirrorshot #0"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot/

echo "---> sync mirrorshot #1"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot_1/

echo "---> sync mirrorshot #2"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot_2/

echo "---> sync mirrorshot #3"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot_3/

echo "---> sync mirrorshot #4"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot_4/

echo "---> sync mirrorshot #5"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot_5/

echo "---> sync mirrorshot #reanalyze"
rsync -arvu --delete /data/projects/deepdetect_u1/models/mirrorshot_f1/ ubuntu@52.51.246.115:/home/ubuntu/projects/deepdetect/models/mirrorshot_reanalyze/

echo -e "\nsync fine-tuned mirrorshot f1 done! \n"
