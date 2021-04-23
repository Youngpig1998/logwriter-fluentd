def filter(tag, time, record)

  
  
  # if(File.exist?('/var/log/env'))
  #   env=Hash[*File.read('/var/log/env').split(/[= \n]+/)]
  # else
  #   env={}
  # end

  

  #如果logSourceCRN和message的value为空字符串
  $logSourceCRN = record["logSourceCRN"]
  if $logSourceCRN == ""
    $logSourceCRN = "crn:v1:production:us-south:assistant:icp:a/02a92df0-657c-43c9-94fc-2280450b1e0b:00000000-0000-0000-1617-768394230058::"
  end
  $message = record["message"]
  if $message == ""
    $message = "Watson Assistant: delete skill"
  end

  record = record.merge({:"attachments" => [{:"name" => "ibm-cp-data"}]})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"contentType" => "http://schemas.ibm.com/cloud/content/1.0/cloudpak"})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"logSourceCRN" => $logSourceCRN})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"message" => $message})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"content" => {:"sourceCrn" => 10}})


  if(File.exist?('/var/log/env'))
    f = File.open('/var/log/env','r')
    context = f.readlines
    n = context[0].split(/[ \n]+/)
    containerName = context[1].split(/[ \n]+/)
    nodeName = context[2].split(/[ \n]+/)
    containerId = context[3].split(/[ \n]+/)
    podIpAdd = context[4].split(/[ \n]+/)


    if n.join("") == "NAMESPACE="
      n = "NOT_SPECIFIED"
    else
      n = n[0].split(/NAMESPACE=/).join("")
    end
    if containerName.join("") == "CONTAINERNAME="
      containerName = "NOT_SPECIFIED"
    else
      containerName = containerName[0].split(/CONTAINERNAME=/).join("")
    end
    if nodeName == "NODENAME="
      nodeName = "NOT_SPECIFIED"
    else
      nodeName = nodeName[0].split(/NODENAME=/).join("")
    end
    if containerId == "CONTAINERID="
      containerId = "NOT_SPECIFIED"
    else
      containerId = containerId[0].split(/CONTAINERID=/).join("")
    end
    if podIpAdd == "PODIPADDRESS="
      podIpAdd = "NOT_SPECIFIED"
    else
      podIpAdd = podIpAdd[0].split(/PODIPADDRESS=/).join("")
    end

    # str = "#{n}#{s}#{u}#{p}#{q}"
    # File.open('/var/log/result.txt', 'w') { |file| file.print(str) }

  end


  record[:"attachments"][0][:"content"] = record[:"attachments"][0][:"content"].merge({:"kubernetes" => {:"container_id" => containerId}})
  record[:"attachments"][0][:"content"][:"kubernetes"] = record[:"attachments"][0][:"content"][:"kubernetes"].merge({:"container_name" => containerName})
  record[:"attachments"][0][:"content"][:"kubernetes"] = record[:"attachments"][0][:"content"][:"kubernetes"].merge({:"namespace" => n})
  record[:"attachments"][0][:"content"][:"kubernetes"] = record[:"attachments"][0][:"content"][:"kubernetes"].merge({:"pod" => podIpAdd})
  record










  # record = record.merge({:"attachments" => {:"name" => "NA"}})
  # record[:"attachments"] = record[:"attachments"].merge({:"content" => {:"sourceCrn" => 10}})
  # record[:"attachments"][:"content"] = record[:"attachments"][:"content"].merge({:"kubernetes" => {:"container_id" => env["CONTAINERID"]}})
  # record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container_name" => env["CONTAINERNAME"]})
  # record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"namespace" => env["NAMESPACE"]})
  # record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"pod" => env["PODIPADDRESS"]})
  # record
end

# def code(record)
#   if record.has_key?("key1")
#     record["code"] = record["key1"].to_i
#     record.delete("key1")
#   end
#   record
# end
#
# def message(record)
#   case record["key2"].to_i
#   when 100..200
#     level = "INFO"
#   when 201..300
#     level = "WARN"
#   else
#     level = "ERROR"
#   end
#   record.delete("key2")
#
#   record["message"] = level + ":" + record["key3"]
#   record.delete("key3")
#   record
# end
