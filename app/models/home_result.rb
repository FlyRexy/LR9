class HomeResult
  include ActiveModel::Model
  include HomeHelper
  include ActiveModel::Validations
  attr_accessor :arr, :num
  validate :check_input
  validate :result
  validates :arr, :num, presence: { message: "can't be empty" }
  validates :arr, format: { with: /^\s*(\d+\s*)*$/, multiline: true, message: 'must contain only positive numbers' }

  def result
    arr = init
    @result_arr, @max_i = HomeHelper.solve(arr)
    if @result_arr.length.zero?
      errors.add(:segment, "count is equal to zero")
    end
    [@result_arr, @max_i]
  end

  def check_input
    if num != arr&.split&.length&.to_s
      errors.add(:number, "of elements in array are not matching with first field")
    end
  end

  def init
    arr = '1 2 3 4 5' if arr.nil?
  end
end
