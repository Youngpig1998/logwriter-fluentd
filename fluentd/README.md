sidecar镜像

作用是读取每个logwriter容器的env环境变量文件（env文件内容可以参见logwriter中的writer.sh，就是记录了每个容器所独有的信息）并将其按一定格式过滤输出到serviceName.log文件中，之后再输出到stdout标准输出中。

"typeURL" should be removed, should be "typeURI"
"attachments.0.name" must be "ibm-cp-data"
"attachments.0.contentType" is missing and must be "http://schemas.ibm.com/cloud/content/1.0/cloudpak"
"message" should be moved/copied to  "attachments.0.content.message"
"logSourceCRN" should be moved/copied to "attachments.0.content.sourceCrn"
