ls
cd root
ls
cd SDY702-DR34_MySQL/
ls
ls
cd scripts/
ls
./createLkSchema.sh localhost:3306 root tcell shared_data
./createLkSchema.sh localhost root tcell shared_data
./createResearchSchema.sh localhost r
./createForeignKeys.sh localhost root tcell shared_data
./loadLkData.sh 
./loadLkData.sh localhost root tcell shared_data
./loadResearchData.sh localhost root tcell shared_data
cd ..
cd .
cd ..
ls
cd SDY1097-DR34_MySQL/
cd scripts/
ls
./loadResearchData.sh localhost root tcell shared_data
ls
ls
cd ..
cd ..
ls
cd SDY1041-DR34_MySQL/
ls
cd scripts/
ls
./loadResearchData.sh 
./loadResearchData.sh localhost root tcell shared_data
cd ..
ls
cd ..
ls
cd SDY1389
cd SDY1389-DR34_MySQL/
LS
ls
cd scripts/
./loadResearchData.sh localhost root tcell shared_data
cd ..
cd ..
cd ..
ls
exec mysqldump --all-databases -uroot -ptcell > /root/shared_data.sql
SELECT * FROM shared_data.file_info AS fi
JOIN fcs_header AS h ON fi.file_info_id=h.file_info_id
JOIN expsample_2_file_info AS e2f ON fi.file_info_id=e2f.file_info_id 
JOIN expsample AS ex ON e2f.expsample_accession=ex.expsample_accession
JOIN expsample_2_treatment AS e2t ON e2f.expsample_accession=e2t.expsample_accession
JOIN treatment AS t ON e2t.treatment_accession=t.treatment_accession
JOIN expsample_2_biosample AS e2b ON e2f.expsample_accession=e2b.expsample_accession
JOIN biosample AS b ON e2b.biosample_accession=b.biosample_accession
JOIN subject AS s ON b.subject_accession=s.subject_accession
WHERE (fi.detail = "Flow Cytometry result") AND (e2f.result_schema = "FCM") AND (fi.name NOT LIKE "%urface%") AND (fi.name NOT LIKE "%isotype%") 
AND (t.name LIKE "No treatment%") AND (fi.name NOT LIKE "%ki67%");
ls
ls
cd root
ls
CD sdy70
CD SDY702-DR34_MySQL/
cd SDY702
cd SDY702-DR34_MySQL/
ls
cd scripts/
ls
./createResearchSchema.sh localhost root tcell shared_data
./createLkSchema.sh localhost root tcell shared_data
./loadLkData.sh localhost root tcell shared_data
./loadResearchData.sh localhost root tcell shared_data
./createForeignKeys.sh localhost root tcell shared_data
cd ..
cd ..
ls
cd SDY1041-DR34_MySQL/
cd scripts/
ls
./loadResearchData.sh localhost root tcell shared_data
cd ..
cd ..
SDY1097-DR34_MySQL/
cd SDY1097-DR34_MySQL/
cd scripts/
ls
./loadResearchData.sh localhost root tcell shared_data
cd ..
cd ..
cd SDY1389-DR34_MySQL/
cd scripts/
LS
ls
./loadResearchData.sh localhost root tcell shared_data
cd ..
cd ..
ls
cd ..
ls
exec mysqldump --all-databases -uroot -p >/root/dump20730.sql
