#hash = {'Input.txt' => 'Randy', 'Code.py' => 'Stan', 'Output.txt' => 'Randy'}
#result should be  {'Randy' => ['Input.txt', 'Output.txt'], 'Stan' => ['Code.py']}


hashes = Hash['Input.txt' => 'Randy', 'Code.py' => 'Stan', 'Output.txt' => 'Randy']
new_hash=Hash.new

hashes.values.uniq.each do |value|
    new_hash[value] = hashes.select{ |key, hash| hash == value }.keys
end

puts new_hash
