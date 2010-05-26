module CSVHash
  module_function
  
  def from_file file
    num = 0
    
    data = []
    columns = []
    
    FasterCSV.foreach(file) do |row|
      num += 1
      if num == 1
        columns = row
        next
      end

      hash = {}
      columns.each_with_index do |col, i|
        next unless col
        val = row[i]

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
    
    data
  end
  
  def to_file hashes, columns
    rows = hashes.collect do |hash|
      vals = columns.collect do |col|
        sp = col.split('__')
        ret = hash
        sp.each do |key|
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

def CSVHash arg, columns=nil
  if arg.is_a?(File)
    CSVHash.from_file(arg.path)
  elsif arg.is_a?(String)
    CSVHash.from_file(arg)
  elsif arg.is_a?(Array) && columns.is_a?(Array)
    CSVHash.to_file(arg,columns)
  end
end