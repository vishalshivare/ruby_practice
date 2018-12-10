puts "enter first number"
a= gets.chomp.to_i
puts "enter second number"
b= gets.chomp.to_i

def multiply(a,b)
  if b==0
    0
  elsif b>0
    a + multiply(a,b-1)
  end
end

puts multiply(3,4)
