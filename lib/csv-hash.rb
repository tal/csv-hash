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
  end
end

def CSVHash arg
  if arg.is_a?(File)
    CSVHash.from_file(arg.path)
  elsif arg.is_a?(String)
    CSVHash.from_file(arg)
  end
end