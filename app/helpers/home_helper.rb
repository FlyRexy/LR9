# frozen_string_literal: true

# help module
module HomeHelper
  def self.solve(arr)
    temp_count = 0
    max_count = 0
    result_arr = []
    max_i = 0
    arr = arr.split.map(&:to_i)
    i = 0
    arr.each do |el|
      temp_count, i = HomeHelper.sqrt(el, i, result_arr, temp_count)
      if temp_count > max_count
        max_count = temp_count
        max_i = i
      end
    end
    [result_arr, max_i]
  end

  def self.sqrt(elem, ind, result_arr, temp_count)
    if Math.sqrt(elem).to_s.match(/^\d*.0$/)
      result_arr[ind] = if temp_count.zero?
                          elem.to_s
                        else
                          "#{result_arr[ind]} #{elem}"
                        end
      [temp_count + 1, ind]
    else
      [0, ind + 1]
    end
  end
end
