#find max and min in array using devide and conqure
class Min_Max
  attr_accessor :min, :max
  def initialize
    @min=0
    @max=0
  end
end

class Get_Min_Max
  def get_min_max(arr,low,high)
    minmax,mml,mmr=Min_Max.new
    mid=0
    if low==high
      minmax.min=arr[low]
      minmax.max=arr[high]
      return minmax
    end
    if high == low+1
      if arr[low]>arr[high]
        minmax.min=arr[high]
        minmax.max=arr[low]
        return minmax
      else
        minmax.min=arr[low]
        minmax.max=arr[high]
        return minmax
      end
    end

    mid = (low+high)/2
    mml = get_min_max(arr,low,mid)
    mmr = get_min_max(arr,mid+1,high)

    if mml.min < mmr.min
      minmax.min = mml.min
    else
      minmax.min = mmr.min
    end
    if mml.max > mmr.max
      minmax.max = mml.max
    else
      minmax.max = mmr.max
    end
    return minmax
  end
end

arr = Array[23,34,7,2,39,11,22,35]
dac = Get_Min_Max.new.get_min_max(arr,0,arr.length-1)
puts dac.min
puts dac.max
