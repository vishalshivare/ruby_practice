#Binary search in ruby
class BinarySearch
  def binary_search(arr,element)
    low = 0
    high = arr.length-1
    begin
      mid = (low+high)/2
      if arr[mid] == element
        return mid
      end
      if arr[mid] < element
        low = mid + 1 #go right
      else
        high = mid - 1 #go left
      end
    end while low <= high
  end
end


arr = Array[2, 3, 4, 10, 40]
puts "element find at index #{BinarySearch.new.binary_search(arr,5)}"
