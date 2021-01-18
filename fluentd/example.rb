def filter(tag, time, record)

  record = record.merge({:"attachments" => {:"name" => "NA1"}})
  record[:"attachments"] = record[:"attachments"].merge({:"content" => {:"sourceCrn" => 10}})

  $i = 1
  $num = 10
  while $i < $num  do
    $path = "/var/log/env#$i"
    if(File.exist?($path)) && $i == 1
      env=Hash[*File.read($path).split(/[= \n]+/)]
      record[:"attachments"][:"content"] = record[:"attachments"][:"content"].merge({:"kubernetes" => {:"container#$i#_id" => env["CONTAINERID"]}})
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_name" => env["CONTAINERNAME"]})
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_namespace" => env["NAMESPACE"]})
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_pod" => env["PODIPADDRESS"]})
    elsif(File.exist?($path))
      env=Hash[*File.read($path).split(/[= \n]+/)]
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_id" => env["CONTAINERID"]})
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_name" => env["CONTAINERNAME"]})
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_namespace" => env["NAMESPACE"]})
      record[:"attachments"][:"content"][:"kubernetes"] = record[:"attachments"][:"content"][:"kubernetes"].merge({:"container#$i#_pod" => env["PODIPADDRESS"]})
    else
      break
    end
    $i +=1
  end

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
