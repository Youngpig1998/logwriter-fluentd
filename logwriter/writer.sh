#! /bin/sh



#将容器相关信息输出到属于容器自己的env文件中
echo NAMESPACE=$NAMESPACE >> /var/log/env$CONTAINERNUM
echo CONTAINERNAME=$CONTAINERNAME >> /var/log/env$CONTAINERNUM
echo NODENAME=$NODENAME >> /var/log/env$CONTAINERNUM
CONTAINERID="$(grep "memory:/" < /proc/self/cgroup | sed 's|.*/||')"
echo CONTAINERID=$CONTAINERID >> /var/log/env$CONTAINERNUM
echo PODIPADDRESS=$PODIPADDRESS >> /var/log/env$CONTAINERNUM






while true
do
    if [[ $ENABLE_AUDIT == "true" ]]; then
        echo '{"payload":{"initiator":{"id":"IBMid-xxx","name":"ttauchi@jp.ibm.com","typeURI":"service/security/account/user","credential":{"type":"user"}},"target":{"id":"crn:v1:dev:public:knowledge-studio:us-south:s/null:tn42h00y-0000-0000-0000-000000000000:document-set:9a62aae0-1b07-11ea-875c-abaf70277755","name":"documents_en.csv","typeURI":"knowledge-studio/document-set"},"action":"knowledge-studio.document-set.create","outcome":"success","reason":{"reasonCode":200},"severity":"normal","eventTime":"2021-1-17T04:43:38.59+0000","eventType":"activity","typeURI":"http://schemas.dmtf.org/cloud/audit/1.0/event","message":"Knowledge Studio: create document-set for document-set 9a62aae0-1b07-11ea-875c-abaf70277755","requestData":{"numDocuments":10}},"saveServiceCopy":true,"logSourceCRN":"crn:v1:dev:public:knowledge-studio:us-south:s/null:tn42h00y-0000-0000-0000-000000000000::","observer":{"name":"ActivityTracker"},"dataEvent":false}'  >> /var/log/serviceName.log
        #echo '{"payload":{"initiator":{"id":"IBMid-xxx","name":"ttauchi@jp.ibm.com","typeURI":"service/security/account/user","credential":{"type":"user"}},"target":{"id":"crn:v1:dev:public:knowledge-studio:us-south:s/null:tn42h00y-0000-0000-0000-000000000000:document:9a62aae0-1b07-11ea-875c-abaf70277755-1","name":"documents_en.csv","typeURI":"knowledge-studio/document"},"action":"knowledge-studio.document.delete","outcome":"success","reason":{"reasonCode":200},"severity":"critical","eventTime":"2019-12-10T04:43:52.35+0000","eventType":"activity","typeURI":"http://schemas.dmtf.org/cloud/audit/1.0/event","message":"Knowledge Studio: delete document for document 9a62aae0-1b07-11ea-875c-abaf70277755-1","requestData":{"numDocumentsDeleted":1,"documentSets":[{"documentSetId":"9a62aae0-1b07-11ea-875c-abaf70277755","documentSetName":"documents_en.csv"}]}},"saveServiceCopy":true,"logSourceCRN":"crn:v1:dev:public:knowledge-studio:us-south:s/null:tn42h00y-0000-0000-0000-000000000000::","observer":{"name":"ActivityTracker"},"dataEvent":false}'  >> /var/log/serviceName.log
        #echo '{"payload":{"initiator":{"id":"IBMid-xxx","name":"ttauchi@jp.ibm.com","typeURI":"service/security/account/user","credential":{"type":"user"}},"target":{"id":"crn:v1:dev:public:knowledge-studio:us-south:s/null:tn42h00y-0000-0000-0000-000000000000:document-set:9a62aae0-1b07-11ea-875c-abaf70277755","name":"documents_en.csv","typeURI":"knowledge-studio/document-set"},"action":"knowledge-studio.document-set.delete","outcome":"success","reason":{"reasonCode":200},"severity":"critical","eventTime":"2019-12-10T04:44:01.71+0000","eventType":"activity","typeURI":"http://schemas.dmtf.org/cloud/audit/1.0/event","message":"Knowledge Studio: delete document-set for document-set 9a62aae0-1b07-11ea-875c-abaf70277755","requestData":{"numDocumentsDeleted":9,"documentSets":[{"documentSetId":"9a62aae0-1b07-11ea-875c-abaf70277755","documentSetName":"documents_en.csv"}]}},"saveServiceCopy":true,"logSourceCRN":"crn:v1:dev:public:knowledge-studio:us-south:s/null:tn42h00y-0000-0000-0000-000000000000::","observer":{"name":"ActivityTracker"},"dataEvent":false}'  >> /var/log/serviceName.log
        #echo '0341.407068000:main thread : {"action":"service.test2","eventType":"activity","initiator":{"id":"testId","name":"TestUser","typeURI":"security/account/user","credential":{"type":"token"}},"observer":{"id":"target"},"target":{"id":"testServiceId","name":"TestService","typeURI":"service/test"},"outcome":"success","reason":{"reasonCode":200},"severity":"normal","typeURI":"http://schemas.dmtf.org/cloud/audit/1.0/event"}' >> /var/log/serviceName.log
        #echo '<34>Apr 1 12:30:00 1.2.3.4 server_name: 1.2.3.4 - - [01/Apr/2020:12:30:00 +0000] {"action":"service.test3","eventType":"activity","initiator":{"id":"testId","name":"TestUser","typeURI":"security/account/user","credential":{"type":"token"}},"observer":{"id":"target"},"target":{"id":"testServiceId","name":"TestService","typeURI":"service/test"},"outcome":"success","reason":{"reasonCode":200},"severity":"normal","typeURI":"http://schemas.dmtf.org/cloud/audit/1.0/event"}' >> /var/log/serviceName.log
        #echo '<133>2020-04-01T12:30:00.123456+00:00 host-name app_name  {"action":"service.test4","eventType":"activity","initiator":{"id":"testId","name":"TestUser","typeURI":"security/account/user","credential":{"type":"token"}},"observer":{"id":"target"},"target":{"id":"testServiceId","name":"TestService","typeURI":"service/test"},"outcome":"success","reason":{"reasonCode":200},"severity":"normal","typeURI":"http://schemas.dmtf.org/cloud/audit/1.0/event"}' >> /var/log/serviceName.log
        sleep 60
    fi
done
