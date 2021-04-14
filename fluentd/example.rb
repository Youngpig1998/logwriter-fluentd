def filter(tag, time, record)
  if(File.exist?('/var/log/env'))
    env=Hash[*File.read('/var/log/env').split(/[= \n]+/)]
  else
    env={}
  end

  $logSourceCRN = record["logSourceCRN"]
  $message = record["message"]

  record = record.merge({:"attachments" => [{:"name" => "ibm-cp-data"}]})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"contentType" => "http://schemas.ibm.com/cloud/content/1.0/cloudpak"})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"logSourceCRN" => $logSourceCRN})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"message" => $message})
  record[:"attachments"][0] = record[:"attachments"][0].merge({:"content" => {:"sourceCrn" => 10}})

  record[:"attachments"][0][:"content"] = record[:"attachments"][0][:"content"].merge({:"kubernetes" => {:"container_id" => env["CONTAINERID"]}})
  record[:"attachments"][0][:"content"][:"kubernetes"] = record[:"attachments"][0][:"content"][:"kubernetes"].merge({:"container_name" => env["CONTAINERNAME"]})
  record[:"attachments"][0][:"content"][:"kubernetes"] = record[:"attachments"][0][:"content"][:"kubernetes"].merge({:"namespace" => env["NAMESPACE"]})
  record[:"attachments"][0][:"content"][:"kubernetes"] = record[:"attachments"][0][:"content"][:"kubernetes"].merge({:"pod" => env["PODIPADDRESS"]})
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
