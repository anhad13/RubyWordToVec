require 'matrix'
module WordToVec
  class WordRepresentation < Matrix
    def self.initialize_2D_array no_of_rows, no_of_columns
      m = self[]
      no_of_rows.times.each do |column_no|
        row=[]
        sum=0
        no_of_columns.times.each do |row_no|
          no=rand
          sum+=no
          row << no
        end
        m = Matrix.rows(m.to_a << row.map{|el| el/sum})
      end
      m
    end
    def self.euclidean_distance(vector1, vector2)
      sum = 0
      vector1.zip(vector2).each do |v1, v2|
        component = (v1 - v2)**2
        sum += component
      end
      Math.sqrt(sum)
    end
    def add_m_to_row! row_number, matrix
      original=self.row_vectors[row_number]
      self.column_count.times.each do |col_no|
        new_sum=self[row_number,col_no]+matrix[0,col_no]
        self.send('[]=', row_number, col_no, new_sum)
      end
    end
  end
end
