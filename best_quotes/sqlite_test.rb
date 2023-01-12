require 'sqlite3'
require 'rulers/sqlite_model'

class MyTable < Rulers::Model::SQLite; end
puts MyTable.schema.inspect

# mt = MyTable.create({
#   'title' => 'it happened',
#   'posted' => 1,
#   'body' => 'it did'
# })

mt = MyTable.create({
  'title' => 'i saw it'
})
mt['title'] = 'i really did'
mt.save!

puts "Count: #{MyTable.count}"

top_id = mt['id'].to_i
(1..top_id).each do |id|
  mt_id = MyTable.find(id)
  puts "Found title #{mt_id["title"]}."
end