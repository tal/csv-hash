require 'faster_csv'
module CSVHash
  module_function
  
  def from_file file
    num = 0
    
    data = []
    columns = []
    
    FasterCSV.foreach(file) do |row|
      num += 1
      if num == 1
        columns = row.collect {|c| c.strip}
        next
      end

      hash = {}
      columns.each_with_index do |col, i|
        next unless col
        col = col ? col.strip : nil
        val = row[i] ? row[i].strip : nil

        setter = hash
        sp = col.split('__')
        sp.each_with_index do |key, j|
          if j == sp.size - 1
            setter[key] = val
          else
            setter[key] ||= {}

            setter = setter[key]
          end
        end

      end

      data << hash
    end
    
    return data, columns
  end
  
  def to_string hashes, columns
    rows = hashes.collect do |hash|
      vals = columns.collect do |col|
        sp = col.to_s.split('__')
        ret = hash
        sp.each do |key|
          puts key unless ret
          ret = ret[key]
        end
        ret
      end
      
      vals
    end
    
    
    csv_string = FasterCSV.generate do |csv|
      csv << columns
      rows.each do |val|
        csv << val
      end
    end
  end
end

# Pass either a path to a csv file to parse which will return an array of hashes (stringified keys) or pass an array of hashes and an array of column names
def CSVHash arg, columns=nil
  if arg.is_a?(File)
    CSVHash.from_file(arg.path)
  elsif arg.is_a?(String)
    CSVHash.from_file(arg)
  elsif arg.is_a?(Array) && columns.is_a?(Array)
    CSVHash.to_string(arg,columns)
  end
end