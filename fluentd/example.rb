require 'json'

def filter(tag, time, record)

  json = File.read('/var/log/env.json')
  containerInfo = JSON.parse(json)

  

  record = record.merge({:"attachments" => {:"name" => "NA1"}})
  record[:"attachments"] = record[:"attachments"].merge({:"content" => {:"sourceCrn" => 10}})

  $i = 1
  containerInfo.each do |container|
    # puts container["id"]+"   "+container["name"]+"  "+container["class"]+"    "+container["phone"]
    if container["containername"] == "logwriter1"
      record[:"attachments"][:"content"] = record[:"attachments"][:"content"].merge({:"kubernetes" => {:"container#$i#_id" => container["containerid"]}})
    else
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_id" => container["containerid"]})
    end
    record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_name" => container["containername"]})
    record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_namespace" => container["namespace"]})
    record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_pod" => container["podipaddress"]})
    $i += 1

  end

  # $i = 1
  # $num = 10
  # while $i < $num  do
  #   if  $containername == "logwriter#$i" and  $i == 1
  #     record[:"attachments"][:"content"] = record[:"attachments"][:"content"].merge({:"kubernetes" => {:"container#$i#_id" => $containerid}})         
  #   elsif  $containername == "logwriter#$i"
  #     record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_id" => $containerid})
  #   else
  #     break
  #   end
  #   record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_name" => $containername})
  #   record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_namespace" => $namespace})
  #   record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_pod" => $podipaddress})
  #   $i += 1
  # end
    
  record


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
