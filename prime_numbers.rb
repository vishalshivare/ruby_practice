#find prime numbers in given array in asc order
arr = Array[23,34,7,2,39,11,22,35]
arr1 = arr.sort
puts arr1
for i in 0..arr1.length-1
    for j in 2..arr1[i]/2
      if arr1[i]%j==0
          puts "#{arr1[i]} is not a prime number"
          break
      end
    end
end
